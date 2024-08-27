// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract P2PTutoringMarketplace {
    struct Tutor {
        address tutorAddress;
        string name;
        string expertise;
        uint256 fee;
        uint256 ratingSum;
        uint256 reviewCount;
    }

    struct Session {
        uint256 sessionId;
        address student;
        address tutor;
        uint256 timestamp;
        bool isCompleted;
    }

    mapping(address => Tutor) public tutors;
    mapping(uint256 => Session) public sessions;
    mapping(address => uint256[]) public tutorSessions; // Tracks sessions for each tutor
    mapping(address => uint256[]) public studentSessions; // Tracks sessions for each student

    uint256 public sessionCounter;

    event TutorRegistered(address indexed tutor, string name, string expertise, uint256 fee);
    event SessionCreated(uint256 indexed sessionId, address indexed student, address indexed tutor, uint256 fee);
    event SessionCompleted(uint256 indexed sessionId);
    event PaymentMade(address indexed from, address indexed to, uint256 amount);
    event ReviewLeft(address indexed tutor, uint256 rating);

    modifier onlyTutor() {
        require(tutors[msg.sender].tutorAddress != address(0), "You are not registered as a tutor.");
        _;
    }

    modifier onlyStudent(uint256 _sessionId) {
        require(sessions[_sessionId].student == msg.sender, "You are not the student for this session.");
        _;
    }

    function registerTutor(string memory _name, string memory _expertise, uint256 _fee) public {
        require(tutors[msg.sender].tutorAddress == address(0), "Tutor is already registered.");

        tutors[msg.sender] = Tutor({
            tutorAddress: msg.sender,
            name: _name,
            expertise: _expertise,
            fee: _fee,
            ratingSum: 0,
            reviewCount: 0
        });

        emit TutorRegistered(msg.sender, _name, _expertise, _fee);
    }

    function bookSession(address _tutor) public payable {
        Tutor memory tutor = tutors[_tutor];
        require(tutor.tutorAddress != address(0), "Tutor does not exist.");
        require(msg.value == tutor.fee, "Incorrect fee.");

        sessionCounter++;
        sessions[sessionCounter] = Session({
            sessionId: sessionCounter,
            student: msg.sender,
            tutor: _tutor,
            timestamp: block.timestamp,
            isCompleted: false
        });

        tutorSessions[_tutor].push(sessionCounter);
        studentSessions[msg.sender].push(sessionCounter);

        emit SessionCreated(sessionCounter, msg.sender, _tutor, msg.value);
    }

    function completeSession(uint256 _sessionId) public onlyStudent(_sessionId) {
        Session storage session = sessions[_sessionId];
        require(!session.isCompleted, "Session is already completed.");

        session.isCompleted = true;
        payable(session.tutor).transfer(tutors[session.tutor].fee);

        emit SessionCompleted(_sessionId);
        emit PaymentMade(msg.sender, session.tutor, tutors[session.tutor].fee);
    }

    function leaveReview(uint256 _sessionId, uint256 _rating) public onlyStudent(_sessionId) {
        require(_rating >= 1 && _rating <= 5, "Rating should be between 1 and 5.");
        Session storage session = sessions[_sessionId];
        require(session.isCompleted, "Session is not completed yet.");

        Tutor storage tutor = tutors[session.tutor];
        tutor.ratingSum += _rating;
        tutor.reviewCount++;

        emit ReviewLeft(session.tutor, _rating);
    }

    function getTutorRating(address _tutor) public view returns (uint256) {
        Tutor memory tutor = tutors[_tutor];
        if (tutor.reviewCount == 0) {
            return 0;
        }
        return tutor.ratingSum / tutor.reviewCount;
    }

    function getTutorSessions(address _tutor) public view returns (uint256[] memory) {
        return tutorSessions[_tutor];
    }

    function getStudentSessions(address _student) public view returns (uint256[] memory) {
        return studentSessions[_student];
    }
}

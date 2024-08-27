## P2P Tutoring Marketplace ##

Vision

The P2P Tutoring Marketplace aims to democratize education by connecting students with qualified tutors through a decentralized platform. By utilizing blockchain technology, this platform ensures that all transactions are transparent, secure, and tamper-proof. The system allows students to book sessions, complete them, and leave reviews, while tutors can manage their sessions and receive payments directly.

Flowchart

mermaid
graph TD;
    A[Student Registers] --> B[Search for Tutors];
    B --> C[Select Tutor];
    C --> D[Book Session];
    D --> E[Session Created];
    E --> F[Session Completed];
    F --> G[Leave Review];
    G --> H[Tutor Rating Updated];
    E --> I[Payment Transferred];


## Smart Contract Overview

Contract Address

- Contract Address: 0xe5F046f5686e9B9Dd996A6d00C7A2B3b40dbC22f

 Key Features

- registerTutor: Register as a tutor with a name, expertise, and fee.
- bookSession: Students can book a session with a tutor by paying the specified fee.
- completeSession: Marks a session as completed and transfers the fee to the tutor.
- leaveReview: Allows students to rate their tutor after a session is completed.
- getTutorRating: Retrieves the average rating for a specific tutor.
- getTutorSessions: Returns all session IDs associated with a specific tutor.
- getStudentSessions: Returns all session IDs associated with a specific student.

Future Scope

1. Session Feedback System: Implement a more detailed feedback mechanism, allowing students to leave comments alongside their ratings.
2. Automated Dispute Resolution: Introduce a decentralized arbitration system for resolving conflicts between students and tutors.
3. Tokenization: Create a native token to incentivize learning and teaching on the platform, rewarding active users.
4. Global Language Support: Expand the platform to support multiple languages and cater to a global audience.
5. Mobile App Development: Develop a mobile application to increase accessibility and user engagement.

Contact Information

For any questions, suggestions, or collaboration inquiries, feel free to contact me:

- Name: Abhishek Dutta
- Email: duttaabhishek704@gmail.com
- LinkedIn: https://www.linkedin.com/in/abhishek-dutta-02a178220/
- GitHub: https://github.com/tri0n0

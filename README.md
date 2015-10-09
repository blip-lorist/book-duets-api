# book-duets-api

- [Capstone requirements](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/master/topic_resources/capstone/capstone.md)
- [Book Duets Mockup](https://github.com/lorainekv/book-duets-api/blob/master/bookduets_mockup.pdf)
- [Book Duets Product Plan](https://github.com/lorainekv/book-duets-api/blob/master/product_plan.md)

### Goals & Guidelines
- Use your product plan to lead the functionality development of their application
- Create and maintain a [Trello board](https://trello.com/) to document progress on your project.
- Host the application using a VPS such as Amazon EC2 **(Not sure which yet)**
- Configure DNS with custom domain **(Got my domain)**
- Create a stylized, responsive design for all devices (phone, tablet, display) **(Bootstrappin)**
- At least 10 items of seed data for each concept/model **Done**
- Use background jobs for any long running tasks (email, image processing, 3rd party data manipulation)
- Use caching for slow or bulky database interactions **(Research this)**
- Use performance analytics to asses and optimize site performance (average server response time < 300ms)
- Practice TDD to lead the development process
- Integrate email (At least user signup)
- Expectations for code quality:
    - 90% or greater test coverage (models and controllers)
    - Javascript tests (client and server side) w/ Mocha
    - B- or greater score on Code Climate
    - No security issues (Brakeman)

### Integration Choices
- Choose at least two complex integrations, examples:
  - Background/Async Jobs (sending emails, confirming registrations)
  - NoSql (MongoDB) **Redis**
  - Content Delivery Network (CDN)
  - Payment Processing (Stripe)
  - Front-end Framework (Ember, Angular, Backbone, etc.)
  - Third-party OAuth (logging in w/ Twitter, Github, etc.) **this one**

### Advanced Feature Choices
- Choose at least two advanced features, examples:
  - Secure Socket Layer (SSL)
  - Content Management System (CMS)
  - Internationalization (i18n)
  - Live Events (notifications, live updates, think back to Philip's AWS presentation)
  - Service Oriented Architecture (SOA) **this one**
  - S3 storage/delivery
  - Secure Public API (documented) **this one**

-- Crear la tabla COMPANY
CREATE TABLE COMPANY (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Crear la tabla EMPLOYEE
CREATE TABLE EMPLOYEE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    FOREIGN KEY (company_id) REFERENCES COMPANY(id)
);

-- Crear la tabla INTERVIEW_FLOW
CREATE TABLE INTERVIEW_FLOW (
    id INT PRIMARY KEY AUTO_INCREMENT,
    description TEXT
);

-- Crear la tabla INTERVIEW_TYPE
CREATE TABLE INTERVIEW_TYPE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- Crear la tabla POSITION
CREATE TABLE POSITION (
    id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT NOT NULL,
    interview_flow_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status VARCHAR(255) NOT NULL,
    is_visible BOOLEAN NOT NULL DEFAULT true,
    location VARCHAR(255) NOT NULL,
    job_description TEXT,
    requirements TEXT,
    responsibilities TEXT,
    salary_min DECIMAL(10, 2) NOT NULL,
    salary_max DECIMAL(10, 2) NOT NULL,
    employment_type VARCHAR(255) NOT NULL,
    benefits TEXT,
    company_description TEXT,
    application_deadline DATE,
    contact_info VARCHAR(255),
    FOREIGN KEY (company_id) REFERENCES COMPANY(id),
    FOREIGN KEY (interview_flow_id) REFERENCES INTERVIEW_FLOW(id)
);

-- Crear la tabla INTERVIEW_STEP
CREATE TABLE INTERVIEW_STEP (
    id INT PRIMARY KEY AUTO_INCREMENT,
    interview_flow_id INT NOT NULL,
    interview_type_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    order_index INT NOT NULL,
    FOREIGN KEY (interview_flow_id) REFERENCES INTERVIEW_FLOW(id),
    FOREIGN KEY (interview_type_id) REFERENCES INTERVIEW_TYPE(id)
);

-- Crear la tabla CANDIDATE
CREATE TABLE CANDIDATE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255) NOT NULL,
    address TEXT NOT NULL
);

-- Crear la tabla APPLICATION
CREATE TABLE APPLICATION (
    id INT PRIMARY KEY AUTO_INCREMENT,
    position_id INT NOT NULL,
    candidate_id INT NOT NULL,
    application_date DATE NOT NULL,
    status VARCHAR(255) NOT NULL,
    notes TEXT,
    FOREIGN KEY (position_id) REFERENCES POSITION(id),
    FOREIGN KEY (candidate_id) REFERENCES CANDIDATE(id)
);

-- Crear la tabla INTERVIEW
CREATE TABLE INTERVIEW (
    id INT PRIMARY KEY AUTO_INCREMENT,
    application_id INT NOT NULL,
    interview_step_id INT NOT NULL,
    employee_id INT NOT NULL,
    interview_date DATE NOT NULL,
    result VARCHAR(255),
    score INT,
    notes TEXT,
    FOREIGN KEY (application_id) REFERENCES APPLICATION(id),
    FOREIGN KEY (interview_step_id) REFERENCES INTERVIEW_STEP(id),
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id)
);

-- Índices para mejorar el rendimiento
CREATE INDEX idx_employee_company ON EMPLOYEE(company_id);
CREATE INDEX idx_position_company ON POSITION(company_id);
CREATE INDEX idx_position_interview_flow ON POSITION(interview_flow_id);
CREATE INDEX idx_application_position ON APPLICATION(position_id);
CREATE INDEX idx_application_candidate ON APPLICATION(candidate_id);
CREATE INDEX idx_interview_application ON INTERVIEW(application_id);
CREATE INDEX idx_interview_employee ON INTERVIEW(employee_id);
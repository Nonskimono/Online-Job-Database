/* JobDetails: Contains detailed information about job opportunities.
JobSkills: Lists various skills associated with job opportunities.
JobSeekerDetails: Stores additional information about job seekers.
ExistingEmployees: Holds information about employees currently working with an employer.
JobHistory: Stores the job history of users.
Education: Records the educational background of users.
ProfessionalNetwork: Manages connections between different users for networking purposes.
JobApplications: Tracks the job applications submitted by users.
Reviews: Allows users to post reviews about employers or job experiences.
*/
-- User Table
-- Employment Type Table
CREATE TABLE IF NOT EXISTS EmploymentType (
    EmploymentTypeId INT AUTO_INCREMENT PRIMARY KEY,
    TypeName VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS User (
    UserId INT AUTO_INCREMENT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    Age INT,
    Sex CHAR(1),
    Contact VARCHAR(50),
    Country VARCHAR(50),
    Loc VARCHAR(100),
    MostRecentJobTitle VARCHAR(100),
    EmploymentTypeId INT,
    MostRecentCompany VARCHAR(100),
    FOREIGN KEY (EmploymentTypeId) REFERENCES EmploymentType(EmploymentTypeId)
);


-- Opportunities Table
CREATE TABLE IF NOT EXISTS Opportunities (
    JobCode INT AUTO_INCREMENT PRIMARY KEY,
    Nature VARCHAR(100),
    Details TEXT,
    EmployerId INT,
    FOREIGN KEY (EmployerId) REFERENCES Employer(EmployerId)
);

-- Employer Table
CREATE TABLE IF NOT EXISTS Employer (
    EmployerId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    LocationId INT,
    FOREIGN KEY (LocationId) REFERENCES Locations(LocationId)
);

-- Locations Table
CREATE TABLE IF NOT EXISTS Locations (
    LocationId INT AUTO_INCREMENT PRIMARY KEY,
    Country VARCHAR(50),
    State VARCHAR(50),
    City VARCHAR(50),
    ZipCode VARCHAR(10)
);

-- JobDetails Table
CREATE TABLE IF NOT EXISTS JobDetails (
    JobDetailId INT AUTO_INCREMENT PRIMARY KEY,
    JobCode INT,
    Description TEXT,
    Requirements TEXT,
    FOREIGN KEY (JobCode) REFERENCES Opportunities(JobCode)
);

-- JobSkills Table
CREATE TABLE IF NOT EXISTS JobSkills (
    SkillId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Category VARCHAR(100)
);

-- JobSeekerDetails Table
CREATE TABLE IF NOT EXISTS JobSeekerDetails (
    SeekerDetailId INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT,
    Skills TEXT,
    ExperienceYears INT,
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

-- ExistingEmployees Table
CREATE TABLE IF NOT EXISTS ExistingEmployees (
    EmployeeId INT AUTO_INCREMENT PRIMARY KEY,
    EmployerId INT,
    UserId INT,
    Position VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (EmployerId) REFERENCES Employer(EmployerId),
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

-- JobHistory Table
CREATE TABLE IF NOT EXISTS JobHistory (
    HistoryId INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT,
    CompanyName VARCHAR(100),
    Position VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

-- Education Table
CREATE TABLE IF NOT EXISTS Education (
    EducationId INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT,
    Institution VARCHAR(100),
    Degree VARCHAR(100),
    StartYear INT,
    EndYear INT,
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

-- ProfessionalNetwork Table
CREATE TABLE IF NOT EXISTS ProfessionalNetwork (
    NetworkId INT AUTO_INCREMENT PRIMARY KEY,
    UserId1 INT,
    UserId2 INT,
    ConnectionDate DATE,
    FOREIGN KEY (UserId1) REFERENCES User(UserId),
    FOREIGN KEY (UserId2) REFERENCES User(UserId)
);

-- JobApplications Table
CREATE TABLE IF NOT EXISTS JobApplications (
    ApplicationId INT AUTO_INCREMENT PRIMARY KEY,
    JobCode INT,
    UserId INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (JobCode) REFERENCES Opportunities(JobCode),
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

-- Reviews Table
CREATE TABLE IF NOT EXISTS Reviews (
    ReviewId INT AUTO_INCREMENT PRIMARY KEY,
    EmployerId INT,
    UserId INT,
    Rating INT,
    Comment TEXT,
    ReviewDate DATE,
    FOREIGN KEY (EmployerId) REFERENCES Employer(EmployerId),
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

-- CompanyProfile Table
CREATE TABLE IF NOT EXISTS CompanyProfile (
    CompanyId INT AUTO_INCREMENT PRIMARY KEY,
    EmployerId INT,
    Profile TEXT,
    EstablishedDate DATE,
    Website VARCHAR(100),
    FOREIGN KEY (EmployerId) REFERENCES Employer(EmployerId)
);

-- Industry Table
CREATE TABLE IF NOT EXISTS Industry (
    IndustryId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT
);

-- Certifications Table
CREATE TABLE IF NOT EXISTS Certifications (
    CertificationId INT AUTO_INCREMENT,
    UserId INT NOT NULL,
    Name VARCHAR(100),
    Authority VARCHAR(100),
    ValidityPeriod INT,  -- Validity period in years
    PRIMARY KEY (CertificationId, UserId),
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);

-- Adding foreign key relationships for JobDetails and JobSkills to Industry
ALTER TABLE JobDetails ADD COLUMN IndustryId INT;
ALTER TABLE JobSkills ADD COLUMN IndustryId INT;
ALTER TABLE JobDetails ADD FOREIGN KEY (IndustryId) REFERENCES Industry(IndustryId);
ALTER TABLE JobSkills ADD FOREIGN KEY (IndustryId) REFERENCES Industry(IndustryId);


-- Other tables and relationships can be added as needed...

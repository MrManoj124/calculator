// create sample projects for testing
// This file about a simple script to create sample projects for testing purposes. It can be used to generate dummy data for development or testing environments.

const fs = require('fs');
const path = require('path');

// Function to create a sample project
function createSampleProject(projectName) {
    const projectPath = path.join(__dirname, projectName);
    if (!fs.existsSync(projectPath)) {
        fs.mkdirSync(projectPath);
        fs.writeFileSync(path.join(projectPath, 'README.md'), `# ${projectName}\n\nThis is a sample project.`);
        console.log(`Project "${projectName}" created successfully.`);
    } else {
        console.log(`Project "${projectName}" already exists.`);
    }
}

// List of sample project names
const sampleProjects = ['ProjectAlpha', 'ProjectBeta', 'ProjectGamma'];
// Create sample projects
sampleProjects.forEach(createSampleProject);

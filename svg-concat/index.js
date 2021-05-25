const fs = require('fs');
const path = require('path');

async function app() {
  let files = process.argv.slice(2, process.argv.length);
  let firstFile = files.splice(0,1)[0];
  let mainFileData = readFileContent(firstFile);
  let fileData = [];
  files.forEach((file) => {
    let data = readFileContent(file);
    fileData.push(getMainContent(data));
  })
  let lastIndex = mainFileData.indexOf('</svg');
  let fullData = [mainFileData.slice(0, lastIndex), fileData.join(''), mainFileData.slice(lastIndex)].join('');
  saveResultFile('res.svg', fullData)
}

function readFileContent(filename) {
  let data = fs.readFileSync(path.resolve(__dirname, filename));
  return data;
}

function saveResultFile(filename, data) {
  fs.writeFileSync(path.resolve(__dirname, filename), data);
}

function getMainContent(data) {
  let startIndex = data.indexOf('<defs');
  let lastIndex = data.indexOf('</svg');
  return data.slice(startIndex, lastIndex);
}

app();
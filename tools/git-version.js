#!/usr/bin/env node

// Generate legacy-format output that looks something like:
// {
//   "version": {
//     "hash": "5b6f793ee81cb725c412b4d87879d6805c0bf76a",
//     "subject": "fixed something",
//     "committer date": "1442788042",
//     "source": "git@github.com:jrgm-docker/teamcity.git"
//   }
// }

var cp = require('child_process');
var util = require('util');

var args = '{"hash":"%H","subject":"%s","committer date":"%ct"}';
var cmd = util.format('git --no-pager log --format=format:\'%s\' -1', args);
cp.exec(cmd, function (err, stdout) {
  var info = {
    version: JSON.parse(stdout || '{}')
  };
  cmd = 'git config --get remote.origin.url';
  cp.exec(cmd, function (err, stdout) {
    info.version.source = (stdout && stdout.trim()) || '';
    console.log(JSON.stringify(info, null, 2));
  });
});

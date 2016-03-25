{exec} = require('child_process')
Shell = require('shell')


module.exports =
  activate: (state) ->
    atom.commands.add 'atom-text-editor', 'local-server-web-view:open': => @processFile()

  processFile: ->
    # Get Absolute File Path
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file
    projectURL = file?.path

    #规则列表
    pathToUrl = {
      'E:\\Workspace\\www\\test':'http://test.com',
      'E:\\Workspace\\www':'http://localhost',
    }

    serverPath = projectURL
    for path,server of pathToUrl
      if projectURL.indexOf(path) isnt -1
        serverPath = server + projectURL.replace(path,'').replace(/\\/g,'/')
        break

    # Send Data to Print Function
    @sendToBrowser serverPath

  sendToBrowser: (serverPath) ->
      Shell.openExternal(serverPath)
      # This creates the URL for the web browser.  EXAMPLE: "http://franzenit.localhost:8081/about.php"

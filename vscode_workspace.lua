local p = premake
local tree = p.tree
local vscode = p.modules.vscode

-- INCLUDES
include("vscode_tasks.lua")
include("vscode_launch.lua")

-- WORKSPACE FILE
vscode.workspace = {}

function vscode.workspace.generateFolders(wks)
    p.push('"folders": [')

    -- Project List
    tree.traverse(p.workspace.grouptree(wks), {
        onleaf = function(n)
            local prj = n.project

            local prjpath = path.getrelative(prj.workspace.location, prj.location)
            p.push('{')
            p.w('"path": "%s"', prjpath)
            p.pop('},')
        end,
    })

    -- Workspace vscode folder
    --p.push('{')
    --p.w('"path": ".vscode"')
    --p.pop('}')

    p.pop('],')
end

-- WORKSPACE AND TASK GENERATION
function vscode.workspace.generate(wks)
    p.push('{')

    vscode.workspace.generateFolders(wks)
    vscode.tasks.generate(wks)
    vscode.launch.generate(wks.projects[wks.startproject]) -- launch/startup project

    p.pop('}')
end

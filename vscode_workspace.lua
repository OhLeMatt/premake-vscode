local p = premake
local project = p.project
local tree = p.tree
local vscode = p.modules.vscode

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

    p.pop('],')
end

-- WORKSPACE AND TASK GENERATION
function vscode.workspace.generate(wks)
    p.push('{')

    vscode.workspace.generateFolders(wks)

    p.pop('}')
end

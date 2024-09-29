InDir = "C:\Users\Doubl\Desktop\mosin\Meshes\Actors\Character\Animations\Weapon\MosinAnims\Mosin" -- will not get files in the immediate folder for now

InputType = "hkx" -- tested and working with fbx and hkx
OutputType = "smd" -- only works with SMD for now

print(InDir)

fn getFilesRecursive root pattern =
(
dir_array = GetDirectories (root+"/*")
for d in dir_array do
  join dir_array (GetDirectories (d+"/*"))
my_files = #()
for f in dir_array do
  join my_files (getFiles (f + pattern))
my_files
)

getFilesRecursive InDir "*.hkx"

FbxImporterSetParam "ScaleConversion" false
FbxImporterSetParam "ScaleFactor" 1.0
FbxImporterSetParam "FillTimeline" true
FbxImporterSetParam "ImportBoneAsDummy" false
FbxImporterSetParam "Mode" #exmerge

for file in my_files do (
    animationRange = interval 0 1
    ImportFile file #noPrompt
    local NewFileName = file
    local extensionPos = findString NewFileName ".hkx"
    extensionPos = extensionPos - 1
    
    NewFileName = substring NewFileName 1 extensionPos

    NewFileName = NewFileName + ".smd"
    local frames = (animationRange.end as integer)/160
    --WBSMDExport NewFileName false 1 false 0 frames false false false false
    -- WBSMDExport NewFileName false 1 false 0 frames false false false false
    WBSMDExport NewFileName false 1 false 1 0 frames false false false false

    print(NewFileName)
)
print("done")


# Layer caps
LAND = 0x01
SEABED = 0x02
SUB = 0x04
WATER = 0x08
AIR = 0x10
ORBIT = 0x20

# Flags
None = 0x00
IgnoreStructures = 0x01

LOG("Hooked footprints.lua")

SpecFootprints { 
    { Name = 'Air1x1',      SizeX=1,  SizeZ=1,  Caps=AIR, MaxWaterDepth=25, MaxSlope=70, Flags=None },
    { Name = 'Air2x2',      SizeX=2,  SizeZ=2,  Caps=AIR, MaxWaterDepth=25, MaxSlope=70, Flags=None },
    { Name = 'Air4x4',      SizeX=4,  SizeZ=4,  Caps=AIR, MaxWaterDepth=25, MaxSlope=70, Flags=None },
    { Name = 'Air8x8',      SizeX=8,  SizeZ=8,  Caps=AIR, MaxWaterDepth=25, MaxSlope=70, Flags=None },
    { Name = 'Air16x16',    SizeX=16, SizeZ=16, Caps=AIR, MaxWaterDepth=25, MaxSlope=70, Flags=None },
}
# RUN: yaml2obj < %s > %t.obj
# RUN: lld-link /out:%t.exe /entry:main /align:32 %t.obj
# RUN: llvm-readobj --file-headers %t.exe | FileCheck %s

# CHECK: SectionAlignment: 32

--- !COFF
header:
  Machine:         IMAGE_FILE_MACHINE_AMD64
  Characteristics: []
sections:
  - Name:            .text
    Characteristics: [ IMAGE_SCN_CNT_CODE, IMAGE_SCN_MEM_EXECUTE, IMAGE_SCN_MEM_READ ]
    Alignment:       4096
    SectionData:     0000000000000000
    Relocations:
      - VirtualAddress:  0
        SymbolName:      __ImageBase
        Type:            IMAGE_REL_AMD64_ADDR64
symbols:
  - Name:            .text
    Value:           0
    SectionNumber:   1
    SimpleType:      IMAGE_SYM_TYPE_NULL
    ComplexType:     IMAGE_SYM_DTYPE_NULL
    StorageClass:    IMAGE_SYM_CLASS_STATIC
    SectionDefinition:
      Length:          8
      NumberOfRelocations: 1
      NumberOfLinenumbers: 0
      CheckSum:        0
      Number:          0
  - Name:            main
    Value:           0
    SectionNumber:   1
    SimpleType:      IMAGE_SYM_TYPE_NULL
    ComplexType:     IMAGE_SYM_DTYPE_NULL
    StorageClass:    IMAGE_SYM_CLASS_EXTERNAL
  - Name:            __ImageBase
    Value:           0
    SectionNumber:   0
    SimpleType:      IMAGE_SYM_TYPE_NULL
    ComplexType:     IMAGE_SYM_DTYPE_NULL
    StorageClass:    IMAGE_SYM_CLASS_EXTERNAL
...

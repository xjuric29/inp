# INP - Návrh počítačových systémů FIT VUT
3. semestr FIT VUT

### 1. úkol:
* Řízení maticového displeje pomocí FPGA
* Upravované jsou soubory:
```
projects/proj1/fpga/ledc8x8.ucf
projects/proj1/fpga/ledc8x8.vhd
projects/proj1/project.xml
```

Hodnocení 10/10 b

### 2. úkol:
* Implementace procesoru vykonávající program napsaný v Brainlove
* Cykly nefungují, nezbyl čas
* Poznámky z hodnocení:
```
Nekompletni sensitivity list; chybejici signaly: CODE_DATA, DATA_RDATA, IN_DATA, cnt_reg, pc_reg, ptr_reg
Mozne problematicke rizeni nasledujicich signalu: DATA_WDATA, OUT_DATA
```

Hodnocení 18/23 b

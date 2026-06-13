# 5500_example_code

Assembly example programs for the **5500FP**, a 24-trit balanced-ternary RISC
processor.

These programs are intended to be assembled with the **CrossASM** macro-assembler
(see <https://github.com/MOS5500/CrossASM_5500FP>) and executed on the 5500FP
development board.

## Repository structure

- `*.asm` — example programs at the top level
- `include/` — header files with constant definitions, brought into the source
  via the `.INCLUDE` directive
- `COMMON/` — accessory code shared by most of the examples

## Examples

The repository contains a collection of example programs, each exercising a
different aspect of the processor. The filenames are descriptive of what is
tested. Further examples may be added over time.

**Suggested starting points** for a first contact with the system:

- `Test_OutSingleChar.asm` — output of a single character on the serial line
- `Test_OutString_2.asm` — output of a null-terminated string on the serial line

These two examples are minimal, produce immediately visible output on the host
terminal, and are the recommended way to verify a correct bring-up of the board
before exploring the other examples.

## Assembling an example with CrossASM

The CrossASM cross-assembler is distributed as a Windows executable in the
[CrossASM_5500FP](https://github.com/MOS5500/CrossASM_5500FP) repository.
It runs natively under Windows.

### Step 1 — Place the source files

Copy the `.asm` source file you want to assemble, together with any required
files from `include/` and `COMMON/`, into the same directory as `CrossASM.exe`.

### Step 2 — Launch CrossASM

Run `CrossASM.exe`. The program takes no command-line arguments; it opens an
interactive menu.

### Step 3 — Assemble and write to SD card

From the menu:

1. **Option 1** — Set the source file. Type the name of the `.asm` file to
   assemble, *without the extension* (for example: `Test_OutSingleChar`).
2. **Option 3** — Assemble the program.
3. **Option 4** — Write the assembled program to an SD card. CrossASM will
   prompt for:
   - the **drive letter** of the SD card on the host PC;
   - the **storage mode**: `Raw (1)` or `FileSystem (2)`.

   **Select `FileSystem (2)`**. This is the format expected by the
   FirstBootLoader stored in the GargantuRAM ROM. The `Raw` mode is reserved
   for low-level use cases and is not needed during normal operation.

A successful write produces the confirmation message:

```
The program was written correctly to the SDCard <letter>:
```

> **Warning** — Writing to the SD card is a destructive operation that erases
> all existing data on the card. CrossASM displays an explicit confirmation
> prompt before proceeding.

## Loading the program on the development board

Once CrossASM has written the program to the SD card:

1. Eject the SD card from the host PC.
2. Insert the SD card into the SD slot of the **GargantuRAM** board, accessible
   on the rear of the 5500FP development unit.
3. Power-cycle (or reset) the board.

On boot, the FirstBootLoader resident in the GargantuRAM ROM reads the program
from the SD card and starts execution.

## Connecting a terminal to the board

The 5500FP development board exposes two USB-UART adaptors based on the
CP2102 chip. To observe the output of an example, connect the host PC to
**serial port 2** (the default output channel) and open a terminal emulator
(PuTTY, minicom, or equivalent) with the following parameters:

| Parameter     | Value |
|---------------|-------|
| Baud rate     | 9600  |
| Data bits     | 8     |
| Parity        | none  |
| Stop bits     | 1     |
| Flow control  | none  |

The CP2102 chip is natively recognised on Windows, Linux, and macOS without
additional driver installation.

## Further information

The 5500FP processor and its system documentation are archived on Zenodo:
[doi:10.5281/zenodo.18881738](https://doi.org/10.5281/zenodo.18881738).

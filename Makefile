riscv64-gcc=/opt/riscv/bin/riscv64-unknown-linux-gnu-gcc -g -ffreestanding -O0 -Wl,--gc-sections \
-nostartfiles -nostdlib -nodefaultlibs -Wl,-T,required/riscv64-virt.ld -mcmodel=medany required/crt0.s

riscv64-dts:
	qemu-system-riscv64 -machine virt -machine dumpdtb=device_tree/riscv64-virt.dtb
	dtc -I dtb -O dts -o device_tree/riscv64-virt.dts device_tree/riscv64-virt.dtb

riscv64-build-supported: 
	${riscv64-gcc} -o driver.out ns16550a.s driver.c 

run-driver:
	qemu-system-riscv64 -nographic -machine virt -m 128M \
		-serial mon:stdio -bios none -kernel driver.out

run-test:
	qemu-system-riscv64 -nographic -machine virt -m 128M \
		-serial mon:stdio -bios none -gdb tcp::1234 -S -kernel driver.out

dbg:
	/opt/riscv/bin/riscv64-unknown-linux-gnu-gdb driver.out

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2004 15:24:17 +0000 (GMT)
Received: from bangpath.uucico.de ([IPv6:::ffff:195.71.9.197]:37386 "EHLO
	bangpath.uucico.de") by linux-mips.org with ESMTP
	id <S8225225AbUAQPYQ> convert rfc822-to-8bit; Sat, 17 Jan 2004 15:24:16 +0000
Received: by bangpath.uucico.de (Postfix, from userid 10)
	id 5670926BB6; Sat, 17 Jan 2004 16:24:15 +0100 (CET)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 167E3FEFB; Sat, 17 Jan 2004 15:24:10 +0000 (GMT)
Date: Sat, 17 Jan 2004 15:24:10 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: linux-mips@linux-mips.org
Subject: Current CVS oopses on Broadcom SWARM
Message-ID: <20040117152410.GA29432@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

At the end of December, Ralf made some "prototype cleanup for 2.4" [1]
which left the SB1250 code uncompilable.  On January 5th, a fix for
this was checked in [2].  Unfortunately, this fix does not work - the
kernel oopses during boot.  The code now looks likes this (in the
past, the return value of prom_boot_secondary was checked and the loop
left when prom_boot_secondary was successful):

                do {

                        /* Iterate until we find a CPU that comes up */
                        cur_cpu++;
                        prom_boot_secondary(cur_cpu,
                                            (unsigned long)p + KERNEL_STACK_SIZE - 32,
                                            (unsigned long)p);
                } while (cur_cpu < NR_CPUS);
                __cpu_number_map[cur_cpu] = i;
                __cpu_logical_map[i] = cur_cpu;

Basically, what this means is that on a SWARM board with 1 physical
CPU, this loop is ran through 32 times (the default of NR_CPUS).
prom_boot_secondary works for the first time, and fails for the 31 CPUs
which don't exist.  At the end, cur_cpu is 32 -- although it should
really be 1.  The kernel oopses a little bit later:


Device eth0:  hwaddr 00-02-4C-FE-0D-08, ipaddr 192.168.1.10, mask 255.255.255.0
        gateway 192.168.1.1, nameserver 131.111.8.42, domain cyrius.com
*** command status = 0
CFE> boot -elf 192.168.1.1:sibylifconfig eth0 -autoboot -elf 192.168.1.1:sibyl
Loader:elf Filesys:tftp Dev:eth0 File:192.168.1.1:sibyl Options:(null)
Loading: 0x0000000020000000/71104 0x00000000200115c0/248 Entry at 0x0000000020000000
Closing network.
Starting program at 0x0000000020000000
SiByte Loader, version 2.4.2
Built on Jan 16 2004
Network device 'eth0' configured
Getting configuration file tftp:192.168.1.1:sibyl.conf...
Config file retrieved.
Available configurations:
  hda
  nfsroot
Boot which configuration [hda]: 
Loading kernel (ELF32):
    1643520@0x80100000
    196608@0x80292000
done
Set up command line arguments to: root=/dev/hda1
Setting up initial prom_init arguments
Cleaning up state...
Transferring control to the kernel.
Kernel entry point is at 0x80294040
Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
Board type: SiByte BCM91250A (SWARM)
CPU revision is: 01040102
FPU revision is: 000f0102
Linux version 2.4.24-pre2 (tbm@deprecation) (gcc version 3.2.3 20030221 (Debian prerelease)) #6 SMP Fri Jan 16 22:06:34 GMT 2004
swarm setup: M41T81 RTC detected.
This kernel optimized for board runs with CFE
Determined physical RAM map:
 memory: 0fe8ae00 @ 00000000 (usable)
On node 0 totalpages: 65162
zone(0): 65162 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1
Calibrating delay loop... 532.48 BogoMIPS
Memory: 254680k/260648k available (1605k kernel code, 5968k reserved, 96k data, 64k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Detected 2 available CPU(s)
Starting CPU 1... cfe_start_cpu(2) returned -1
Slave cpu booted successfully
cfe_start_cpu(3) returned -1
cfe_start_cpu(4) returned -1
cfe_start_cpu(5) returned -1
cfe_start_cpu(6) returned -1
cfe_start_cpu(7) returned -1
cfe_start_cpu(8) returned -1
cfe_start_cpu(9) returned -1
cfe_start_cpu(10) returned -1
cfe_start_cpu(11) returned -1
cfe_start_cpu(12) returned -1
cfe_start_cpu(13) returned -1
cfe_start_cpu(14) returned -1
cfe_start_cpu(15) returned -1
cfe_start_cpu(16) returned -1
cfe_start_cpu(17) returned -1
cfe_start_cpu(18) returned -1
cfe_start_cpu(19) returned -1
cfe_start_cpu(20) returned -1
cfe_start_cpu(21) returned -1
cfe_start_cpu(22) returned -1
cfe_start_cpu(23) returned -1
cfe_start_cpu(24) returned -1
cfe_start_cpu(25) returned -1
cfe_start_cpu(26) returned -1
cfe_start_cpu(27) returned -1
cfe_start_cpu(28) returned -1
cfe_start_cpu(29) returned -1
cfe_start_cpu(30) returned -1
cfe_start_cpu(31) returned -1
cfe_start_cpu(32) returned -1
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: Probing PCI hardware on host bus 0.
PCI: 00:01.0: class 600 doesn't match header type 01. Ignoring class.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Unable to handle kernel paging request at virtual address 00000050, epc == 8010dd44, ra == 80110540
Oops in fault.c::do_page_fault, line 206:
$0 : 00000000 802e0000 8fe80000 00000000 802a5460 00000020 00000000 00000001
$8 : 802c39f4 00000000 8fe80000 80358000 ffffffff 00000016 802afdcc ffffffff
$16: 802a5060 ffffffff 00000000 00000065 802a3090 8036fe98 00000000 00000000
$24: 802b5864 802c3970                   8036e000 8036fde8 8036fde8 80110540
Hi : 00000000
Lo : 00000c20
epc   : 8010dd44    Not tainted
Status: 10001f02
Cause : 00808008
PrId  : 01040102
Process swapper (pid: 1, stackpage=8036e000)
Stack:    802a3090 8036fe98 00000000 8feb52e8 802a5020 10001f01 80358000
 00000002 8036fe10 80110540 80358000 fffffff4 803584e4 00000700 803584e4
 00000700 8ff97538 80111d38 8018a2c4 8018a268 00000024 00000000 80358000
 8036fe98 00000000 8036fe70 00000010 00002180 00000700 802a3090 80124374
 200116d8 8ff977f8 8fe95dc0 8ffc4ab0 8feb52e8 80107af8 802804fc 0000000f
 00000000 ...
Call Trace:   [<80110540>] [<80111d38>] [<8018a2c4>] [<8018a268>] [<80124374>]
 [<80107af8>] [<802804fc>] [<801081b0>] [<801893bc>] [<80189364>] [<801891b4>]
 [<8018a2c4>] [<8018a268>] [<8018a068>] [<80189364>] [<8015b58c>] [<80124374>]
 [<80111734>] [<80102aa0>] [<801007fc>] [<80111734>] [<80124718>] [<8027edc0>]
 [<801007fc>] [<80100840>] [<80113750>] [<80102ab0>] [<80111734>] [<8016a4e8>]
 [<8016a4c4>] [<80102aa0>]

Code: ad420014  0804373f  00000000 <8cc40050> 30620010  14400011  240dffff  5460002e  8d6200c8 
Kernel panic: Attempted to kill init!
 <0>Rebooting in 5 seconds..

----- End forwarded message -----

[1] http://linux.junsun.net/xcvs/xcvs_linux_mips/patches/6344.patch
[2] http://linux.junsun.net/xcvs/xcvs_linux_mips/patches/6390.patch
-- 
Martin Michlmayr
tbm@cyrius.com

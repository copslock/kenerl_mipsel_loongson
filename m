Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2002 06:11:27 +0100 (CET)
Received: from web12605.mail.yahoo.com ([216.136.173.228]:29867 "HELO
	web12605.mail.yahoo.com") by linux-mips.org with SMTP
	id <S1122117AbSJaFL0>; Thu, 31 Oct 2002 06:11:26 +0100
Message-ID: <20021031051117.59421.qmail@web12605.mail.yahoo.com>
Received: from [202.54.38.194] by web12605.mail.yahoo.com via HTTP; Wed, 30 Oct 2002 21:11:17 PST
Date: Wed, 30 Oct 2002 21:11:17 -0800 (PST)
From: Atifa Kheel <atifa_kheel@yahoo.com>
Subject: Linux on DDB5074 board crashes
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1398225064-1036041077=:59083"
Return-Path: <atifa_kheel@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atifa_kheel@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1398225064-1036041077=:59083
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am trying to boot Linux-2.4.18(sgi distribution)on
ddb5074 board. 
Initially there was a problem with the network
card(ether expresspro 100) not being intialized and it
used to fail in the self test.
Then i applied the patch which did the pci_auto to
assign the pci resources.
With this i was able to get the network card working
and setup NFS rootfile system.

But now the problem is like this:

The kernel boots and once the VFS is mounted and init
starts executing sash the kernel crashes,
even a simple user application(simple hello world
program) crashes giving "unaligned access"

The output is not consistent all the time,it sometimes
just hangs without any output and sometimes produces
the oops.

There was a discussion on the mailing list about
"unaligned access" problem in 2.4.18 kernel, and a
patch was suggested(patch to
arch/mips/kernel/unaligned.c),i tried even this patch
but it didn't help.

Thinking the problem may be with the kernel version,i
moved onto linux2.5.1(with the pci_auto patch) but
still the problem persists.

i have build my user application using,
mipsel-linux-gcc -static -mips2 -o hello hello.c

To check whether it was a problem with the
application( sash or hello) itself ,i tested the same
application on another MIPS variant running the
Monta-vista distribution. There it works fine, so does
not seem to be an application problem,

Looking at the oops message it looks that the kernel
is crashing in emulate_load_store instruction while
doing lwl or swl instruction.(this is looking at the
System.map file)
It looks like this happening when it is doing exec of
the user application.But i think the exec code cannot
be suspected here.
probably some corruption trigerring up here.

Can we suspect anything around the time of exec? Can
it be a problem with the way the application was
compiled?

Enclosed is the log for further reference.
Any pointers would be of great help,
thanx
Atifa



__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
--0-1398225064-1036041077=:59083
Content-Type: text/plain; name="linux2.4.18log2.TXT"
Content-Description: linux2.4.18log2.TXT
Content-Disposition: inline; filename="linux2.4.18log2.TXT"


Loading elf file: 192.168.1.89:vmlinux
 0x80080000/1363144 |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/ + 0x801ce000/282624 -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\ + 0x80213000/130608 |/-\|/-\|/-\|/-\|/-\| + 4546 syms /-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\
Entry address is 8008072c
PMON> g root=nfs
Loading R4000 MMU routines.
CPU revision is: 00002321
Primary instruction cache 32kb, linesize 32 bytes.
Primary data cache 32kb, linesize 32 bytes.
Linux version 2.4.18 (atifa@posix) (gcc version 3.0.3) #354 Wed Oct 30 21:48:33 IST 2002
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: root=nfs 
Calling serial console init
After parse options time_init intialization
After trap_init intialization
IN init_IRQ
CPU_IRQ_BASE: 32
enabling 8259 cascade
After init_IRQ intialization
After sched_init intialization
After softirq_init intialization
Calibrating delay loop... 199.47 BogoMIPS
Memory: 62316k/65536k available (1331k kernel code, 3220k reserved, 77k data, 196k init)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
PCI Autoconfig: Found Bus 0, Device 0, Function 0
PCI Autoconfig: Found Bus 0, Device 1, Function 0
PCI Autoconfig: BAR 0, I/O, size=0x80, address=0x1000
PCI Autoconfig: BAR 1, Mem, size=0x80, address=0x8100000
PCI Autoconfig: Found Bus 0, Device 3, Function 0
PCI Autoconfig: BAR 0, Mem, size=0x1000, address=0x8101000
PCI Autoconfig: BAR 1, I/O, size=0x20, address=0x1080
PCI Autoconfig: BAR 2, Mem, size=0x100000, address=0x8200000
PCI Autoconfig: Found Bus 0, Device 10, Function 0
PCI Autoconfig: BAR 0, I/O, size=0x40, address=0x10c0
PCI Autoconfig: BAR 1, I/O, size=0x20, address=0x1100
PCI Autoconfig: Found Bus 0, Device 13, Function 0
PCI Autoconfig: BAR 0, Mem, size=0x1000, address=0x8300000
Scanning bus 00

calling pci_name_device PCI device 10b9:1533
PCI device 10b9:1533Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
calling pci_name_device PCI device 1011:0009
PCI device 1011:0009Digital Equipment Corporation DECchip 21140 [FasterNet]
calling pci_name_device PCI device 8086:1229
PCI device 8086:1229Intel Corp. 82557 [Ethernet Pro 100]
calling pci_name_device PCI device 10b9:7101
PCI device 10b9:7101Acer Laboratories Inc. [ALi] M7101 PMU
calling pci_name_device PCI device 10b9:5237
PCI device 10b9:5237Acer Laboratories Inc. [ALi] M5237 USBFixups for bus 00
irq_map[0]: 1c
irq_map[1]: 18
irq_map[3]: 19
irq_map[10]: 1c
irq_map[13]: 1c
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
*******rs_init called 
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
status i pci_find_capability 640 device hdr type 0
status i pci_find_capability 640 device hdr type 0
set pwer state=-5 
tx_ring_dma=11b8000
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:A0:C9:6B:32:7D, IRQ 25.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 678400-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
**IN ip auto config
**in ic_dynamic
Sending BOOTP requests ..... OK
IP-Config: Got BOOTP answer from 192.168.1.192, my address is 192.168.1.161
IP-Config: Complete:
      device=eth0, addr=192.168.1.161, mask=255.255.255.0, gw=255.255.255.255,
     host=iddb-5074, domain=, nis-domain=(none),
     bootserver=192.168.1.192, rootserver=192.168.1.192, rootpath=/tftpboot/iddb-5074
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
In nfs_root_data
Looking up port of RPC 100003/2 on 192.168.1.192
Looking up port of RPC 100005/1 on 192.168.1.192
VFS: Mounted root (nfs filesystem).
In init
Freeing unused kernel memory: 196k freed
Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn, line 373:
$0 : 00000000 90017c00 811e7b30 00000000
$4 : ad220000 811e7b28 000033ca 811e7c10
$8 : 90017c01 1000001e 00000000 7fff7fdd
$12: 00000003 00000001 00000001 811b9e40
$16: 800dde7c 811e7b28 81183120 00000000
$20: 10000000 00006012 811e7ef0 811e7d80
$24: 00000002 8117c138
$28: 811e6000 811e7b08 00000004 8008a738
epc   : 8008d990    Not tainted
Status: 90017c03
Cause : 00000010
Process sh (pid: 1, stackpage=811e6000)
Stack: 00000000 800b95a4 811e7b38 00000000 00000001 811b9ec0 8008a738 00006012
       811e7ef0 811e7d80 00000000 800ef770 811e7b38 811e7b38 00000000 90017c00
       00000000 7fff7f50 7fff7fdd 00000004 00000008 811e7c10 00000000 7fff7fc0
       00000000 7fff7fdd 00000003 00000001 00000001 811b9e40 00000001 811b9ec0
       81183120 00000000 10000000 00006012 811e7ef0 811e7d80 00000002 8117c138
       801ffb70 ...
Call Trace: [<800b95a4>] [<8008a738>] [<800ef770>] [<800deb10>] [<800dde80>] [<800deb10>] [<800ded98>] [<800ef7fc>] [<800afa68>] [<800b061c>] [<800b06a4>] [<800d01a0>] [<800de59c>] [<800ca5ac>] [<800ca8b4>] [<800cbd70>] [<8008cd00>] [<800d0b0c>] [<801ad7c8>] [<8008d584>] [<8008d584>] [<801ad4bc>] [<801ad4bc>] [<801ad4bc>] [<8009cc54>] [<800b9848>] [<8009ce88>] [<8009cdb0>] [<801ae760>] [<80090344>] [<800883a4>] [<801ad7c8>] [<80088494>] [<801ad814>] [<801b271c>] [<801b2668>] [<8008836c>] [<80088c1c>] [<80088020>] [<80088c0c>]
Code: 00511021  8c430018  a8c30003 <b8c30000> 080235f8  8fbf0018  24c20008  00101827  00c21025 
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..a0020000: heap is already above this poinô
PMON version 0.0.365 [DDB-VRC4374,EL,NET]
NEC Electronics,  Sun Dec 20 15:55:12 PST 1998
This is free software, and comes with ABSOLUTELY NO WARRANTY,
you are welcome to redistribute it without restriction.
CPU type R5000.  Rev 2.1.  133 MHz.
Memory size 64 MBytes.
Icache size 32 Kbytes, 32 bytes/line.
Dcache size 32 Kbytes, 32 bytes/line.
User Space from 0xa005c7b8 to 0xa4000000 


PMON> initEther
a0020000: heap is already above this poinô
PCI Slot 2  Vendor ID = 0x91011 
Assign PCI IO Addr 0x6100000 to  PCI slot 2 

en0: enabling 10baseT UTP port
: DC21140 [10-100Mb/s] pass 2.2 Ethernet address 00:00:4c:80:a2:dd
en0: enabling 10baseT UTP port
PMON> boot
Loading elf file: 192.168.1.89:vmlinux
 0x80080000/1363144 |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/ + 0x801ce000/282624 -\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\ + 0x80213000/130608 |/-\|/-\|/-\|/-\|/-\| + 4546 syms /-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\
Entry address is 8008072c
PMON> g root=nfs
Loading R4000 MMU routines.
CPU revision is: 00002321
Primary instruction cache 32kb, linesize 32 bytes.
Primary data cache 32kb, linesize 32 bytes.
Linux version 2.4.18 (atifa@posix) (gcc version 3.0.3) #354 Wed Oct 30 21:48:33 IST 2002
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: root=nfs 
Calling serial console init
After parse options time_init intialization
After trap_init intialization
IN init_IRQ
CPU_IRQ_BASE: 32
enabling 8259 cascade
After init_IRQ intialization
After sched_init intialization
After softirq_init intialization
Calibrating delay loop... 199.47 BogoMIPS
Memory: 62316k/65536k available (1331k kernel code, 3220k reserved, 77k data, 196k init)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
PCI Autoconfig: Found Bus 0, Device 0, Function 0
PCI Autoconfig: Found Bus 0, Device 1, Function 0
PCI Autoconfig: BAR 0, I/O, size=0x80, address=0x1000
PCI Autoconfig: BAR 1, Mem, size=0x80, address=0x8100000
PCI Autoconfig: Found Bus 0, Device 3, Function 0
PCI Autoconfig: BAR 0, Mem, size=0x1000, address=0x8101000
PCI Autoconfig: BAR 1, I/O, size=0x20, address=0x1080
PCI Autoconfig: BAR 2, Mem, size=0x100000, address=0x8200000
PCI Autoconfig: Found Bus 0, Device 10, Function 0
PCI Autoconfig: BAR 0, I/O, size=0x40, address=0x10c0
PCI Autoconfig: BAR 1, I/O, size=0x20, address=0x1100
PCI Autoconfig: Found Bus 0, Device 13, Function 0
PCI Autoconfig: BAR 0, Mem, size=0x1000, address=0x8300000
Scanning bus 00

calling pci_name_device PCI device 10b9:1533
PCI device 10b9:1533Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
calling pci_name_device PCI device 1011:0009
PCI device 1011:0009Digital Equipment Corporation DECchip 21140 [FasterNet]
calling pci_name_device PCI device 8086:1229
PCI device 8086:1229Intel Corp. 82557 [Ethernet Pro 100]
calling pci_name_device PCI device 10b9:7101
PCI device 10b9:7101Acer Laboratories Inc. [ALi] M7101 PMU
calling pci_name_device PCI device 10b9:5237
PCI device 10b9:5237Acer Laboratories Inc. [ALi] M5237 USBFixups for bus 00
irq_map[0]: 1c
irq_map[1]: 18
irq_map[3]: 19
irq_map[10]: 1c
irq_map[13]: 1c
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
*******rs_init called 
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
status i pci_find_capability 640 device hdr type 0
status i pci_find_capability 640 device hdr type 0
set pwer state=-5 
tx_ring_dma=11b8000
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:A0:C9:6B:32:7D, IRQ 25.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 678400-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
**IN ip auto config
**in ic_dynamic
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.1.192, my address is 192.168.1.161
IP-Config: Complete:
      device=eth0, addr=192.168.1.161, mask=255.255.255.0, gw=255.255.255.255,
     host=iddb-5074, domain=, nis-domain=(none),
     bootserver=192.168.1.192, rootserver=192.168.1.192, rootpath=/tftpboot/iddb-5074
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
In nfs_root_data
Looking up port of RPC 100003/2 on 192.168.1.192
Looking up port of RPC 100005/1 on 192.168.1.192
VFS: Mounted root (nfs filesystem).
In init
Freeing unused kernel memory: 196k freed

a0020000: heap is already above this poinô
PMON version 0.0.365 [DDB-VRC4374,EL,NET]
NEC Electronics,  Sun Dec 20 15:55:12 PST 1998
This is free software, and comes with ABSOLUTELY NO WARRANTY,
you are welcome to redistribute it without restriction.
CPU type R5000.  Rev 2.1.  133 MHz.
Memory size 64 MBytes.
Icache size 32 Kbytes, 32 bytes/line.
Dcache size 32 Kbytes, 32 bytes/line.
User Space from 0xa005c7b8 to 0xa4000000 


PMON> 
--0-1398225064-1036041077=:59083--

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2006 21:49:26 +0000 (GMT)
Received: from web31506.mail.mud.yahoo.com ([68.142.198.135]:46202 "HELO
	web31506.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20027627AbWKQVtV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Nov 2006 21:49:21 +0000
Received: (qmail 53078 invoked by uid 60001); 17 Nov 2006 21:49:10 -0000
Message-ID: <20061117214910.53076.qmail@web31506.mail.mud.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=p0oVwz3X9Z8yKgiDf/IVRvqCXniAWt287rBxNMCcB6mmXjPDzlje1Z3NLbfWOnS4O6YFOmHSI9t4tv8RuBsdq3XQokh57BxJdkXwFTIIrfkZjQnPr80qV7ZVTtvgwwKq+PHnVC/MITvJTgQ7p0fvyF3mG0f5fZZXq1xSMVO0CdM=;
X-YMail-OSG: xAOyE2kVM1lm7PbDfAXyySyw4z.6__YHCWjaEzsTY2978hD6vPPiyP8p.jdad67IM0e39wGVu48Dzmfi15H.PoT5fAJ.g3vv61l9Xte7jCjJ6aB7P2o54bOHze.jSAODNIqAvo492QFDumx_OH7spR3TNf7WaAI3jA--
Received: from [70.103.67.194] by web31506.mail.mud.yahoo.com via HTTP; Fri, 17 Nov 2006 13:49:09 PST
Date:	Fri, 17 Nov 2006 13:49:09 -0800 (PST)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Getting a data bus error on SB1 board
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm using the latest (ok, 17th November, 10am pacific
time) git tree on the Broadcom BCM91250 that I've
always had problems with/nightmares about.

I'm getting a data bus error and am wondering if there
are any un-gitted patches circulating that fix the
problem and/or can diagnose better what is going on.

After turning on ALL of the debugging Linux has to
offer (and then some), this is the part of the boot
log that shows what is happening:

[42949373.640000] Good, all 218 testcases passed! |
[42949373.650000] ---------------------------------
[42949373.650000] Dentry cache hash table entries:
32768 (order: 6, 262144 bytes)
[42949373.660000] Inode-cache hash table entries:
16384 (order: 5, 131072 bytes)
[42949373.700000] Memory: 247296k/260764k available
(3030k kernel code, 13152k reserved, 1123k data, 232k
init, 0k highmem)
[42949373.960000] Mount-cache hash table entries: 256
[42949373.970000] Checking for 'wait' instruction... 
unavailable.
[42949373.970000] Checking for the multiply/shift
bug... no.
[42949373.980000] Checking for the daddi bug... no.
[42949373.980000] Checking for the daddiu bug... no.
[42949373.990000] CPU revision is: 03040102
[42949373.990000] FPU revision is: 000f0102
[42949373.990000] Primary instruction cache 32kB,
4-way, linesize 32 bytes.
[42949373.990000] Primary data cache 32kB, 4-way,
linesize 32 bytes.
[42949373.990000] Synthesized TLB refill handler (40
instructions).
[42949374.240000] Brought up 2 CPUs
[42949374.270000] migration_cost=10000
[42949374.290000] NET: Registered protocol family 16
[42949374.330000] Generic PHY: Registered new driver
[42949374.340000] SCSI subsystem initialized
[42949374.340000] usbcore: registered new interface
driver usbfs
[42949374.350000] usbcore: registered new interface
driver hub
[42949374.360000] usbcore: registered new device
driver usb
[42949374.380000] NET: Registered protocol family 2
[42949374.500000] IP route cache hash table entries:
2048 (order: 2, 16384 bytes)
[42949374.500000] TCP established hash table entries:
8192 (order: 6, 458752 bytes)
[42949374.520000] TCP bind hash table entries: 4096
(order: 5, 229376 bytes)
[42949374.530000] TCP: Hash tables configured
(established 8192 bind 4096)
[42949374.530000] TCP reno registered
[42949374.550000] Initializing RT-Tester: OK
[42949374.550000] audit: initializing netlink socket
(disabled)
[42949374.560000] audit(1163791574.600:1): initialized
[42949374.570000] io scheduler noop registered
[42949374.570000] io scheduler anticipatory registered
[42949374.580000] io scheduler deadline registered
(default)
[42949374.590000] io scheduler cfq registered
[42949375.160000] RAMDISK driver initialized: 1 RAM
disks of 4096K size 1024 blocksize
[42949375.170000] eth0: enabling TCP rcv checksum
[42949375.170000] eth0: SiByte Ethernet at 0x10064000,
address: 00:02:4C:FD:0D:3C
[42949375.180000] eth1: enabling TCP rcv checksum
[42949375.190000] eth1: SiByte Ethernet at 0x10065000,
address: 00:02:4C:FD:0D:3D
[42949375.200000] physmap platform flash device:
01000000 at 1fc00000
[42949375.210000] physmap-flash.0: Found 1 x16 devices
at 0x0 in 8-bit bank
[42949375.210000] DBE physical address: 0020000020
[42949375.220000] Data bus error, epc ==
ffffffff802da0bc, ra == ffffffff802da6d0
[42949375.230000] Oops[#1]:
[42949375.230000] Cpu 1
[42949375.230000] $ 0   : 0000000000000000
0000000014001fe0 0000000000000000 0000000000400020
[42949375.240000] $ 4   : a800000000b2e770
0000000000400000 0000000000000001 0000000000000001
[42949375.250000] $ 8   : 0000000000000001
0000000000000001 0000000000000002 a80000000fe27b23
[42949375.260000] $12   : 000000000000000a
0000000000000000 0000000000000000 ffffffff80406ef8
[42949375.260000] $16   : a800000000b2e770
a80000000fe27c50 0000000000000001 0000000000400000
[42949375.270000] $20   : ffffffff80480d70
0000000000400000 ffffffff8047dd80 ffffffff80481388
[42949375.280000] $24   : 0000000000000030
0000000000000000
[42949375.290000] $28   : a80000000fe24000
a80000000fe27bb0 a80000000fe27bb0 ffffffff802da6d0
[42949375.300000] Hi    : 0000000000000000
[42949375.300000] Lo    : 0000000000000001
[42949375.300000] epc   : ffffffff802da0bc
qry_present+0x2ac/0x420     Not tainted
[42949375.310000] ra    : ffffffff802da6d0
cfi_probe_chip+0x460/0x17d0
[42949375.320000] Status: 14001fe3    KX SX UX KERNEL
EXL IE
[42949375.320000] Cause : 8080001c
[42949375.330000] PrId  : 03040102
[42949375.330000] Modules linked in:
[42949375.330000] Process swapper (pid: 1,
threadinfo=a80000000fe24000, task=a80000000fe20e08)
[42949375.340000] Stack : 0000000000000000
ffffffff80481370 0000000000200000 0000000000000051
[42949375.350000]         0000000000000052
0000000000000059 a80000000fe27bf0 a80000000fe27b23
[42949375.360000]         a800000000b2cb58
00000000000000d0 0000000000000003 a800000000b2cb58
[42949375.360000]         0000000000000001
a800000000b2e770 ffffffff80480d70 0000000000000008
[42949375.370000]         ffffffff8047dd80
ffffffff80481388 a80000000fe27c50 ffffffff802e31b8
[42949375.380000]         0000000000000000
0000000000000000 0000000100000002 0000000100000000
[42949375.390000]         0000000000000000
0000000000000000 a800000000aff668 000000ad00000049
[42949375.400000]         0000000100000000
0000000000000015 0000000000000000 a80000000fe27cc0
[42949375.410000]         ffffffff80480d40
ffffffff80428288 a800000000b2e770 ffffffff80481370
[42949375.410000]         ffffffff80481150
ffffffff80481498 ffffffff8047dd80 ffffffff80481388
[42949375.420000]         ...
[42949375.420000] Call Trace:
[42949375.430000] [<ffffffff802da0bc>]
qry_present+0x2ac/0x420
[42949375.430000] [<ffffffff802da6d0>]
cfi_probe_chip+0x460/0x17d0
[42949375.440000] [<ffffffff802e31b8>]
mtd_do_chip_probe+0x1d4/0x48c
[42949375.440000] [<ffffffff802da25c>]
cfi_probe+0x2c/0x40
[42949375.450000] [<ffffffff802d9d64>]
do_map_probe+0x7c/0x128
[42949375.460000] [<ffffffff802e37f4>]
physmap_flash_probe+0x1f8/0x324
[42949375.460000] [<ffffffff802bdd2c>]
platform_drv_probe+0x20/0x34
[42949375.470000] [<ffffffff802bb418>]
really_probe+0x94/0x1d4
[42949375.470000] [<ffffffff802bb65c>]
driver_probe_device+0x104/0x124
[42949375.480000] [<ffffffff802bb690>]
__device_attach+0x14/0x28
[42949375.480000] [<ffffffff802ba1e0>]
bus_for_each_drv+0x5c/0xb0
[42949375.490000] [<ffffffff802bb760>]
device_attach+0xbc/0x110
[42949375.500000] [<ffffffff802ba0b8>]
bus_attach_device+0x40/0x94
[42949375.500000] [<ffffffff802b8588>]
device_add+0x40c/0x5d4
[42949375.510000] [<ffffffff802be39c>]
platform_device_add+0x1b4/0x218
[42949375.510000] [<ffffffff802be428>]
platform_device_register+0x28/0x40
[42949375.520000] [<ffffffff8053453c>]
physmap_init+0x58/0x74
[42949375.530000] [<ffffffff8010071c>]
init+0x2bc/0x68c
[42949375.530000] [<ffffffff8010523c>]
kernel_thread_helper+0x14/0x1c
[42949375.540000]
[42949375.540000]
[42949375.540000] Code: dc820018  0043102d  90420000
<080b6840> 304600ff  24020002  14c20006  24020004 
dc820018
[42949375.550000] Kernel panic - not syncing:
Attempted to kill init!
[42949375.560000]  BUG: warning at
kernel/lockdep.c:1822/trace_hardirqs_on()
[42949375.560000] Rebooting in 5 seconds..Call Trace:
[42949375.560000] [<ffffffff80109ffc>]
dump_stack+0x10/0x54
[42949375.560000] [<ffffffff8016226c>]
trace_hardirqs_on+0x190/0x290
[42949375.560000] [<ffffffff8010cb04>]
stop_this_cpu+0x64/0x7c
[42949375.560000] [<ffffffff8010d1f0>]
smp_call_function_interrupt+0x90/0xf0
[42949375.560000] [<ffffffff801020d8>]
sb1250_mailbox_interrupt+0xdc/0xf8
[42949375.560000] [<ffffffff80101934>]
plat_irq_dispatch+0x54/0x1ec
[42949375.560000] [<ffffffff801027e0>]
ret_from_irq+0x0/0x4
[42949375.560000] [<ffffffff801052c0>]
cpu_idle+0x40/0x7c
[42949375.560000] [<ffffffff80100b48>]
rest_init+0x5c/0x74
[42949375.560000] [<ffffffff8051000c>]
start_kernel+0x660/0x688
[42949375.560000]



 
____________________________________________________________________________________
Sponsored Link

Online degrees - find the right program to advance your career.
Www.nextag.com

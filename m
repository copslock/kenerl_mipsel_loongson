Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2005 05:28:26 +0000 (GMT)
Received: from mail.soc-soft.com ([IPv6:::ffff:202.56.254.199]:1541 "EHLO
	IGateway.soc-soft.com") by linux-mips.org with ESMTP
	id <S8224905AbVBAF2G> convert rfc822-to-8bit; Tue, 1 Feb 2005 05:28:06 +0000
Received: from mail.soc-soft.com ([192.168.4.25]) by IGateway with trend_isnt_name_B; Tue, 01 Feb 2005 10:59:30 +0530
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problem with HIGHMEM implementation for 32 bit mips-el port
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date:	Tue, 1 Feb 2005 10:59:29 +0530
Message-ID: <4BF47D56A0DD2346A1B8D622C5C5902C49D06C@soc-mail.soc-soft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with HIGHMEM implementation for 32 bit mips-el port
Thread-Index: AcUHZ5+GqdPkBSu5Qheuw5ro5eKB9QAtJutw
Sensitivity: Personal
From:	<Rishabh@soc-soft.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Rishabh@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rishabh@soc-soft.com
Precedence: bulk
X-list: linux-mips


Hi all,
I am attaching the bootlog of the system. There is no PCI device connected to the system.

I am using MVL port for TX4925 Processor. I modified the kernel code such that there is no hole in the global mem_map page allocation, thus leading to no direct resolution of high-memory page struct address and the virtual address.

Also there is a global variable "high_memory" which is initialized in mem_init()[arch/mips/mm/init.c : line no 288]. What is it used for? Also why highstart_pfn is reinitialized to

highstart_pfn = (KSEG1- KSEG0)>> PAGE_SHIFT;
high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);

On my system high_memory is getting calculated to 84000000, wherein it should be the virtual address marking the start of ZONE_HIGHMEM(0xe0000000)? Isn't it?



____________________________________________________________________________

PMON> g
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB 4-way, linesize 32 bytes.
Linux version 2.4.20_mvl31-rbhma4300-mips_fp_le (gcc version 3.3.1 (MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) #117 Mon Jan
 31 16:13:09 IST 2005
Can't analyze prologue code at 8003df5c
TX4925 PCIC -- DID:0181 VID:102f RID:10 Arbiter:Internal
TX4925 PCIC -- PCICLK:Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
 memory: 04000000 @ 20000000 (usable)
bootmem_init: map[0].start: 0, map[0].end: 4000
bootmem_init: map[1].start: 20000, map[1].end: 24000
bootmem_init: first_usable_pfn: 1de, max_low_pfn: 4000, highend_pfn: 24000
64MB HIGHMEM available.

pgd: 801a1fe0, pmd: 801a1fe0, pte:801e0000, pkmap_page_table:801e0000
kmap_init: kmap_vstart: ffffe000, kmap_pte: 801dfff8, kmap_prot:2015
paging_init: low: 4000, max_dma: 1000, highstart_pfn: 20000, highend_pfn: 24000
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 16384 pages.
Zone Structure dump ZONE_DMA
lock            :       1
free_pages      :       0
pages_min       :       20
pages_low       :       40
pages_high      :       60
need_balance    :       0
zone->free_area[0]      :       801ac988
zone->free_area[1]      :       801ac994
zone->free_area[2]      :       801ac9a0
zone->free_area[3]      :       801ac9ac
zone->free_area[4]      :       801ac9b8
zone->free_area[5]      :       801ac9c4
zone->free_area[6]      :       801ac9d0
zone->free_area[7]      :       801ac9dc
zone->free_area[8]      :       801ac9e8
zone->free_area[9]      :       801ac9f4
wait_table      :       81180040
wait_table_size :       10
wait_table_shift        :       1c
zone_pgdat      :       801ac974
zone_mem_map    :       81000020
zone_start_paddr        :       0
zone_start_mapnr        :       0
name            :       801497d0
size            :       1000

ZONE_NORMAL

lock            :       1
free_pages      :       0
pages_min       :       60
pages_low       :       c0
pages_high      :       120
need_balance    :       0
zone->free_area[0]      :       801aca38
zone->free_area[1]      :       801aca44
zone->free_area[2]      :       801aca50
zone->free_area[3]      :       801aca5c
zone->free_area[4]      :       801aca68
zone->free_area[5]      :       801aca74
zone->free_area[6]      :       801aca80
zone->free_area[7]      :       801aca8c
zone->free_area[8]      :       801aca98
zone->free_area[9]      :       801acaa4
wait_table      :       81180340
wait_table_size :       40
wait_table_shift        :       1a
zone_pgdat      :       801ac974
zone_mem_map    :       81030020
zone_start_paddr        :       1000000
zone_start_mapnr        :       1000
name            :       801497d4
size            :       3000

ZONE_HIGHMEM
lock            :       1
free_pages      :       0
pages_min       :       80
pages_low       :       100
pages_high      :       180
need_balance    :       0
zone->free_area[0]      :       801acae8
zone->free_area[1]      :       801acaf4
zone->free_area[2]      :       801acb00
zone->free_area[3]      :       801acb0c
zone->free_area[4]      :       801acb18
zone->free_area[5]      :       801acb24
zone->free_area[6]      :       801acb30
zone->free_area[7]      :       801acb3c
zone->free_area[8]      :       801acb48
zone->free_area[9]      :       801acb54
wait_table      :       81180ba0
wait_table_size :       40
wait_table_shift        :       1a
zone_pgdat      :       801ac974
zone_mem_map    :       810c0020
zone_start_paddr        :       4000000
zone_start_mapnr        :       4000
name            :       801497dc
size            :       4000

Kernel command line:  console=ttyS0,38400 ip=any ne_eth=0x17020280,27 root=/dev/
nfs rw
Calibrating delay loop... 199.88 BogoMIPS
MIPS CPU counter frequency is fixed at 100000000 Hz
Memory: 127604k/65536k available (1301k kernel code, 3468k reserved, 92k data, 216k init, 65536k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x801b6498
Scanning bus 00, I/O 0x00001000:0x01001000, Mem 0x08000000:0x10000000
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
LSP Revision 1
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
allocated 32 pages and 32 bhs reserved for the highmem bounces
Dummy keyboard driver installed.
pty: 256 Unix98 ptys configured
TX39/49 Serial driver version 0.30-mvl
ttyS0 at 0xff1ff300 (irq = 36) is a TX39/49 SIO
ttyS1 at 0xff1ff400 (irq = 37) is a TX39/49 SIO
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x17020280: 00 60 0a 00 49 cf
eth0: RBHMA4X00/RTL8019 found at 0x17020280, using IRQ 27.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.5.122, my address is 192.168.5.252
IP-Config: Complete:
      device=eth0, addr=192.168.5.252, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.5.252, domain=, nis-domain=(none),
     bootserver=192.168.5.122, rootserver=192.168.5.122, rootpath=/home/rishabh/
opt/montavista/pro/devkit/mips/fp_le/target
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
do_initcalls: call 8019d8ac
Looking up port of RPC 100003/2 on 192.168.5.122
Looking up port of RPC 100005/1 on 192.168.5.122
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 216k freed
PCI error interrupt (irq 0x35).
pcistat:2290, g2pstatus:000001c0, pcicstatus:00000000
ccfg:18b44071
$0 : 00000000 10008401 00000000 00000000 0000002c 81189bb8 801b63ec 80141a90
$8 : 00000400 00000400 00000000 3fe946e3 0000fb10 00000000 0000fb10 00000000
$16: 801b63ec 00000001 81189bb8 0000002c 81189bb8 83cf3120 83ced0a0 00001000
$24: 00000000 801b91bf                   81188000 81189b68 00000000 800213e4
Hi : 00000000
Lo : 00000000
epc  : 800210ec    Not tainted
Status: 10008403
Cause : 00006c00
tx4925 pcic settings:
0000: 0181102f 22900146 06000010 00000000 00000008 00000008 00000000 00000001
0020: 00000000 00000000 00000000 00000000 00000000 000000dc 00000000 0000002c
0040: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0060: 00000090 000001c0 00000073 00000000 00000000 00000000 00000000 00000000
0080: 00000000 00000000 00002200 0000f900 00000000 00000018 00000000 00000000
00a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00c0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00220001
00e0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0100: 76543210 00000002 00000000 00000000 00000000 00000000 00000080 00001801
0120: 08000000 00000000 00000000 00000000 00000000 00000000 04000000 00000000
0140: 07ffff00 00000000 00000000 00ffff00 08000000 00000000 00000000 00000000
0160: 00000000 00000000 00000000 00000000 000fff12 00000000 00000001 00000000
0180: 00000000 03f00206 00000000 00000000 00000000 00000000 00000000 00000000
Kernel panic: PCI error at PC:800210ec.
In interrupt handler - not syncing
 <1>Unable to handle kernel paging request at virtual address 00000000, epc == 0
0000000, ra == 800d728c
Oops in fault.c::do_page_fault, line 213:
$0 : 00000000 10008401 00000000 bb020283 801b2c98 811898c0 00000000 00000000
$8 : 00000400 00000400 00002e9b 801b89b8 fffffffe ffffffff 00000010 00000007
$16: 00000000 83e54060 0000006e 801b2c98 00000001 801b2c98 17020280 00001000
$24: 8118997f ffffffff                   81188000 811898a8 00000001 800d728c
Hi : 00000000
Lo : 00000000
epc  : 00000000    Not tainted
Status: 10008403
Cause : 00000008
Process swapper (pid: 1, stackpage=81188000)
Stack:    ffffffff 0000000a 00000000 801b0000 ffffffff 0000000a 801b1c78
 0000000c 00000000 00000001 00000000 17020283 17020287 801b89b8 00000001
 17020280 83e54060 801b2c98 00000001 17020287 1702028d 00001000 00000000
 800d6d64 40cd8ddc 81189988 80028a78 ffffffff 811853e0 00000001 81189988
 0000001b 81189988 83cf3120 83ced0a0 80021104 8019e360 00000001 81189ab8
 80141aa0 ...
Call Trace:   [<800d6d64>] [<80028a78>] [<80021104>] [<80141aa0>] [<800213e4>]
 [<80034158>] [<8015cccc>] [<80141cb4>] [<80034264>] [<8015cccc>] [<80033a18>]
 [<80033aa8>] [<801404ec>] [<800210ec>] [<80021104>] [<80141aa0>] [<800213e4>]
 [<80141cb4>] [<801310b8>] [<8012f634>] [<8013129c>] [<80141a90>] [<80039b40>]
 [<800213e4>] [<800210ec>] [<80141aa0>] [<800213e4>] [<80141cb4>] [<80091d88>]
 [<8004c6ac>] [<8013bc44>] [<8004c018>] [<8006b104>] [<8004c810>] [<8004c62c>]
 [<80091b78>] [<8006b01c>] [<80068bdc>] [<80069138>] [<800d0c34>] ...

Code: (Bad address in epc)

Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

____________________________________________________________________________

-----Original Message-----
From: Jan-Benedict Glaw [mailto:jbglaw@lug-owl.de]
Sent: Monday, January 31, 2005 1:05 PM
To: Rishabh Kumar Goel
Cc: linux-mips@linux-mips.org
Subject: Re: Problem with HIGHMEM implementation for 32 bit mips-el port

On Mon, 2005-01-31 12:49:53 +0530, Rishabh@soc-soft.com <Rishabh@soc-soft.com>
wrote in message <4BF47D56A0DD2346A1B8D622C5C5902C472FE1@soc-mail.soc-soft.com>:
>
> Hi all,
>
> I am working on MIPS32 port of linux (kernel version 2.4.18) for R4000
> processor. While compilation was fine but the kernel boot up panics in
> "init".

2.4.18? You opened some old sepulchre, didn't you? Please forward-port
your patches at least to a recent 2.4.x kernel, if not 2.6.x.

MfG, JBG

--
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
 fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!   O O O
ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));

The information contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If you are not
the intended recipient, please notify the sender and delete the message along with
any annexure. You should not disclose, copy or otherwise use the information contained
in the message or any annexure. Any views expressed in this e-mail are those of the
individual sender except where the sender specifically states them to be the views of
SoCrates Software India Pvt Ltd., Bangalore.

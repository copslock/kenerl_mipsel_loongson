Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9IEXPv29258
	for linux-mips-outgoing; Thu, 18 Oct 2001 07:33:25 -0700
Received: from hell.ascs.muni.cz (hell.ascs.muni.cz [147.251.60.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9IEXGD29248
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 07:33:17 -0700
Received: (from xhejtman@localhost)
	by hell.ascs.muni.cz (8.11.2/8.11.2) id f9IEa6S29906
	for linux-mips@oss.sgi.com; Thu, 18 Oct 2001 16:36:06 +0200
Date: Thu, 18 Oct 2001 16:36:05 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-mips@oss.sgi.com
Subject: Origin 200
Message-ID: <20011018163605.F1089@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-MIME-Autoconverted: from 8bit to quoted-printable by hell.ascs.muni.cz id f9IEa6S29906
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f9IEXHD29249
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I've finally got our origin to load linux kernel via bootp/tftp (Btw, it _must_
be the same server for bootp and tftp?)
I have my cross cimpiled kernel 2.4.9. Kernel options are:
 root=/dev/nfs ip=... nfsroot=... init=/bin/bash
However it never boots up. At random place it freezes. Sometimes without any
oops genereated sometimes with. I've also tried kernel from ftp site
- kernel/test/origin - linux-2.4.2. same behaviour. Is there something I could
do?
Is that ok that cpu clock is 65535MHz?

kernel messages:
1457776 +451040  5448 entry: 0xa800000000184000
ARCH: SGI-IP27
PROMLIB: ARC firmware Version 64 Revision 0
Discovered 1 cpus on 1 nodes
Total memory probed : 0x4000 pages
Linux version 2.4.2 (ralf@cashcow) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2 release)) #4 SMP Tue Mar 20 00:33:52 MET 2001
Loading R10000 MMU routines.
CPU revision is: 00000926
Primary instruction cache 32kb, linesize 64 bytes
Primary data cache 32kb, linesize 32 bytes
Secondary cache sized at 1024K, linesize 128
IP27: Running on node 0.
Node 0 has a primary CPU, CPU is running.
Node 0 has no secondary CPU.
Machine is in M mode.
Cpu 0, Nasid 0x0, pcibr_setup(): found partnum= 0xc002...is bridge
CPU 0 clock is 65535MHz.
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs
ip=147.251.48.209:147.251.48.208:147.251.48.14:255.255.255.0 nfsr
Entering 64-bit mode.
Calibrating delay loop... 179.81 BogoMIPS
Memory: 60824k/65536k available (1423k kernel code, 4712k reserved, 184k data,
220k init)
Dentry-cache hash table entries: 8192 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 3, 32768 bytes)
Page-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 4096 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
REPLICATION: ON nasid 0, ktext from nasid 0, kdata from nasid 0
PCI: Probing PCI hardware hts.
PCI: Fixing isp1020 in [bus:lot.fn] 00:00.0
PCI: Fixing isp1020 in [bus:slot.fn] 00:01.0
PCI: Fixing base addresses for IOC3 device 00:02.0
PCI: Fixing isp1020 in [bus:slot.fn] 00:05.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 40114kB/13371kB, 128 slots per queue
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enabled
ttyS00 at iomem 0x9200000008620178 (irq = 0) is a 16550A
Got dbe at 0xffffffff80142fc8
Cpu 0
$0      : 0000000000000000 0000000014201ce0 9200000001000108 000000000022b6b8
$4      : 9200000001030100 9200000001000108 ffffffff802117e0 0000000000000000
$8      : 0000000000000001 0000000000000000 ffffffff802117e0 0000000000000008
$12     : 0000000014201ce0 000000001000001f 0000000000000008 ffffffff80177aa0
$16     : 0000000000000000 0000000000000790 a8000000012fbcc0 ffffffff801cfda8
$20     : ffffffff8020d498 a8000000012c0220 a8000000012c0000 a500000000000000
$24     : 0000000000000020 0000000000000000
$28     : a8000000012f8000 a8000000012fbc90 000000ffffffffff ffffffff801418e0
Hi      : 0000000000000000
Lo      : 0000000000000008
epc     : ffffffff80142fc8
badvaddr: ffffffff800ee714
badvaddr: ffffffff800ee714
Status  : 14201ce2
Cause   : 0000901c
Cause   : 0000901c
Index:  0 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0
g=0]  [pa=000000 c=0 d=0 v=0 g=0]
.....
-- 
Luká¹ Hejtmánek

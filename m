Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2007 16:10:33 +0000 (GMT)
Received: from hydra.gt.owl.de ([195.71.99.218]:43478 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S20029566AbXKSQKZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2007 16:10:25 +0000
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 32492937BA; Mon, 19 Nov 2007 17:09:54 +0100 (CET)
Date:	Mon, 19 Nov 2007 17:09:54 +0100
From:	Florian Lohoff <flo@rfc822.org>
To:	linux-mips@linux-mips.org
Subject: IP22 64Bit arcboot - current git crashes on 3 machines at different points
Message-ID: <20071119160954.GA12244@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
Organization: rfc822 - pure communication
X-SpiderMe: mh-200711191703@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Subject: Re: Bug#451805: linux-image-2.6.22-3-r4k-ip22 dies early on boot /=
 Starting ELF64 kernel

Hi,
i am seeing strange issues with 64 Bit kernels IP22 on different
machines. This came up when i tried the debian distribution kernel
which fails for me on 2 machines.

Current git does not work on all 3=20

IP22 Indy R5k 150Mhz
 r4k-ip22-2.6.22-6 works
 current git 2.6.24-rc2	breaks in Zilog serial driver (see end)
 PROM Monitor SGI Version 5.3 Rev B10 R4X00/R5000 IP24 Feb 12, 1996 (BE)

IP22 Indy R4k 100Mhz
 r4k-ip22-2.6.22-6 dies after "Starting ELF64 Kernel"
 current git 2.6.24-rc2 dies with a backtrace in cache_alloc_refill (see en=
d)
 PROM Monitor SGI Version 5.1.2 Rev B4 R4X00 IP24 Dec  9, 1993 (BE)

IP22 Indigo2 R4k 250Mhz
 r4k-ip22-2.6.22-6 dies after "Starting ELF64 Kernel"
 current git 2.6.24-rc2 dies after initializing hash tables (see end)
 PROM Monitor SGI Version 5.3 Rev E IP22 Sep 28, 1995 (BE)


IP22 r5k 150Mhz Indy 2.6.24-rc2
>> boot
60928+176+320 entry: 0x88802d9c

arcsboot: ARCS Linux ext2fs loader 0.3.8.8

Loading linux2624 from scsi(0)disk(1)partition(1)
Allocated 0x70 bytes for segments
Loading 64-bit executable
Loading program segment 1 at 0x88004000, offset=3D0x0 4000, size =3D 0x0 40=
e085
c000      (cache: 22.2%)18000      (cache: 34.7%)24000      (cache: 46.6%)3=
0000      (cache: 57.5%)3c000      (cache: 67.8%)48000      (cache: 74.3%)5=
4000      (cache: 77.7%)60000      (cache: 77.6%)6c000      (cache: 77.5%)7=
8000      (cache: 78.7%)84000      (cache: 78.9%)90000      (cache: 79.1%)9=
c000      (cache: 80.3%)a8000      (cache: 82.6%)b4000      (cache: 82.5%)c=
0000      (cache: 82.7%)cc000      (cache: 84.3%)d8000      (cache: 85.0%)e=
4000      (cache: 85.3%)f0000      (cache: 86.1%)fc000      (cache: 85.9%)1=
08000      (cache: 86.8%)114000      (cache: 87.5%)120000      (cache: 88.2=
%)12c000      (cache: 88.7%)138000      (cache: 89.2%)144000      (cache: 8=
9.6%)150000      (cache: 90.0%)15c000      (cache: 90.3%)168000      (cache=
: 90.6%)174000      (cache: 90.8%)180000      (cache: 91.1%)18c000      (ca=
che: 91.3%)198000      (cache: 91.5%)1a4000      (cache: 91.6%)1b0000      =
(cache: 91.8%)1bc000      (cache: 92.0%)1c8000      (cache: 92.1%)1d4000   =
   (cache: 92.2%)1e0000      (cache: 92.4%)1ec000      (cache: 92.5%)1f8000=
      (cache: 92.6%)204000      (cache: 92.7%)210000      (cache: 92.8%)21c=
000      (cache: 92.9%)228000      (cache: 92.9%)234000      (cache: 93.0%)=
240000      (cache: 93.1%)24c000      (cache: 93.2%)258000      (cache: 93.=
2%)264000      (cache: 93.3%)270000      (cache: 93.4%)27c000      (cache: =
93.4%)288000      (cache: 93.5%)294000      (cache: 93.5%)2a0000      (cach=
e: 93.6%)2ac000      (cache: 93.6%)2b8000      (cache: 93.7%)2c4000      (c=
ache: 93.7%)2d0000      (cache: 93.8%)2dc000      (cache: 93.8%)2e8000     =
 (cache: 93.8%)2f4000      (cache: 93.9%)300000      (cache: 93.9%)30c000  =
    (cache: 93.9%)318000      (cache: 94.0%)324000      (cache: 94.0%)33000=
0      (cache: 94.0%)33c000      (cache: 94.1%)348000      (cache: 94.1%)35=
4000      (cache: 94.1%)360000      (cache: 94.2%)36c000      (cache: 94.2%=
)378000      (cache: 94.2%)384000      (cache: 94.2%)390000      (cache: 94=
=2E3%)39c000      (cache: 94.3%)3a8000      (cache: 94.3%)3b4000      (cach=
e: 94.3%)3c0000      (cache: 94.3%)3cc000      (cache: 94.4%)3d8000      (c=
ache: 94.4%)3e4000      (cache: 94.4%)3f0000      (cache: 94.4%)3fc000     =
 (cache: 94.4%)408000      (cache: 94.5%)414000      (cache: 94.5%)420000  =
    (cache: 94.5%)42c000      (cache: 94.5%)438000      (cache: 94.5%)44400=
0      (cache: 94.5%)450000      (cache: 94.6%)45c000      (cache: 94.6%)46=
8000      (cache: 94.6%)474000      (cache: 94.6%)480000      (cache: 94.6%=
)48c000      (cache: 94.6%)498000      (cache: 94.6%)Zeroing memory at 0x71=
0210, size =3D 0x0
Starting ELF64 kernel
Linux version 2.6.24-rc2-gcd60878b-dirty (flo@firewall) (gcc version 4.2.2)=
 #1 Mon Nov 19 14:33:08 CET 2007
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
console [early0] enabled
CPU revision is: 00002321 (R5000)
FPU revision is: 00002310
MC: SGI memory controller Revision 3
MC: Probing memory configuration:
 bank0:  32M @ 08000000
 bank1:  32M @ 0a000000
Determined physical RAM map:
 memory: 0000000004000000 @ 0000000008000000 (usable)
Wasting 1835008 bytes for tracking 32768 unused pages
Initrd not found or empty - disabling initrd
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 48480
Kernel command line: root=3D/dev/sda2
Primary instruction cache 32kB, VIPT, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, VIPT, cache aliases, linesize 32 bytes
Synthesized clear page handler (15 instructions).
Synthesized copy page handler (24 instructions).
Synthesized TLB refill handler (38 instructions).
Synthesized TLB load handler fastpath (51 instructions).
Synthesized TLB store handler fastpath (51 instructions).
Synthesized TLB modify handler fastpath (50 instructions).
PID hash table entries: 1024 (order: 10, 8192 bytes)
Calibrating system timer... 300000 [150.0000 MHz CPU]
Using 75.000 MHz high precision timer.
NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9 revisi=
on A, cmap revision C, bt445 revision D
NG1: Screensize 1024x768
Console: colour SGI Newport 128x48
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Memory: 57600k/65536k available (2925k kernel code, 7524k reserved, 955k da=
ta, 272k init, 0k highmem)
Security Framework initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
net_namespace: 120 bytes
NET: Registered protocol family 16
EISA bus registered
SCSI subsystem initialized
Time: MIPS clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 2, 16384 bytes)
TCP established hash table entries: 8192 (order: 5, 131072 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1195479647.784:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
DS1286 Real Time Clock Driver v1.0
Serial: IP22 Zilog driver (1 chips).






IP22 r4k 250Mhz Indigo2 2.6.24-rc2:
arcsboot: ARCS Linux ext2fs loader 0.3.8.8

Loading linux2624 from scsi(1)disk(5)rdisk(0)partition(0)
Allocated 0x70 bytes for segments
Loading 64-bit executable
Loading program segment 1 at 0x88004000, offset=3D0x0 4000, size =3D 0x0 40=
e085
c000      (cache: 46.1%)18000      (cache: 69.3%)24000      (cache: 78.0%)3=
0000      (cache: 82.4%)3c000      (cache: 85.1%)48000      (cache: 86.8%)5=
4000      (cache: 88.1%)60000      (cache: 89.1%)6c000      (cache: 89.8%)7=
8000      (cache: 90.4%)84000      (cache: 90.9%)90000      (cache: 91.3%)9=
c000      (cache: 91.6%)a8000      (cache: 91.9%)b4000      (cache: 92.2%)c=
0000      (cache: 92.4%)cc000      (cache: 92.6%)d8000      (cache: 92.8%)e=
4000      (cache: 92.9%)f0000      (cache: 93.1%)fc000      (cache: 93.2%)1=
08000      (cache: 93.3%)114000      (cache: 93.4%)120000      (cache: 93.5=
%)12c000      (cache: 93.6%)138000      (cache: 93.7%)144000      (cache: 9=
3.8%)150000      (cache: 93.9%)15c000      (cache: 93.9%)168000      (cache=
: 94.0%)174000      (cache: 94.0%)180000      (cache: 94.1%)18c000      (ca=
che: 94.1%)198000      (cache: 94.2%)1a4000      (cache: 94.2%)1b0000      =
(cache: 94.3%)1bc000      (cache: 94.3%)1c8000      (cache: 94.4%)1d4000   =
   (cache: 94.4%)1e0000      (cache: 94.4%)1ec000      (cache: 94.5%)1f8000=
      (cache: 94.5%)204000      (cache: 94.5%)210000      (cache: 94.6%)21c=
000      (cache: 94.6%)228000      (cache: 94.6%)234000      (cache: 94.6%)=
240000      (cache: 94.7%)24c000      (cache: 94.7%)258000      (cache: 94.=
7%)264000      (cache: 94.7%)270000      (cache: 94.7%)27c000      (cache: =
94.8%)288000      (cache: 94.8%)294000      (cache: 94.8%)2a0000      (cach=
e: 94.8%)2ac000      (cache: 94.8%)2b8000      (cache: 94.9%)2c4000      (c=
ache: 94.9%)2d0000      (cache: 94.9%)2dc000      (cache: 94.9%)2e8000     =
 (cache: 94.9%)2f4000      (cache: 94.9%)300000      (cache: 94.9%)30c000  =
    (cache: 95.0%)318000      (cache: 95.0%)324000      (cache: 95.0%)33000=
0      (cache: 95.0%)33c000      (cache: 95.0%)348000      (cache: 95.0%)35=
4000      (cache: 95.0%)360000      (cache: 95.0%)36c000      (cache: 95.0%=
)378000      (cache: 95.1%)384000      (cache: 95.1%)390000      (cache: 95=
=2E1%)39c000      (cache: 95.1%)3a8000      (cache: 95.1%)3b4000      (cach=
e: 95.1%)3c0000      (cache: 95.1%)3cc000      (cache: 95.1%)3d8000      (c=
ache: 95.1%)3e4000      (cache: 95.1%)3f0000      (cache: 95.1%)3fc000     =
 (cache: 95.1%)408000      (cache: 95.2%)414000      (cache: 95.2%)Zeroing =
memory at 0x710210, size =3D 0x0
Starting ELF64 kernel
Linux version 2.6.24-rc2-gcd60878b-dirty (flo@firewall) (gcc version 4.2.2)=
 #1 Mon Nov 19 14:33:08 CET 2007
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
console [early0] enabled
CPU revision is: 00000460 (R4400SC)
FPU revision is: 00000500
MC: SGI memory controller Revision 3
MC: Probing memory configuration:
 bank0:  64M @ 10000000
 bank1:  64M @ 14000000
 bank2: 128M @ 08000000
Determined physical RAM map:
 memory: 0000000010000000 @ 0000000008000000 (usable)
Wasting 1835008 bytes for tracking 32768 unused pages
Initrd not found or empty - disabling initrd
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 96960
Kernel command line: root=3D/dev/sdf1 console=3DttyS0 auto
Primary instruction cache 16kB, VIPT, direct mapped, linesize 16 bytes.
Primary data cache 16kB, direct mapped, VIPT, cache aliases, linesize 16 by=
tes
Unified secondary cache 2048kB direct mapped, linesize 128 bytes.
Synthesized clear page handler (22 instructions).
Synthesized copy page handler (39 instructions).
Synthesized TLB refill handler (38 instructions).
Synthesized TLB load handler fastpath (50 instructions).
Synthesized TLB store handler fastpath (50 instructions).
Synthesized TLB modify handler fastpath (49 instructions).
EISA: Probing bus...
EISA: Detected 0 card.
ISA support compiled in.
PID hash table entries: 2048 (order: 11, 16384 bytes)
Calibrating system timer... 500000 [250.0000 MHz CPU]
Using 125.000 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Memory: 251104k/262144k available (2925k kernel code, 10628k reserved, 955k=
 data, 272k init, 0k highmem)


IP22 R4k 100Mhz Indy - 2.6.24-rc2:
Loading linux2624 from scsi(0)disk(1)rdisk(0)partition(0)
Allocated 0x70 bytes for segments
Loading 64-bit executable
Loading program segment 1 at 0x88004000, offset=3D0x0 4000, size =3D 0x0 40=
e085
c000      (cache: 44.0%)18000      (cache: 68.7%)24000      (cache: 77.7%)3=
0000      (cache: 82.2%)3c000      (cache: 85.0%)48000      (cache: 86.8%)5=
4000      (cache: 88.0%)60000      (cache: 89.0%)6c000      (cache: 89.8%)7=
8000      (cache: 90.4%)84000      (cache: 90.9%)90000      (cache: 91.3%)9=
c000      (cache: 91.6%)a8000      (cache: 91.9%)b4000      (cache: 92.2%)c=
0000      (cache: 92.4%)cc000      (cache: 92.6%)d8000      (cache: 92.8%)e=
4000      (cache: 92.9%)f0000      (cache: 93.1%)fc000      (cache: 93.2%)1=
08000      (cache: 93.3%)114000      (cache: 93.4%)120000      (cache: 93.5=
%)12c000      (cache: 93.6%)138000      (cache: 93.7%)144000      (cache: 9=
3.8%)150000      (cache: 93.8%)15c000      (cache: 93.9%)168000      (cache=
: 94.0%)174000      (cache: 94.0%)180000      (cache: 94.1%)18c000      (ca=
che: 94.1%)198000      (cache: 94.2%)1a4000      (cache: 94.2%)1b0000      =
(cache: 94.3%)1bc000      (cache: 94.3%)1c8000      (cache: 94.4%)1d4000   =
   (cache: 94.4%)1e0000      (cache: 94.4%)1ec000      (cache: 94.5%)1f8000=
      (cache: 94.5%)204000      (cache: 94.5%)210000      (cache: 94.6%)21c=
000      (cache: 94.6%)228000      (cache: 94.6%)234000      (cache: 94.6%)=
240000      (cache: 94.7%)24c000      (cache: 94.7%)258000      (cache: 94.=
7%)264000      (cache: 94.7%)270000      (cache: 94.7%)27c000      (cache: =
94.8%)288000      (cache: 94.8%)294000      (cache: 94.8%)2a0000      (cach=
e: 94.8%)2ac000      (cache: 94.8%)2b8000      (cache: 94.8%)2c4000      (c=
ache: 94.9%)2d0000      (cache: 94.9%)2dc000      (cache: 94.9%)2e8000     =
 (cache: 94.9%)2f4000      (cache: 94.9%)300000      (cache: 94.9%)30c000  =
    (cache: 95.0%)318000      (cache: 95.0%)324000      (cache: 95.0%)33000=
0      (cache: 95.0%)33c000      (cache: 95.0%)348000      (cache: 95.0%)35=
4000      (cache: 95.0%)360000      (cache: 95.0%)36c000      (cache: 95.0%=
)378000      (cache: 95.1%)384000      (cache: 95.1%)390000      (cache: 95=
=2E1%)39c000      (cache: 95.1%)3a8000      (cache: 95.1%)3b4000      (cach=
e: 95.1%)3c0000      (cache: 95.1%)3cc000      (cache: 95.1%)3d8000      (c=
ache: 95.1%)3e4000      (cache: 95.1%)3f0000      (cache: 95.1%)3fc000     =
 (cache: 95.1%)408000      (cache: 95.2%)414000      (cache: 95.2%)Zeroing =
memory at 0x710210, size =3D 0x0
Starting ELF64 kernel
Linux version 2.6.24-rc2-gcd60878b-dirty (flo@firewall) (gcc version 4.2.2)=
 #1 Mon Nov 19 14:33:08 CET 2007
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
console [early0] enabled
CPU revision is: 00000430 (R4000SC)
FPU revision is: 00000500
MC: SGI memory controller Revision 3
MC: Probing memory configuration:
 bank0:  64M @ 08000000
 bank1:  64M @ 0c000000
Determined physical RAM map:
 memory: 0000000008000000 @ 0000000008000000 (usable)
Wasting 1835008 bytes for tracking 32768 unused pages
Initrd not found or empty - disabling initrd
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64640
Kernel command line: root=3D/dev/sda1
Primary instruction cache 8kB, VIPT, direct mapped, linesize 16 bytes.
Primary data cache 8kB, direct mapped, VIPT, cache aliases, linesize 16 byt=
es
Unified secondary cache 1024kB direct mapped, linesize 128 bytes.
Synthesized clear page handler (22 instructions).
Synthesized copy page handler (39 instructions).
Synthesized TLB refill handler (38 instructions).
Synthesized TLB load handler fastpath (50 instructions).
Synthesized TLB store handler fastpath (50 instructions).
Synthesized TLB modify handler fastpath (49 instructions).
PID hash table entries: 1024 (order: 10, 8192 bytes)
Calibrating system timer... 200000 [100.0000 MHz CPU]
Using 50.000 MHz high precision timer.
NG1: Revision 3, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9 revisi=
on A, cmap revision C, bt445 revision A
NG1: Screensize 1040x768
Console: colour SGI Newport 130x48
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Memory: 122336k/131072k available (2925k kernel code, 8448k reserved, 955k =
data, 272k init, 0k highmem)
Kernel bug detected[#1]:
Cpu 0
$ 0   : 0000000000000000 000000001400cce0 0000000000000001 0000000000000000
$ 4   : ffffffff8fc16140 00000000000000d0 00000000000000d0 0000000000000000
$ 8   : ffffffff8fc15000 0000000000000000 ffffffff8fc15030 0000000000000000
$12   : 0000000000100100 0000000000200200 ffffffff883f59a8 ffffffff883f59b8
$16   : ffffffff8fc15180 ffffffff8fc16140 00000000000000d0 ffffffff8fc16140
$20   : 0000000000000080 0000000000000000 0000000000042000 0000000000000000
$24   : 0000000000001463 0000000000000001                                 =
=20
$28   : ffffffff88398000 ffffffff8839bde0 00000000000000d0 ffffffff8808bac8
Hi    : 0000000000000000
Lo    : 0000000000000080
epc   : ffffffff8808bb5c cache_alloc_refill+0x8c/0x710     Not tainted
ra    : ffffffff8808bac8 kmem_cache_alloc+0xe0/0xe8
Status: 1400cce2    KX SX UX KERNEL EXL=20
Cause : 00000034
PrId  : 00000430 (R4000SC)
Modules linked in:
Process swapper (pid: 0, threadinfo=3Dffffffff88398000, task=3Dffffffff8839=
c2a8)
Stack : 00000000000000d0 0000000000000000 000000001400cce1 ffffffff88430000
        00000000000000d0 ffffffff8fc16140 0000000000000080 0000000000000000
        0000000000042000 0000000000042000 ffffffff8834c568 ffffffff8808bac8
        ffffffff8fc16140 ffffffff88430000 ffffffff883acfa0 0000000000000080
        ffffffff882da754 0000000000000080 0000000000000100 0000000000000000
        ffffffff8fc16140 ffffffff8808cdb4 0000001e00000000 0000000000000000
        0000000000000001 ffffffffffffff80 0000000000000000 0000000000000000
        0000000000000000 0000000000000014 ffffffff883acfb0 ffffffff883f57f8
        0000000000040000 ffffffff883acfa0 ffffffff883ad118 ffffffff88430058
        ffffffff883f0000 ffffffff883b0000 ffffffff88430000 ffffffff883e69a0
        ...
Call Trace:
[<ffffffff8808bb5c>] cache_alloc_refill+0x8c/0x710
[<ffffffff8808bac8>] kmem_cache_alloc+0xe0/0xe8
[<ffffffff882da754>] setup_cpu_cache+0x64/0x168
[<ffffffff8808cdb4>] kmem_cache_create+0x37c/0x548
[<ffffffff883e69a0>] kmem_cache_init+0x428/0x430
[<ffffffff883cfb18>] start_kernel+0x270/0x3d8


Code: 14e00002  24020001  2d620001 <00028036> dd720040  1240000d  00000000 =
 8e030004  8e450000=20
Kernel panic - not syncing: Attempted to kill the idle task!

--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHQbVRUaz2rXW+gJcRAsqWAJ9cTvCVY8OP8DuJRdQElK+fKluH1QCgtu5m
iq2DvF3KH460SIn+Q1f2qhg=
=R2g6
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 10:07:50 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.179]:56081 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492300AbZGHIHp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2009 10:07:45 +0200
Received: by wa-out-1112.google.com with SMTP id n4so918928wag.0
        for <linux-mips@linux-mips.org>; Wed, 08 Jul 2009 01:07:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=GZaNC06CxWQAyCEhX4dnweaxxQw4LZpCFZNu3S+hEZk=;
        b=enjSWOX1cHiyUkghqAOXImijOMP7nEixAE1UuaJHtaoRFjDmK5xfQAQClK+jZW8LZO
         8XaNjv/jHEofju4fsZjc66YCjWjVsQ0ARzJFPkLiFsljT45iqILvs0RItFLaQPbgVrV5
         ddwgJ2ZJrFoHarLGhn/aQC3hmHSoTB8VeCM6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=QUIFp5a7GZ+EzYkMQZ4NDRbUTNmOrUU7PK4z8QBUDENjkIaptJ5qCklkwW317qxdk0
         QhGUBw9/IHxond70i4iFh8rgvpQOQYmA3G3B/QbInbc8lj9txlZg06i75VnAc01TVjJD
         pHRCAOa2z2F/UmsI2sdwL+n9241Sw/rwbFjhM=
MIME-Version: 1.0
Received: by 10.114.79.18 with SMTP id c18mr10901723wab.149.1247040462985; 
	Wed, 08 Jul 2009 01:07:42 -0700 (PDT)
Date:	Wed, 8 Jul 2009 13:37:42 +0530
Message-ID: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com>
Subject: Linux port failing on MIPS32 24Kc
From:	joe seb <joe.seb8@gmail.com>
To:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016364c66f3d11ae7046e2d3b05
Return-Path: <joe.seb8@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe.seb8@gmail.com
Precedence: bulk
X-list: linux-mips

--0016364c66f3d11ae7046e2d3b05
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

We are trying to port linux 2.6.29.4 version of the kernel from
linux-mips.org site to our MIPS 24K based platform and we see issues when we
use the cache in write-back mode. Cache with write-through configuration
works fine.
We use:
Linux kernel - 2.6.29.4
GNU cross tools - 4.3.2
Busybox - 1.14.1
U-boot - 2009.03

Our platform has 256MB of RAM and its mapped to second 256 MB of the KSEG0
(0x90000000 - 0x9FFFFFFF) and KSEG1 (0xB0000000 - 0xBFFFFFFF), and we
specify that "mem=16M@256M" as boot parameter (we just want to use the first
16MB by the kernel). The cache initialization for the KSEG0 is done in
u-boot.

The error we get when cache is configured as write-back is given below:

--------------------
Linux version 2.6.29.4 (gcc version 4.3.2 (Sourcery G
++ Lite 4.3-51) ) #11 PREEMPT Tue Jul 7 21:16:00 IST 2009
CPU revision is: 0101937c (MIPS 24Kc)
Determined physical RAM map:
User-defined physical RAM map:
 memory: 01000000 @ 10000000 (usable)
Wasting 2097152 bytes for tracking 65536 unused pages
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal   0x00010000 -> 0x00011000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00010000 -> 0x00011000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: mem=16M@256M console=ttyS0,9600 cca=3
Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
Using cache attribute 3
Writing ErrCtl register=00000000
Readback ErrCtl register=00000000
PID hash table entries: 64 (order: 6, 256 bytes)
CPU frequency 50.00 MHz
console [ttyS0] enabled
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13776k/16384k available (1210k kernel code, 2608k reserved, 234k
data, 6
76k init, 0k highmem)
Calibrating delay loop... 33.17 BogoMIPS (lpj=165888)
Mount-cache hash table entries: 512
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 26
Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
serial8250: ttyS0 at MMIO 0xa1a30000 (irq = 188) is a 16550A
serial8250: ttyS1 at MMIO 0xa1a40000 (irq = 189) is a 16550A
Freeing unused kernel memory: 676k freed
Algorithmics/MIPS FPU Emulator v1.5
CPU 0 Unable to handle kernel paging request at virtual address cccccccc,
epc ==
 cccccccc, ra == cccccccc
Oops[#1]:
Cpu 0
$ 0   : 00000000 0053934a 00000000 00000001
$ 4   : 00000001 00000000 00000000 0000009a
$ 8   : 00000010 900038c0 00532730 00532730
$12   : 00000018 90284880 00020000 00000034
$16   : cccccccc 9016c320 9016aae0 90213520
$20   : 00000000 9016a960 00000001 90fa9680
$24   : 00000000 9009a414
$28   : 90176000 90177d58 9016aae0 cccccccc
Hi    : 0000000d
Lo    : 0000004a
epc   : cccccccc 0xcccccccc
    Not tainted
ra    : cccccccc 0xcccccccc
Status: 10004403    KERNEL EXL IE
Cause : 10800008
BadVA : cccccccc
PrId  : 0101937c (MIPS 24Kc)
Process rcS (pid: 11, threadinfo=90176000, task=90200500, tls=0053f470)
Stack : cccccccc cccccccc 90200500 9016aae0 90213520 00000000 90213520
00000000
        9016aae0 90213520 00000000 90025c28 90200500 90faf9c0 90200500
00000107
        9016aae0 00000107 9016aae0 900a04c8 00000003 902a4a40 902a4a48
00000000
        902a4a44 900b3ad8 90fb1880 90fa9680 00000000 00000003 90fb1880
90fa9680
        90177f30 90da7b20 cccccccc cccccccc cccccccc cccccccc cccccccc
cccccccc
        ...
Call Trace:
[<90025c28>] mmput+0x9c/0x194
[<900a04c8>] flush_old_exec+0x47c/0x988
[<900b3ad8>] alloc_fd+0x9c/0x1a4
[<90086c88>] handle_mm_fault+0x9a8/0x107c
[<9002f7c4>] do_softirq+0xc8/0xd0
[<900cc60c>] load_elf_binary+0x0/0x1410
[<9009fd9c>] search_binary_handler+0xa0/0x2bc
[<900a138c>] do_execve+0x298/0x300
[<900a4c60>] getname+0x28/0xc8
[<9000c714>] sys_execve+0x4c/0x78
[<90002398>] stack_done+0x20/0x3c

Code: (Bad address in epc)
do_cpu invoked from kernel context![#2]:
Cpu 0
$ 0   : 00000000 90210000 9016a98c 00000001
$ 4   : 00000002 00000003 90168468 00000000
$ 8   : 000007c4 00000004 9016846c 00000001
$12   : ffffff80 00000000 90136f7c 00000010
$16   : 00000000 00000000 90200500 90213520
$20   : 9016a994 90177ca8 00000000 90fa9680
$24   : 00000000 90121648
$28   : 90176000 90177b48 9016aae0 90fa9680
Hi    : 0098963b
Lo    : 38c9b600
epc   : 90fa9680 0x90fa9680
    Tainted: G      D
ra    : 90fa9680 0x90fa9680
Status: 10004403    KERNEL EXL IE
Cause : 1080002c
PrId  : 0101937c (MIPS 24Kc)
Process rcS (pid: 11, threadinfo=90176000, task=90200500, tls=0053f470)
Stack : 9016aae0 900041c4 00000000 00000000 90177ca8 90177ca8 0000000b
90200500
        90200500 cccccccc 00000000 9002cc78 90200658 9016a960 9020065c
90213520
        90152d44 90177ca8 00000001 cccccccc 00000000 90177ca8 90152d44
90177ca8
        90200500 cccccccc 00000000 90177ca8 00000000 90fa9680 9016aae0
9000e0d4
        cccccccc 90220000 ffffffff 00000e89 90177bec cccccccc 9016a960
90010f58
        ...
Call Trace:
[<900041c4>] printk+0x24/0x30
[<9002cc78>] do_exit+0xf4/0x88c
[<9000e0d4>] nmi_exception_handler+0x0/0x34
[<90010f58>] do_page_fault+0x2e0/0x350
[<90070234>] rmqueue_bulk+0x54/0xd8
[<900b0d48>] touch_atime+0xf8/0x174
[<9006c7e8>] generic_file_aio_read+0x4d8/0x8d8
[<90000404>] ret_from_exception+0x0/0x10
[<900038c0>] __bzero+0xc4/0x164
[<9009a414>] do_sync_read+0x0/0x168
[<90025c28>] mmput+0x9c/0x194
[<900a04c8>] flush_old_exec+0x47c/0x988
[<900b3ad8>] alloc_fd+0x9c/0x1a4
[<90086c88>] handle_mm_fault+0x9a8/0x107c
[<9002f7c4>] do_softirq+0xc8/0xd0
[<900cc60c>] load_elf_binary+0x0/0x1410
[<9009fd9c>] search_binary_handler+0xa0/0x2bc
[<900a138c>] do_execve+0x298/0x300
[<900a4c60>] getname+0x28/0xc8
[<9000c714>] sys_execve+0x4c/0x78
[<90002398>] stack_done+0x20/0x3c

Code: 040a001a  e5a8b400  4018e618 <464c457f> 00010101  00000000  00000000
0008
0002  00000001
Fixing recursive fault but reboot is needed!
-------------------------------

We get crashes at different places and the above crash is one of them.
Do you think this failure is due to the wrong cache configuration or related
to the d-cache aliasing problem?

The cache details of our platform:
D-cache: 32KB, 4-way, 32B line size, virtually indexed and physically
tagged, Config7[AR] bit is set (alias is removed by the hardware).
I-cache:  32KB, 4-way, 32B line size,virtually indexed and physically tagged


Is there any similar 24k platform supported in linux kernel which we are
refer for the configurations?


Thanks and Regards
Joe

--0016364c66f3d11ae7046e2d3b05
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi,</p>
<p>We are trying to port linux 2.6.29.4 version of the kernel from <a href=
=3D"http://linux-mips.org">linux-mips.org</a> site to our MIPS 24K based pl=
atform and we see issues when we use the cache in write-back mode. Cache wi=
th write-through configuration works fine.<br>
We use:<br>Linux kernel - 2.6.29.4<br>GNU cross tools - 4.3.2<br>Busybox - =
1.14.1<br>U-boot - 2009.03</p>
<p>Our platform has 256MB of RAM and its mapped to second 256 MB of the KSE=
G0 (0x90000000 - 0x9FFFFFFF) and KSEG1 (0xB0000000 - 0xBFFFFFFF), and we sp=
ecify that &quot;<a href=3D"mailto:mem=3D16M@256M">mem=3D16M@256M</a>&quot;=
 as boot parameter (we just want to use the first 16MB by the kernel). The =
cache initialization for the KSEG0 is done in u-boot. </p>

<p>The error we get when cache is configured as write-back is given below:<=
/p>
<p>--------------------<br>Linux version 2.6.29.4 (gcc version 4.3.2 (Sourc=
ery G<br>++ Lite 4.3-51) ) #11 PREEMPT Tue Jul 7 21:16:00 IST 2009<br>CPU r=
evision is: 0101937c (MIPS 24Kc)<br>Determined physical RAM map:<br>User-de=
fined physical RAM map:<br>
=A0memory: 01000000 @ 10000000 (usable)<br>Wasting 2097152 bytes for tracki=
ng 65536 unused pages<br>Initrd not found or empty - disabling initrd<br>Zo=
ne PFN ranges:<br>=A0 Normal=A0=A0 0x00010000 -&gt; 0x00011000<br>Movable z=
one start PFN for each node<br>
early_node_map[1] active PFN ranges<br>=A0=A0=A0 0: 0x00010000 -&gt; 0x0001=
1000<br>Built 1 zonelists in Zone order, mobility grouping off.=A0 Total pa=
ges: 4064<br>Kernel command line: <a href=3D"mailto:mem=3D16M@256M">mem=3D1=
6M@256M</a> console=3DttyS0,9600 cca=3D3<br>
Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.<br>Primary =
data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes<br>Using cache =
attribute 3<br>Writing ErrCtl register=3D00000000<br>Readback ErrCtl regist=
er=3D00000000<br>
PID hash table entries: 64 (order: 6, 256 bytes)<br>CPU frequency 50.00 MHz=
<br>console [ttyS0] enabled<br>Dentry cache hash table entries: 2048 (order=
: 1, 8192 bytes)<br>Inode-cache hash table entries: 1024 (order: 0, 4096 by=
tes)<br>
Memory: 13776k/16384k available (1210k kernel code, 2608k reserved, 234k da=
ta, 6<br>76k init, 0k highmem)<br>Calibrating delay loop... 33.17 BogoMIPS =
(lpj=3D165888)<br>Mount-cache hash table entries: 512<br>VFS: Disk quotas d=
quot_6.5.2<br>
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)<br>msgmni has be=
en set to 26<br>Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled<br>=
serial8250: ttyS0 at MMIO 0xa1a30000 (irq =3D 188) is a 16550A<br>serial825=
0: ttyS1 at MMIO 0xa1a40000 (irq =3D 189) is a 16550A<br>
Freeing unused kernel memory: 676k freed<br>Algorithmics/MIPS FPU Emulator =
v1.5<br>CPU 0 Unable to handle kernel paging request at virtual address ccc=
ccccc, epc =3D=3D<br>=A0cccccccc, ra =3D=3D cccccccc<br>Oops[#1]:<br>Cpu 0<=
br>$ 0=A0=A0 : 00000000 0053934a 00000000 00000001<br>
$ 4=A0=A0 : 00000001 00000000 00000000 0000009a<br>$ 8=A0=A0 : 00000010 900=
038c0 00532730 00532730<br>$12=A0=A0 : 00000018 90284880 00020000 00000034<=
br>$16=A0=A0 : cccccccc 9016c320 9016aae0 90213520<br>$20=A0=A0 : 00000000 =
9016a960 00000001 90fa9680<br>
$24=A0=A0 : 00000000 9009a414=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 <br>$28=A0=A0 : 90176000 90177d58 9016aae0 cccccccc<br>Hi=A0=A0=A0 :=
 0000000d<br>Lo=A0=A0=A0 : 0000004a<br>epc=A0=A0 : cccccccc 0xcccccccc<br>=
=A0=A0=A0 Not tainted<br>ra=A0=A0=A0 : cccccccc 0xcccccccc<br>Status: 10004=
403=A0=A0=A0 KERNEL EXL IE <br>
Cause : 10800008<br>BadVA : cccccccc<br>PrId=A0 : 0101937c (MIPS 24Kc)<br>P=
rocess rcS (pid: 11, threadinfo=3D90176000, task=3D90200500, tls=3D0053f470=
)<br>Stack : cccccccc cccccccc 90200500 9016aae0 90213520 00000000 90213520=
 00000000<br>
=A0=A0=A0=A0=A0=A0=A0 9016aae0 90213520 00000000 90025c28 90200500 90faf9c0=
 90200500 00000107<br>=A0=A0=A0=A0=A0=A0=A0 9016aae0 00000107 9016aae0 900a=
04c8 00000003 902a4a40 902a4a48 00000000<br>=A0=A0=A0=A0=A0=A0=A0 902a4a44 =
900b3ad8 90fb1880 90fa9680 00000000 00000003 90fb1880 90fa9680<br>
=A0=A0=A0=A0=A0=A0=A0 90177f30 90da7b20 cccccccc cccccccc cccccccc cccccccc=
 cccccccc cccccccc<br>=A0=A0=A0=A0=A0=A0=A0 ...<br>Call Trace:<br>[&lt;9002=
5c28&gt;] mmput+0x9c/0x194<br>[&lt;900a04c8&gt;] flush_old_exec+0x47c/0x988=
<br>[&lt;900b3ad8&gt;] alloc_fd+0x9c/0x1a4<br>
[&lt;90086c88&gt;] handle_mm_fault+0x9a8/0x107c<br>[&lt;9002f7c4&gt;] do_so=
ftirq+0xc8/0xd0<br>[&lt;900cc60c&gt;] load_elf_binary+0x0/0x1410<br>[&lt;90=
09fd9c&gt;] search_binary_handler+0xa0/0x2bc<br>[&lt;900a138c&gt;] do_execv=
e+0x298/0x300<br>
[&lt;900a4c60&gt;] getname+0x28/0xc8<br>[&lt;9000c714&gt;] sys_execve+0x4c/=
0x78<br>[&lt;90002398&gt;] stack_done+0x20/0x3c</p>
<p>Code: (Bad address in epc)<br>do_cpu invoked from kernel context![#2]:<b=
r>Cpu 0<br>$ 0=A0=A0 : 00000000 90210000 9016a98c 00000001<br>$ 4=A0=A0 : 0=
0000002 00000003 90168468 00000000<br>$ 8=A0=A0 : 000007c4 00000004 9016846=
c 00000001<br>
$12=A0=A0 : ffffff80 00000000 90136f7c 00000010<br>$16=A0=A0 : 00000000 000=
00000 90200500 90213520<br>$20=A0=A0 : 9016a994 90177ca8 00000000 90fa9680<=
br>$24=A0=A0 : 00000000 90121648=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 <br>$28=A0=A0 : 90176000 90177b48 9016aae0 90fa9680<br>
Hi=A0=A0=A0 : 0098963b<br>Lo=A0=A0=A0 : 38c9b600<br>epc=A0=A0 : 90fa9680 0x=
90fa9680<br>=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0 D=A0=A0 <br>ra=A0=A0=A0 : 9=
0fa9680 0x90fa9680<br>Status: 10004403=A0=A0=A0 KERNEL EXL IE <br>Cause : 1=
080002c<br>PrId=A0 : 0101937c (MIPS 24Kc)<br>Process rcS (pid: 11, threadin=
fo=3D90176000, task=3D90200500, tls=3D0053f470)<br>
Stack : 9016aae0 900041c4 00000000 00000000 90177ca8 90177ca8 0000000b 9020=
0500<br>=A0=A0=A0=A0=A0=A0=A0 90200500 cccccccc 00000000 9002cc78 90200658 =
9016a960 9020065c 90213520<br>=A0=A0=A0=A0=A0=A0=A0 90152d44 90177ca8 00000=
001 cccccccc 00000000 90177ca8 90152d44 90177ca8<br>
=A0=A0=A0=A0=A0=A0=A0 90200500 cccccccc 00000000 90177ca8 00000000 90fa9680=
 9016aae0 9000e0d4<br>=A0=A0=A0=A0=A0=A0=A0 cccccccc 90220000 ffffffff 0000=
0e89 90177bec cccccccc 9016a960 90010f58<br>=A0=A0=A0=A0=A0=A0=A0 ...<br>Ca=
ll Trace:<br>[&lt;900041c4&gt;] printk+0x24/0x30<br>
[&lt;9002cc78&gt;] do_exit+0xf4/0x88c<br>[&lt;9000e0d4&gt;] nmi_exception_h=
andler+0x0/0x34<br>[&lt;90010f58&gt;] do_page_fault+0x2e0/0x350<br>[&lt;900=
70234&gt;] rmqueue_bulk+0x54/0xd8<br>[&lt;900b0d48&gt;] touch_atime+0xf8/0x=
174<br>
[&lt;9006c7e8&gt;] generic_file_aio_read+0x4d8/0x8d8<br>[&lt;90000404&gt;] =
ret_from_exception+0x0/0x10<br>[&lt;900038c0&gt;] __bzero+0xc4/0x164<br>[&l=
t;9009a414&gt;] do_sync_read+0x0/0x168<br>[&lt;90025c28&gt;] mmput+0x9c/0x1=
94<br>
[&lt;900a04c8&gt;] flush_old_exec+0x47c/0x988<br>[&lt;900b3ad8&gt;] alloc_f=
d+0x9c/0x1a4<br>[&lt;90086c88&gt;] handle_mm_fault+0x9a8/0x107c<br>[&lt;900=
2f7c4&gt;] do_softirq+0xc8/0xd0<br>[&lt;900cc60c&gt;] load_elf_binary+0x0/0=
x1410<br>
[&lt;9009fd9c&gt;] search_binary_handler+0xa0/0x2bc<br>[&lt;900a138c&gt;] d=
o_execve+0x298/0x300<br>[&lt;900a4c60&gt;] getname+0x28/0xc8<br>[&lt;9000c7=
14&gt;] sys_execve+0x4c/0x78<br>[&lt;90002398&gt;] stack_done+0x20/0x3c</p>

<p>Code: 040a001a=A0 e5a8b400=A0 4018e618 &lt;464c457f&gt; 00010101=A0 0000=
0000=A0 00000000=A0 0008<br>0002=A0 00000001 <br>Fixing recursive fault but=
 reboot is needed!<br>-------------------------------</p>
<p>We get crashes at different places and the=A0above=A0crash is one=A0of t=
hem. </p>
<div>Do you think this failure is due to the wrong cache configuration or r=
elated to the d-cache aliasing problem?</div>
<div><br>The cache details of our platform:<br>D-cache: 32KB, 4-way, 32B li=
ne size, virtually indexed and physically tagged, Config7[AR] bit is set (a=
lias is removed by the hardware). <br>I-cache:=A0 32KB, 4-way, 32B line siz=
e,virtually indexed and physically tagged </div>

<p>Is there any similar 24k platform supported in linux kernel which we are=
 refer for the configurations? </p>
<p><br>Thanks and Regards<br>Joe</p>

--0016364c66f3d11ae7046e2d3b05--

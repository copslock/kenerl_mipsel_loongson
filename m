Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jul 2004 10:09:59 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:38607 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225362AbUGGJJy>; Wed, 7 Jul 2004 10:09:54 +0100
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc12) with ESMTP
          id <2004070709094701200t9307e>
          (Authid: kumba12345);
          Wed, 7 Jul 2004 09:09:47 +0000
Message-ID: <40EBBE66.2000605@gentoo.org>
Date: Wed, 07 Jul 2004 05:12:06 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: 2.6.7 + gcc-3.4.1 = bada boom
Content-Type: multipart/mixed;
 boundary="------------060201020207080706050901"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060201020207080706050901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Gave a shot at building a 2.6.7-bk13 kernel checkout (20040707) for SGI 
O2 w/ gcc-3.4.1.  Didn't get very far...

First was the old "accum" issue visited back in April[1].  Maciej posted 
a patch to 2.4, which I used to generate a similar patch for 2.6. 
arch/mips/kernel/time.c needed the same four removals of accum as the 
2.4 patch did, but there was one instance of "accum" in 
arch/mips/kernel/cpu-bugs64.c (which seems to be the one accum Maciej's 
2.4 patch removed from cpu-probe.c).  The attached patch removes these 
as per the discussion in April.

Following that, the build, while filled with a gazillion warnings about 
passing different var types to functions, built fine.  The resulting 
kernel even booted -- a little.  The second attached file has the Oops, 
which happens right after "Checking for the daddiu bug... no.".

Ideas on this, anyone?  I haven't tried this on a raq2/mipsel yet, but I 
can if needed


--Kumba


[1]: http://www.linux-mips.org/archives/linux-mips/2004-04/msg00049.html

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond

--------------060201020207080706050901
Content-Type: text/plain;
 name="sgi-o2-2607bk13-gcc341-b00m.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sgi-o2-2607bk13-gcc341-b00m.txt"

System Maintenance Menu

1) Start System
2) Install System Software
3) Run Diagnostics
4) Recover System
5) Enter Command Monitor

Option? 5
Command Monitor.  Type "exit" to return to the menu.
>
>
> bootp(): root=/dev/sda3 console=ttyS0,38400
Setting $netaddr to 192.168.1.12 (from server )
Obtaining  from server
5034117+171179 entry: 0xffffffff8046f020
Linux version 2.6.7-mipscvs-20040707 (root@khazad-dum) (gcc version 3.4.1 (Gentoo Linux 3.4.1, ssp-3.4-2, pie-8.7.6.3)) #2 Wed Jul 7 04
:18:31 EDT 2004
ARCH: SGI-IP32
PROMLIB: ARC firmware Version 1 Revision 10
CPU revision is: 00002321
FPU revision is: 00002310
CRIME id a rev 1 at 0x0000000014000000
Determined physical RAM map:
 memory: 0000000000002000 @ 0000000000000000 (reserved)
 memory: 0000000000002000 @ 0000000000002000 (usable)
 memory: 00000000004f7000 @ 0000000000004000 (reserved)
 memory: 0000000000855000 @ 00000000004fb000 (usable)
 memory: 00000000002b0000 @ 0000000000d50000 (ROM data)
 memory: 0000000000100000 @ 0000000001000000 (reserved)
 memory: 0000000000300000 @ 0000000001100000 (ROM data)
 memory: 000000000ac00000 @ 0000000001400000 (usable)
On node 0 totalpages: 49152
  DMA zone: 49152 pages, LIFO batch:12
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/sda3 console=ttyS0,38400 root=/dev/sda3 console=ttyS0,38400
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB 2-way, linesize 32 bytes.
R5000 SCACHE size 1024kB, linesize 32 bytes.
PID hash table entries: 1024 (order 10: 16384 bytes)
Calibrating system timer... 200 MHz CPU detected
Using 100.250 MHz high precision timer.
Console: colour dummy device 80x25
CRIME memory error at 0x3fffffe0 ST 0x0400a828<INV,RE,REID=0x28,NONFATAL>
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Memory: 181248k/184668k available (3279k kernel code, 3164k reserved, 1241k data, 396k init, 0k highmem)
Calibrating delay loop... 199.68 BogoMIPS
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  available.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
CPU 0 Unable to handle kernel paging request at virtual address 0000000000000028, epc == ffffffff80088290, ra == ffffffff80088298
Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:
Cpu 0
$ 0   : 0000000000000000 0000000000000018 0000000000000000 ffffffff80398000
$ 4   : ffffffff81715d60 0000000000000000 0000000000000000 000000000000000d
$ 8   : ffffffff8bfd0068 ffffffffffffffff ffffffff8bfd0010 000000000000ffff
$12   : 0000000000000030 ffffffff8020bc44 ffffffff8bfd2e40 ffffffffffffffff
$16   : 0000000000000000 ffffffffffffffe9 ffffffff81715e60 ffffffff81715d60
$20   : ffffffffa13fb98c ffffffff81072430 ffffffff81054100 0000000000000000
$24   : 0000000000000001 0000000000000020
$28   : ffffffff8038c000 ffffffff8038fd80 0000000000000001 ffffffff80088298
Hi    : 0000000000000000
Lo    : 0000000000000e00
epc   : ffffffff80088290 pgd_current+0xfffffffeffb8d568/0xfffffffeffe3d050     Not tainted
ra    : ffffffff80088298 pgd_current+0xfffffffeffb8d570/0xfffffffeffe3d050
Status: 9401fce3    KX SX UX KERNEL EXL IE
Cause : 80000008
BadVA : 0000000000000028
PrId  : 00002321
Process swapper (pid: 0, threadinfo=ffffffff8038c000, task=ffffffff80398000)
Stack : 0000000000000004 0000000000000000 ffffffff803b97c0 0000000000000004
        0000000000000800 000000000000003c 000000000000003e 0000000000000004
        ffffffff8038fe20 0000000000000000 0000000000000000 ffffffff80004470
        0000000000800b00 ffffffffa13fb028 ffffffffa13fb98c ffffffff81072430
        ffffffff81054100 0000000000000000 0000000000000001 ffffffff8000c7f8
        000000000000003c ffffffff8003a928 ffffffff800102f8 ffffffffa13fb028
        0000000000000000 ffffffff81072430 00000000000013bf 0000000000000001
        0000000000800b00 0000000000000000 ffffffff8038ff70 dfffffffffffffff
        ffffffff804d3f50 0000000000000804 0000000000000001 0000000000000100
        0000000000000000 ffffffff804ef1a8 0000000000000000 0000000000000800
        ...
Call Trace:
 [<ffffffff80004470>] pgd_current+0xfffffffeffb09748/0xfffffffeffe3d050
 [<ffffffff8000c7f8>] pgd_current+0xfffffffeffb11ad0/0xfffffffeffe3d050
 [<ffffffff8003a928>] pgd_current+0xfffffffeffb3fc00/0xfffffffeffe3d050
 [<ffffffff800102f8>] pgd_current+0xfffffffeffb155d0/0xfffffffeffe3d050
 [<ffffffff80004470>] pgd_current+0xfffffffeffb09748/0xfffffffeffe3d050
 [<ffffffff8000441c>] pgd_current+0xfffffffeffb096f4/0xfffffffeffe3d050
 [<ffffffff8000aa80>] pgd_current+0xfffffffeffb0fd58/0xfffffffeffe3d050
 [<ffffffff8000441c>] pgd_current+0xfffffffeffb096f4/0xfffffffeffe3d050
 [<ffffffff8046f8d4>] pgd_current+0xfffffffefff74bac/0xfffffffefff932b8
 [<ffffffff8046f8cc>] pgd_current+0xfffffffefff74ba4/0xfffffffefff932b8
 [<ffffffff8046f0a0>] pgd_current+0xfffffffefff74378/0xfffffffefff932b8


Code: 0040982d  3c02804e  dc4251d0 <0c0255e6> dc440028  10400098  0040802d  0c02205a  0040202d
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

--------------060201020207080706050901
Content-Type: text/plain;
 name="mipscvs-2.6.7-remove-accum.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mipscvs-2.6.7-remove-accum.patch"

--- arch/mips/kernel/time.c.orig	2004-07-07 03:56:59.819260432 -0400
+++ arch/mips/kernel/time.c	2004-07-07 03:58:16.645581056 -0400
@@ -278,7 +278,7 @@ static unsigned long fixed_rate_gettimeo
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (sll32_usecs_per_cycle)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -333,7 +333,7 @@ static unsigned long calibrate_div32_get
 	__asm__("multu  %1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
@@ -375,7 +375,7 @@ static unsigned long calibrate_div64_get
 				: "r" (timerhi), "m" (timerlo),
 				  "r" (tmp), "r" (USECS_PER_JIFFY),
 				  "r" (USECS_PER_JIFFY_FRAC)
-				: "hi", "lo", "accum");
+				: "hi", "lo");
 			cached_quotient = quotient;
 		}
 	}
@@ -389,7 +389,7 @@ static unsigned long calibrate_div64_get
 	__asm__("multu	%1,%2"
 		: "=h" (res)
 		: "r" (count), "r" (quotient)
-		: "lo", "accum");
+		: "lo");
 
 	/*
 	 * Due to possible jiffies inconsistencies, we need to check
--- arch/mips/kernel/cpu-bugs64.c.orig	2004-07-07 04:54:01.762046056 -0400
+++ arch/mips/kernel/cpu-bugs64.c	2004-07-07 04:54:26.501285120 -0400
@@ -82,7 +82,7 @@ static inline void mult_sh_align_mod(lon
 		".set	pop"
 		: "=&r" (lv1), "=r" (lw)
 		: "r" (m1), "r" (m2), "r" (s), "I" (0)
-		: "hi", "lo", "accum");
+		: "hi", "lo");
 	/* We have to use single integers for m1 and m2 and a double
 	 * one for p to be sure the mulsidi3 gcc's RTL multiplication
 	 * instruction has the workaround applied.  Older versions of

--------------060201020207080706050901--

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1139lU20711
	for linux-mips-outgoing; Thu, 31 Jan 2002 19:09:47 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1139Vd20647
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 19:09:31 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1129TX07897
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 18:09:29 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: One bug fixed, another found?
Date: Thu, 31 Jan 2002 18:09:29 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAICEDFCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Well, it appears that I managed to track down the first cause of the
crashes.  The memory map was configured one way, but the
add_memory_region() calls were mapping it out another way.  It works
much better when the map is the same, with contiguous or discontiguous
memory.  Actually, it works very well under the "rebuild ncftp" test I
was doing.

So, of course, I had to find another test which caused a problem.  I
moved on to encoding MP3s useing bladenc (it's also a good chance to
do some benchmarking relative to other CPUs).

But now I've found another bug.  I've applied my fix to kernels from
2.4.3 to 2.4.17 (what I'm running now).  It's repeatable with all I've
tried.  The oops below is 2.4.17 using NFS root.  I've tried using a
disk-based root, but every attempt to mkfs the partition winds up
crashing in a manner similar to this.  Actually, almost the same --
same virtual address, epc, and ra.

Now, I'm running into something different.  If I load down the system
using bladeenc, I eventually get this (usually after several minutes
of successful processing):

Unable to handle kernel paging request at virtual address fffffffc,
epc == 8010b1ec, ra == 8010b19c
Oops in fault.c:do_page_fault, line 204:

The decoded oops is below... one thing that is different about this
problem is that it oopses with the exact (or almost exact) same
virtual address, epc, and ra _every_time_.  It's almost enough to make
me wonder if there is a bug in __wake_up().  The crashes using
mkfs.ext2 take a slightly different path, but they still wind up in
alloc_pages and die is exactly the same place.

Does anyone recogize this?  The virtual address makes me immediately
suspicious, but I'm just not certain what this means.  The relevant
code is all in linux/mm/page_alloc.c -- I'm still kinda new to this
section of the kernel, but I'm guessing that if there really was a bug
in this section of code, it would have affected a great many people
before me.

Matt

Unable to handle kernel paging request at virtual address fffffffc,
epc == 8010b
1ec, ra == 8010b19c
$0 : 00000000 b0045400 00000000 00000000 00000017 802d51cc 92bdc000
93e7d120
$8 : 92bdc000 b0045401 00000000 00000000 00000000 00000000 00000088
00000000
$16: 00000000 b0045400 00000001 b0045401 802de998 802dad88 00000001
92ce1160
$24: 00000000 2acce4e0                   92bdc000 92bddd68 92bddd68
8010b19c
epc  : 8010b1ec    Not tainted
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: b0045402
Cause : 80008008
Process bladeenc (pid: 660, stackpage=92bdc000)
Stack: 92bddd68 92bddd68 92bddd68 92bddd68 802df378 00000001 00000000
93ff8bf0
       802df1fc 802df36c 000001d2 92bc4060 8012c588 8012c528 00001000
92bc4060
       00000000 92bc4060 81018fc0 92ce1160 00000005 92bc4120 00001a55
93ff8bf0
       92ce1160 0000001f 00001000 8012c180 81018fc0 92bc4120 00001a54
93ff8bec
       80122aa0 80122af8 93f036c0 00000000 80170988 80170980 00000005
00001a50
       92ce1160 ...
Call Trace: [<8012c588>] [<8012c528>] [<8012c180>] [<80122aa0>]
[<80122af8>] [<8
0170988>]
 [<80170980>] [<801233ec>] [<8012372c>] [<8012377c>] [<80126198>]
[<80123d80>]
 [<80123c78>] [<801680dc>] [<8010703c>] [<8013290c>] [<80113158>]
[<80106508>]
 [<80106508>]
Code: 12400004  00000000  8e100000 <5614ffcc> 8e05fffc  40016000
32730001  3421
0001  38210001

>>RA;  8010b19c <__wake_up+ec/198>
>>PC;  8010b1ec <__wake_up+13c/198>   <=====
Trace; 8012c588 <__alloc_pages+d0/21c>
Trace; 8012c528 <__alloc_pages+70/21c>
Trace; 8012c180 <_alloc_pages+20/2c>
Trace; 80122aa0 <page_cache_read+a0/11c>
Trace; 80122af8 <page_cache_read+f8/11c>
Trace; 80170988 <nfs_updatepage+218/314>
Trace; 80170980 <nfs_updatepage+210/314>
Trace; 801233ec <generic_file_readahead+174/1ec>
Trace; 8012372c <do_generic_file_read+24c/51c>
Trace; 8012377c <do_generic_file_read+29c/51c>
Trace; 80126198 <generic_file_write+558/828>
Trace; 80123d80 <generic_file_read+94/1a0>
Trace; 80123c78 <file_read_actor+0/74>
Trace; 801680dc <nfs_file_read+cc/ec>
Trace; 8010703c <handle_IRQ_event+80/f4>
Trace; 8013290c <sys_read+d8/130>
Trace; 80113158 <sys_time+18/5c>
Trace; 80106508 <stack_done+1c/38>
Trace; 80106508 <stack_done+1c/38>
Code;  8010b1e0 <__wake_up+130/198>
00000000 <_PC>:
Code;  8010b1e0 <__wake_up+130/198>
   0:   12400004  beqz    s2,14 <_PC+0x14> 8010b1f4
<__wake_up+144/198>
Code;  8010b1e4 <__wake_up+134/198>
   4:   00000000  nop
Code;  8010b1e8 <__wake_up+138/198>
   8:   8e100000  lw      s0,0(s0)
Code;  8010b1ec <__wake_up+13c/198>   <=====
   c:   5614ffcc  0x5614ffcc   <=====
Code;  8010b1f0 <__wake_up+140/198>
  10:   8e05fffc  lw      a1,-4(s0)
Code;  8010b1f4 <__wake_up+144/198>
  14:   40016000  mfc0    at,$12
Code;  8010b1f8 <__wake_up+148/198>
  18:   32730001  andi    s3,s3,0x1
Code;  8010b1fc <__wake_up+14c/198>
  1c:   34210001  ori     at,at,0x1
Code;  8010b200 <__wake_up+150/198>
  20:   38210001  xori    at,at,0x1


--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

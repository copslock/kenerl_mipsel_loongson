Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 18:14:49 +0000 (GMT)
Received: from mail.blastwave.org ([147.87.98.10]:30344 "EHLO
	mail.blastwave.org") by ftp.linux-mips.org with ESMTP
	id S20021429AbXCISOo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Mar 2007 18:14:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.blastwave.org (Postfix) with ESMTP id 42599F9AA
	for <linux-mips@linux-mips.org>; Fri,  9 Mar 2007 19:14:13 +0100 (MET)
X-Virus-Scanned: amavisd-new at blastwave.org
Received: from mail.blastwave.org ([127.0.0.1])
	by localhost (enterprise.blastwave.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pyRv2WYJpeYk for <linux-mips@linux-mips.org>;
	Fri,  9 Mar 2007 19:14:03 +0100 (MET)
Received: from unknown (66-132.63-81.stat.fixnetdata.ch [81.63.132.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.blastwave.org (Postfix) with ESMTP id E4642F957
	for <linux-mips@linux-mips.org>; Fri,  9 Mar 2007 19:14:02 +0100 (MET)
Date:	Fri, 9 Mar 2007 19:13:54 +0100
From:	Attila Kinali <attila@kinali.ch>
To:	linux-mips@linux-mips.org
Subject: crash in first printk of start_kernel
Message-Id: <20070309191354.f962e57b.attila@kinali.ch>
Organization: NERV
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.10.6; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <attila@kinali.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: attila@kinali.ch
Precedence: bulk
X-list: linux-mips

Hi,

I'm currently to bring up a new embedded system we build
using the Alchemy Au1550 CPU. The board itself looks like
a downsized version of the DB1550 evaluation board from AMD,
with 64MB DRAM and a 32MB NOR flash, plus PC-Card controller,
one ethernet port used.

I'm using a 2.6.16.11 (an old snapshot from about last august,
when we started development of another board) that has slight
adjustments in various drivers to accomodate for our platform
specific stuff.

While booting from u-boot works fine, ie it can load the kernel
from tftp, checksum is ok, uncompression is ok. It then jumps
into the kernel but ends up in an exception handler when executing
the first printk in start_kernel (ie the printk(KERN_NOTICE);
at init/main.c:451).

While in the "exception handler" endless loop from u-boot 
ra points to vscnprintf() (lib/vsprintf.c:512)
where it calls vsnprintf() (at line 517).

If i set a breakpoint at lib/vsprintf.c:517 and follow it
into vsnprintf, i get the follwing gdb log:

---
Breakpoint 3, vscnprintf (buf=0x80411548 "", size=0x803b1fac,
    fmt=0x8036f10c "<5>", args=0x803b1fac) at lib/vsprintf.c:517
517             i=vsnprintf(buf,size,fmt,args);
(gdb) step
vsnprintf (buf=0x80411548 "", size=0x400, fmt=0x8036f10c "<5>", args=0xff0000)
    at lib/vsprintf.c:276
276             if (unlikely((int) size < 0)) {
(gdb) next
285             end = buf + size - 1;
(gdb) next
287             if (end < buf - 1) {
(gdb) p end
$1 = 0x80411947 ""
(gdb) p buf
$2 = 0x80411548 ""
---

if i go here further (either next/step or continue), then i end up
in the exception handler. So, it must be something in the asm
of this line:

---
(gdb) disassemble $pc $pc+100
Dump of assembler code from 0x8026612c to 0x80266190:
0xffffffff8026612c <vsnprintf+68>:      addiu   v0,a0,-1
0xffffffff80266130 <vsnprintf+72>:      sltu    v0,s2,v0
0xffffffff80266134 <vsnprintf+76>:      beqz    v0,0x80266144 <vsnprintf+92>
0xffffffff80266138 <vsnprintf+80>:      bltz    a0,0x802461c0 <jffs2_remount_fs+144>
0xffffffff8026613c <vsnprintf+84>:      li      s2,-1
0xffffffff80266140 <vsnprintf+88>:      negu    s6,a0
0xffffffff80266144 <vsnprintf+92>:      lb      v0,0(a2)
0xffffffff80266148 <vsnprintf+96>:      beqz    v0,0x80266190 <vsnprintf+168>
0xffffffff8026614c <vsnprintf+100>:     move    a0,a2
0xffffffff80266150 <vsnprintf+104>:     lb      v1,0(a0)
0xffffffff80266154 <vsnprintf+108>:     li      v0,37
0xffffffff80266158 <vsnprintf+112>:     beq     v1,v0,0x802661dc <vsnprintf+244>
0xffffffff8026615c <vsnprintf+116>:     lbu     a0,4(a0)
0xffffffff80266160 <vsnprintf+120>:     sltu    v0,s2,s0
0xffffffff80266164 <vsnprintf+124>:     bnez    v0,0x80266174 <vsnprintf+140>
0xffffffff80266168 <vsnprintf+128>:     sllv    zero,zero,zero
0xffffffff8026616c <vsnprintf+132>:     sb      a0,0(s0)
0xffffffff80266170 <vsnprintf+136>:     lw      a2,80(sp)
0xffffffff80266174 <vsnprintf+140>:     addiu   s0,s0,1
0xffffffff80266178 <vsnprintf+144>:     addiu   v0,a2,1
0xffffffff8026617c <vsnprintf+148>:     sw      v0,80(sp)
0xffffffff80266180 <vsnprintf+152>:     lb      v1,0(v0)
0xffffffff80266184 <vsnprintf+156>:     move    a0,v0
0xffffffff80266188 <vsnprintf+160>:     bnez    v1,0x80266150 <vsnprintf+104>
0xffffffff8026618c <vsnprintf+164>:     move    a2,v0
End of assembler dump.
---

But if i use stepi from here on, then it looks like that the
BDI2000's breakpoint (both soft and hard) somehow interferes
with the execution of the code:

---
(gdb) display/i $pc
1: x/i $pc  0x8026612c <vsnprintf+68>:  addiu   v0,a0,-1
(gdb) stepi
0xffffffff80266130      287             if (end < buf - 1) {
1: x/i $pc  0x80266130 <vsnprintf+72>:  sltu    v0,s2,v0
(gdb) stepi
287             if (end < buf - 1) {
1: x/i $pc  0x80266134 <vsnprintf+76>:  beqz    v0,0x80266144 <vsnprintf+92>
(gdb) stepi
287             if (end < buf - 1) {
1: x/i $pc  0x80266134 <vsnprintf+76>:  beqz    v0,0x80266144 <vsnprintf+92>
(gdb) stepi
287             if (end < buf - 1) {
1: x/i $pc  0x80266134 <vsnprintf+76>:  beqz    v0,0x80266144 <vsnprintf+92>
(gdb) stepi
287             if (end < buf - 1) {
1: x/i $pc  0x80266134 <vsnprintf+76>:  beqz    v0,0x80266144 <vsnprintf+92>
(gdb) stepi
---

Yes, the next instruction (bltz    a0,0x802461c0 <jffs2_remount_fs+144>)
looks fishy and should be most probably a NOP. If i patch this point
by hand and continue it crashes at another point.

The only two reasons why the instruction at this point could be
wrong, is either a gcc bug or a bug in u-boot's gunzip function.
And i somewhat doubt both. gcc is a 3.3.1 from Montavista and both
gcc and u-boot work on our other board which has a similar layout.

Has anyone an idea what the problem here could be or how i could
narrow it down?

Thanks in advance

			Attila Kinali

-- 
Praised are the Fountains of Shelieth, the silver harp of the waters,
But blest in my name forever this stream that stanched my thirst!
                         -- Deed of Morred

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 01:04:57 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:37846 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021904AbXCMBEz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 01:04:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2D12tuH027488;
	Tue, 13 Mar 2007 01:02:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2D12qUU027481;
	Tue, 13 Mar 2007 01:02:52 GMT
Date:	Tue, 13 Mar 2007 01:02:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Attila Kinali <attila@kinali.ch>
Cc:	linux-mips@linux-mips.org
Subject: Re: crash in first printk of start_kernel
Message-ID: <20070313010252.GB26119@linux-mips.org>
References: <20070309191354.f962e57b.attila@kinali.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070309191354.f962e57b.attila@kinali.ch>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 09, 2007 at 07:13:54PM +0100, Attila Kinali wrote:

Grüzi Attila,

> I'm using a 2.6.16.11 (an old snapshot from about last august,
> when we started development of another board) that has slight
> adjustments in various drivers to accomodate for our platform
> specific stuff.

You may want to update anyway.  between the linux-2.6.16.11 tag of the
linux-mips.org and the top of the linux-2.6.16-stable branch there are
almost 58,000 lines of patch.  Even more if your compare the MIPS -stable
branch to kernel.org's 2.6.16.11.  Iow a few metric buttloads.

> While booting from u-boot works fine, ie it can load the kernel
> from tftp, checksum is ok, uncompression is ok. It then jumps
> into the kernel but ends up in an exception handler when executing
> the first printk in start_kernel (ie the printk(KERN_NOTICE);
> at init/main.c:451).
> 
> While in the "exception handler" endless loop from u-boot 
> ra points to vscnprintf() (lib/vsprintf.c:512)
> where it calls vsnprintf() (at line 517).
> 
> If i set a breakpoint at lib/vsprintf.c:517 and follow it
> into vsnprintf, i get the follwing gdb log:
> 
> ---
> Breakpoint 3, vscnprintf (buf=0x80411548 "", size=0x803b1fac,
>     fmt=0x8036f10c "<5>", args=0x803b1fac) at lib/vsprintf.c:517
> 517             i=vsnprintf(buf,size,fmt,args);
> (gdb) step
> vsnprintf (buf=0x80411548 "", size=0x400, fmt=0x8036f10c "<5>", args=0xff0000)
>     at lib/vsprintf.c:276
> 276             if (unlikely((int) size < 0)) {
> (gdb) next
> 285             end = buf + size - 1;
> (gdb) next
> 287             if (end < buf - 1) {
> (gdb) p end
> $1 = 0x80411947 ""
> (gdb) p buf
> $2 = 0x80411548 ""
> ---
> 
> if i go here further (either next/step or continue), then i end up
> in the exception handler. So, it must be something in the asm
> of this line:
> 
> ---
> (gdb) disassemble $pc $pc+100
> Dump of assembler code from 0x8026612c to 0x80266190:

> 0xffffffff80266134 <vsnprintf+76>:      beqz    v0,0x80266144 <vsnprintf+92>
> 0xffffffff80266138 <vsnprintf+80>:      bltz    a0,0x802461c0 <jffs2_remount_fs+144>

A branch in the delay slot of another branch is forbidden by the MIPS
architecture.  All processors I every tried this on missbehave in very
unobvious ways when this is attempted.

You may want to compare that against your vmlinux file.  If the vmlinux
binary also contains this bug, try building the affected source file with
-S to find if the bug is cause by compiler or assembler.

> End of assembler dump.
> ---
> 
> But if i use stepi from here on, then it looks like that the
> BDI2000's breakpoint (both soft and hard) somehow interferes
> with the execution of the code:

In single stepping mode your debugger probably executes branches by
software emulation.  Chances are the emulation does something different
for this illegal code sequence than actual hardware.

> ---
> (gdb) display/i $pc
> 1: x/i $pc  0x8026612c <vsnprintf+68>:  addiu   v0,a0,-1
> (gdb) stepi
> 0xffffffff80266130      287             if (end < buf - 1) {
> 1: x/i $pc  0x80266130 <vsnprintf+72>:  sltu    v0,s2,v0
> (gdb) stepi
> 287             if (end < buf - 1) {
> 1: x/i $pc  0x80266134 <vsnprintf+76>:  beqz    v0,0x80266144 <vsnprintf+92>
> (gdb) stepi
> 287             if (end < buf - 1) {
> 1: x/i $pc  0x80266134 <vsnprintf+76>:  beqz    v0,0x80266144 <vsnprintf+92>
> (gdb) stepi
> 287             if (end < buf - 1) {
> 1: x/i $pc  0x80266134 <vsnprintf+76>:  beqz    v0,0x80266144 <vsnprintf+92>
> (gdb) stepi
> 287             if (end < buf - 1) {
> 1: x/i $pc  0x80266134 <vsnprintf+76>:  beqz    v0,0x80266144 <vsnprintf+92>
> (gdb) stepi
> ---
> 
> Yes, the next instruction (bltz    a0,0x802461c0 <jffs2_remount_fs+144>)
> looks fishy and should be most probably a NOP. If i patch this point
> by hand and continue it crashes at another point.
> 
> The only two reasons why the instruction at this point could be
> wrong, is either a gcc bug or a bug in u-boot's gunzip function.
> And i somewhat doubt both. gcc is a 3.3.1 from Montavista and both
> gcc and u-boot work on our other board which has a similar layout.

3.3.1 is _dangerously_ old.  At the very least update to 3.3.6 - or even
4.1.2.  A vanilla source gcc tree from ftp.gnu.org is fine to build the
kernel.

  Ralf

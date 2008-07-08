Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 16:16:08 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:48774 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20036090AbYGHPQB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jul 2008 16:16:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m68FEaPV031632;
	Tue, 8 Jul 2008 16:15:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m68FEU4Z031631;
	Tue, 8 Jul 2008 16:14:30 +0100
Date:	Tue, 8 Jul 2008 16:14:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Harald Krapfenbauer <krapfenbauer@ict.tuwien.ac.at>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 64-bit values on 32-bit machine
Message-ID: <20080708151429.GA31147@linux-mips.org>
References: <487334AD.70100@ict.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487334AD.70100@ict.tuwien.ac.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 08, 2008 at 11:34:37AM +0200, Harald Krapfenbauer wrote:

> I want to know how 64-bit values are passed on a little-endian 32-bit
> MIPS machine on function calls.
> 
> If there is one 64-bit argument to a function, it is passed in registers
> a0-a1 I think, but does a0 contain the lower 4 bytes or the upper 4?
> 
> Similarly, if there are several arguments so that a 64-bit argument is
> passed on the stack: Do the lower 4 bytes go to the lower address or to
> the higher?

Give a man a fish and he's got to eat for one day.  Teach a man how to
fish and he's got food for a life ;-)

I suggest to find out about such ABI details you write a small test program
in C, compile that to assembler code using the -S option and check the
generated .s file.  For example:

$ cat c.c
extern foo(unsigned long long a1, unsigned long long a2,
           unsigned long long a3);

void bar(void)
{
	foo(1UL, 2UL, 3UL);
}
$ mips-linux-gcc -fno-pic -mno-abicalls -O2 -S c.c
	.file	1 "c.c"
	.section .mdebug.abi32
	.previous
	.gnu_attribute 4, 1
	.text
	.align	2
	.globl	bar
	.ent	bar
	.type	bar, @function
bar:
	.set	nomips16
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	li	$3,3			# 0x3
	move	$2,$0
	li	$5,1			# 0x1
	move	$4,$0
	li	$7,2			# 0x2
	move	$6,$0
	sw	$31,28($sp)
	sw	$3,20($sp)
	jal	foo
	sw	$2,16($sp)

	lw	$31,28($sp)
	nop
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	bar
	.ident	"GCC: (GNU) 4.3.0"
$

mips-linux-gcc is the big endian compiler.  Repeat for little endian:

$ mipsel-linux-gcc -fno-pic -mno-abicalls -O2 -S c.c
	.file	1 "c.c"
	.section .mdebug.abi32
	.previous
	.gnu_attribute 4, 1
	.text
	.align	2
	.globl	bar
	.ent	bar
	.type	bar, @function
bar:
	.set	nomips16
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 24, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	li	$2,3			# 0x3
	move	$3,$0
	li	$4,1			# 0x1
	move	$5,$0
	li	$6,2			# 0x2
	move	$7,$0
	sw	$31,28($sp)
	sw	$2,16($sp)
	jal	foo
	sw	$3,20($sp)

	lw	$31,28($sp)
	nop
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	bar
	.ident	"GCC: (GNU) 4.3.0"
$

Ignore the "-fno-pic -mno-abicalls" options; they disable the PIC code
generation which on MIPS is default and is making the generated code well
harder to read.

You will notice that big endian compiler uses register pairs $4/$5 rsp.
$6/$6 in the order high / low half and the little endian compiler does it
in the reverse order; similar for the memory order for stack arguments.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2004 17:14:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:41455 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224948AbUHaQN4>; Tue, 31 Aug 2004 17:13:56 +0100
Received: from localhost (p2038-ipad11funabasi.chiba.ocn.ne.jp [219.162.37.38])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 2B099771D
	for <linux-mips@linux-mips.org>; Wed,  1 Sep 2004 01:13:53 +0900 (JST)
Date: Wed, 01 Sep 2004 01:22:23 +0900 (JST)
Message-Id: <20040901.012223.59462025.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Subject: gcc 3.3.4/3.4.1 and get_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found that gcc 3.3.4/3.4.1 can not compile this sample code properly.

--- k.c ---
/* mips-linux-gcc -D__KERNEL__ -O2 -mno-abicalls -fno-pic -I $(KERNEL)/include -S k.c */
#include <asm/uaccess.h>

extern char ptr[];

static int func0(int arg0)
{
	return 0;
}

int func1(int *arg)
{
	int arg0 = arg[0];
	int arg1;

	if (arg0)
		return -1;
	arg0 = func0(0);
	get_user(arg1 , (int*)arg[1]);
	if (func0(ptr[arg0]))
		return 0;
	if (arg1)
		ptr[arg0] = 0;
	return 0;
}
--- k.c end ---

The codes around the first calling of func0 are:

	.set	noreorder
	.set	nomacro
	jal	func0
	.set	macro
	.set	reorder

	lw	$4,4($16)

The jal does not have delay slot.  Then "lw $4" (part of get_user)
executed as the delay slot instruction.

I create a sample code with very stripped version of get_user.

--- kk.c ---
/* mips-linux-gcc -O2 -mno-abicalls -fno-pic -S kk.c */

#define get_user(x,ptr)			\
{					\
	int __gu_val;			\
	__asm__ ("":"=r" (__gu_val));	\
	if (ptr) {			\
		__asm__ __volatile__(	\
		"\tlw\t%0,%1\n\t"	\
		:"=r" (__gu_val)	\
		:"o" (*(ptr)));		\
	}				\
	(x) = __gu_val;			\
}

extern char ptr[];

static int func0(int arg0)
{
	return 0;
}

int func1(int *arg)
{
	int arg0 = arg[0];
	int arg1;

	if (arg0)
		return -1;
	arg0 = func0(0);
	get_user(arg1 , (int*)arg[1]);
	if (func0(ptr[arg0]))
		return 0;
	if (arg1)
		ptr[arg0] = 0;
	return 0;
}
--- kk.c end ---

And complete output of gcc 3.3.4:

	.file	1 "kk.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.ent	func0
	.type	func0, @function
func0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$0
	.set	macro
	.set	reorder

	.end	func0
	.align	2
	.globl	func1
	.ent	func1
	.type	func1, @function
func1:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	sw	$31,24($sp)
	move	$16,$4
	sw	$17,20($sp)
	lw	$2,0($16)
	move	$4,$0
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	li	$3,-1			# 0xffffffffffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	func0
	.set	macro
	.set	reorder

	lw	$4,4($16)
	#nop
	beq	$4,$0,$L4
#APP
		lw	$17,0($4)
	
#NO_APP
$L4:
	la $16,ptr($2)
	lb	$4,0($16)
	jal	func0
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	move	$3,$0
	.set	macro
	.set	reorder

	beq	$17,$0,$L2
	sb	$0,0($16)
$L2:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	func1
	.ident	"GCC: (GNU) 3.3.4"


Also complete output of gcc 3.4.1:

	.file	1 "kk.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.ent	func0
	.type	func0, @function
func0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	j	$31
	move	$2,$0

	.set	macro
	.set	reorder
	.end	func0
	.align	2
	.globl	func1
	.ent	func1
	.type	func1, @function
func1:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	addiu	$sp,$sp,-32
	sw	$16,16($sp)
	sw	$31,24($sp)
	move	$16,$4
	sw	$17,20($sp)
	lw	$3,0($16)
	move	$4,$0
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L2
	li	$5,-1			# 0xffffffffffffffff
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	func0
	.set	macro
	.set	reorder

	lw	$4,4($16)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$4,$0,$L8
	move	$3,$2
	.set	macro
	.set	reorder

	lui	$2,%hi(ptr)
$L9:
	addiu	$2,$2,%lo(ptr)
	addu	$16,$3,$2
	lb	$4,0($16)
	jal	func0
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L2
	move	$5,$0
	.set	macro
	.set	reorder

	beq	$17,$0,$L2
	sb	$0,0($16)
$L2:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$5
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$sp,$sp,32
	.set	macro
	.set	reorder

$L8:
#APP
		lw	$17,0($4)
	
#NO_APP
	.set	noreorder
	.set	nomacro
	j	$L9
	lui	$2,%hi(ptr)
	.set	macro
	.set	reorder

	.end	func1
	.ident	"GCC: (GNU) 3.4.1"


Is this a get_user's problem or gcc's?

---
Atsushi Nemoto

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jan 2003 22:00:48 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:43719
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225209AbTAZWAr>; Sun, 26 Jan 2003 22:00:47 +0000
Received: from bogon.sigxcpu.org (kons-d9bb5466.pool.mediaWays.net [217.187.84.102])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 3E0AB2BC2E; Sun, 26 Jan 2003 23:00:44 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 76B4F4B9AC; Sun, 26 Jan 2003 22:59:42 +0100 (CET)
Date: Sun, 26 Jan 2003 22:59:42 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: gcc@gcc.gnu.org
Cc: linux-mips@linux-mips.org
Subject: optimizer problem in linux-mips gcc-3.2?
Message-ID: <20030126215942.GD14230@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
glibc's string/tester and string/inl-tester fail when compiled with
Debian's "gcc version 3.2.2 20030109 (Debian prerelease)" on linux-mips
(big endian) and -O2 or -Os. I've tried to strip down the testcase as
far as possible and suspect that gcc miscompiles it. It works fine with
Debian's "gcc version 2.95.4 20011002" and with the above gcc-3.2.2 and
optimations turned off, -O3 and -O1:

foo@bar:~$ gcc --save-temps -O2 tester.c && ./a.out
memccpy flunked test 8
0x10000100 is abcdefghr should be abcdefgh
1 errors.

foo@bar:~$ gcc --save-temps -Os tester.c && ./a.out 
memccpy flunked test 8
0x10000100 is abcdefghr should be abcdefgh
1 errors.

foo@bar:~$ gcc --save-temps -O3 tester.c && ./a.out 
0x10000100 is abcdefgh should be abcdefgh
No errors.

foo@bar:~$ gcc --save-temps -O0 tester.c && ./a.out 
0x10000100 is abcdefgh should be abcdefgh
No errors.

foo@bar:~$ gcc -O1 tester.c && ./a.out 
0x100000f0 is abcdefgh should be abcdefgh
No errors.

I've attache the testcase and the assembler output for -O2. Any help
greatly appreciated.
Regards,
 -- Guido

--jRHKVT23PllUwdXP
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="tester.c"

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

/* Make sure we don't test the optimized inline functions if we want to
   test the real implementation.  */
#if !defined DO_STRING_INLINES
#undef __USE_STRING_INLINES
#endif

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef HAVE_GNU_LD
#define _sys_nerr	sys_nerr
#define _sys_errlist	sys_errlist
#endif

#define	STREQ(a, b)	(strcmp((a), (b)) == 0)

const char *it = "memccpy";	/* Routine name for message routines. */
size_t errors = 0;

/* Complain if condition is not true.  */
static void
check (int thing, int number)
{
  if (!thing)
    {
      printf("flunked test %d\n", number);
      ++errors;
    }
}

/* Complain if first two args don't strcmp as equal.  */
static void
equal (const char *a, const char *b, int number)
{
  check(a != NULL && b != NULL && STREQ (a, b), number);
}

char one[50];
char two[50];

static void
test_memccpy (void)
{
  (void) strcpy(one, "abcdefgh");
  (void) strcpy(two, "horsefeathers");
  check(memccpy(two, one, 'f', 9) == two+6, 7);	/* Returned value. */
  equal(one, "abcdefgh", 8);		/* Source intact? */
  printf("%p is %s should be abcdefgh\n", one, one);
  equal(two, "abcdefeathers", 9);		/* Copy correct? */
}

int
main (void)
{
  int status;

  /* memccpy.  */
  test_memccpy ();

  if (errors == 0)
    {
      status = EXIT_SUCCESS;
      puts("No errors.");
    }
  else
    {
      status = EXIT_FAILURE;
      printf("%Zd errors.\n", errors);
    }

  return status;
}

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tester-O2.s"

	.file	1 "tester.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.globl	it
	.rdata
	.align	2
$LC0:
	.ascii	"memccpy\000"
	.data
	.align	2
	.type	it,@object
	.size	it,4
it:
	.word	$LC0
	.globl	errors
	.align	2
	.type	errors,@object
	.size	errors,4
errors:
	.word	0
	.rdata
	.align	2
$LC1:
	.ascii	"flunked test %d\n\000"
	.text
	.align	2
	.ent	check
		.type		 check,@function
check:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 16, extra= 8
	.mask	0x90000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,32
	.cprestore 16
	move	$2,$4
	sw	$31,28($sp)
	la	$4,$LC1
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L3
	sw	$28,24($sp)
	.set	macro
	.set	reorder

$L1:
	lw	$31,28($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

$L3:
	la	$25,printf
	jal	$31,$25
	lw	$3,errors
	#nop
	addu	$3,$3,1
	sw	$3,errors
	j	$L1
	.end	check
	.align	2
	.ent	equal
		.type		 equal,@function
equal:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 16, extra= 8
	.mask	0x90030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$17,28($sp)
	sw	$16,24($sp)
	sw	$31,36($sp)
	sw	$28,32($sp)
	move	$17,$6
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L5
	move	$16,$0
	.set	macro
	.set	reorder

	beq	$5,$0,$L5
	la	$25,strcmp
	jal	$31,$25
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L6
	move	$4,$16
	.set	macro
	.set	reorder

	li	$16,1			# 0x1
$L5:
	move	$4,$16
$L6:
	move	$5,$17
	la	$25,check
	jal	$31,$25
	lw	$31,36($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	equal
	.rdata
	.align	2
$LC2:
	.ascii	"abcdefgh\000"
	.align	2
$LC3:
	.ascii	"horsefeathers\000"
	.align	2
$LC4:
	.ascii	"%p is %s should be abcdefgh\n\000"
	.align	2
$LC5:
	.ascii	"abcdefeathers\000"
	.text
	.align	2
	.ent	test_memccpy
		.type		 test_memccpy,@function
test_memccpy:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 16, extra= 8
	.mask	0x90070000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$17,28($sp)
	sw	$16,24($sp)
	la	$17,two
	la	$16,one
	li	$7,9			# 0x9
	sw	$18,32($sp)
	li	$6,102			# 0x66
	la	$18,$LC2
	move	$4,$17
	move	$5,$16
	sw	$31,40($sp)
	lwl	$2,0($18)
	lwr	$2,3($18)
	lwl	$3,4($18)
	lwr	$3,7($18)
	lb	$8,8($18)
	swl	$2,0($16)
	swr	$2,3($16)
	swl	$3,4($16)
	swr	$3,7($16)
	la	$9,$LC3
	lwl	$2,0($9)
	lwr	$2,3($9)
	lwl	$3,4($9)
	lwr	$3,7($9)
	lwl	$8,8($9)
	lwr	$8,11($9)
	swl	$2,0($17)
	swr	$2,3($17)
	swl	$3,4($17)
	swr	$3,7($17)
	swl	$8,8($17)
	swr	$8,11($17)
	lb	$2,12($9)
	lb	$3,13($9)
	sb	$2,12($17)
	sb	$3,13($17)
	sb	$8,8($16)
	sw	$28,36($sp)
	la	$25,memccpy
	jal	$31,$25
	addu	$3,$17,6
	xor	$2,$2,$3
	sltu	$2,$2,1
	move	$4,$2
	li	$5,7			# 0x7
	la	$25,check
	jal	$31,$25
	move	$4,$16
	move	$5,$18
	li	$6,8			# 0x8
	la	$25,equal
	jal	$31,$25
	move	$5,$16
	move	$6,$16
	la	$4,$LC4
	la	$25,printf
	jal	$31,$25
	move	$4,$17
	la	$5,$LC5
	li	$6,9			# 0x9
	la	$25,equal
	jal	$31,$25
	lw	$31,40($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,48
	.set	macro
	.set	reorder

	.end	test_memccpy
	.rdata
	.align	2
$LC6:
	.ascii	"No errors.\000"
	.align	2
$LC7:
	.ascii	"%Zd errors.\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
		.type		 main,@function
main:
	.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0x90010000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$16,24($sp)
	sw	$31,32($sp)
	sw	$28,28($sp)
	la	$25,test_memccpy
	jal	$31,$25
	lw	$2,errors
	la	$4,$LC6
	move	$5,$2
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L9
	move	$16,$0
	.set	macro
	.set	reorder

	la	$25,puts
	jal	$31,$25
$L10:
	move	$2,$16
	lw	$31,32($sp)
	lw	$16,24($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

$L9:
	la	$4,$LC7
	la	$25,printf
	jal	$31,$25
	.set	noreorder
	.set	nomacro
	j	$L10
	li	$16,1			# 0x1
	.set	macro
	.set	reorder

	.end	main

	.comm	one,50

	.comm	two,50
	.ident	"GCC: (GNU) 3.2.2 20030109 (Debian prerelease)"

--jRHKVT23PllUwdXP--

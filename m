Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 00:54:06 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:17355 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225280AbUJFXyB>;
	Thu, 7 Oct 2004 00:54:01 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 6 Oct 2004 16:53:58 -0700
Message-ID: <4164857E.3000601@avtrex.com>
Date: Wed, 06 Oct 2004 16:53:34 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: glibc 2.3.3 patches for mips?
References: <20041006233841.GA13351@tuxdriver.com>
In-Reply-To: <20041006233841.GA13351@tuxdriver.com>
Content-Type: multipart/mixed;
 boundary="------------000703080806020605010503"
X-OriginalArrivalTime: 06 Oct 2004 23:53:58.0139 (UTC) FILETIME=[BEEC64B0:01C4ABFF]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000703080806020605010503
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

John W. Linville wrote:
> Anyone here using glibc 2.3.3 on mips?  I had trouble using crosstool to
> build a gcc_3.3.3-glibc_2.3.3 combination.  gcc_3.3.3-glibc_2.3.3 seems
> to have built fine, although I haven't done much testing of the
> binaries...
> 
> If anyone is using glibc_2.3.3, what patches (if any) did you use to get
> it going?
> 
> Thanks,
> 
> John

I am not using crosstool, but have gcc-3.3.1 based cross compiler build of
glibc-2.3.3 that is running well.

Use binutils 2.15.

This all for mipsel-linux target.

Attached are my glibc-2.3.3 patches.  Still having problems getting
gcc-3.4.2 to build it, so if anybody has the magic answer for that...

David Daney.


--------------000703080806020605010503
Content-Type: text/plain;
 name="glibc-2.3.3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="glibc-2.3.3.diff"

Only in glibc-2.3.3/manual: texis
diff -rcp glibc-2.3.3.orig/glibc-2.3.3/sysdeps/mips/dl-machine.h glibc-2.3.3/sysdeps/mips/dl-machine.h
*** glibc-2.3.3.orig/glibc-2.3.3/sysdeps/mips/dl-machine.h	2003-07-30 23:33:52.000000000 -0700
--- glibc-2.3.3/sysdeps/mips/dl-machine.h	2004-09-24 15:49:05.000000000 -0700
*************** _dl_runtime_resolve:\n							      \
*** 474,480 ****
  	" STRINGXP(PTR_LA) " $25, _dl_start_user\n\
  	.globl _dl_start_user\n\
  	.type _dl_start_user,@function\n\
- 	.ent _dl_start_user\n\
  _dl_start_user:\n\
  	" STRINGXP(SETUP_GP) "\n\
  	" STRINGXV(SETUP_GP64($18,_dl_start_user)) "\n\
--- 474,479 ----
*************** _dl_start_user:\n\
*** 512,519 ****
  	" STRINGXP(PTR_LA) " $2, _dl_fini\n\
  	# Jump to the user entry point.\n\
  	move $25, $17\n\
! 	jr $25\n\
! 	.end _dl_start_user\n\t"\
  	_RTLD_EPILOGUE(ENTRY_POINT)\
  	".previous"\
  );
--- 511,517 ----
  	" STRINGXP(PTR_LA) " $2, _dl_fini\n\
  	# Jump to the user entry point.\n\
  	move $25, $17\n\
! 	jr $25\n\t" \
  	_RTLD_EPILOGUE(ENTRY_POINT)\
  	".previous"\
  );
diff -rcp glibc-2.3.3.orig/glibc-2.3.3/sysdeps/mips/__longjmp.c glibc-2.3.3/sysdeps/mips/__longjmp.c
*** glibc-2.3.3.orig/glibc-2.3.3/sysdeps/mips/__longjmp.c	2001-07-05 21:56:00.000000000 -0700
--- glibc-2.3.3/sysdeps/mips/__longjmp.c	2004-09-24 15:51:06.000000000 -0700
*************** __longjmp (env, val_arg)
*** 37,42 ****
--- 37,43 ----
       along the way.  */
    register int val asm ("a1");
  
+ #ifndef __mips_soft_float
    /* Pull back the floating point callee-saved registers.  */
    asm volatile ("l.d $f20, %0" : : "m" (env[0].__fpregs[0]));
    asm volatile ("l.d $f22, %0" : : "m" (env[0].__fpregs[1]));
*************** __longjmp (env, val_arg)
*** 48,53 ****
--- 49,55 ----
    /* Get and reconstruct the floating point csr.  */
    asm volatile ("lw $2, %0" : : "m" (env[0].__fpc_csr));
    asm volatile ("ctc1 $2, $31");
+ #endif
  
    /* Get the GP. */
    asm volatile ("lw $gp, %0" : : "m" (env[0].__gp));
Only in glibc-2.3.3/sysdeps/mips: __longjmp.c~
diff -rcp glibc-2.3.3.orig/glibc-2.3.3/sysdeps/mips/setjmp_aux.c glibc-2.3.3/sysdeps/mips/setjmp_aux.c
*** glibc-2.3.3.orig/glibc-2.3.3/sysdeps/mips/setjmp_aux.c	2003-03-20 02:27:55.000000000 -0800
--- glibc-2.3.3/sysdeps/mips/setjmp_aux.c	2004-09-24 15:50:50.000000000 -0700
***************
*** 27,32 ****
--- 27,33 ----
  int
  __sigsetjmp_aux (jmp_buf env, int savemask, int sp, int fp)
  {
+ #ifndef __mips_soft_float
    /* Store the floating point callee-saved registers...  */
    asm volatile ("s.d $f20, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[0]));
    asm volatile ("s.d $f22, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[1]));
*************** __sigsetjmp_aux (jmp_buf env, int savema
*** 34,40 ****
    asm volatile ("s.d $f26, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[3]));
    asm volatile ("s.d $f28, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[4]));
    asm volatile ("s.d $f30, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[5]));
! 
    /* .. and the PC;  */
    asm volatile ("sw $31, %0" : : "m" (env[0].__jmpbuf[0].__pc));
  
--- 35,41 ----
    asm volatile ("s.d $f26, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[3]));
    asm volatile ("s.d $f28, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[4]));
    asm volatile ("s.d $f30, %0" : : "m" (env[0].__jmpbuf[0].__fpregs[5]));
! #endif
    /* .. and the PC;  */
    asm volatile ("sw $31, %0" : : "m" (env[0].__jmpbuf[0].__pc));
  
*************** __sigsetjmp_aux (jmp_buf env, int savema
*** 57,64 ****
--- 58,67 ----
    asm volatile ("sw $22, %0" : : "m" (env[0].__jmpbuf[0].__regs[6]));
    asm volatile ("sw $23, %0" : : "m" (env[0].__jmpbuf[0].__regs[7]));
  
+ #ifndef __mips_soft_float
    /* .. and finally get and reconstruct the floating point csr.  */
    asm ("cfc1 %0, $31" : "=r" (env[0].__jmpbuf[0].__fpc_csr));
+ #endif
  
    /* Save the signal mask if requested.  */
    return __sigjmp_save (env, savemask);
Only in glibc-2.3.3/sysdeps/mips: setjmp_aux.c~

--------------000703080806020605010503--

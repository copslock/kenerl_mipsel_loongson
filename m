Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 22:12:41 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:33113 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225953AbUFKVMh>;
	Fri, 11 Jun 2004 22:12:37 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Jun 2004 14:10:23 -0700
Message-ID: <40CA1FE3.9030507@avtrex.com>
Date: Fri, 11 Jun 2004 14:10:59 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Daney <ddaney@avtrex.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, cgd@broadcom.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch] (revised patch) / 0 should send SIGFPE not SIGTRAP 
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com> <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl> <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com> <Pine.LNX.4.55.0406112133380.13062@jurand.ds.pg.gda.pl> <40CA1B35.6010603@avtrex.com>
In-Reply-To: <40CA1B35.6010603@avtrex.com>
Content-Type: multipart/mixed;
 boundary="------------020506050403020700000207"
X-OriginalArrivalTime: 11 Jun 2004 21:10:23.0998 (UTC) FILETIME=[82E891E0:01C44FF8]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020506050403020700000207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Daney wrote:

> How about the attached (lightly tested) patch?
>
I will quit sending patches after this one.  It is equivalent to the 
previous version, except it uses the symbolic names of the break codes 
instead of the numeric values.

David Daney.



--------------020506050403020700000207
Content-Type: text/plain;
 name="traps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traps.diff"

*** ../linux-avtrex/linux/arch/mips/kernel/traps.c	2004-02-26 11:14:09.000000000 -0800
--- arch/mips/kernel/traps.c	2004-06-11 14:04:52.000000000 -0700
***************
*** 38,43 ****
--- 38,44 ----
  #include <asm/traps.h>
  #include <asm/uaccess.h>
  #include <asm/mmu_context.h>
+ #include <asm/break.h>
  
  extern asmlinkage void handle_mod(void);
  extern asmlinkage void handle_tlbl(void);
***************
*** 597,615 ****
  	 * There is the ancient bug in the MIPS assemblers that the break
  	 * code starts left to bit 16 instead to bit 6 in the opcode.
  	 * Gas is bug-compatible ...
! 	 */
! 	bcode = ((opcode >> 16) & ((1 << 20) - 1));
! 
! 	/*
  	 * (A short test says that IRIX 5.3 sends SIGTRAP for all break
  	 * insns, even for break codes that indicate arithmetic failures.
  	 * Weird ...)
  	 * But should we continue the brokenness???  --macro
  	 */
  	switch (bcode) {
! 	case 6:
! 	case 7:
! 		if (bcode == 7)
  			info.si_code = FPE_INTDIV;
  		else
  			info.si_code = FPE_INTOVF;
--- 598,622 ----
  	 * There is the ancient bug in the MIPS assemblers that the break
  	 * code starts left to bit 16 instead to bit 6 in the opcode.
  	 * Gas is bug-compatible ...
! 	 *
  	 * (A short test says that IRIX 5.3 sends SIGTRAP for all break
  	 * insns, even for break codes that indicate arithmetic failures.
  	 * Weird ...)
  	 * But should we continue the brokenness???  --macro
+          *
+          * It seems some assemblers (binutils-2.15 for example) assemble
+          * break correctly.  So we check for the break code in either
+          * position.
+          *
  	 */
+ 
+ 	bcode = ((opcode >> 6) & ((1 << 20) - 1));
  	switch (bcode) {
! 	case BRK_OVERFLOW:
! 	case BRK_DIVZERO:
!         case BRK_OVERFLOW << 10:
!         case BRK_DIVZERO << 10:
! 		if (bcode == BRK_DIVZERO || bcode == (BRK_DIVZERO << 10))
  			info.si_code = FPE_INTDIV;
  		else
  			info.si_code = FPE_INTOVF;
***************
*** 633,639 ****
  
  	/* Immediate versions don't provide a code.  */
  	if (!(opcode & OPCODE))
! 		tcode = ((opcode >> 6) & ((1 << 20) - 1));
  
  	/*
  	 * (A short test says that IRIX 5.3 sends SIGTRAP for all trap
--- 640,646 ----
  
  	/* Immediate versions don't provide a code.  */
  	if (!(opcode & OPCODE))
! 		tcode = ((opcode >> 6) & ((1 << 10) - 1));
  
  	/*
  	 * (A short test says that IRIX 5.3 sends SIGTRAP for all trap

--------------020506050403020700000207--

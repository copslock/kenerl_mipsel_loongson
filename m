Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 21:52:44 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:40792 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225949AbUFKUwj>;
	Fri, 11 Jun 2004 21:52:39 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Jun 2004 13:50:26 -0700
Message-ID: <40CA1B35.6010603@avtrex.com>
Date: Fri, 11 Jun 2004 13:51:01 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: cgd@broadcom.com, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com> <40C9F7F0.50501@avtrex.com> <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl> <mailpost.1086981251.16853@news-sj1-1> <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com> <Pine.LNX.4.55.0406112133380.13062@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0406112133380.13062@jurand.ds.pg.gda.pl>
Content-Type: multipart/mixed;
 boundary="------------050705030308070603060308"
X-OriginalArrivalTime: 11 Jun 2004 20:50:26.0155 (UTC) FILETIME=[B8F03BB0:01C44FF5]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050705030308070603060308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Maciej W. Rozycki wrote:

>On Fri, 11 Jun 2004 cgd@broadcom.com wrote:
>  
>
>>Unfortunately, at this point, Linux should probably accept the
>>divide-by-zero code in both locations.
>>    
>>
>
> I think that's not a big trouble for Linux -- the path is rare and not
>critical for performance.
>
>  
>
How about the attached (lightly tested) patch?

David Daney.

--------------050705030308070603060308
Content-Type: text/plain;
 name="traps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traps.diff"

*** ../linux-avtrex/linux/arch/mips/kernel/traps.c	2004-02-26 11:14:09.000000000 -0800
--- arch/mips/kernel/traps.c	2004-06-11 13:43:00.000000000 -0700
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
--- 597,621 ----
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
! 	case 0x0006:
! 	case 0x0007:
!         case 0x1800: /* 6 << 10 */
!         case 0x1c00: /* 7 << 10 */
! 		if (bcode == 0x7 || bcode == 0x1c00)
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
--- 639,645 ----
  
  	/* Immediate versions don't provide a code.  */
  	if (!(opcode & OPCODE))
! 		tcode = ((opcode >> 6) & ((1 << 10) - 1));
  
  	/*
  	 * (A short test says that IRIX 5.3 sends SIGTRAP for all trap

--------------050705030308070603060308--

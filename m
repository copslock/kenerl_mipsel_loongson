Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 22:44:08 +0000 (GMT)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:11024 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225208AbTBTWoH>; Thu, 20 Feb 2003 22:44:07 +0000
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Thu, 20 Feb 2003 14:44:05 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id OAA04166; Thu, 20 Feb 2003 14:43:50 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h1KMhwER023411; Thu, 20 Feb 2003 14:43:58 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id OAA02915; Thu,
 20 Feb 2003 14:43:58 -0800
Message-ID: <3E555A2E.5920F387@broadcom.com>
Date: Thu, 20 Feb 2003 14:43:58 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: __volatile__ for asms in unaligned.c
X-WSS-ID: 124B85BF1271189-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


I just discovered that my compiler is scheduling the code in the asm
blocks in unaligned.c *before* the 'goto sigbus'.  My gcc is 3.1.1 with
some almost certainly unrelated local mods.

Anyway, is there a reason these aren't marked as volatile?  The gcc docs
have the scary comment "You can prevent an `asm' instruction from being
deleted, MOVED SIGNIFICANTLY, or combined, by writing the keyword
`volatile' after the`asm'."

Here's an example, for the lw_op case in the mips64 kernel:
---------
	case lw_op:
		if (verify_area(VERIFY_READ, addr, 4))
			goto sigbus;

		__asm__(
			"1:\tlwl\t%0, (%2)\n"
			"2:\tlwr\t%0, 3(%2)\n\t"
---------

Compiled with normal mips64 build flags (for SB1) was turned into:
---------
	### verify_area
        ld      $2,2400($28)
        daddu   $3,$5,4
        or      $3,$5,$3
        and     $2,$2,$3
        li      $4,-14                  # 0xfffffffffffffff2
        movz    $4,$0,$2
...
	### the asm code
        1:      lwl     $9, ($5)
2:      lwr     $9, 3($5)
        li      $3, 0
3:      .section        .fixup,"ax"
        4:      li      $3, -14
        j       3b

...
	### finally, the verify_area result check
        beq     $4,$0,$L1131

---------

Kip

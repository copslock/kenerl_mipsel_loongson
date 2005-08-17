Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 04:01:56 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:216.31.210.19]:36113 "EHLO
	MMS3.broadcom.com") by linux-mips.org with ESMTP
	id <S8226016AbVHQDBg>; Wed, 17 Aug 2005 04:01:36 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Tue, 16 Aug 2005 20:05:35 -0700
X-Server-Uuid: 35E76369-CF33-4172-911A-D1698BD5E887
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Tue, 16 Aug 2005 20:06:10 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BPG11840; Tue, 16 Aug 2005 20:06:10 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id UAA24004 for <linux-mips@linux-mips.org>; Tue, 16 Aug 2005 20:06:10
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j7H368ov005277 for <linux-mips@linux-mips.org>; Tue, 16 Aug 2005
 20:06:09 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j7H368p16025 for linux-mips@linux-mips.org; Tue, 16 Aug 2005
 20:06:08 -0700
Date:	Tue, 16 Aug 2005 20:06:08 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] casts in TLB macros
Message-ID: <20050817030608.GM24444@broadcom.com>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F1C76F50B04317880-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Fix three cases where macro arguments are not parenthesized, leading to
incorrect operator precedence when called with an expression as the
argument.  This causes incorrect evaluation of
    write_c0_entrylo0(pte_val(*ptep++) >> 6)
when pte_t is 64 bits - the pte value is cast to (unsigned int) first,
then the shift is done, losing the top 32 bits.

Also, this does not add an extra set of parentheses surrounding the
(cast)(value) pair, as there's no danger of precedence problems to avoid
given the high precedence of the cast operator and that this is the
terminal macro in this macro trail.

Signed-off-by: Andrew Isaacson <adi@broadcom.com>

 include/asm-mips/pgtable-32.h |    2 +-

Index: linux-2.6.13-rc5/include/asm-mips/mipsregs.h
===================================================================
--- linux-2.6.13-rc5.orig/include/asm-mips/mipsregs.h	2005-07-14 10:47:59.000000000 -0700
+++ linux-2.6.13-rc5/include/asm-mips/mipsregs.h	2005-08-16 19:44:47.000000000 -0700
@@ -693,13 +693,13 @@
 	if (sel == 0)							\
 		__asm__ __volatile__(					\
 			"mtc0\t%z0, " #register "\n\t"			\
-			: : "Jr" ((unsigned int)value));		\
+			: : "Jr" (unsigned int)(value));		\
 	else								\
 		__asm__ __volatile__(					\
 			".set\tmips32\n\t"				\
 			"mtc0\t%z0, " #register ", " #sel "\n\t"	\
 			".set\tmips0"					\
-			: : "Jr" ((unsigned int)value));		\
+			: : "Jr" (unsigned int)(value));		\
 } while (0)
 
 #define __write_64bit_c0_register(register, sel, value)			\
@@ -748,7 +748,7 @@
 do {									\
 	__asm__ __volatile__(						\
 		"ctc0\t%z0, " #register "\n\t"				\
-		: : "Jr" ((unsigned int)value));			\
+		: : "Jr" (unsigned int)(value));			\
 } while (0)
 
 /*

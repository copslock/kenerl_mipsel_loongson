Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 12:14:29 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:20516
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225214AbTFBLO1>; Mon, 2 Jun 2003 12:14:27 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 2 Jun 2003 11:14:25 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h52BEFjf022570;
	Mon, 2 Jun 2003 20:14:16 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 02 Jun 2003 20:14:53 +0900 (JST)
Message-Id: <20030602.201453.48536826.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: mips64 LOAD_KPTE2 fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If a TLB exception occured on very high address (such as
0xffffffffffffffff), invalid_vmalloc_address should be called but
currently not.

I think it is because LOAD_KPTE2 in arch/mips64/mm/tlbex-r4k.S does
not check overflow of (kptbl + offset).  Here is a patch (both 2.4 and
2.5).


diff -u linux-mips-cvs/arch/mips64/mm/tlbex-r4k.S linux.new/arch/mips64/mm/tlbex-r4k.S
--- linux-mips-cvs/arch/mips64/mm/tlbex-r4k.S	Mon Apr 28 09:44:54 2003
+++ linux.new/arch/mips64/mm/tlbex-r4k.S	Mon Jun  2 19:44:57 2003
@@ -72,6 +72,8 @@
 	/*
 	 * Determine that fault address is within vmalloc range.
 	 */
+	bgez	\ptr, \not_vmalloc		# check overflow
+	nop
 	dla	\tmp, ekptbl
 	sltu	\tmp, \ptr, \tmp
 	beqz	\tmp, \not_vmalloc		# not vmalloc
---
Atsushi Nemoto

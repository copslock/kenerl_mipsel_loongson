Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 12:23:20 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:64774
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225214AbTFBLXQ>; Mon, 2 Jun 2003 12:23:16 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 2 Jun 2003 11:23:14 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h52BN7jf022583;
	Mon, 2 Jun 2003 20:23:07 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Mon, 02 Jun 2003 20:23:45 +0900 (JST)
Message-Id: <20030602.202345.08315331.nemoto@toshiba-tops.co.jp>
To: anemo@mba.ocn.ne.jp
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: mips64 LOAD_KPTE2 fix
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20030602.201453.48536826.nemoto@toshiba-tops.co.jp>
References: <20030602.201453.48536826.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 02 Jun 2003 20:14:53 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> If a TLB exception occured on very high address (such as
anemo> 0xffffffffffffffff), invalid_vmalloc_address should be called
anemo> but currently not.

anemo> I think it is because LOAD_KPTE2 in arch/mips64/mm/tlbex-r4k.S
anemo> does not check overflow of (kptbl + offset).  Here is a patch
anemo> (both 2.4 and 2.5).

Please ignore it.  I missed an another fix.  The beqz lacks delay
slot.  Here is a new patch.

diff -u linux-mips-cvs/arch/mips64/mm/tlbex-r4k.S linux.new/arch/mips64/mm/tlbex-r4k.S
--- linux-mips-cvs/arch/mips64/mm/tlbex-r4k.S	Mon Apr 28 09:44:54 2003
+++ linux.new/arch/mips64/mm/tlbex-r4k.S	Mon Jun  2 20:16:41 2003
@@ -72,9 +72,12 @@
 	/*
 	 * Determine that fault address is within vmalloc range.
 	 */
+	bgez	\ptr, \not_vmalloc		# check overflow
+	nop
 	dla	\tmp, ekptbl
 	sltu	\tmp, \ptr, \tmp
 	beqz	\tmp, \not_vmalloc		# not vmalloc
+	nop
 	.endm
 
 
---
Atsushi Nemoto

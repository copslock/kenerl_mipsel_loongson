Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 10:25:13 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:60184
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225206AbVBGKY5>; Mon, 7 Feb 2005 10:24:57 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 7 Feb 2005 10:24:55 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 611F9239E39; Mon,  7 Feb 2005 19:24:51 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j17AOoRm047578;
	Mon, 7 Feb 2005 19:24:51 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 07 Feb 2005 19:24:50 +0900 (JST)
Message-Id: <20050207.192450.55145246.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	nigel@mips.com, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050204145803.GA5618@linux-mips.org>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp>
	<4203890B.5030305@mips.com>
	<20050204145803.GA5618@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 4 Feb 2005 15:58:03 +0100, Ralf Baechle <ralf@linux-mips.org> said:
ralf> That's not a new feature in the MIPS world; the R10000 family
ralf> introduced that first and Linux knows how to make use of it.  So
ralf> now I just need to teach c-r4k.c to check the AR bit on the 24K.

20KC Users Manual says it has physically indexed data cache.

--- linux-mips.org/arch/mips/mm/c-r4k.c	2005-02-07 19:06:54.598390493 +0900
+++ linux-mips/arch/mips/mm/c-r4k.c	2005-02-07 19:10:38.779771207 +0900
@@ -1016,6 +1016,8 @@
 	case CPU_R10000:
 	case CPU_R12000:
 		break;
+	case CPU_20KC:	/* physically indexed */
+		break;
 	case CPU_24K:
 		if (!(read_c0_config7() & (1 << 16)))
 	default:

For other MIPS64 core, 5Kc has virtually indexed cache.  How about 25KF?

---
Atsushi Nemoto

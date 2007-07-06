Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 16:17:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:28107 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021797AbXGFPRs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jul 2007 16:17:48 +0100
Received: from localhost (p1230-ipad210funabasi.chiba.ocn.ne.jp [58.88.120.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 85856B814; Sat,  7 Jul 2007 00:16:28 +0900 (JST)
Date:	Sat, 07 Jul 2007 00:17:18 +0900 (JST)
Message-Id: <20070707.001718.74753856.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] 74K: Only use WAIT with interrupts disabled for core
 rev >= 2.1.0
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20021769AbXGFOZl/20070706142541Z+11993@ftp.linux-mips.org>
References: <S20021769AbXGFOZl/20070706142541Z+11993@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Isn't this needed?

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 9a05f82..5a5bb3d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -150,6 +150,7 @@ static inline void check_wait(void)
 		break;
 
 	case CPU_74K:
+		cpu_wait = r4k_wait;
 		if ((c->processor_id & 0xff) >= PRID_REV_ENCODE_332(2, 1, 0))
 			cpu_wait = r4k_wait_irqoff;
 		break;

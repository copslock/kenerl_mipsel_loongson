Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 07:19:27 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:56318 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039070AbXBBHTX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Feb 2007 07:19:23 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 2 Feb 2007 16:19:22 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 73AE34209E;
	Fri,  2 Feb 2007 16:18:58 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 6838620606;
	Fri,  2 Feb 2007 16:18:58 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l127IvW0040407;
	Fri, 2 Feb 2007 16:18:57 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 02 Feb 2007 16:18:57 +0900 (JST)
Message-Id: <20070202.161857.55145886.nemoto@toshiba-tops.co.jp>
To:	mano@roarinelk.homelinux.net
Cc:	linux-mips@linux-mips.org
Subject: Re: 2.6.20-rc: au1x irqs broken
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070202061356.GA23661@roarinelk.homelinux.net>
References: <20070202061356.GA23661@roarinelk.homelinux.net>
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
X-archive-position: 13891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 2 Feb 2007 07:13:56 +0100, Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> mips-git commit 1603b5aca14f15b34848fb5594d0c7b6333b99144 broke
> au1x irqs. The kernel boots; however it is not able to
> mount nfsroot. Reverting the arch/mips/au1000/common/irq.c
> bits of the above commit fixes it.

Thank you for report.  But I can not see how that change break au1x.
You are using au1000_eth driver, and the driver use level irq, right?

Does reverting just only this part work?

 static struct irq_chip level_irq_type = {
 	.typename = "Au1000 Level",
-	.startup = startup_irq,
-	.shutdown = shutdown_irq,
-	.enable = local_enable_irq,
-	.disable = local_disable_irq,
 	.ack = mask_and_ack_level_irq,
+	.mask = local_disable_irq,
+	.mask_ack = mask_and_ack_level_irq,
+	.unmask = local_enable_irq,
 	.end = end_irq,
 };
 
And if it was work, does reverting only 4 lines removal part work?

---
Atsushi Nemoto

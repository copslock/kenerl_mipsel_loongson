Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 18:50:13 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:54729 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28588386AbYGRRuK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 18:50:10 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m6IHo4cc007602;
	Fri, 18 Jul 2008 10:50:04 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 Jul 2008 10:50:04 -0700
Received: from [172.25.32.36] ([172.25.32.36]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 18 Jul 2008 10:50:03 -0700
Message-ID: <4880D7D0.9040200@windriver.com>
Date:	Fri, 18 Jul 2008 12:50:08 -0500
From:	Jason Wessel <jason.wessel@windriver.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] kgdb, mips: add arch support for the kernel's kgdb
 core
References: <1216400928-29097-1-git-send-email-jason.wessel@windriver.com><1216400928-29097-2-git-send-email-jason.wessel@windriver.com><1216400928-29097-3-git-send-email-jason.wessel@windriver.com> <20080719.023116.122828931.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080719.023116.122828931.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jul 2008 17:50:04.0010 (UTC) FILETIME=[B53D74A0:01C8E8FE]
Return-Path: <jason.wessel@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.wessel@windriver.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> 
> The kgdb_ealy_setup check should be at beginning of init_IRQ (before
> set_irq_noprobe loop)?


I would agree, and it looks like the following now in the patch.
I will revalidate with the HW to ensure there is no regression. :-)

Jason.

@@ -130,8 +135,18 @@ void __init init_IRQ(void)
 {
 	int i;
 
+#ifdef CONFIG_KGDB
+	if (kgdb_early_setup)
+		return;
+#endif
+
 	for (i = 0; i < NR_IRQS; i++)
 		set_irq_noprobe(i);
 
 	arch_init_irq();
+
+#ifdef CONFIG_KGDB
+	if (!kgdb_early_setup)
+		kgdb_early_setup = 1;
+#endif
 }

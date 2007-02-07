Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2007 17:42:15 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:53899 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039489AbXBGRmL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2007 17:42:11 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 230CC3EC9; Wed,  7 Feb 2007 09:41:38 -0800 (PST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
To:	ralf@linux-mips.org
Subject: [PATCH] (2.6.20) Toshiba RBTX49x7: declare prom_getcmdline()
Date:	Wed, 7 Feb 2007 20:41:36 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Organization: MontaVista Software Inc.
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200702072041.36064.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix a bunch of warnings caused by a missing prom_getcmdline() prototype.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: linux-2.6/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ linux-2.6/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -137,6 +137,8 @@ int tx4927_using_backplane = 0;
 extern void gt64120_time_init(void);
 extern void toshiba_rbtx4927_irq_setup(void);
 
+char *prom_getcmdline(void);
+
 #ifdef CONFIG_PCI
 #define CONFIG_TX4927BUG_WORKAROUND
 #undef TX4927_SUPPORT_COMMAND_IO

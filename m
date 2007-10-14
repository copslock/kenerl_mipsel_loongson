Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 17:12:12 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:37562 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20034743AbXJNQLr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 17:11:47 +0100
Received: from lagash (88-106-176-50.dynamic.dsl.as9105.com [88.106.176.50])
	by relay01.mx.bawue.net (Postfix) with ESMTP id 1B29C48BCB;
	Sun, 14 Oct 2007 18:10:23 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Ih63W-0003IM-Nj; Sun, 14 Oct 2007 17:11:06 +0100
Date:	Sun, 14 Oct 2007 17:11:06 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] Fix MIPSsim booting from NFS root
Message-ID: <20071014161106.GS3379@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

MIPSsim probably doesn't have any sort of environment, but writing
a zero in it kills even the compiled in command line. This prevents
booting via NFS root.

Signed-Off-By: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/mipssim/sim_cmdline.c b/arch/mips/mipssim/sim_cmdline.c
index c63021a..74240e1 100644
--- a/arch/mips/mipssim/sim_cmdline.c
+++ b/arch/mips/mipssim/sim_cmdline.c
@@ -28,8 +28,5 @@ char * __init prom_getcmdline(void)
 
 void  __init prom_init_cmdline(void)
 {
-	char *cp;
-	cp = arcs_cmdline;
-	/* Get boot line from environment? */
-	*cp = '\0';
+	/* XXX: Get boot line from environment? */
 }

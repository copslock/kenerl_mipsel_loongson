Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 11:59:04 +0100 (BST)
Received: from arrakis.dune.hu ([195.56.146.235]:46731 "EHLO arrakis.dune.hu")
	by ftp.linux-mips.org with ESMTP id S20022024AbXHBK7B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 11:59:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id 4B5537840C5
	for <linux-mips@linux-mips.org>; Thu,  2 Aug 2007 12:58:59 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZ4uSEjFTqtc for <linux-mips@linux-mips.org>;
	Thu,  2 Aug 2007 12:58:55 +0200 (CEST)
Received: from ecaz.afh.b-m.hu (firewall.ahiv.hu [195.228.168.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by arrakis.dune.hu (Postfix) with ESMTP id 9D1B07840C1
	for <linux-mips@linux-mips.org>; Thu,  2 Aug 2007 12:58:55 +0200 (CEST)
Date:	Thu, 02 Aug 2007 12:58:50 +0200
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Sync SiByte system code to the new DUART driver
From:	"Imre Kaloz" <kaloz@openwrt.org>
Organization: OpenWrt - Wireless Freedom
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-ID: <op.twfh4cuw2s3iss@ecaz.afh.b-m.hu>
Return-Path: <kaloz@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
X-list: linux-mips

The new upstream SiByte DUART driver uses a different config option then
the old one, so the SiByte target doesn't compile currently.
This patch fixes the problem.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

---

diff --git a/arch/mips/sibyte/cfe/console.c b/arch/mips/sibyte/cfe/console.c
index c6ec748..4cec9d7 100644
--- a/arch/mips/sibyte/cfe/console.c
+++ b/arch/mips/sibyte/cfe/console.c
@@ -46,7 +46,7 @@ static int cfe_console_setup(struct console *cons, char *str)
  	/* XXXKW think about interaction with 'console=' cmdline arg */
  	/* If none of the console options are configured, the build will break. */
  	if (cfe_getenv("BOOT_CONSOLE", consdev, 32) >= 0) {
-#ifdef CONFIG_SIBYTE_SB1250_DUART
+#ifdef CONFIG_SERIAL_SB1250_DUART
  		if (!strcmp(consdev, "uart0")) {
  			setleds("u0cn");
  		} else if (!strcmp(consdev, "uart1")) {

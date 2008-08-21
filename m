Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 23:16:12 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:39320 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S28586996AbYHUWP2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 23:15:28 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id D2639FE2E23;
	Fri, 22 Aug 2008 00:15:22 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id E21343F008A;
	Fri, 22 Aug 2008 00:14:53 +0200 (CEST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id AC8FF90004;
	Fri, 22 Aug 2008 00:14:53 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 22 Aug 2008 00:14:52 +0200
Subject: [PATCH 4/6] rb532: remove gpio bootup state
MIME-Version: 1.0
X-UID:	1120
X-Length: 1909
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808220014.52655.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: E21343F008A.4040A
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

We are not using gpio bootup state, so do not export
it and do not parse the kernel command line tag for it.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 1bc0af8..c5d8868 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -41,8 +41,6 @@ extern void __init setup_serial_port(void);
 
 unsigned int idt_cpu_freq = 132000000;
 EXPORT_SYMBOL(idt_cpu_freq);
-unsigned int gpio_bootup_state;
-EXPORT_SYMBOL(gpio_bootup_state);
 
 static struct resource ddr_reg[] = {
 	{
@@ -108,9 +106,6 @@ void __init prom_setup_cmdline(void)
 				mips_machtype = MACH_MIKROTIK_RB532;
 		}
 
-		if (match_tag(prom_argv[i], GPIO_TAG))
-			gpio_bootup_state = tag2ul(prom_argv[i], GPIO_TAG);
-
 		strcpy(cp, prom_argv[i]);
 		cp += strlen(prom_argv[i]);
 	}
@@ -122,11 +117,6 @@ void __init prom_setup_cmdline(void)
 		strcpy(cp, arcs_cmdline);
 		cp += strlen(arcs_cmdline);
 	}
-	if (gpio_bootup_state & 0x02)
-		strcpy(cp, GPIO_INIT_NOBUTTON);
-	else
-		strcpy(cp, GPIO_INIT_BUTTON);
-
 	cmd_line[CL_SIZE-1] = '\0';
 
 	strcpy(arcs_cmdline, cmd_line);

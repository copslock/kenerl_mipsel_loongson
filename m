Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:34:29 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51513 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010680AbaJGFbC1K0C1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=A86cH9ks65X9PU9nhclBxy819n4wwi6DVLGTSSnr1NI=;
        b=j+ucWMPrBIj5xOQ1LOHtls/nMy3StZEXn3T/AXj8HJcgXH+4UXxhglg6wQ7TXbjeSJAgjGfIf8WCfDe88s6JixAAnrwwyHG+gEtRLI+/KBSrD5wbxsw6+tv5eUXH5fupa2rCMMh1EJy5UMmmlcqycW74BZr27AwN7yxUbaPg99c=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNMO-002j5n-6r
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:30:56 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32926 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNLL-002c5g-2s; Tue, 07 Oct 2014 05:29:51 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 23/44] power/reset: qnap-poweroff: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:25 -0700
Message-Id: <1412659726-29957-24-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.3
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020208.54337A90.008C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 931
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 5
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with default priority value of 128 to reflect that
the original code generates an error if another poweroff handler has
already been registered when the driver is loaded.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/qnap-poweroff.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index a75db7f..c474980 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -16,7 +16,9 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/serial_reg.h>
 #include <linux/kallsyms.h>
 #include <linux/of.h>
@@ -55,7 +57,8 @@ static void __iomem *base;
 static unsigned long tclk;
 static const struct power_off_cfg *cfg;
 
-static void qnap_power_off(void)
+static int qnap_power_off(struct notifier_block *this, unsigned long unused1,
+			  void *unused2)
 {
 	const unsigned divisor = ((tclk + (8 * cfg->baud)) / (16 * cfg->baud));
 
@@ -72,14 +75,20 @@ static void qnap_power_off(void)
 
 	/* send the power-off command to PIC */
 	writel(cfg->cmd, UART1_REG(TX));
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block qnap_poweroff_nb = {
+	.notifier_call = qnap_power_off,
+	.priority = 128,
+};
+
 static int qnap_power_off_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	struct clk *clk;
-	char symname[KSYM_NAME_LEN];
 
 	const struct of_device_id *match =
 		of_match_node(qnap_power_off_of_match_table, np);
@@ -106,22 +115,13 @@ static int qnap_power_off_probe(struct platform_device *pdev)
 
 	tclk = clk_get_rate(clk);
 
-	/* Check that nothing else has already setup a handler */
-	if (pm_power_off) {
-		lookup_symbol_name((ulong)pm_power_off, symname);
-		dev_err(&pdev->dev,
-			"pm_power_off already claimed %p %s",
-			pm_power_off, symname);
-		return -EBUSY;
-	}
-	pm_power_off = qnap_power_off;
-
-	return 0;
+	return register_poweroff_handler(&qnap_poweroff_nb);
 }
 
 static int qnap_power_off_remove(struct platform_device *pdev)
 {
-	pm_power_off = NULL;
+	unregister_poweroff_handler(&qnap_poweroff_nb);
+
 	return 0;
 }
 
-- 
1.9.1

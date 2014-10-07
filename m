Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:42:23 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52114 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010664AbaJGFcHbzQ5P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:32:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=sd9+dVBhfvQIGg+RmaWWiGnVpvGQ8ZfgP1x3LeTSNPs=;
        b=pGBkIA20yN6fEYUqhG7swU4SELZ/QKh+EV2ZwYEvLsyBI9GrgzzUL42zSLneTLwxg8Eqr2DK1B0LIxGAjwwiMWwbrGc2rp4HVayHSMGaj/ClAAmzrN6dG7vtOaKkwBTpFwcAWcP3qL0VqI0U+5GASAjxC5kbTltVywO2KH0Db2s=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNNR-002oNW-8M
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:32:01 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32945 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNM6-002gyM-Ux; Tue, 07 Oct 2014 05:30:39 +0000
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
        Matt Fleming <matt.fleming@intel.com>
Subject: [PATCH 42/44] efi: Register poweroff handler with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:44 -0700
Message-Id: <1412659726-29957-43-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.8
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020207.54337AD1.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1369
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 184
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
X-archive-position: 43035
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
directly. Register with low priority value of 64 since the efi code
states that this is a poweroff handler of last resort.

Cc: Matt Fleming <matt.fleming@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/firmware/efi/reboot.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/reboot.c b/drivers/firmware/efi/reboot.c
index 9c59d1c..c082439 100644
--- a/drivers/firmware/efi/reboot.c
+++ b/drivers/firmware/efi/reboot.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2014 Red Hat, Inc., Mark Salter <msalter@redhat.com>
  */
 #include <linux/efi.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 
 int efi_reboot_quirk_mode = -1;
@@ -38,19 +40,32 @@ bool __weak efi_poweroff_required(void)
 	return false;
 }
 
-static void efi_power_off(void)
+static int efi_power_off(struct notifier_block *this,
+			 unsigned long unused1, void *unused2)
 {
 	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block efi_poweroff_nb = {
+	.notifier_call = efi_power_off,
+	.priority = 64,
+};
+
 static int __init efi_shutdown_init(void)
 {
+	int ret = 0;
+
 	if (!efi_enabled(EFI_RUNTIME_SERVICES))
 		return -ENODEV;
 
-	if (efi_poweroff_required())
-		pm_power_off = efi_power_off;
+	if (efi_poweroff_required()) {
+		ret = register_poweroff_handler(&efi_poweroff_nb);
+		if (ret)
+			pr_err("efi: Failed to register poweroff handler\n");
+	}
 
-	return 0;
+	return ret;
 }
 late_initcall(efi_shutdown_init);
-- 
1.9.1

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:35:51 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51661 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010685AbaJGFbNTOvK4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=7mvLKglzhfviHXvYJrtV7ll7hkQ6H9rcg96FVrnOSQY=;
        b=lKkdjn6u+fbdi2TFUGeoOWexTNElQS0JgN1VC+HgeVFqOBs1aeVa2RwfuVMpT9zhDVB/ZGrxAzEqxr551JK8AzhFk5zoUc2a975+dNj16wmYNGXDJhVliwXtusMx1FXPGwlDNtTRnBQSh6Ga14G8p7dNXMAF6CaUjk/gx2caZe4=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNMY-002kVm-VY
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:31:07 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32932 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNLX-002dCW-GQ; Tue, 07 Oct 2014 05:30:04 +0000
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
        Julian Andres Klode <jak@jak-linux.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 29/44] staging: nvec: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:31 -0700
Message-Id: <1412659726-29957-30-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.3
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020208.54337A9B.005D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1038
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 41
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
X-archive-position: 43012
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
directly. Register with default priority value of 128 since we don't know
any better.

Cc: Julian Andres Klode <jak@jak-linux.org>
Cc: Marc Dietrich <marvin24@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/nvec/nvec.c | 24 +++++++++++++++---------
 drivers/staging/nvec/nvec.h |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index a93208a..33d406c 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -33,6 +33,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -80,8 +81,6 @@ enum nvec_sleep_subcmds {
 #define LID_SWITCH BIT(1)
 #define PWR_BUTTON BIT(15)
 
-static struct nvec_chip *nvec_power_handle;
-
 static const struct mfd_cell nvec_devices[] = {
 	{
 		.name = "nvec-kbd",
@@ -759,12 +758,17 @@ static void nvec_disable_i2c_slave(struct nvec_chip *nvec)
 }
 #endif
 
-static void nvec_power_off(void)
+static int nvec_power_off(struct notifier_block *this, unsigned long unused1,
+			  void *unused2)
 {
+	struct nvec_chip *nvec = container_of(this, struct nvec_chip,
+					      poweroff_nb);
 	char ap_pwr_down[] = { NVEC_SLEEP, AP_PWR_DOWN };
 
-	nvec_toggle_global_events(nvec_power_handle, false);
-	nvec_write_async(nvec_power_handle, ap_pwr_down, 2);
+	nvec_toggle_global_events(nvec, false);
+	nvec_write_async(nvec, ap_pwr_down, 2);
+
+	return NOTIFY_DONE;
 }
 
 /*
@@ -878,8 +882,11 @@ static int tegra_nvec_probe(struct platform_device *pdev)
 	nvec->nvec_status_notifier.notifier_call = nvec_status_notifier;
 	nvec_register_notifier(nvec, &nvec->nvec_status_notifier, 0);
 
-	nvec_power_handle = nvec;
-	pm_power_off = nvec_power_off;
+	nvec->poweroff_nb.notifier_call = nvec_power_off;
+	nvec->poweroff_nb.priority = 128;
+	ret = register_poweroff_handler(&nvec->poweroff_nb);
+	if (ret)
+		dev_err(nvec->dev, "Failed to register poweroff handler\n");
 
 	/* Get Firmware Version */
 	msg = nvec_write_sync(nvec, get_firmware_version, 2);
@@ -914,13 +921,12 @@ static int tegra_nvec_remove(struct platform_device *pdev)
 {
 	struct nvec_chip *nvec = platform_get_drvdata(pdev);
 
+	unregister_poweroff_handler(&nvec->poweroff_nb);
 	nvec_toggle_global_events(nvec, false);
 	mfd_remove_devices(nvec->dev);
 	nvec_unregister_notifier(nvec, &nvec->nvec_status_notifier);
 	cancel_work_sync(&nvec->rx_work);
 	cancel_work_sync(&nvec->tx_work);
-	/* FIXME: needs check wether nvec is responsible for power off */
-	pm_power_off = NULL;
 
 	return 0;
 }
diff --git a/drivers/staging/nvec/nvec.h b/drivers/staging/nvec/nvec.h
index e271375..e5ee2af 100644
--- a/drivers/staging/nvec/nvec.h
+++ b/drivers/staging/nvec/nvec.h
@@ -163,6 +163,8 @@ struct nvec_chip {
 	struct nvec_msg *last_sync_msg;
 
 	int state;
+
+	struct notifier_block poweroff_nb;
 };
 
 extern int nvec_write_async(struct nvec_chip *nvec, const unsigned char *data,
-- 
1.9.1

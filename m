Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:47:28 +0100 (CET)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42627 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013484AbaKLIrMh332e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:12 +0100
Received: by mail-pd0-f179.google.com with SMTP id g10so11905578pdj.10
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2uFQusJJ5vxIw3tOTJTr94O9l13vRw7Ap4ZHqZyPQw=;
        b=huws2PbOntipX2LnTGErYz8EMJnjePLf5oE0JKzJcmwBuXtMd8g7QXUysuncdbrGH4
         IygPqaZ0rhxGMpwo3odNSHbGUdBrvYNtcmPkFfF2DKEqAUZj6Uf4wvnyqt71CZtvmVcg
         V5w/Tu1jqE+QxRCs/mboP3Vn4VhWeC1p3FI6HYmfFtnoXLtt1u6n+5xdWq4kteQbze21
         sJgI5Wbu9bccYChH5+V0es8B7J8+SgZrYcQC6qSlGGwFx69fO0vYupcBkJKjo9McIm2R
         Q8FVnDgZaKI9axDXBMEk2IejD/N5/neyd8mfZUDQpdTR/DCkPzCkce81TG4e5lt1O5JB
         YkKQ==
X-Received: by 10.66.124.228 with SMTP id ml4mr46017995pab.42.1415782026679;
        Wed, 12 Nov 2014 00:47:06 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:06 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 1/8] tty: Fallback to use dynamic major number
Date:   Wed, 12 Nov 2014 00:46:26 -0800
Message-Id: <1415781993-7755-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

From: Tushar Behera <tushar.behera@linaro.org>

In a multi-platform scenario, the hard-coded major/minor numbers in
serial drivers may conflict with each other. A typical scenario is
observed with amba-pl011 and samsung-uart drivers, both of these
drivers use same set of major/minor numbers. If both of these drivers
are enabled, probe of samsung-uart driver fails because the desired
node is busy.

The issue is fixed by adding a fallback in driver core, so that we can
use dynamic major number in case device node allocation fails for
hard-coded major/minor number.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
[cernekee: fix checkpatch warnings]
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/tty_io.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 0508a1d..a6d4d9a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3365,6 +3365,22 @@ int tty_register_driver(struct tty_driver *driver)
 	dev_t dev;
 	struct device *d;
 
+	if (driver->major) {
+		dev = MKDEV(driver->major, driver->minor_start);
+		error = register_chrdev_region(dev, driver->num, driver->name);
+		/* In case of error, fall back to dynamic allocation */
+		if (error < 0) {
+			pr_warn("Default device node (%d:%d) for %s is busy, using dynamic major number\n",
+				driver->major, driver->minor_start,
+				driver->name);
+			driver->major = 0;
+		}
+	}
+
+	/*
+	 * Don't replace the following check with an else to above if statement,
+	 * as it may also be called as a fallback.
+	 */
 	if (!driver->major) {
 		error = alloc_chrdev_region(&dev, driver->minor_start,
 						driver->num, driver->name);
@@ -3372,9 +3388,6 @@ int tty_register_driver(struct tty_driver *driver)
 			driver->major = MAJOR(dev);
 			driver->minor_start = MINOR(dev);
 		}
-	} else {
-		dev = MKDEV(driver->major, driver->minor_start);
-		error = register_chrdev_region(dev, driver->num, driver->name);
 	}
 	if (error < 0)
 		goto err;
-- 
2.1.1

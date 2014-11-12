Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:54:56 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:54178 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013420AbaKLUykqkOiX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:40 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so12983063pdj.12
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2uFQusJJ5vxIw3tOTJTr94O9l13vRw7Ap4ZHqZyPQw=;
        b=nWK7XdLOiY99DW0s0/T5Y/rYdJ15nv6pzqeLBRk0sPdY88iEzUzYTo3h5xE5ztXAJA
         3HAplDuRqQSTqznyogyAx22FuS5IRQz3ZimglWzEsVKnibMp5qXnbiw9WknETpwTnhI0
         NaPHKDrpTgnyHyd+d88RDCmrrDAG0F0HAfzKfpAufMBF7CRKrXZ/+szl5OLhshkMuuwF
         iky2DBznRpiEkCCzumrjmyVb+xwgmw2xVByIbTqXxTD3aweKzpoQ8+rq707oXIizUblG
         ZbHJy0tdhAMaPfUkhR913W6qyGx40+CgwtX3Eu2SeK3BZADzJmWXu0q0xOhDGL4UOyFy
         49jw==
X-Received: by 10.70.63.9 with SMTP id c9mr50651450pds.104.1415825673832;
        Wed, 12 Nov 2014 12:54:33 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:33 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 01/10] tty: Fallback to use dynamic major number
Date:   Wed, 12 Nov 2014 12:53:58 -0800
Message-Id: <1415825647-6024-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44076
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

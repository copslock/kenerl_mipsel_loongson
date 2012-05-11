Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 May 2012 00:05:58 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56120 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903698Ab2EKWFj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 May 2012 00:05:39 +0200
Received: by pbbrq13 with SMTP id rq13so4326314pbb.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+0MCNy/97YWhHr9bEHmjDfGcoxx9PBjsekFDBvpuNMM=;
        b=m72OTH0cmy8PtzgmI4bjuTdEFJGJu6v/ATZE3Z8ejIi6TnWv7Ldx+4jSxnbqVQaEpn
         N+uLYKBlSV4CjV1QJvjKWYjTkaTVtUO+UMR3WzrXA6HI3vF7xnxjB4QBKQW1U9AfHh9W
         K6hfY4sTyJ7rsRDXyI8HOY9JK8sPrzK/MffWXfDK7vFnxyTnBlsL8GGJ7gHHw5xkPM7h
         wcGtbajt5jsqOr0R9WNBCKE0lUhKSvaJzpOFqZlwSaLrnScB8EM1KpRjQkWIkxTk/Pu/
         7tSIo/3xy5F/QUU6MFf4XUKa/QtonLAdqTRh80RPNU24MMWIvewjT1O2ETmVkpB6Pgj4
         TnpA==
Received: by 10.68.203.225 with SMTP id kt1mr36139467pbc.133.1336773933419;
        Fri, 11 May 2012 15:05:33 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id kd6sm13960215pbc.24.2012.05.11.15.05.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 15:05:32 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4BM5VHO017918;
        Fri, 11 May 2012 15:05:31 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4BM5Vw7017917;
        Fri, 11 May 2012 15:05:31 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/3] spi: Use consistent MODALIAS values.
Date:   Fri, 11 May 2012 15:05:22 -0700
Message-Id: <1336773923-17866-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

For SPI devices, the MODALIAS should start with "spi:" so that the
modprobe can find the proper drivers.

Be consistent, for devices added via spi_new_device(), make sure
"spi:" is added if it is not already there.  In spi_match_device()
handle matching when the "spi:" prefix is present.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/spi/spi.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3d8f662..8c49964 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -59,6 +59,16 @@ static struct device_attribute spi_dev_attrs[] = {
 	__ATTR_NULL,
 };
 
+/*
+ * modalias will be of the form "spi:name" or "name", match on just
+ * the name portion.
+ */
+static const char *spi_device_spidev2name(const struct spi_device *sdev)
+{
+	const char *p = strchr(sdev->modalias, ':');
+	return p ? p + 1 : sdev->modalias;
+}
+
 /* modalias support makes "modprobe $MODALIAS" new-style hotplug work,
  * and the sysfs version makes coldplug work too.
  */
@@ -66,8 +76,10 @@ static struct device_attribute spi_dev_attrs[] = {
 static const struct spi_device_id *spi_match_id(const struct spi_device_id *id,
 						const struct spi_device *sdev)
 {
+	const char *name = spi_device_spidev2name(sdev);
+
 	while (id->name[0]) {
-		if (!strcmp(sdev->modalias, id->name))
+		if (!strcmp(name, id->name))
 			return id;
 		id++;
 	}
@@ -94,14 +106,20 @@ static int spi_match_device(struct device *dev, struct device_driver *drv)
 	if (sdrv->id_table)
 		return !!spi_match_id(sdrv->id_table, spi);
 
-	return strcmp(spi->modalias, drv->name) == 0;
+	return strcmp(spi_device_spidev2name(spi), drv->name) == 0;
 }
 
 static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct spi_device		*spi = to_spi_device(dev);
 
-	add_uevent_var(env, "MODALIAS=%s%s", SPI_MODULE_PREFIX, spi->modalias);
+	if (strncmp(SPI_MODULE_PREFIX, spi->modalias,
+		    strlen(SPI_MODULE_PREFIX)) == 0)
+		add_uevent_var(env, "MODALIAS=%s", spi->modalias);
+	else
+		add_uevent_var(env, "MODALIAS=%s%s",
+			       SPI_MODULE_PREFIX, spi->modalias);
+
 	return 0;
 }
 
@@ -418,6 +436,7 @@ struct spi_device *spi_new_device(struct spi_master *master,
 {
 	struct spi_device	*proxy;
 	int			status;
+	size_t			l;
 
 	/* NOTE:  caller did any chip->bus_num checks necessary.
 	 *
@@ -430,13 +449,23 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	if (!proxy)
 		return NULL;
 
-	WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
+	if (strncmp(SPI_MODULE_PREFIX, chip->modalias,
+		    strlen(SPI_MODULE_PREFIX)) == 0) {
+		proxy->modalias[0] = 0;
+	} else {
+		l = strlcpy(proxy->modalias, SPI_MODULE_PREFIX,
+			    sizeof(proxy->modalias));
+		WARN_ON(l >= sizeof(proxy->modalias));
+	}
+
+	l = strlcat(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
+
+	WARN_ON(l >= sizeof(proxy->modalias));
 
 	proxy->chip_select = chip->chip_select;
 	proxy->max_speed_hz = chip->max_speed_hz;
 	proxy->mode = chip->mode;
 	proxy->irq = chip->irq;
-	strlcpy(proxy->modalias, chip->modalias, sizeof(proxy->modalias));
 	proxy->dev.platform_data = (void *) chip->platform_data;
 	proxy->controller_data = chip->controller_data;
 	proxy->controller_state = NULL;
-- 
1.7.2.3

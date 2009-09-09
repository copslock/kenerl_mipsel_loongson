Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2009 23:24:24 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41259 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493465AbZIIVX4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Sep 2009 23:23:56 +0200
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=pengutronix.de)
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <w.sang@pengutronix.de>)
	id 1MlUdj-00008g-3r; Wed, 09 Sep 2009 23:23:46 +0200
From:	Wolfram Sang <w.sang@pengutronix.de>
To:	linux-i2c@vger.kernel.org
Cc:	linuxppc-dev@ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, uclinux-dist-devel@blackfin.uclinux.org,
	Wolfram Sang <w.sang@pengutronix.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Jean Delvare <khali@linux-fr.org>
Date:	Wed,  9 Sep 2009 23:22:48 +0200
Message-Id: <1252531371-14866-2-git-send-email-w.sang@pengutronix.de>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
X-SA-Exim-Connect-IP: 92.198.50.58
X-SA-Exim-Mail-From: w.sang@pengutronix.de
Subject: [PATCH 1/4] gpio/pcf857x: copy i2c_device_id from old pcf8574-driver
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <w.sang@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w.sang@pengutronix.de
Precedence: bulk
X-list: linux-mips

The deprecated pcf8574 driver is going to be removed. Make sure this
replacement-driver inherits all i2c_device_ids for a smooth transition.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/gpio/pcf857x.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/pcf857x.c b/drivers/gpio/pcf857x.c
index 9525724..3f1ec1e 100644
--- a/drivers/gpio/pcf857x.c
+++ b/drivers/gpio/pcf857x.c
@@ -28,6 +28,7 @@
 
 static const struct i2c_device_id pcf857x_id[] = {
 	{ "pcf8574", 8 },
+	{ "pcf8574a", 8 },
 	{ "pca8574", 8 },
 	{ "pca9670", 8 },
 	{ "pca9672", 8 },
-- 
1.6.3.3

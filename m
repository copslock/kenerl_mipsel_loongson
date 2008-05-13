Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 04:28:14 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:31731 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20022203AbYEMD16 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2008 04:27:58 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4D3RhpN003714;
	Tue, 13 May 2008 05:27:43 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4D3Rgnk003710;
	Tue, 13 May 2008 04:27:42 +0100
Date:	Tue, 13 May 2008 04:27:42 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Jean Delvare <khali@linux-fr.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>
cc:	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] RTC: Trivially probe for an M41T80 (#2)
Message-ID: <Pine.LNX.4.55.0805130303430.535@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 When probing the driver try to access the device with a read to one of
its registers and exit silently if the read fails.  This is so that boards
may register this device unconditionally and do not trigger error messages
at the bootstrap, where there is no other way to determine if an
M41T80-class RTC is actually there.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Please note this patch trivially depends on 
patch-2.6.26-rc1-20080505-m41t80-smbus-17 -- 5/6 of this set.

  Maciej

patch-2.6.26-rc1-20080505-m41t80-probe-18
diff -up --recursive --new-file linux-2.6.26-rc1-20080505.macro/drivers/rtc/rtc-m41t80.c linux-2.6.26-rc1-20080505/drivers/rtc/rtc-m41t80.c
--- linux-2.6.26-rc1-20080505.macro/drivers/rtc/rtc-m41t80.c	2008-05-05 02:55:40.000000000 +0000
+++ linux-2.6.26-rc1-20080505/drivers/rtc/rtc-m41t80.c	2008-05-11 00:30:54.000000000 +0000
@@ -690,10 +690,11 @@ static struct notifier_block wdt_notifie
 static int m41t80_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	int rc = 0;
 	struct rtc_device *rtc = NULL;
 	struct rtc_time tm;
 	struct m41t80_data *clientdata = NULL;
+	int reg;
+	int rc;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -701,6 +702,13 @@ static int m41t80_probe(struct i2c_clien
 		goto exit;
 	}
 
+	/* Trivially check it's there; keep the result for the HT check. */
+	reg = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_HOUR);
+	if (reg < 0) {
+		rc = -ENXIO;
+		goto exit;
+	}
+
 	dev_info(&client->dev,
 		 "chip found, driver version " DRV_VERSION "\n");
 
@@ -723,11 +731,7 @@ static int m41t80_probe(struct i2c_clien
 	i2c_set_clientdata(client, clientdata);
 
 	/* Make sure HT (Halt Update) bit is cleared */
-	rc = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_HOUR);
-	if (rc < 0)
-		goto ht_err;
-
-	if (rc & M41T80_ALHOUR_HT) {
+	if (reg & M41T80_ALHOUR_HT) {
 		if (clientdata->features & M41T80_FEATURE_HT) {
 			m41t80_get_datetime(client, &tm);
 			dev_info(&client->dev, "HT bit was set!\n");
@@ -740,18 +744,18 @@ static int m41t80_probe(struct i2c_clien
 		}
 		if (i2c_smbus_write_byte_data(client,
 					      M41T80_REG_ALARM_HOUR,
-					      rc & ~M41T80_ALHOUR_HT) < 0)
+					      reg & ~M41T80_ALHOUR_HT) < 0)
 			goto ht_err;
 	}
 
 	/* Make sure ST (stop) bit is cleared */
-	rc = i2c_smbus_read_byte_data(client, M41T80_REG_SEC);
-	if (rc < 0)
+	reg = i2c_smbus_read_byte_data(client, M41T80_REG_SEC);
+	if (reg < 0)
 		goto st_err;
 
-	if (rc & M41T80_SEC_ST) {
+	if (reg & M41T80_SEC_ST) {
 		if (i2c_smbus_write_byte_data(client, M41T80_REG_SEC,
-					      rc & ~M41T80_SEC_ST) < 0)
+					      reg & ~M41T80_SEC_ST) < 0)
 			goto st_err;
 	}
 

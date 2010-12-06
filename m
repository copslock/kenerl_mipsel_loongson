Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 05:15:19 +0100 (CET)
Received: from mail-gx0-f176.google.com ([209.85.161.176]:65148 "EHLO
        mail-gx0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490955Ab0LFEPP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Dec 2010 05:15:15 +0100
Received: by gxk4 with SMTP id 4so6619147gxk.35
        for <multiple recipients>; Sun, 05 Dec 2010 20:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fRc2cB7JXFHnSMcu8LJdiBzm+qIDr2zU2Aicw2pK/wI=;
        b=BrDz6iAwrHheq2q2nMCxSTPGlsyePdHMXVKSRXFPMQmiGAT25NbHk+JCreD7VUHRd6
         1Bk24IrZPdb/wq6Wy2wlNfKtuGbfFPJWq9/2PVsE0CgFSRdBjv1gkqTJ6yk6l1QEsoZX
         cVxGjWZwlAz3sYPdJYihuNmYgcSjv5M3AYIzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BugjNUVilg8g7fJVIuztTUs/2FnBWshWW/8hm1aKTBV/sbgppJ9QVXcc77vr/dtsqv
         sT3WY/MtPtaWIT+crQsQob4I6ivMnYgiLPmTyMofxVjoa9DFbos7zlxcaK/vsjw7giEr
         7Bh+Ch1GHVcY6ywUPZiXpr78R7O8DdhekxaKs=
Received: by 10.150.136.18 with SMTP id j18mr8151313ybd.169.1291608908054;
        Sun, 05 Dec 2010 20:15:08 -0800 (PST)
Received: from localhost (cpe-065-190-173-137.nc.res.rr.com [65.190.173.137])
        by mx.google.com with ESMTPS id u10sm1352778yba.1.2010.12.05.20.15.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 20:15:06 -0800 (PST)
From:   Matt Turner <mattst88@gmail.com>
To:     Jean Delvare <khali@linux-fr.org>
Cc:     linux-mips@linux-mips.org, linux-i2c@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 1/3] RTC: SMBus support for the M41T80, etc. driver
Date:   Sun,  5 Dec 2010 23:15:03 -0500
Message-Id: <1291608903-16993-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.2.2
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

From: Maciej W. Rozycki <macro@linux-mips.org>

The BCM1250A SOC which is used on the SWARM board utilising an M41T81
chip only supports pure I2C in the raw bit-banged mode.  Nobody sane
really wants to use it unless absolutely necessary and the M41T80, etc.
chips work just fine with an SMBus adapter which is what the standard mode
of operation of the BCM1250A.  The only drawback of byte accesses with the
M41T80 is the chip only latches clock data registers for the duration of
an I2C transaction which works fine with a block transfers, but not
byte-wise accesses.

The driver currently requires an I2C adapter providing both SMBus and raw
I2C access.  This is a set of changes to make it work with any SMBus
adapter providing at least read byte and write byte protocols.  
Additionally, if a given SMBus adapter supports I2C block read and/or
write protocols (a common extension beyond the SMBus spec), they are used
as well.  The problem of unlatched clock data if SMBus byte transactions
are used is resolved in the standard way.  For raw I2C controllers this
functionality is provided by the I2C core as SMBus emulation in a
transparent way.

Tested-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
This patch was originally sent to the i2c list in May 2008, but looks like
it got lost waiting on some changes in arch/mips to land upstream [2]. These
landed long ago, so this patch should be good to go in as well.

Jean, please apply.

[1] http://lists.lm-sensors.org/pipermail/i2c/2008-May/003739.html
[2] http://lists.lm-sensors.org/pipermail/i2c/2008-May/003658.html

 drivers/rtc/rtc-m41t80.c |  251 ++++++++++++++++++++--------------------------
 1 files changed, 107 insertions(+), 144 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 5a8daa3..2233ed5 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -6,6 +6,7 @@
  * Based on m41t00.c by Mark A. Greer <mgreer@mvista.com>
  *
  * 2006 (c) mycable GmbH
+ * Copyright (c) 2008 Maciej W. Rozycki
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -38,6 +39,8 @@
 #define M41T80_REG_DAY	5
 #define M41T80_REG_MON	6
 #define M41T80_REG_YEAR	7
+#define M41T80_REG_CONTROL	8
+#define M41T80_REG_WATCHDOG	9
 #define M41T80_REG_ALARM_MON	0xa
 #define M41T80_REG_ALARM_DAY	0xb
 #define M41T80_REG_ALARM_HOUR	0xc
@@ -66,7 +69,7 @@
 #define M41T80_FEATURE_WD	(1 << 3)	/* Extra watchdog resolution */
 #define M41T80_FEATURE_SQ_ALT	(1 << 4)	/* RSx bits are in reg 4 */
 
-#define DRV_VERSION "0.05"
+#define DRV_VERSION "0.06"
 
 static DEFINE_MUTEX(m41t80_rtc_mutex);
 static const struct i2c_device_id m41t80_id[] = {
@@ -89,31 +92,89 @@ struct m41t80_data {
 	struct rtc_device *rtc;
 };
 
-static int m41t80_get_datetime(struct i2c_client *client,
-			       struct rtc_time *tm)
+
+static int m41t80_write_block_data(struct i2c_client *client,
+				   u8 reg, u8 num, u8 *buf)
 {
-	u8 buf[M41T80_DATETIME_REG_SIZE], dt_addr[1] = { M41T80_REG_SEC };
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= client->addr,
-			.flags	= 0,
-			.len	= 1,
-			.buf	= dt_addr,
-		},
-		{
-			.addr	= client->addr,
-			.flags	= I2C_M_RD,
-			.len	= M41T80_DATETIME_REG_SIZE - M41T80_REG_SEC,
-			.buf	= buf + M41T80_REG_SEC,
-		},
-	};
+	int i, rc;
+
+	if (i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
+		i = i2c_smbus_write_i2c_block_data(client, reg, num, buf);
+	} else {
+		for (i = 0; i < num; i++) {
+			rc = i2c_smbus_write_byte_data(client, reg + i,
+						       buf[i]);
+			if (rc < 0) {
+				i = rc;
+				goto out;
+			}
+		}
+	}
+out:
+	return i;
+}
 
-	if (i2c_transfer(client->adapter, msgs, 2) < 0) {
-		dev_err(&client->dev, "read error\n");
-		return -EIO;
+static int m41t80_read_block_data(struct i2c_client *client,
+				  u8 reg, u8 num, u8 *buf)
+{
+	int i, rc;
+
+	if (i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		i = i2c_smbus_read_i2c_block_data(client, reg, num, buf);
+	} else {
+		for (i = 0; i < num; i++) {
+			rc = i2c_smbus_read_byte_data(client, reg + i);
+			if (rc < 0) {
+				i = rc;
+				goto out;
+			}
+			buf[i] = rc;
+		}
 	}
+out:
+	return i;
+}
+
+static int m41t80_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	u8 buf[M41T80_DATETIME_REG_SIZE];
+	int loops = 2;
+	int sec0, sec1;
+
+	/*
+	 * Time registers are latched by this chip if an I2C block
+	 * transfer is used, but with SMBus-style byte accesses
+	 * this is not the case, so check seconds for a wraparound.
+	 */
+	do {
+		if (m41t80_read_block_data(client, M41T80_REG_SEC,
+					   M41T80_DATETIME_REG_SIZE -
+					   M41T80_REG_SEC,
+					   buf + M41T80_REG_SEC) < 0) {
+			dev_err(&client->dev, "read error\n");
+			return -EIO;
+		}
+		if (i2c_check_functionality(client->adapter,
+					    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+			sec1 = buf[M41T80_REG_SEC];
+			break;
+		}
+
+		sec0 = buf[M41T80_REG_SEC];
+		sec1 = i2c_smbus_read_byte_data(client, M41T80_REG_SEC);
+		if (sec1 < 0) {
+			dev_err(&client->dev, "read error\n");
+			return -EIO;
+		}
+
+		sec0 = bcd2bin(sec0 & 0x7f);
+		sec1 = bcd2bin(sec1 & 0x7f);
+	} while (sec1 < sec0 && --loops);
 
-	tm->tm_sec = bcd2bin(buf[M41T80_REG_SEC] & 0x7f);
+	tm->tm_sec = sec1;
+	tm->tm_min = bcd2bin(buf[M41T80_REG_MIN] & 0x7f);
 	tm->tm_min = bcd2bin(buf[M41T80_REG_MIN] & 0x7f);
 	tm->tm_hour = bcd2bin(buf[M41T80_REG_HOUR] & 0x3f);
 	tm->tm_mday = bcd2bin(buf[M41T80_REG_DAY] & 0x3f);
@@ -128,39 +189,16 @@ static int m41t80_get_datetime(struct i2c_client *client,
 /* Sets the given date and time to the real time clock. */
 static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
-	u8 wbuf[1 + M41T80_DATETIME_REG_SIZE];
-	u8 *buf = &wbuf[1];
-	u8 dt_addr[1] = { M41T80_REG_SEC };
-	struct i2c_msg msgs_in[] = {
-		{
-			.addr	= client->addr,
-			.flags	= 0,
-			.len	= 1,
-			.buf	= dt_addr,
-		},
-		{
-			.addr	= client->addr,
-			.flags	= I2C_M_RD,
-			.len	= M41T80_DATETIME_REG_SIZE - M41T80_REG_SEC,
-			.buf	= buf + M41T80_REG_SEC,
-		},
-	};
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= client->addr,
-			.flags	= 0,
-			.len	= 1 + M41T80_DATETIME_REG_SIZE,
-			.buf	= wbuf,
-		 },
-	};
+	u8 buf[M41T80_DATETIME_REG_SIZE];
 
 	/* Read current reg values into buf[1..7] */
-	if (i2c_transfer(client->adapter, msgs_in, 2) < 0) {
+	if (m41t80_read_block_data(client, M41T80_REG_SEC,
+				   M41T80_DATETIME_REG_SIZE - M41T80_REG_SEC,
+				   buf + M41T80_REG_SEC) < 0) {
 		dev_err(&client->dev, "read error\n");
 		return -EIO;
 	}
 
-	wbuf[0] = 0; /* offset into rtc's regs */
 	/* Merge time-data and register flags into buf[0..7] */
 	buf[M41T80_REG_SSEC] = 0;
 	buf[M41T80_REG_SEC] =
@@ -177,8 +215,8 @@ static int m41t80_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 		bin2bcd(tm->tm_mon + 1) | (buf[M41T80_REG_MON] & ~0x1f);
 	/* assume 20YY not 19YY */
 	buf[M41T80_REG_YEAR] = bin2bcd(tm->tm_year % 100);
-
-	if (i2c_transfer(client->adapter, msgs, 1) != 1) {
+	if (m41t80_write_block_data(client, M41T80_REG_SSEC,
+				    M41T80_DATETIME_REG_SIZE, buf) < 0) {
 		dev_err(&client->dev, "write error\n");
 		return -EIO;
 	}
@@ -252,34 +290,11 @@ err:
 static int m41t80_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	u8 wbuf[1 + M41T80_ALARM_REG_SIZE];
-	u8 *buf = &wbuf[1];
+	u8 buf[M41T80_ALARM_REG_SIZE];
 	u8 *reg = buf - M41T80_REG_ALARM_MON;
-	u8 dt_addr[1] = { M41T80_REG_ALARM_MON };
-	struct i2c_msg msgs_in[] = {
-		{
-			.addr	= client->addr,
-			.flags	= 0,
-			.len	= 1,
-			.buf	= dt_addr,
-		},
-		{
-			.addr	= client->addr,
-			.flags	= I2C_M_RD,
-			.len	= M41T80_ALARM_REG_SIZE,
-			.buf	= buf,
-		},
-	};
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= client->addr,
-			.flags	= 0,
-			.len	= 1 + M41T80_ALARM_REG_SIZE,
-			.buf	= wbuf,
-		 },
-	};
 
-	if (i2c_transfer(client->adapter, msgs_in, 2) < 0) {
+	if (m41t80_read_block_data(client, M41T80_REG_ALARM_MON,
+				   M41T80_ALARM_REG_SIZE, buf) < 0) {
 		dev_err(&client->dev, "read error\n");
 		return -EIO;
 	}
@@ -289,7 +304,6 @@ static int m41t80_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	reg[M41T80_REG_ALARM_MIN] = 0;
 	reg[M41T80_REG_ALARM_SEC] = 0;
 
-	wbuf[0] = M41T80_REG_ALARM_MON; /* offset into rtc's regs */
 	reg[M41T80_REG_ALARM_SEC] |= t->time.tm_sec >= 0 ?
 		bin2bcd(t->time.tm_sec) : 0x80;
 	reg[M41T80_REG_ALARM_MIN] |= t->time.tm_min >= 0 ?
@@ -303,7 +317,8 @@ static int m41t80_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	else
 		reg[M41T80_REG_ALARM_DAY] |= 0x40;
 
-	if (i2c_transfer(client->adapter, msgs, 1) != 1) {
+	if (m41t80_write_block_data(client, M41T80_REG_ALARM_MON,
+				    M41T80_ALARM_REG_SIZE, buf) < 0) {
 		dev_err(&client->dev, "write error\n");
 		return -EIO;
 	}
@@ -323,24 +338,10 @@ static int m41t80_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	u8 buf[M41T80_ALARM_REG_SIZE + 1]; /* all alarm regs and flags */
-	u8 dt_addr[1] = { M41T80_REG_ALARM_MON };
 	u8 *reg = buf - M41T80_REG_ALARM_MON;
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= client->addr,
-			.flags	= 0,
-			.len	= 1,
-			.buf	= dt_addr,
-		},
-		{
-			.addr	= client->addr,
-			.flags	= I2C_M_RD,
-			.len	= M41T80_ALARM_REG_SIZE + 1,
-			.buf	= buf,
-		},
-	};
 
-	if (i2c_transfer(client->adapter, msgs, 2) < 0) {
+	if (m41t80_read_block_data(client, M41T80_REG_ALARM_MON,
+				   M41T80_ALARM_REG_SIZE + 1, buf) < 0) {
 		dev_err(&client->dev, "read error\n");
 		return -EIO;
 	}
@@ -513,26 +514,16 @@ static int boot_flag;
  */
 static void wdt_ping(void)
 {
-	unsigned char i2c_data[2];
-	struct i2c_msg msgs1[1] = {
-		{
-			.addr	= save_client->addr,
-			.flags	= 0,
-			.len	= 2,
-			.buf	= i2c_data,
-		},
-	};
-	struct m41t80_data *clientdata = i2c_get_clientdata(save_client);
+	u8 wdt = 0x80;				/* WDS = 1 (0x80)  */
 
-	i2c_data[0] = 0x09;		/* watchdog register */
+	struct m41t80_data *clientdata = i2c_get_clientdata(save_client);
 
 	if (wdt_margin > 31)
-		i2c_data[1] = (wdt_margin & 0xFC) | 0x83; /* resolution = 4s */
+		/* mulitplier = WD_TIMO / 4, resolution = 4s (0x3)  */
+		wdt |= (wdt_margin & 0xfc) | 0x3;
 	else
-		/*
-		 * WDS = 1 (0x80), mulitplier = WD_TIMO, resolution = 1s (0x02)
-		 */
-		i2c_data[1] = wdt_margin<<2 | 0x82;
+		/* mulitplier = WD_TIMO, resolution = 1s (0x2)  */
+		wdt |= wdt_margin << 2 | 0x2;
 
 	/*
 	 * M41T65 has three bits for watchdog resolution.  Don't set bit 7, as
@@ -541,7 +532,7 @@ static void wdt_ping(void)
 	if (clientdata->features & M41T80_FEATURE_WD)
 		i2c_data[1] &= ~M41T80_WATCHDOG_RB2;
 
-	i2c_transfer(save_client->adapter, msgs1, 1);
+	i2c_smbus_write_byte_data(save_client, M41T80_REG_WATCHDOG, wdt);
 }
 
 /**
@@ -551,36 +542,8 @@ static void wdt_ping(void)
  */
 static void wdt_disable(void)
 {
-	unsigned char i2c_data[2], i2c_buf[0x10];
-	struct i2c_msg msgs0[2] = {
-		{
-			.addr	= save_client->addr,
-			.flags	= 0,
-			.len	= 1,
-			.buf	= i2c_data,
-		},
-		{
-			.addr	= save_client->addr,
-			.flags	= I2C_M_RD,
-			.len	= 1,
-			.buf	= i2c_buf,
-		},
-	};
-	struct i2c_msg msgs1[1] = {
-		{
-			.addr	= save_client->addr,
-			.flags	= 0,
-			.len	= 2,
-			.buf	= i2c_data,
-		},
-	};
-
-	i2c_data[0] = 0x09;
-	i2c_transfer(save_client->adapter, msgs0, 2);
-
-	i2c_data[0] = 0x09;
-	i2c_data[1] = 0x00;
-	i2c_transfer(save_client->adapter, msgs1, 1);
+	i2c_smbus_read_byte_data(save_client, M41T80_REG_WATCHDOG);
+	i2c_smbus_write_byte_data(save_client, M41T80_REG_WATCHDOG, 0);
 }
 
 /**
@@ -782,8 +745,8 @@ static int m41t80_probe(struct i2c_client *client,
 	struct rtc_time tm;
 	struct m41t80_data *clientdata = NULL;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C
-				     | I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA)) {
 		rc = -ENODEV;
 		goto exit;
 	}
-- 
1.7.3.2

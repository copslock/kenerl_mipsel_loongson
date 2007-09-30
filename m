Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2007 10:55:44 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:19072 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20025708AbXI3JzS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2007 10:55:18 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l8U9tAve009399;
	Sun, 30 Sep 2007 02:55:10 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:55:10 -0700
Received: from [128.224.162.179] ([128.224.162.179]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:55:09 -0700
Message-ID: <46FF726E.4020200@windriver.com>
Date:	Sun, 30 Sep 2007 17:54:54 +0800
From:	Mark Zhan <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
MIME-Version: 1.0
To:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
CC:	ralf@linux-mips.org, a.zummo@towertech.it,
	rongkai.zhan@windriver.com
Subject: [PATCH 2/4] RTC: make m41t80 driver can work with the SMBus adapters
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2007 09:55:09.0824 (UTC) FILETIME=[FCC2B800:01C80347]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

This patch makes m41t80 RTC driver also can work with the SMBus adapters,
which doesn't i2c_transfer() method.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
  drivers/rtc/rtc-m41t80.c |  118 ++++++++++++++++++++++++-----------------------
  1 file changed, 62 insertions(+), 56 deletions(-)

--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -105,6 +105,51 @@ struct m41t80_data {
  	struct rtc_device *rtc;
  };

+static int m41t80_i2c_read(struct i2c_client *client, struct i2c_msg *msgs, int num)
+{
+	int i, rc;
+	u8 dt_addr = msgs[0].buf[0];
+
+	if (num < 2)
+		return -1;
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
+		i2c_transfer(client->adapter, msgs, 2) < 0) {
+		dev_err(&client->dev, "read error\n");
+		return -EIO;
+	} else {
+		for (i = 0; i < msgs[1].len; i++) {
+			rc = i2c_smbus_read_byte_data(client, dt_addr + i);
+			if (rc < 0)
+				return -EIO;
+			msgs[1].buf[i] = (u8)rc;
+		}
+	}
+
+	return 0;
+}
+
+static int m41t80_i2c_write(struct i2c_client *client, struct i2c_msg *msg)
+{
+	int i, rc;
+	u8 *wbuf = msg->buf;
+	u8 *buf = wbuf + 1;
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
+	    i2c_transfer(client->adapter, msg, 1) < 0) {
+		dev_err(&client->dev, "write error\n");
+		return -EIO;
+	} else {
+		for (i = 0; i < msg[0].len - 1; i++) {
+			rc = i2c_smbus_write_byte_data(client, wbuf[0]+i, buf[i]);
+			if (rc < 0)
+				return -EIO;
+		}
+	}
+
+	return 0;
+}
+
  static int m41t80_get_datetime(struct i2c_client *client,
  			       struct rtc_time *tm)
  {
@@ -124,10 +169,8 @@ static int m41t80_get_datetime(struct i2
  		},
  	};

-	if (i2c_transfer(client->adapter, msgs, 2) < 0) {
-		dev_err(&client->dev, "read error\n");
+	if (m41t80_i2c_read(client, msgs, 2))
  		return -EIO;
-	}

  	tm->tm_sec = BCD2BIN(buf[M41T80_REG_SEC] & 0x7f);
  	tm->tm_min = BCD2BIN(buf[M41T80_REG_MIN] & 0x7f);
@@ -171,10 +214,8 @@ static int m41t80_set_datetime(struct i2
  	};

  	/* Read current reg values into buf[1..7] */
-	if (i2c_transfer(client->adapter, msgs_in, 2) < 0) {
-		dev_err(&client->dev, "read error\n");
+	if (m41t80_i2c_read(client, msgs_in, 2))
  		return -EIO;
-	}

  	wbuf[0] = 0; /* offset into rtc's regs */
  	/* Merge time-data and register flags into buf[0..7] */
@@ -194,10 +235,9 @@ static int m41t80_set_datetime(struct i2
  	/* assume 20YY not 19YY */
  	buf[M41T80_REG_YEAR] = BIN2BCD(tm->tm_year % 100);

-	if (i2c_transfer(client->adapter, msgs, 1) != 1) {
-		dev_err(&client->dev, "write error\n");
+	if (m41t80_i2c_write(client, msgs))
  		return -EIO;
-	}
+
  	return 0;
  }

@@ -295,10 +335,9 @@ static int m41t80_rtc_set_alarm(struct d
  		 },
  	};

-	if (i2c_transfer(client->adapter, msgs_in, 2) < 0) {
-		dev_err(&client->dev, "read error\n");
+	if (m41t80_i2c_read(client, msgs_in, 2))
  		return -EIO;
-	}
+
  	reg[M41T80_REG_ALARM_MON] &= ~(0x1f | M41T80_ALMON_AFE);
  	reg[M41T80_REG_ALARM_DAY] = 0;
  	reg[M41T80_REG_ALARM_HOUR] &= ~(0x3f | 0x80);
@@ -319,10 +358,8 @@ static int m41t80_rtc_set_alarm(struct d
  	else
  		reg[M41T80_REG_ALARM_DAY] |= 0x40;

-	if (i2c_transfer(client->adapter, msgs, 1) != 1) {
-		dev_err(&client->dev, "write error\n");
+	if (m41t80_i2c_write(client, msgs))
  		return -EIO;
-	}

  	if (t->enabled) {
  		reg[M41T80_REG_ALARM_MON] |= M41T80_ALMON_AFE;
@@ -356,10 +393,9 @@ static int m41t80_rtc_read_alarm(struct
  		},
  	};

-	if (i2c_transfer(client->adapter, msgs, 2) < 0) {
-		dev_err(&client->dev, "read error\n");
+	if (m41t80_i2c_read(client, msgs, 2))
  		return -EIO;
-	}
+
  	t->time.tm_sec = -1;
  	t->time.tm_min = -1;
  	t->time.tm_hour = -1;
@@ -516,14 +552,7 @@ static int boot_flag;
  static void wdt_ping(void)
  {
  	unsigned char i2c_data[2];
-	struct i2c_msg msgs1[1] = {
-		{
-			.addr	= save_client->addr,
-			.flags	= 0,
-			.len	= 2,
-			.buf	= i2c_data,
-		},
-	};
+
  	i2c_data[0] = 0x09;		/* watchdog register */

  	if (wdt_margin > 31)
@@ -534,7 +563,7 @@ static void wdt_ping(void)
  		 */
  		i2c_data[1] = wdt_margin<<2 | 0x82;

-	i2c_transfer(save_client->adapter, msgs1, 1);
+	i2c_smbus_write_byte_data(save_client, i2c_data[0], i2c_data[1]);
  }

  /**
@@ -544,36 +573,14 @@ static void wdt_ping(void)
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
+	unsigned char i2c_data[2];

-	i2c_data[0] = 0x09;
-	i2c_transfer(save_client->adapter, msgs0, 2);
+	i2c_data[0] = 0x09; /* watchdog register */
+	i2c_data[1] = i2c_smbus_read_byte_data(save_client, i2c_data[0]);

-	i2c_data[0] = 0x09;
+	/* write 0x00 to disable WDT until it is programmed again. */
  	i2c_data[1] = 0x00;
-	i2c_transfer(save_client->adapter, msgs1, 1);
+	i2c_smbus_read_byte_datasave_client, i2c_data[0], i2c_data[1]);
  }

  /**
@@ -764,8 +771,7 @@ static int m41t80_probe(struct i2c_clien
  	const struct m41t80_chip_info *chip;
  	struct m41t80_data *clientdata = NULL;

-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C
-				     | I2C_FUNC_SMBUS_BYTE_DATA)) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
  		rc = -ENODEV;
  		goto exit;
  	}

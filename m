Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 16:04:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:46033 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024075AbXJAPEl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2007 16:04:41 +0100
Received: from localhost (p1055-ipad306funabasi.chiba.ocn.ne.jp [123.217.171.55])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 41665F169; Tue,  2 Oct 2007 00:04:35 +0900 (JST)
Date:	Tue, 02 Oct 2007 00:06:16 +0900 (JST)
Message-Id: <20071002.000616.31638007.anemo@mba.ocn.ne.jp>
To:	rongkai.zhan@windriver.com
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com, ralf@linux-mips.org,
	a.zummo@towertech.it
Subject: Re: [PATCH 2/4] RTC: make m41t80 driver can work with the SMBus
 adapters
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46FF726E.4020200@windriver.com>
References: <46FF726E.4020200@windriver.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 30 Sep 2007 17:54:54 +0800, Mark Zhan <rongkai.zhan@windriver.com> wrote:
> This patch makes m41t80 RTC driver also can work with the SMBus adapters,
> which doesn't i2c_transfer() method.
> 
> Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>

As Jean already said, your mailer corrupted your patch.
Also, please keep in mind the 80 column rule.

> +static int m41t80_i2c_read(struct i2c_client *client, struct i2c_msg *msgs, int num)
> +{
> +	int i, rc;
> +	u8 dt_addr = msgs[0].buf[0];
> +
> +	if (num < 2)
> +		return -1;
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
> +		i2c_transfer(client->adapter, msgs, 2) < 0) {
> +		dev_err(&client->dev, "read error\n");
> +		return -EIO;
> +	} else {
> +		for (i = 0; i < msgs[1].len; i++) {
> +			rc = i2c_smbus_read_byte_data(client, dt_addr + i);
> +			if (rc < 0)
> +				return -EIO;
> +			msgs[1].buf[i] = (u8)rc;
> +		}
> +	}
> +
> +	return 0;
> +}

You must ensure time values are consistent.  The RTC might update its
time data between each I2C transfer.

It seems the original rtc_m41t81.c:m41t81_get_time() tries to solve
this issue by reading sec/min in loop, but it would not be enough.
For example, if the function was called at 23:59:59, the sec (and min)
might wrap just before reading the hour, then you might get 00:59:59.

The old m41t00 i2c driver once did it right with smbus, but current
m41t00 driver (and rtc-m41t80 driver) dropped that feature a while
ago.  You can see the old code at:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/i2c/chips/m41t00.c;hb=e931b8d8a428f87e6ea488d2fd80007bb66b3ea8

> +static int m41t80_i2c_write(struct i2c_client *client, struct i2c_msg *msg)
> +{
> +	int i, rc;
> +	u8 *wbuf = msg->buf;
> +	u8 *buf = wbuf + 1;
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
> +	    i2c_transfer(client->adapter, msg, 1) < 0) {
> +		dev_err(&client->dev, "write error\n");
> +		return -EIO;
> +	} else {
> +		for (i = 0; i < msg[0].len - 1; i++) {
> +			rc = i2c_smbus_write_byte_data(client, wbuf[0]+i, buf[i]);
> +			if (rc < 0)
> +				return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}

Writing to the RTC by multiple I2C transfers might have same
consistency problem.  But it would not be a real problem if you wrote
the sec register first.  Here is a comment in
rtc_m41t81.c:m41t81_set_time():

	/*
	 * Note the write order matters as it ensures the correctness.
	 * When we write sec, 10th sec is clear.  It is reasonable to
	 * believe we should finish writing min within a second.
	 */

I think this comment is worth to import.

Other parts looks good for me.

---
Atsushi Nemoto

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 15:00:18 +0100 (BST)
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:64481 "EHLO
	kraid.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20023988AbXJAOAJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 15:00:09 +0100
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with ESMTP id 7026ACF0A7;
	Mon,  1 Oct 2007 15:59:38 +0200 (CEST)
Date:	Mon, 1 Oct 2007 15:59:38 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Mark Zhan <rongkai.zhan@windriver.com>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	ralf@linux-mips.org
Subject: Re: [i2c] [PATCH 3/4] RTC: add Xicor 1241 driver
Message-ID: <20071001155938.0590fc3a@hyperion.delvare>
In-Reply-To: <46FF7279.3020102@windriver.com>
References: <46FF7279.3020102@windriver.com>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Mark,

On Sun, 30 Sep 2007 17:55:05 +0800, Mark Zhan wrote:
> This patch add the Xicor 1241 RTC driver which is used in
> MIPS Sibyte 1250/1480 boards.

So this chip is using two-byte register addressing, which isn't
compatible with SMBus. Which explains why the register reads and writes
in your driver look strange. I don't think it's quite correct.

> +/*
> + * Register Offset
> + */
> +#define X1241_SEC	0x30		/* Seconds */
> +#define X1241_MIN	0x31		/* Minutes */
> +#define X1241_HOUR	0x32		/* Hours */
> +#define X1241_MDAY	0x33		/* Day of month */
> +#define X1241_MON	0x34		/* Month */
> +#define X1241_YEAR	0x35		/* Year */
> +#define X1241_WDAY	0x36		/* Day of Week */
> +#define X1241_Y2K	0x37		/* Year 2K */
> +#define X1241_SR	0x3F		/* Status register */
> +
> +DEFINE_SPINLOCK(xicor1241_lock);
> +
> +static int xicor1241_get_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned int y2k, year, mon, mday, wday, hour, min, sec;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&xicor1241_lock, flags);
> +
> +	i2c_smbus_write_byte_data(client, X1241_SEC, X1241_SEC);

If I read the datasheet properly, this should be:

	i2c_smbus_write_byte_data(client, 0, X1241_SEC);

The SC register is at 0x0030, not 0x3030.

> +	sec = i2c_smbus_read_byte_data(client, X1241_SEC);
> +	min = i2c_smbus_read_byte_data(client, X1241_MIN);
> +	hour = i2c_smbus_read_byte_data(client, X1241_HOUR);
> +	mday = i2c_smbus_read_byte_data(client, X1241_MDAY);
> +	mon = i2c_smbus_read_byte_data(client, X1241_MON);
> +	year = i2c_smbus_read_byte_data(client, X1241_YEAR);
> +	wday = i2c_smbus_read_byte_data(client, X1241_WDAY);
> +	y2k = i2c_smbus_read_byte_data(client, X1241_Y2K);

You are using the "Current Address Read" mode here, right? If so, you
aren't supposed to send any address information at all, i.e. you should
use i2c_smbus_read_byte() instead of i2c_smbus_read_byte_data(). You
are probably just lucky that the chip ignores the extra byte you're
sending.

> (...)
> +static int xicor1241_set_time(struct device *dev, struct rtc_time *tm)
> +{
> (...)
> +	/* unlock writes to the CCR */
> +	i2c_smbus_write_word_data(client, X1241_SR,
> +			(X1241_SR_WEL << 8) | X1241_SR);
> +	i2c_smbus_write_word_data(client, X1241_SR,
> +			((X1241_SR_WEL | X1241_SR_RWEL) << 8) | X1241_SR);
> +
> +	i2c_smbus_write_word_data(client, X1241_SEC, (sec << 8) | X1241_SEC);
> +	i2c_smbus_write_word_data(client, X1241_MIN, (min << 8) | X1241_MIN);
> +	i2c_smbus_write_word_data(client, X1241_HOUR, (hour << 8) | X1241_HOUR);
> +	i2c_smbus_write_word_data(client, X1241_MDAY, (mday << 8) | X1241_MDAY);
> +	i2c_smbus_write_word_data(client, X1241_WDAY, (wday << 8) | X1241_WDAY);
> +	i2c_smbus_write_word_data(client, X1241_MON, (mon << 8) | X1241_MON);
> +	i2c_smbus_write_word_data(client, X1241_YEAR, (year << 8) | X1241_YEAR);
> +	i2c_smbus_write_word_data(client, X1241_Y2K, (y2k << 8) | X1241_Y2K);
> +
> +	i2c_smbus_write_word_data(client, X1241_SR, (0 << 8) | X1241_SR);

Here again I am surprised. I expected:

	i2c_smbus_write_word_data(client, 0, (sec << 8) | X1241_SEC);

So that you write to register 0x0030, not 0x3030. Same for all the
other register writes. Or am I misreading the datasheet?

> +
> +	spin_unlock_irqrestore(&xicor1241_lock, flags);
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops xicor1241_rtc_ops = {
> +	.read_time = xicor1241_get_time,
> +	.set_time  = xicor1241_set_time,
> +};
> +
> +static int __devinit xicor1241_rtc_probe(struct i2c_client *client)
> +{
> +	struct rtc_device *rtc;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_dbg(&client->dev, "I2C adapter function check failure!\n");
> +		return -ENODEV;
> +	}

This check isn't sufficient, you must check for
I2C_FUNC_SMBUS_WRITE_WORD_DATA as well, and possibly
I2C_FUNC_SMBUS_READ_BYTE if my comment above is correct.

-- 
Jean Delvare

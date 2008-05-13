Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 17:58:42 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:32238 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20032307AbYEMQ6k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2008 17:58:40 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4DGvrce007367;
	Tue, 13 May 2008 18:57:53 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4DGvqTg007363;
	Tue, 13 May 2008 17:57:52 +0100
Date:	Tue, 13 May 2008 17:57:52 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jean Delvare <khali@linux-fr.org>
cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] RTC: SMBus support for the M41T80, etc. driver (#2)
In-Reply-To: <20080513140444.49d7a044@hyperion.delvare>
Message-ID: <Pine.LNX.4.55.0805131752340.7267@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130254420.535@cliff.in.clinika.pl>
 <20080513140444.49d7a044@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Jean,

> The I2C part of the changes look OK to me. With one comment below:
> 
> > +static int m41t80_get_datetime(struct i2c_client *client, struct rtc_time *tm)
> > +{
> > +	u8 buf[M41T80_DATETIME_REG_SIZE];
> > +	int loops = 2;
> > +	int sec0, sec1;
> > +
> > +	/*
> > +	 * Time registers are latched by this chip if an I2C block
> > +	 * transfer is used, but with SMBus-style byte accesses
> > +	 * this is not the case, so check seconds for a wraparound.
> > +	 */
> > +	do {
> > +		if (m41t80_read_block_data(client, M41T80_REG_SEC,
> > +					   M41T80_DATETIME_REG_SIZE -
> > +					   M41T80_REG_SEC,
> > +					   buf + M41T80_REG_SEC) < 0) {
> > +			dev_err(&client->dev, "read error\n");
> > +			return -EIO;
> > +		}
> > +		sec0 = buf[M41T80_REG_SEC];
> >  
> > -	tm->tm_sec = BCD2BIN(buf[M41T80_REG_SEC] & 0x7f);
> > +		sec1 = i2c_smbus_read_byte_data(client, M41T80_REG_SEC);
> > +		if (sec1 < 0) {
> > +			dev_err(&client->dev, "read error\n");
> > +			return -EIO;
> > +		}
> > +
> > +		sec0 = BCD2BIN(sec0 & 0x7f);
> > +		sec1 = BCD2BIN(sec1 & 0x7f);
> > +	} while (sec1 < sec0 && --loops);
> 
> You will do this even if all the registers were read as a block and the
> RTC latched the register values so they have to be correct. Isn't it a
> bit unfair / inefficient? If client->adapter has the
> I2C_FUNC_SMBUS_READ_I2C_BLOCK functionality you can skip the comparison
> and retry mechanism completely, saving some time and CPU cycles.

 Well, actually there is a reason beyond that.  It may change if we
support subsecond resolution, but we currently do not.  The reason is if
we return the original timestamp and the seconds register changes while
the timestamp is being read, then effectively we return a value that is
off by one second.  This is why for seconds I decided to return the second
value read all the time.

  Maciej

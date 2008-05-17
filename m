Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 May 2008 21:47:39 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:30962 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20035746AbYEQUrg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 May 2008 21:47:36 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4HKkjLU010479;
	Sat, 17 May 2008 22:46:45 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4HKkZ0g010475;
	Sat, 17 May 2008 21:46:35 +0100
Date:	Sat, 17 May 2008 21:46:35 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	khali@linux-fr.org, a.zummo@towertech.it,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	ralf@linux-mips.org, tglx@linutronix.de,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] RTC: SMBus support for the M41T80, etc. driver (#2)
In-Reply-To: <20080518.003157.126143021.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.55.0805172134420.10067@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130254420.535@cliff.in.clinika.pl>
 <20080513140444.49d7a044@hyperion.delvare> <Pine.LNX.4.55.0805131752340.7267@cliff.in.clinika.pl>
 <20080518.003157.126143021.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 18 May 2008, Atsushi Nemoto wrote:

> I suppose the "off by one second" issue is not the matter each driver
> should take care of.  This race is common for most RTC chip.

 I agree, but with the reread it comes for free here.  Given you have two 
values of seconds available here, which one would you choose?  You can't 
take both at once. ;-)

> I do not have strong opinion for optimization suggested by Jean.  It
> might be better, but I'm OK with current your patch.

 Hmm, it looks as simple as putting a clause like:

	if (i2c_check_functionality(client->adapter, 
				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)
		break;

into the loop and even at 400kHz it saves a considerable amount of time.
It sounds plausible -- I'll do that.

  Maciej

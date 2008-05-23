Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2008 04:37:44 +0100 (BST)
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:27485 "HELO
	smtp123.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20028965AbYEWDhl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 May 2008 04:37:41 +0100
Received: (qmail 6054 invoked from network); 23 May 2008 03:37:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=l/x5y+SGY8HNSoE/pJ4lmbaeyqVQ5N4DU2yEOXbeSHwVRXEX6vMxxvZmwZsFVeYCbFN7FptbCs6hrT4Uw7pVBerdZZJ5xlGRlPVXBOTAOQoyJ2aZwLNO7PvxdGlJXH25CnHgFau18Gj23L7RSJomj6XEsiQnJvTAN4sIIN9SXQM=  ;
Received: from unknown (HELO pogo) (david-b@pacbell.net@69.226.247.198 with plain)
  by smtp123.sbc.mail.sp1.yahoo.com with SMTP; 23 May 2008 03:37:24 -0000
X-YMail-OSG: e3v0JnoVM1kGDbQpyzsNKq2dxCbhCiSkqPtyP.wUHuiFxnt14wEJ6hKBh7y.FTwIxG.kbFC1.FeIM1La5tW5R7ky3hK.4GdKDPoICM4EHlwZiyqWPSkcJsn87RsJfZJb5P8-
X-Yahoo-Newman-Property: ymail-3
From:	David Brownell <david-b@pacbell.net>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 6/6] RTC: Trivially probe for an M41T80 (#2)
Date:	Thu, 22 May 2008 20:07:06 -0700
User-Agent: KMail/1.9.9
Cc:	Jean Delvare <khali@linux-fr.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55.0805130303430.535@cliff.in.clinika.pl> <20080513142829.2d737424@hyperion.delvare> <Pine.LNX.4.55.0805131759580.7267@cliff.in.clinika.pl>
In-Reply-To: <Pine.LNX.4.55.0805131759580.7267@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200805222007.07146.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Tuesday 13 May 2008, Maciej W. Rozycki wrote:
> Then I am not sure how i2c_new_probed_device() could be used for a
> baseboard device.  With an option card bearing an I2C adapter it can be
> done at the time the card, including the adapter, is initialized.  With a
> baseboard adapter it really begs to be in board initialization.  

One idiom to consider is callbacks (or notifications) when the
relevant i2c_adapter is registered.

Some of the GPIO drivers do that, so that they can hook up the
relevant devices or options.  Example, when an pcf8574 expander
is used to drive LEDs, the "this chip got registered" callback
can register the relevant "leds-gpio" platform device.  Or when
it's used to switch power to other devices, sometimes they must
defer registration till then too (power them up first, *then* it
makes sense to register them).

This could handle that "board has this I2C RTC -or- that one"
case pretty cleanly; but then, so would having a "probe first"
flag that's specific to the i2c_board_info.  (So long as the
probe logic could distinguish the devices... which will not in
the most general case work from i2c-core code.)

- Dave

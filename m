Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 13:28:46 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:53367 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20027468AbYEMM2n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 May 2008 13:28:43 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1JvuYs-0003IN-QA
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Tue, 13 May 2008 15:28:58 +0200
Date:	Tue, 13 May 2008 14:28:29 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/6] RTC: Trivially probe for an M41T80 (#2)
Message-ID: <20080513142829.2d737424@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805130303430.535@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130303430.535@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Tue, 13 May 2008 04:27:42 +0100 (BST), Maciej W. Rozycki wrote:
>  When probing the driver try to access the device with a read to one of
> its registers and exit silently if the read fails.  This is so that boards
> may register this device unconditionally and do not trigger error messages
> at the bootstrap, where there is no other way to determine if an
> M41T80-class RTC is actually there.

I don't like this. You are only supposed to declare in platform init
structures, I2C devices that you are sure are present. Relying on the
driver to not attach to the device if it is in fact not there sounds
wrong, because the I2C device will still be declared, so it's
confusing. Also, you consider that a driver silently failing to attach
is a feature, and in your specific case it may be, but for other users
it will be an annoyance: in the general case you want errors to be
clearly reported.

If you are not sure that an I2C device will be present, then you should
not declare it as part of the I2C board info, but register it later
with i2c_new_probed_device(). If this isn't possible or not convenient,
then I'd rather add a probing variant of i2c_register_board_info() (or
maybe a new flag in i2c_board_info.flags) than hack all i2c drivers to
silent failures when devices are missing.

-- 
Jean Delvare

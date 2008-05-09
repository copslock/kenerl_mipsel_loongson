Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 21:39:03 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:47806 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20024876AbYEIUjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 May 2008 21:39:00 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1JuaJ2-0007ej-TW
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Fri, 09 May 2008 23:39:09 +0200
Date:	Fri, 9 May 2008 22:38:45 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Message-ID: <20080509223845.4a38d751@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805092054030.10552@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
	<20080507085953.2c08b854@hyperion.delvare>
	<Pine.LNX.4.55.0805072145040.25644@cliff.in.clinika.pl>
	<20080508105905.3209c659@hyperion.delvare>
	<Pine.LNX.4.55.0805082344040.5944@cliff.in.clinika.pl>
	<20080509092835.3bbf0f55@hyperion.delvare>
	<Pine.LNX.4.55.0805092054030.10552@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Fri, 9 May 2008 21:27:04 +0100 (BST), Maciej W. Rozycki wrote:
>  Well, sorry, but I could only sense the lack of style in this piece of
> code, which is why I tried to apply some.

I agree, i2c-sibyte is very old code, and unmaintained, coding style is
horrible. That's one more reason to not include random style cleanups
in a patch doing functional changes, the improvement will hardly be
visible. If you care about cleaning up the code of this driver - and I
would appreciate that - please make a separate patch.

>                                            You are free to disagree and as
> you have undertaken maintenance of this area I am going to respect it.

And I thank you for that.

-- 
Jean Delvare

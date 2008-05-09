Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 22:22:06 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:47124 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20025074AbYEIVWD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 May 2008 22:22:03 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1Juayg-0003Em-6z
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Sat, 10 May 2008 00:22:10 +0200
Date:	Fri, 9 May 2008 23:21:46 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Brownell <david-b@pacbell.net>, linux-mips@linux-mips.org,
	mgreer@mvista.com, rtc-linux@googlegroups.com,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-kernel@vger.kernel.org, i2c@lm-sensors.org, ab@mycable.de,
	Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [i2c] [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
Message-ID: <20080509232146.18638986@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805092127410.10552@cliff.in.clinika.pl>
References: <200805070120.03821.david-b@pacbell.net>
	<Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
	<200805071625.20430.david-b@pacbell.net>
	<Pine.LNX.4.55.0805080306080.32613@cliff.in.clinika.pl>
	<20080509100841.151eabcd@hyperion.delvare>
	<Pine.LNX.4.55.0805092127410.10552@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Fri, 9 May 2008 21:55:38 +0100 (BST), Maciej W. Rozycki wrote:
> > This is reimplementing i2c_smbus_write_i2c_block_data().
> 
>  Where does it come from?  I fail to see this type of transfer being 
> defined anywhere in the SMBus spec.

It is indeed not.

>                                      I checked the spec before I referred 
> to the implementation in our I2C core and I hope you agree I may not have 
> expected any extensions beyond what the SMBus spec defines.

The "smbus" in these function names are more about "what SMBus
controllers usually can do" than about the SMBus specification. But I
admit you couldn't guess.

>  That written, you are of course correct WRT the reimplementation and I am 
> eager to remove it -- thanks for the point.  I'll skip all your other 
> comments related as obviously implied by this change.
> 
>  Given the function and friends make use of apparently a non-standard
> SMBus transfer, I think they should be called differently, perhaps
> i2c_smbusext_write_i2c_block_data(), etc. or suchlike.

This was an option when the functions where introduced 9 years ago.
But now that it was done, renaming them would cause even more
confusion, I think. I would be fine with adding comments in i2c-core.c
or improving Documentation/i2c/smbus-protocol to make it more obious,
though.

On a related note, you will notice that the other i2c_smbus_* functions
do not follow the naming of SMBus transactions. Again that's something
I regret but I feel that changing the names now would cause a lot of
confusion amongst developers, so I'm not doing it.

> > Mixing code cleanups with functional changes is a Bad Idea (TM).
> 
>  I am happy to bother you with a separate patch including style fixes.  I
> can even create a handful of them, grouping functionally consistent
> changes.

Just one patch should be enough, if I agree with all the changes. You
might make a separate patch with the things I may not agree with, so
that you don't have to cherry-revert them if I indeed don't agree, and
we just merge them if I do agree.

> > >  	dev_info(&client->dev,
> > > -		 "chip found, driver version " DRV_VERSION "\n");
> > > +		 "%s chip found, driver version " DRV_VERSION "\n",
> > > +		 client->name);
> > 
> > Incorrect change, dev_info() already includes the chip name.
> 
>  My system must be a notable exception then, as this change modifies 
> output:
> 
> rtc-m41t80 1-0068: chip found, driver version 0.05
> 
> to:
> 
> rtc-m41t80 1-0068: m41t81 chip found, driver version 0.05
> 
> here.

My bad, for some reason I thought that dev_printk() included the device
name but it in fact includes the driver name. I was wrong, just ignore
me.

-- 
Jean Delvare

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 18:17:49 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:7480 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20027521AbYEMRRr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 May 2008 18:17:47 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1Jvz4c-0002xe-AE
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Tue, 13 May 2008 20:18:02 +0200
Date:	Tue, 13 May 2008 19:17:32 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	David Woodhouse <dwmw2@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] RTC: SWARM I2C board initialization (#2)
Message-ID: <20080513191732.259d0ab2@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805131747590.7267@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130249230.535@cliff.in.clinika.pl>
	<20080513133416.59a8d943@hyperion.delvare>
	<Pine.LNX.4.55.0805131747590.7267@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

On Tue, 13 May 2008 17:51:32 +0100 (BST), Maciej W. Rozycki wrote:
> > >  I have renamed i2c-swarm.c to swarm-i2c.c for consistency with names 
> > > of other files under arch/mips/.
> > 
> > But you forgot to update the log message accordingly...
> 
>  I did not, unless I am missing something.

		printk(KERN_ERR
		       "i2c-swarm: cannot register board I2C devices\n");

> > >  Please note this patch trivially depends on
> > > patch-2.6.26-rc1-20080505-swarm-core-16 -- 2/6 of this set.
> > 
> > OK, so I should just wait for patch 2/6 to get upstream before I add
> > this one to my i2c tree?
> 
>  Either this or you can apply both and remove the local copy of the former
> when it comes back from upstream.  Whatever you prefer -- it is your
> choice.

I don't really want to include a mips arch patch in my public i2c tree,
that would be confusing. I think I'll just wait. I have the mips patch
in my local tree, so quilt will tell me when it hits upstream.

-- 
Jean Delvare

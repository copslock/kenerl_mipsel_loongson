Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2005 22:52:45 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33548 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133830AbVKBWwY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Nov 2005 22:52:24 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1EXRTX-0005p6-O9; Wed, 02 Nov 2005 22:53:00 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1EXRTV-0008G6-PP; Wed, 02 Nov 2005 22:52:57 +0000
Date:	Wed, 2 Nov 2005 22:52:57 +0000
From:	Russell King <rmk+lkml@arm.linux.org.uk>
To:	Andy Isaacson <adi@hexapodia.org>
Cc:	Pavel Machek <pavel@suse.cz>,
	Richard Purdie <richard@openedhand.com>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
	linux-mips@linux-mips.org
Subject: Re: [RFC] The driver model, I2C and gpio provision on Sharp SL-C1000 (Akita)
Message-ID: <20051102225257.GE4778@flint.arm.linux.org.uk>
Mail-Followup-To: Andy Isaacson <adi@hexapodia.org>,
	Pavel Machek <pavel@suse.cz>,
	Richard Purdie <richard@openedhand.com>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
	linux-mips@linux-mips.org
References: <20051029190819.GB657@openzaurus.ucw.cz> <20051102194453.GF26542@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102194453.GF26542@hexapodia.org>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+lkml@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, Nov 02, 2005 at 11:44:53AM -0800, Andy Isaacson wrote:
> On Sat, Oct 29, 2005 at 09:08:19PM +0200, Pavel Machek wrote:
> > > I2C drivers appear relatively late in the boot procedure and changing
> > > that isn't practical. I therefore ended up writing akita-ioexp which
> > 
> > It seems that making i2c init early is only sane choice. I realize PC people
> > will hate it... but apart from that, why is it impractical?
> 
> FWIW, I have also run into this "I need I2C early in boot, but it's not
> inited until late" on SiByte (arch/mips/sibyte/{sb1250,bcm1480}/setup.c).  
> For the time being in the linux-mips tree we simply have two drivers
> talking to the I2C interface - sibyte/swarm/rtc_* and i2c-sibyte.c,
> and they are currently lacking even any trivial locking.  We haven't
> seen any problems yet but that's due to limited exercise - the default
> config doesn't hook up any drivers for the other chips on I2C.
> 
> How do other arches that have I2C RTCs deal with this problem?  Or is
> there something wrong with how arch/mips/kernel/time.c:time_init deals
> with the rtc?

On ARM, where we have I2C RTCs, I tend to leave xtime well alone in
time_init and just setup the timer.  When i2c is initialised, and
the bus and RTC have been detected, I set the time from them at
that point.

I haven't seen any problems with this approach.  In fact, I'd
rather time_init() just setup the timer, and we set the time of
day later during the kernels initialisation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

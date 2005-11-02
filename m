Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2005 19:44:31 +0000 (GMT)
Received: from straum.hexapodia.org ([64.81.70.185]:1825 "EHLO
	straum.hexapodia.org") by ftp.linux-mips.org with ESMTP
	id S8133822AbVKBToL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Nov 2005 19:44:11 +0000
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id E8DAB283; Wed,  2 Nov 2005 11:44:53 -0800 (PST)
Date:	Wed, 2 Nov 2005 11:44:53 -0800
From:	Andy Isaacson <adi@hexapodia.org>
To:	Pavel Machek <pavel@suse.cz>
Cc:	Richard Purdie <richard@openedhand.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Russell King <rmk@arm.linux.org.uk>, Greg KH <gregkh@suse.de>,
	linux-mips@linux-mips.org
Subject: Re: [RFC] The driver model, I2C and gpio provision on Sharp SL-C1000 (Akita)
Message-ID: <20051102194453.GF26542@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029190819.GB657@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.2i
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 29, 2005 at 09:08:19PM +0200, Pavel Machek wrote:
> > I2C drivers appear relatively late in the boot procedure and changing
> > that isn't practical. I therefore ended up writing akita-ioexp which
> 
> It seems that making i2c init early is only sane choice. I realize PC people
> will hate it... but apart from that, why is it impractical?

FWIW, I have also run into this "I need I2C early in boot, but it's not
inited until late" on SiByte (arch/mips/sibyte/{sb1250,bcm1480}/setup.c).  
For the time being in the linux-mips tree we simply have two drivers
talking to the I2C interface - sibyte/swarm/rtc_* and i2c-sibyte.c,
and they are currently lacking even any trivial locking.  We haven't
seen any problems yet but that's due to limited exercise - the default
config doesn't hook up any drivers for the other chips on I2C.

How do other arches that have I2C RTCs deal with this problem?  Or is
there something wrong with how arch/mips/kernel/time.c:time_init deals
with the rtc?

> > There is a fundamental problem with the lack of a proper gpio interface
> > in Linux. Every driver does something different with them (be it pxa
> > specific gpios, SCOOP gpios, those on a IO expander, those on a video
> > chip (w100fb springs to mind) to name just the Zaurus specific ones.
> 
> Yup. GPIOs are not problem on i386, so noone solved this one :-(.

I would also be overjoyed to have a GPIO infrastructure to plug into.

(And I would say "GPIOs are not used on PCs"; I am confident the Geode
driving the seat-back TV on this Song flight has GPIOs...)

-andy

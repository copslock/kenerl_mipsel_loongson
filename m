Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 11:15:41 +0000 (GMT)
Received: from witte.sonytel.be ([80.88.33.193]:7126 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133455AbWB0LPd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Feb 2006 11:15:33 +0000
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k1RBMwlR016317;
	Mon, 27 Feb 2006 12:22:58 +0100 (MET)
Date:	Mon, 27 Feb 2006 12:22:57 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	jblache@debian.org, rmk+serial@arm.linux.org.uk
Subject: Re: IP22 doesn't shutdown properly
In-Reply-To: <20060227105236.GI12044@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.62.0602271222120.18095@pademelon.sonytel.be>
References: <20060217225824.GE20785@deprecation.cyrius.com>
 <20060223221350.GA5239@deprecation.cyrius.com> <20060224190517.GA28013@lst.de>
 <20060227105236.GI12044@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 27 Feb 2006, Martin Michlmayr wrote:
> * Christoph Hellwig <hch@lst.de> [2006-02-24 20:05]:
> > This patch was dropped when a real fix went into one of the sun serial
> > drivers with which this issue was seen before.  Please look through
> > the drivers/serial/sun* changelogs and see what fix needs to be
> > ported to the ip22zilog driver.
> 
> Ralf suggested to see what other changes have been made to the
> sunzilog driver recently and update the ip22zilog driver accordingly.
> Russell, please queue the following patch for 2.6.17.

Any chance they can be merged, to avoid such missed updates in the future?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

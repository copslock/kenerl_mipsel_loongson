Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2007 14:18:18 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:38160 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20021925AbXFYNSP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Jun 2007 14:18:15 +0100
Received: (qmail 27763 invoked by uid 1000); 25 Jun 2007 15:18:14 +0200
Date:	Mon, 25 Jun 2007 15:18:14 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Attila Kinali <attila@kinali.ch>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1550 ac97 driver
Message-ID: <20070625131814.GA27621@roarinelk.homelinux.net>
References: <20070625150506.a0cd7f9b.attila@kinali.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070625150506.a0cd7f9b.attila@kinali.ch>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Mon, Jun 25, 2007 at 03:05:06PM +0200, Attila Kinali wrote:
> I'm currently trying to get the AC97 codec code for the Alchemy
> Au1550 working. It looks like this code has not been touched for
> ages and has been rotting for quite a while.
> 
> As i assume that i'm not the only one using this code, i'd like
> to ask whether someone else got the bits and pieces of this driver
> together and working. If so, what changes did you apply?

I wrote experimental ALSA ASoC drivers for the Au1200 PSC in AC97
and I2S mode.  From my limited understanding, the Au1550 PSCs are
identical to the ones on the Au1200, so the drivers *should* work.
on the 1550 (All the proper PSC base addresses are already in there;
all you'd need to do is add code for your board)

An update to the dbdma api is required to get proper DMA ringbuffers.

If you're interested, I put 2 patches online:

http://mlau.at/files/au1xxx-dbdma-audio-updates-v2.patch
http://mlau.at/files/au1xpsc-asoc-v2.patch

	Manuel Lauss

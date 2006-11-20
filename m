Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2006 13:22:32 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:37129 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20038521AbWKTNW2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Nov 2006 13:22:28 +0000
Received: (qmail 13854 invoked by uid 1000); 20 Nov 2006 14:22:26 +0100
Date:	Mon, 20 Nov 2006 14:22:26 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Freddy Spierenburg <freddy@dusktilldawn.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1xmmc.c: does it work?
Message-ID: <20061120132226.GB13740@roarinelk.homelinux.net>
References: <20061120094053.GA13509@roarinelk.homelinux.net> <20061120104922.GC32045@dusktilldawn.nl> <20061120120148.GA13740@roarinelk.homelinux.net> <20061120123740.GE32045@dusktilldawn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120123740.GE32045@dusktilldawn.nl>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Mon, Nov 20, 2006 at 01:37:40PM +0100, Freddy Spierenburg wrote:
> Hi Manuel,
> 
> On Mon, Nov 20, 2006 at 01:01:48PM +0100, Manuel Lauss wrote:
> > On Mon, Nov 20, 2006 at 11:49:22AM +0100, Freddy Spierenburg wrote:
> > > Are you working with a real MMC card or with an SD-card?
> > 
> > SD cards so far. MMC seems broken in a different way.
> 
> Broke in a different way? I can positively confirm that I have a
> 512MB and 1GB MMC-card working with the patch I hereby send to
> you.

continuously issues CMD2 and CMD3 messages to the card, and
lots of "au1xx(0): DEBUG: PENDING - 03000090" messages.
 
> I've also tried a DaneElec 1GB and Kingston 1GB SD-card and
> SanDisk 128MB MicroSD-card. All failed.
> 
> 
> > Yes, please. I'd like to give it a spin
> 
> Please find it attached.

Thank you. You only removed parts of the Db/Pb board specific
stuff and disabled DMA, correct?

-- 
 ml.

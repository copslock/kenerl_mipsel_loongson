Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2006 12:01:54 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:44047 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20038189AbWKTMBu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Nov 2006 12:01:50 +0000
Received: (qmail 13754 invoked by uid 1000); 20 Nov 2006 13:01:48 +0100
Date:	Mon, 20 Nov 2006 13:01:48 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Freddy Spierenburg <freddy@dusktilldawn.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1xmmc.c: does it work?
Message-ID: <20061120120148.GA13740@roarinelk.homelinux.net>
References: <20061120094053.GA13509@roarinelk.homelinux.net> <20061120104922.GC32045@dusktilldawn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120104922.GC32045@dusktilldawn.nl>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Freddy,

On Mon, Nov 20, 2006 at 11:49:22AM +0100, Freddy Spierenburg wrote:
> On Mon, Nov 20, 2006 at 10:40:53AM +0100, Manuel Lauss wrote:
> > I insert a known working card, and the mmc cmd trace suggests
> > CMD9 (send CSD) times out.
> 
> Are you working with a real MMC card or with an SD-card?

SD cards so far. MMC seems broken in a different way.

> I myself am not able to get several SD-cards working, even though
> SD-cards should be able to talk the MMC-protocol (AFAIK).

From what I understand, SD is a superset of the MMC command set.

> What I do have is several MMC-cards working properly, but I have
> to add a small side note. I am using the AU1100 processor on our
> own designed board. This AU1100 processor has a different DMA
> controller than the AU1200 and AU1500. 

It does not get so far to actually transfer data

> If you have trouble with MMC-cards too I'm more than willing to
> send you the patch, but it probably needs some tweaking on your
> part. That's why I do not yet attach it to this mail. Just ask
> me personally for it if you want to try it out.

Yes, please. I'd like to give it a spin
 
> > Before I go about to trace the problem I'd like to know if
> > other people see this problem too or if it's specific to my
> > system.
> 
> With the SD-cards the driver indeed got no answer on the CMD9
> request. So yes, I have the same problem on the AU1100 with the
> 2.6.16 kernel.

I'll see what I can do ti fix this.

Thanks,

-- 
 ml.

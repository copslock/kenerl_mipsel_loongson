Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 08:45:03 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:37642 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20037480AbXBUIo6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Feb 2007 08:44:58 +0000
Received: (qmail 9988 invoked by uid 1000); 21 Feb 2007 09:44:57 +0100
Date:	Wed, 21 Feb 2007 09:44:57 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Au1000 PCMCIA broken in 2.6.20
Message-ID: <20070221084457.GB9822@roarinelk.homelinux.net>
References: <20070221073848.GA9822@roarinelk.homelinux.net> <200702210919.16930.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200702210919.16930.eckhardt@satorlaser.com>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Ulrich,

On Wed, Feb 21, 2007 at 09:19:16AM +0100, Ulrich Eckhardt wrote:
> On Wednesday 21 February 2007 08:38, Manuel Lauss wrote:
> > PCMCIA is broken on my Au1200 platform. Seems to me that accesses to
> > Attribute memory are broken; a dump of the CIS reveals the following:
> >
> > 1.0: ParseTuple: Bad CIS tuple
> > 00000000  01 03 ff ff ff 1c 04 ff  ff ff ff 18 02 ff ff 20 
> > 00000010  04 98 00 00 00 15 20 04  ff ff ff ff ff ff ff ff
> > 00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff 
> > 00000030  ff ff ff ff ff ff ff 21  02 04 01 22 02 ff ff 22
> [...]
> > it should look like this:
> > 00000000  01 03 d9 01 ff 1c 04 03  d9 01 ff 18 02 df 01 20 
> > 00000010  04 98 00 00 00 15 20 04  01 54 4f 53 48 49 42 41
> > 00000020  20 54 48 4e 43 46 32 35  36 4d 50 47 20 00 00 00
> 
> Can you rule out a timing problem, i.e. that the system bus is configured 
> correctly? The reason I ask is that some values seem to be read correctly but 
> others not. I seem to remember something like that keeping me busy trying to 

No timing problems. For testing purposes I set timings as slow as possible
(at least the hw people told me the timings they gave me were slowest
possible).

> get an Au1100 to run. Also, try a different card, too, I experienced hard 
> lockups with CF cards of one brand that (on an electronic level) seemed to 
> behave badly and cause the system to break.

I have tested lots of cf cards from different vendors on 2.6.19 and none
locked the system or behaved badly in any way. So I think I can rule out
any hardware issues. 

> > Reverting "[PATCH] Generic ioremap_page_range: mips conversion" makes it
> > work again:
> > http://www.linux-mips.org/git?p=linux.git;a=commitdiff_plain;h=8e087929df88
> >4dbb13e383d49d192bdd6928ecbf;hp=62dfb5541a025b47df9405ff0219c7829a97d83b
> 
> I see one thing that disturbs me a lot in this code (before but even more 
> after this changeset): use of casts in the calls to remap_area_pages or 
> ioremap_page_range. Those typically only serve to hide errors and 
> specifically on the Au1100 (probably also on Au1200) because there the 
> physical addresses are 36 bit while virtual addresses are 32 bit. If there is 
> a truncation going on due to wrong datatypes, these casts will disable the 
> compiler warnings.


> Apropos, the switching between 32 and 36 bit physical addresses was done via a 
> configuration setting in 2.4, try toggling that one, too, if it still exists.

pcmcia does not work without 64 bit mode anyway (CONFIG_64BIT_PHYS_ADDR=y)
As I stated, simply reverting the patch fixes all pcmcia issues for me.
CF cards and ethernet work absolutely fine without it.
So I think it's that the upper 4 of the 36 bits addresses get lost somewhere
in the new ioremap path. I hope someone with more kernel knowledge is
willing to look into it.

Thanks!

-- 
 ml.

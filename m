Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2008 20:52:51 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:2548 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28575421AbYETTwt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2008 20:52:49 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4KJq23A000874;
	Tue, 20 May 2008 21:52:03 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4KJpvYu000870;
	Tue, 20 May 2008 20:51:58 +0100
Date:	Tue, 20 May 2008 20:51:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	a.zummo@towertech.it, hvr@gnu.org, akpm@linux-foundation.org,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: M41T80: Century Bit support
In-Reply-To: <20080519.011034.25909336.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.55.0805202045320.31790@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805170057370.4049@cliff.in.clinika.pl>
 <20080518.000242.41199304.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0805171959030.10067@cliff.in.clinika.pl>
 <20080519.011034.25909336.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 19 May 2008, Atsushi Nemoto wrote:

> >  That's what I did initially as it is as obvious as you can get.  But as I
> > noted, CFE, the firmware used with the SWARM, does not set CEB even though
> > it takes CB into account.  The approach is not useful therefore at least
> > for one major user of the device.
> 
> Oh I had missed that the firmware does not set CEB.  Hmm...

 As I said, this is one of the lesser problems with CFE, sigh...

> >  Hmm, not terribly useful as few of us if anybody live back in the 20th
> > century. ;-)  I think let's scrap the patch in this case and let our
> > grandchildren solve the problem -- a proposal has been published and can
> > be reused as needed.
> 
> OK for me.  Lets hear how our grandchildren complain on this fault. :)

 Well, Andrew has applied this patch to the -mm tree now and after a bit
of thinking I have made up my mind and decided we should keep the patch.  
This is an I2C device which means it will always only be explicitly
requested by platform code.  This is an opportunity for the platform to
express the will and the way to use the century bit.

 I'll cook-up a follow-on patch as soon as the SWARM bits propagate to
upstream, to add a set of flags that will let platforms specify the
desired way the century bit is meant to be handled and which this driver
will honour.  Please feel free to keep the interpretation within your pet
board intact -- the flags will be capable to express your needs.

 Andrew, could you please hold the patch in -mm till the flags have been 
added?

  Maciej

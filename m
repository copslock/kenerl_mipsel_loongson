Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 15:33:19 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.110.227]:44423 "EHLO
	basil.diamond.local") by linux-mips.org with ESMTP
	id <S8225193AbUCaOdR>; Wed, 31 Mar 2004 15:33:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by basil.diamond.local (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id i2VEXorJ020621;
	Wed, 31 Mar 2004 15:33:51 +0100
From: Bob Lees <bob@diamond.demon.co.uk>
Organization: Diamond Consulting Services Ltd
To: Pete Popov <ppopov@mvista.com>
Subject: Re: Frequency (cpu speed) control on AU1100
Date: Wed, 31 Mar 2004 15:33:50 +0100
User-Agent: KMail/1.5.4
Cc: Dan Malek <dan@embeddededge.com>, linux-mips@linux-mips.org
References: <200403302137.38123.bob@diamond.demon.co.uk> <200403302338.08735.bob@diamond.demon.co.uk> <4069F942.5090202@mvista.com>
In-Reply-To: <4069F942.5090202@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403311533.50534.bob@diamond.demon.co.uk>
Return-Path: <bob@diamond.demon.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bob@diamond.demon.co.uk
Precedence: bulk
X-list: linux-mips

On Tuesday 30 March 2004 23:48, Pete Popov wrote:
> Bob Lees wrote:
> >On Tuesday 30 March 2004 22:56, Dan Malek wrote:
> >>Bob Lees wrote:
> >> > ....I suspect I am
> >>>
> >>>missing something somewhere, but I can't find any references to cpu
> >>> speed control for the MIPS processors, specically the au1x range.
> >>
> >>The Au1xxx has a PLL that multiplies the incoming 12 MHz clock up to the
> >>internal frequency.  Just be aware there are lots of peripheral clocks
> >>and bus clocks derived from this internal frequency.  There is code
> >>in the kernel power management to allow changing the frequency during
> >>operation of Linux, but I don't know how well it works today as I have
> >>not tested that for quite some time.
> >>
> >>Thanks.
> >>	-- Dan
> >
> >Thanks Dan & Pete for the prompt response.
> >
> >I have tried the /proc/sys/pm/freq interface and by putting a bogomips
> > calc into power.c, it appears to indicate a change in core frequency.  I
> > think your caution may be well founded as I got input overruns on the
> > serial console when I took the speed down to 84MHz, good character
> > recognition though, so it was an input buffer speed issue.
> >
> >Also I can see an approx 40-50mA change in current from 84 to 396MHz which
> >indicates something is changing.  Supply is at 5 volts thru a simple
> > switcher down to 3.3 volts on the Aurora board.  This is with nothing
> > else running and an nfs filesystem.  As part of monitoring current I am
> > seeing an anomoly: namely after boot is complete and system is quiesent,
> > at apparently 396MHz, the current is 200mA, now after playing with the
> > freq control the current at 396MHz stabalises at around 250mA.  Verrry
> > strange - any thoughts??
>
> Is the 250mA after you've done a new power cycle, which doesn't make
> sense, or after you scale down to 84 and back up to 396MHz?

After I scale down to 84 and back up to 396MHz.  Having seen Dan's comments 
which I largely agree with I may not play with the speed after all!!  Having 
said that I would like to find out why we are seeing this behaviour.  It 
could well be that the frequency switching is disrupting one of the clocks 
and/or the PM which is running on power up.

We already recognise that the peripherals play as much if not a greater part 
in the overall power consumption.

>
> >On another topic, what state is the IRDA driver in?
>
> It works. Check out the IrDA readme on
> linux-mips.org:/pub/linux/mips/people/ppopov/2.4. I've tested two boards
> back to back using the network layer at FIR speeds, and a board to palm
> pilot using SIR. It's all in the readme.

OK I have this and will have a play.
>
> >This is building from the
> >patched 2.4.25 kernel on your site Dan.  And a big thank you for this
> > source of a patched kernel and build tools.
>
> Pete

Bob

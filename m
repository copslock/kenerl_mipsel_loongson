Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61HLGnC012416
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 10:21:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61HLGk8012415
	for linux-mips-outgoing; Mon, 1 Jul 2002 10:21:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61HLAnC012397
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 10:21:10 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.9.3) with ESMTP id g61HP0N16567;
	Mon, 1 Jul 2002 19:25:00 +0200
Received: (from karel@localhost)
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) id TAA16476;
	Mon, 1 Jul 2002 19:25:00 +0200 (MET DST)
From: Karel van Houten <vhouten@kpn.com>
Message-Id: <200207011725.TAA16476@sparta.research.kpn.com>
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
To: jbglaw@lug-owl.de
Date: Mon, 1 Jul 2002 19:24:59 +0200 (MET DST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20020701151359.GR17216@lug-owl.de> from "jbglaw@lug-owl.de" at Jul 01, 2002 05:13:59 PM
X-Url: http://www-lsdm.research.kpn.com/~karel
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Mon, 2002-07-01 16:28:13 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
> wrote in message
> <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda.pl>:
> > On Mon, 1 Jul 2002, Jan-Benedict Glaw wrote:
> > 
> > > Okay, stupid idea. All these flush functions seem to be never called in
> > > parallel or recursive, so if might be possible to have a global flags
> > > variable and instead of always calling __save..() and __restore..(),
> > > we bulid a pair of inline functions doing this. This wouldn't give
> > > any penalty for !CONFIG_CPU_R4X00 and doesn't obscure the code so much
> > > as all those #ifdef and #endif's would do... I'll test my suggestion
> > > as fast as I reach my Indy again (is powered down at home...).
> > 
> >  Feel free to use the change privately.  Otherwise please code a real fix,
> > i.e. a set of buggy-R4600-specific functions, as CONFIG_CPU_R4X00 means
> > other processors as well, e.g. R4000 or R4400 which are fine here. 
> > 
> >  Actually blocking interrupts for over 0.01s as it used to be done is
> 
> Ah. That would explain the huge time drifts when the box is under
> load...
> 

Indeed, I'm now running 2.4.18, and for the first time my DS5000/260 and
DS5000/200 can keep exact time, even under heavy load.
Btw, I use a R4400SC CPU.

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------

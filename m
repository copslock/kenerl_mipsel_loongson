Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 19:22:46 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:18173 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225196AbTDASWp>;
	Tue, 1 Apr 2003 19:22:45 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA31961;
	Tue, 1 Apr 2003 10:22:33 -0800
Subject: Re: Au1500 hardware cache coherency
From: Pete Popov <ppopov@mvista.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Pete@ekner.info, Popov@ekner.info,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <1049221364.26674.248.camel@zeus.mvista.com>
References: <3E882FB8.BBFDACE2@ekner.info> <3E8853B3.9080902@amd.com>
	 <3E885B68.6927451E@ekner.info> <3E8883B8.1000000@amd.com>
	 <3E889602.62B7AB6B@ekner.info> <1049142818.26677.68.camel@zeus.mvista.com>
	 <3E8944EA.6E7AE06C@ekner.info> <1049221364.26674.248.camel@zeus.mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1049221414.26883.250.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2003 10:23:35 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

As Ralf pointed out, 

s/2.4.20-pre4/2.4.21-pre4  :)

Pete

On Tue, 2003-04-01 at 10:22, Pete Popov wrote:
> > > Config[OD] is set in setup.c and should not be cleared afterward.
> 
> > Due to errata #4, it is cleared whenever macroes like set_c0_config or change_c0_config is
> > called. This happens in several places:
> 
> >     au1000_restart (probably doesn't matter?)
> >     cache parity error exception (doesn't matter, we're probably dying anyway)
> >     ld_mmu_mips32 (in c-mips32.c)
> 
> Thanks for bringing this to my attention. I'll take a look at it, but
> I'm leaving this Thursday for two weeks and won't be able to get to it
> until after 4/21.
> 
> > I'm not quite sure whether ld_mmu_mips32 is called after au1x00 setup, but if it is,
> > the bit is cleared, never to be set again. Maybe the c0_config macroes should be changed
> > due to errata #4?
> 
> I doubt Ralf is going to change common macros to fix a specific bug.
> 
> > > Can you send me your test and exact instructions on how you're
> > > duplicating the error? I won't have time to look at it until after 4/20
> > > though.
> > >
> > 
> > Sure. However, I will first try to make sure that the kernel does not have the same problem on another
> > non AU1500 platform.
> > 
> > BTW, are you using the HPT onboard IDE controller? Last time I tried, it wasn't functional, the kernel crashed
> > during boot when kudzu was doing some HW probing on the IDE stuff. I'm using a plug-in promise card
> > (20268 based).
> 
> The Pb1500 HPT370 driver works fine for me, and now the Db1500 HPT371
> seems to work as well. However, with the 2.4.20-pre4 kernel, both boards
> crash with a kernel panic when doing a very large 'cp -a'. I don't know
> at this point what the problem is. The MV 2.4.18 based kernel passes the
> same stress tests repeatedly on the Pb1500. So either something got
> broken between 2.4.18 and 2.4.20-pre4, or the 2.4.18 kernel is getting
> lucky.  The boards are still 'usable' with a 2.4.20-pre4 and a hard disk
> cause I can boot with a disk based root fs and run lmbench of the disk.
> But it's quite possible that the problem you observed is caused by the
> same bug I'm encountering. 
> 
> I think I have a Promise IDE card at home and I'll run a test with it
> when I get back. It would be interesting to see if that driver causes
> the same problems.
> 
> Pete

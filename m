Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KHbIEC003710
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 10:37:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KHbH2F003709
	for linux-mips-outgoing; Tue, 20 Aug 2002 10:37:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KHbAEC003696
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 10:37:10 -0700
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA10635;
	Tue, 20 Aug 2002 10:40:03 -0700
Subject: Re: Mips cross toolchain
From: Pete Popov <ppopov@mvista.com>
To: Joe George <joeg@clearcore.net>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3D627AEB.5010003@clearcore.net>
References: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>
		<3D626E61.3010505@clearcore.net>
	<1029862665.11391.5.camel@zeus.mvista.com>  <3D627AEB.5010003@clearcore.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 20 Aug 2002 10:41:40 -0700
Message-Id: <1029865300.11781.22.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-08-20 at 10:22, Joe George wrote:
> > Where those patches created from the sourceforge tree or you created
> > them independently?  I would hate to see the two ports diverge.
> 
> I've been syncing the sf tree.
> 
> > I already sent Ralf a patch for the 36bit support.  He told me the patch
> > looks fine but it doesn't seem like he's had time to merge it in.  The
> > code is in sourceforge.net
> 
> My initial patches on this came from the sf tree.  Ralf called out the
> endian problem.
> > Again, I've done some work for big endian support and pushed it out in
> > sourceforge.net because I have write access there.  Most drivers work
> > just fine in BE mode.  The exception right now is the epson 1356/1386
> > video controller.  There might be some others but I don't remember.
> > Certainly all the SOC peripherals work fine.
> 
> The problems I'm working on are in your tlbex-mips32.S.

I see of the 36 bit patch in oss now, but not the whole thing.  Is Ralf
waiting for you to fix the problems in tlbex-mips32.S?  Are those
problems endian related or something else?  I tested the pcmcia driver
in BE mode, and that driver uses the 36 bit code, so I thought it's
endian safe ...
 
> > If you're submitting patches in oss, please take the latest work in
> > sourceforge.net first to sync up the two.  First, you might save
> > yourself some work. Second, it will keep the two ports from diverging.
> 
> Couldn't of done it without your work, I really appreciate the work
> you have done.

Thanks for syncing up the oss tree!  I was afraid that if you're sending
independent patches some of the sourceforge work would get lost.

Pete

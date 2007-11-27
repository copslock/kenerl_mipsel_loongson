Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 02:32:03 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:57350 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S28574210AbXK0Cby (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 02:31:54 +0000
Received: from SNaIlmail.Peter (77.47.3.174.static.cablesurf.de [77.47.3.174])
	by mail1.pearl-online.net (Postfix) with ESMTP id B0166B370;
	Tue, 27 Nov 2007 03:31:49 +0100 (CET)
Received: from Opal.Peter (Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id lAR2Uwvb001969;
	Tue, 27 Nov 2007 03:30:58 +0100
Received: from Opal.Peter (localhost [127.0.0.1])
	by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Sendmail/Linux 2.4.24-1-386) with ESMTP id lAR2UmO7002804;
	Tue, 27 Nov 2007 03:30:49 +0100
Received: from localhost (pf@localhost)
	by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Debian-1) with ESMTP id lAR2UmGH002800;
	Tue, 27 Nov 2007 03:30:48 +0100
X-Authentication-Warning: Opal.Peter: pf owned process doing -bs
Date:	Tue, 27 Nov 2007 03:30:48 +0100 (CET)
From:	post@pfrst.de
X-Sender: pf@Opal.Peter
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: SGI IP28 support
In-Reply-To: <20071126230127.GA21970@alpha.franken.de>
Message-ID: <Pine.LNX.4.21.0711270315070.2765-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips


Hi!

On Tue, 27 Nov 2007, Thomas Bogendoerfer wrote:

> Date: Tue, 27 Nov 2007 00:01:27 +0100
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: linux-mips@linux-mips.org
> Subject: Re: SGI IP28 support
> 
> On Mon, Nov 26, 2007 at 11:38:14PM +0100, Thomas Bogendoerfer wrote:
> > [..]
> 
> There is one thing I forgot: You need a special gcc, which will generate
> cache barriers to avoid speculative stores done by the R10k. Peter
> had some patches submitted to the gcc maintainers, which I used to
> build my own gcc 4.2.1 cross compiler. Does anybody know, if Peter's
> paches are already intergrated in newer gcc versions ?

They hardly are. At least i didn't undertake a second attempt yet. Nor
did i hear of the Gentoo-folks or someone else taking this unpleasant
job.

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessary a
> good idea.                                                [ RFC1925, 2.3 ]
> 
> 
> 

kind regards

peter

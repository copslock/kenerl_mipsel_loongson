Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2004 17:57:44 +0000 (GMT)
Received: from p508B66BC.dip.t-dialin.net ([IPv6:::ffff:80.139.102.188]:60773
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225281AbUK1R5k>; Sun, 28 Nov 2004 17:57:40 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iASHvdL4000387;
	Sun, 28 Nov 2004 18:57:39 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iASHvcwE000386;
	Sun, 28 Nov 2004 18:57:38 +0100
Date: Sun, 28 Nov 2004 18:57:38 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: sjhill@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20041128175738.GA32666@linux-mips.org>
References: <20041127061929Z8224786-1751+2584@linux-mips.org> <Pine.LNX.4.58L.0411272202100.12787@blysk.ds.pg.gda.pl> <20041127231543.GA14252@linux-mips.org> <Pine.LNX.4.58L.0411280138200.27645@blysk.ds.pg.gda.pl> <20041128115336.GB14004@linux-mips.org> <Pine.LNX.4.58L.0411281722090.18191@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0411281722090.18191@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 28, 2004 at 05:44:16PM +0000, Maciej W. Rozycki wrote:
> Date: Sun, 28 Nov 2004 17:44:16 +0000 (GMT)
> From: "Maciej W. Rozycki" <macro@linux-mips.org>
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: sjhill@linux-mips.org, linux-mips@linux-mips.org
> Subject: Re: CVS Update@-mips.org: linux
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
> On Sun, 28 Nov 2004, Ralf Baechle wrote:
> 
> > >  Anyone is free to bump their console/syslog loglevel to get rid of less
> > > important messages to suit there preferences.  And INFO, which is what the
> > > message uses, is the lowest level for stuff for non-developers.
> > 
> > As a deterring example why I try to cut down on system messages checkout:
> > 
> >   http://www.linux-mips.org/wiki/index.php/IP27_boot_messages
> > 
> > 70kB of little information crawling over a 19k2 console making kernel
> > startup an entertaining experience for the whole family ;-)
> 
>  Why don't you boot at 115200bps then?  I do that with my DECstations
> (well, since I've fixed their serial console to support it).  Otherwise
> there's that "quiet" argument to bump the console loglevel.
> 
>  Besides the SWARM and friends boot at 115200bps by default anyway and
> their average bootstrap log size is around 7kB... ;-)

Because that a) the default rate of the machine and b) the limit of the
terminal server.  ALOT of console servers.

  Ralf

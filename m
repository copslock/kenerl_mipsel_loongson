Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 16:48:12 +0000 (GMT)
Received: from p508B6FDE.dip.t-dialin.net ([IPv6:::ffff:80.139.111.222]:28885
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbTBEQsM>; Wed, 5 Feb 2003 16:48:12 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h15Gm7q16132;
	Wed, 5 Feb 2003 17:48:07 +0100
Date: Wed, 5 Feb 2003 17:48:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Jason Ormes <jormes@wideopenwest.com>, linux-mips@linux-mips.org
Subject: Re: kernel boot error.
Message-ID: <20030205174807.B13033@linux-mips.org>
References: <200302041841.10507.jormes@wideopenwest.com> <20030205004345.GI27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205004345.GI27302@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Wed, Feb 05, 2003 at 11:43:45AM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 11:43:45AM +1100, Andrew Clausen wrote:

> On Tue, Feb 04, 2003 at 06:41:10PM -0600, Jason Ormes wrote:
> > hello,
> > 
> > can someone help me with this error?  Is this because the network failed?
> 
> I'm getting exactly the same problem.  What machine are you using?
> I'm using an ip27 (origin 200), and an acenic network card.
> 
> It seems that there all kinds of PCI hacks in the ip27 support,
> and I'm currently trying to figure out how to get this card working...

His particular machine is a uniprocessor machine, a very rare configuration.
In all the years I'm working with Origins this is just the second I
encounter.  Note that disabling one of the processor doesn't suffice;
this problem really only seems to hit machines with one physical processor.

  Ralf

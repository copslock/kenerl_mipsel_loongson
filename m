Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 12:47:26 +0100 (BST)
Received: from p508B7959.dip.t-dialin.net ([IPv6:::ffff:80.139.121.89]:63936
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225192AbTDALrZ>; Tue, 1 Apr 2003 12:47:25 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h31BlDr07749;
	Tue, 1 Apr 2003 13:47:13 +0200
Date: Tue, 1 Apr 2003 13:47:13 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Hartvig Ekner <hartvig@ekner.info>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Au1500 hardware cache coherency
Message-ID: <20030401134713.B7618@linux-mips.org>
References: <3E882FB8.BBFDACE2@ekner.info> <1049135714.26674.19.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1049135714.26674.19.camel@zeus.mvista.com>; from ppopov@mvista.com on Mon, Mar 31, 2003 at 10:35:14AM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 31, 2003 at 10:35:14AM -0800, Pete Popov wrote:

> > So before spending more time on debugging this, and creating patches
> > for using HW coherency, I wanted to hear your input - maybe there are
> > known problems in the Au1500 coherency implementation?
> 
> Looks like Eric already replied to your questions.
> 
> Patches to get the code to compile with NONCOHERENT_IO turned off would
> be good, even if you don't want to do that yet. 
> 
> FYI, in the latest kernel I'm getting a panic when doing a very large
> 'cp -a' from nfs to ata100 disk (don't know if the disk itself matters)
> (Pb1500 and Db1500).  The same test passes with a 2.4.18 kernel, so it
> seems like it's not a hardware issue, unless the 2.4.18 kernel is just
> getting lucky.  I'll be gone till 4/20 so I won't have time to debug it
> until after I get back.

Not that this is Linux 2.4.21-pre4 which did replace essentially the
entire IDE code due to major problems with the old IDE core.  The problems
were huge - large enough to warrant the rewrite of such a large subsystem
in a stable series of kernels and certainly the dust hasn't fully settled
yet.

  Ralf

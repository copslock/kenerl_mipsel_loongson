Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 21:08:47 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:56978 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225848AbVFMUIc>;
	Mon, 13 Jun 2005 21:08:32 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j5DK8K6t029893
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 13 Jun 2005 22:08:21 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j5DK8KUn029891;
	Mon, 13 Jun 2005 22:08:20 +0200
Date:	Mon, 13 Jun 2005 22:08:20 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Daniel Jacobowitz <dan@debian.org>,
	Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building o32 glibc on mips64
Message-ID: <20050613200820.GA29872@lst.de>
References: <42AB3366.8030206@jg555.com> <20050613195602.GA3739@nevyn.them.org> <Pine.LNX.4.61L.0506132100080.1725@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506132100080.1725@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Mon, Jun 13, 2005 at 09:05:59PM +0100, Maciej W. Rozycki wrote:
> On Mon, 13 Jun 2005, Daniel Jacobowitz wrote:
> 
> > I have not tried the 2.3.x series glibcs on MIPS64.  I recommend you
> > use glibc HEAD for now instead, unless you're interested in tracking
> > down this sort of problem.
> 
>  FYI, I've been able to build glibc 2.3.5 with GCC 4.0.0 for 
> mips64el-linux (n64) with minimal patching.  I think what's only really 
> required is that patch by Richard Sandiford that stays suspended in the 
> glibc Bugzilla.
> 
>  For o32 glibc may have to be configured for "mips{,el}-linux" (as o32 
> isn't MIPS64 at all), but that's a pure guess -- I haven't checked the 
> scripts for that requirement.
> 
>  Do you think HEAD is stable enough for a non-glibc developer?  It's soon 
> after a fork after all, so I'd expect more serious changes to be applied 
> nowadays.

Btw, what is the chance to see a biarch toolchain for mips?  It seems
all linux architectures with 32bit and 64bit variants seem to have one
these days, except mips.

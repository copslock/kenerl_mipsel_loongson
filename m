Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 21:04:20 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:1061
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225202AbTDDUER>; Fri, 4 Apr 2003 21:04:17 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 191XQ7-000Ebh-00
	for linux-mips@linux-mips.org; Fri, 04 Apr 2003 22:04:15 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 191XQ7-0002ZK-00
	for <linux-mips@linux-mips.org>; Fri, 04 Apr 2003 22:04:15 +0200
Date: Fri, 4 Apr 2003 22:04:15 +0200
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Unknown ARCS message/hang
Message-ID: <20030404200415.GI14490@rembrandt.csv.ica.uni-stuttgart.de>
References: <1049427871.3e8cff9f9c50e@my.visi.com> <Pine.GSO.3.96.1030404142811.7307B-100000@delta.ds2.pg.gda.pl> <20030404131935.GF11906@bogon.ms20.nix> <1049467405.3e8d9a0dea4a5@my.visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049467405.3e8d9a0dea4a5@my.visi.com>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Erik J. Green wrote:
> 
> .. and just to display my complete technical mastery, I failed to echo this
> message to the list the first time around =\
> 
> 
> Quoting Guido Guenther <agx@sigxcpu.org>:
> > >  0x211c4018 is a mapped address, which you can't use that early in a boot.
> > Isn't 0xa8000000211c4000 in xkphys and therefore unmapped? The PROM only
> > seems to look at the lower 32bits of PC though.
> > Puzzled,
> >  -- Guido
> 
> That's what I thought too.  I did notice that the 64 bit kernel seems to refer
> to some 32 bit compatibility address spaces, so I'm probably confused on what
> gets used when.
> 
> FYI, the load address I'm using (0xa800000020004000) is the one specified in the
> irix headers for an IP30 kernel (as I read it anyway) and is very close to the
> entry point IRIX uses on the same machine.

Current 64-bit kernels are loaded in the 32-bit compatibility space, i.e. the
load address is 0xffffffff8???????. If you want to load to 64-bit space (the
firmware of r10k ip28 needs this, too), you'll have to fix several macro
expansions in the kernel. I did this once for my ip28, but haven't found the
time to make it really work yet.

An outdated patch which covers this and some other issues is available at
http://www.csv.ica.uni-stuttgart.de/homes/ths/linux-mips/kernel/oss-linux-2002-06-05.diff


Thiemo

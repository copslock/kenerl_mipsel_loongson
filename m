Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CNmpQ24503
	for linux-mips-outgoing; Thu, 12 Apr 2001 16:48:51 -0700
Received: from dea.waldorf-gmbh.de (u-120-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.120])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CNmmM24500
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 16:48:49 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3D0maw02426;
	Fri, 13 Apr 2001 02:48:36 +0200
Date: Fri, 13 Apr 2001 02:48:36 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-mips@oss.sgi.com
Subject: Re: 64-bit on Origin (was:  64-bit on Cobalt?)
Message-ID: <20010413024835.B2348@bacchus.dhis.org>
References: <20010408184241.A3443@john-edwin-tobey.org> <20010409035453.B774@bacchus.dhis.org> <20010413000612.G1256@mail.muni.cz> <20010413012510.B1270@bacchus.dhis.org> <20010413005025.A20386@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010413005025.A20386@mail.muni.cz>; from xhejtman@mail.muni.cz on Fri, Apr 13, 2001 at 12:50:25AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 13, 2001 at 12:50:25AM +0200, Lukas Hejtmanek wrote:

> I ment something like this:
> file mipstest.o
> mipstest.o: ELF 64-bit MSB mips-3 relocatable, MIPS R3000_BE, version 1, not
> stripped
> 
> > gcc - should work.  Binutils - major brain surgery required.  glibc -
> > 64-bit support practically non-existant.
> 
> So as and/or ld generates bad code?

Both know fairly little about 64-bit ELF atm.

> Does anyone already work on it?

Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> is working on it; it's
quite an effort to get it right so if you want to work on this you should
probably team up with him.

> And if binutils are broken that means kernel is 32-bit as well?

Yes but that's more a feature than a bug.  All intra-kernel references are
now only 32-bit therefore we've got more compact, faster code as result.

The boot file is a 64-bit ELF kernel, though.  That's because the ARC
firmware of the Origin will accept nothing else so we cheat by converting
the 32-bit vmlinux into a 64-bit file using objcopy.

> Anyway 32-bit applications should run pretty fine?

Most of them.  Now and then we find bugs in the binary compatibility code
but these are usually easy to squash.

   Ralf

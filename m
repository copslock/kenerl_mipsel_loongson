Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CMoWW22988
	for linux-mips-outgoing; Thu, 12 Apr 2001 15:50:32 -0700
Received: from hell.ascs.muni.cz (hell.ascs.muni.cz [147.251.60.138])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CMoSM22982;
	Thu, 12 Apr 2001 15:50:29 -0700
Received: (from xhejtman@localhost)
	by hell.ascs.muni.cz (8.11.0/8.11.0) id f3CMoPq21065;
	Fri, 13 Apr 2001 00:50:25 +0200
Date: Fri, 13 Apr 2001 00:50:25 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: 64-bit on Origin (was:  64-bit on Cobalt?)
Message-ID: <20010413005025.A20386@mail.muni.cz>
References: <20010408184241.A3443@john-edwin-tobey.org> <20010409035453.B774@bacchus.dhis.org> <20010413000612.G1256@mail.muni.cz> <20010413012510.B1270@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010413012510.B1270@bacchus.dhis.org>; from ralf@oss.sgi.com on Fri, Apr 13, 2001 at 01:25:10AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 13, 2001 at 01:25:10AM +0200, Ralf Baechle wrote:
> > So it is possible to run 64-bit application on Origin 200?
> 
> In theory yes - if you have any ...

I ment something like this:
file mipstest.o
mipstest.o: ELF 64-bit MSB mips-3 relocatable, MIPS R3000_BE, version 1, not
stripped

> gcc - should work.  Binutils - major brain surgery required.  glibc -
> 64-bit support practically non-existant.

So as and/or ld generates bad code?

Does anyone already work on it?

And if binutils are broken that means kernel is 32-bit as well?


Anyway 32-bit applications should run pretty fine?

-- 
Luká¹ Hejtmánek

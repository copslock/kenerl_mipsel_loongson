Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NLDqRw013202
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 14:13:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NLDqLd013201
	for linux-mips-outgoing; Tue, 23 Jul 2002 14:13:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NLDhRw013191
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 14:13:43 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6NLDHXb026374;
	Tue, 23 Jul 2002 14:13:17 -0700 (PDT)
Received: from menelaus.mips.com (menelaus [192.168.65.223])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id OAA27298;
	Tue, 23 Jul 2002 14:13:10 -0700 (PDT)
Received: from mips.com (localhost [127.0.0.1])
	by menelaus.mips.com (8.9.3/8.9.0) with ESMTP id OAA04095;
	Tue, 23 Jul 2002 14:13:10 -0700 (PDT)
Message-ID: <3D3DC6E6.AFF9CBFD@mips.com>
Date: Tue, 23 Jul 2002 14:13:10 -0700
From: "Kevin D. Kissell" <kevink@mips.com>
Organization: MIPS Technologies Inc.
X-Mailer: Mozilla 4.61 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
References: <Pine.GSO.3.96.1020723164235.29699A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > My personal belief is that the mips and mips64 trees
> > should ultimately be merged, and that creating additional
> > and gratuitous differences should be avoided.
> 
>  I don't think it's possible to be fully achieved.  Some differences will
> have to exist, at least in the headers, but likely within the arch tree as
> well.  The reason is binary code size or perfomance -- having R3000
> support code in mips64 binaries is simply ridiculous as is using 32-bit
> operations with 64-bit data on a 64-bit CPU.  However, it is worth trying
> to minimize visible differences where possible, e.g. by convincing the
> compiler to optimize irrelevant bits away.

I am not interested in running R3000's with 64-bit
binaries - only in having common sources for both.
I fully expect that there will always be differences
between the platforms, but the last time I checked,
there were more identical or nearly identical source
modules across the two arch trees than there were 
distinctly different ones.  The result is that the 
two subtrees tend to drift out of sync.  For me, 
it's really a "Software Engineering 101" kind of 
thing that there should be exactly one instance 
in the source tree of any source module that is 
common to 32-bit and 64-bit MIPS kernels, and that 
where the code cannot be common, sensible rules should 
be applied in terms of when to put both sets of code 
in the same module as conditionally complied blocks and
when to split things out into seperately maintained
modules. Etc. Etc.

		Kevin K.

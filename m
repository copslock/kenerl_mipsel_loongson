Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CMR4g22186
	for linux-mips-outgoing; Thu, 12 Apr 2001 15:27:04 -0700
Received: from dea.waldorf-gmbh.de (u-120-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.120])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CMQWM22144
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 15:26:40 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3CNPA101661;
	Fri, 13 Apr 2001 01:25:10 +0200
Date: Fri, 13 Apr 2001 01:25:10 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-mips@oss.sgi.com
Subject: Re: 64-bit on Origin (was:  64-bit on Cobalt?)
Message-ID: <20010413012510.B1270@bacchus.dhis.org>
References: <20010408184241.A3443@john-edwin-tobey.org> <20010409035453.B774@bacchus.dhis.org> <20010413000612.G1256@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010413000612.G1256@mail.muni.cz>; from xhejtman@mail.muni.cz on Fri, Apr 13, 2001 at 12:06:12AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 13, 2001 at 12:06:12AM +0200, Lukas Hejtmanek wrote:

> So it is possible to run 64-bit application on Origin 200?

In theory yes - if you have any ...

> What's the state of user-land 64-bit applications for that?
> (gcc, binutils, glibc)

gcc - should work.  Binutils - major brain surgery required.  glibc -
64-bit support practically non-existant.

> We have Origin 200 at university and my diploma thesis could be to run true
> 64-bit linux on it. Anyone interested?

  Ralf

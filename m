Received:  by oss.sgi.com id <S42226AbQIVNcX>;
	Fri, 22 Sep 2000 06:32:23 -0700
Received: from [131.188.77.254] ([131.188.77.254]:20740 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S42204AbQIVNcH>;
	Fri, 22 Sep 2000 06:32:07 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869536AbQIVNb4>;
        Fri, 22 Sep 2000 15:31:56 +0200
Date:   Fri, 22 Sep 2000 15:31:56 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     Brady Brown <bbrown@ti.com>,
        SGI news group <linux-mips@oss.sgi.com>,
        Ulf Carlsson <ulfc@engr.sgi.com>
Subject: Re: ELF/Modutils problem
Message-ID: <20000922153156.A2677@bacchus.dhis.org>
References: <20000921153631.A1238@bacchus.dhis.org> <1690.969616620@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1690.969616620@ocs3.ocs-net>; from kaos@melbourne.sgi.com on Fri, Sep 22, 2000 at 08:57:00PM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 22, 2000 at 08:57:00PM +1100, Keith Owens wrote:

> >On Wed, Sep 20, 2000 at 11:24:25AM +1100, Keith Owens wrote:
> >> modutils 2.3.11 includes a sanity check on the number of local symbols
> >> precisely because of this MIPS problem.  I agree with you that mips gcc
> >> is violating the ELF standard, 2.3.11 just detects this and issues an
> >> error message instead of overwriting memory but gcc needs to be fixed.
> >
> >And gcc has nothing to with it so it won't need to be fixed ...
> 
> Point taken, I should have said the MIPS toolchain instead of gcc.
> Something in the toolchain is generating an ELF object that does not
> follow the rules.  Can we catch someone's attention to get it fixed?

Ulf Carlsson <ulfc@engr.sgi.com> is currently maintaining binutils.
Ulf, you got the bandwidth to take a look at this?  After a look over the
gas code it's not obvious to my why this doesn't work on MIPS but on
all the other architectures, you probably know the internals of this beast
better than I do.

  Ralf

Received:  by oss.sgi.com id <S42232AbQIVPVx>;
	Fri, 22 Sep 2000 08:21:53 -0700
Received: from gatekeep.ti.com ([192.94.94.61]:13962 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S42204AbQIVPVk>;
	Fri, 22 Sep 2000 08:21:40 -0700
Received: from dlep6.itg.ti.com ([157.170.188.9])
	by gatekeep.ti.com (8.11.0/8.11.0) with ESMTP id e8MFKfT21116;
	Fri, 22 Sep 2000 10:20:41 -0500 (CDT)
Received: from dlep6.itg.ti.com (localhost [127.0.0.1])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA08563;
	Fri, 22 Sep 2000 10:20:35 -0500 (CDT)
Received: from dlep3.itg.ti.com (dlep3.itg.ti.com [157.170.188.62])
	by dlep6.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA08547;
	Fri, 22 Sep 2000 10:20:35 -0500 (CDT)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.180])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA03798;
	Fri, 22 Sep 2000 10:20:39 -0500 (CDT)
Message-ID: <39CB7978.E222DF8E@ti.com>
Date:   Fri, 22 Sep 2000 09:23:36 -0600
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Keith Owens <kaos@melbourne.sgi.com>,
        SGI news group <linux-mips@oss.sgi.com>,
        Ulf Carlsson <ulfc@engr.sgi.com>
Subject: Re: ELF/Modutils problem
References: <20000921153631.A1238@bacchus.dhis.org> <1690.969616620@ocs3.ocs-net> <20000922153156.A2677@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> On Fri, Sep 22, 2000 at 08:57:00PM +1100, Keith Owens wrote:
>
> > >On Wed, Sep 20, 2000 at 11:24:25AM +1100, Keith Owens wrote:
> > >> modutils 2.3.11 includes a sanity check on the number of local symbols
> > >> precisely because of this MIPS problem.  I agree with you that mips gcc
> > >> is violating the ELF standard, 2.3.11 just detects this and issues an
> > >> error message instead of overwriting memory but gcc needs to be fixed.
> > >
> > >And gcc has nothing to with it so it won't need to be fixed ...
> >
> > Point taken, I should have said the MIPS toolchain instead of gcc.
> > Something in the toolchain is generating an ELF object that does not
> > follow the rules.  Can we catch someone's attention to get it fixed?
>
> Ulf Carlsson <ulfc@engr.sgi.com> is currently maintaining binutils.
> Ulf, you got the bandwidth to take a look at this?  After a look over the
> gas code it's not obvious to my why this doesn't work on MIPS but on
> all the other architectures, you probably know the internals of this beast
> better than I do.
>
>   Ralf

I'm not sure what exact piece of the tool chain forms the un-linked elf file,
but as I stated originally the symbol table in the .o file is incorrect after
compiling and then if I do an incremental link (-r) the symbol table and length
pointer have been corrected. Based upon this it looks like the output from the
linker is correct, but the output from the earlier stage is wrong.

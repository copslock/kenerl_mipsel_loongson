Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2LJBql05086
	for linux-mips-outgoing; Wed, 21 Mar 2001 11:11:52 -0800
Received: from jester.ti.com (jester.ti.com [192.94.94.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2LJBnM05078;
	Wed, 21 Mar 2001 11:11:49 -0800
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by jester.ti.com (8.11.1/8.11.1) with ESMTP id f2LJBhD03358;
	Wed, 21 Mar 2001 13:11:43 -0600 (CST)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id NAA00595;
	Wed, 21 Mar 2001 13:11:42 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id NAA00585;
	Wed, 21 Mar 2001 13:11:42 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.126])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id NAA22269;
	Wed, 21 Mar 2001 13:11:41 -0600 (CST)
Message-ID: <3AB8FDEE.95A74D61@ti.com>
Date: Wed, 21 Mar 2001 12:15:58 -0700
From: Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: SGI news group <linux-mips@oss.sgi.com>
Subject: Re: Sign extended 64bit address
References: <3AB7EFF7.A20E4FF3@ti.com> <20010321050407.A3261@bacchus.dhis.org> <3AB8DDCE.CA0F16BC@ti.com> <20010321181017.A7274@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Wed, Mar 21, 2001 at 09:58:54AM -0700, Brady Brown wrote:
>
> > > > I have run into the earlier mentioned problem of objcopy not correctly
> > > > dealing with the sign extended 64 bit address generated by the new
> > > > tools. Is there an update on this issue? Any good work-arounds or short
> > > > time solutions?
> > >
> > > I don't have your old report at hand but somewhen during the past year
> > > binutils received a number of fixes related to signed/unsigned addresses,
> > > so you should try a recent copy of binutils.
> >
> > I'm currently using binutils-2.10.91-2 from Maciej's site. Is there a later
> > rev that I should look at?
>
> I was believing that that one is good; can you resend your bugreport
> about the sign extension problem?  Thanks.
>
>   Ralf

Problem solved. Sorry, my oversight. The binutils are correctly handling the
addresses. What happened was that the new tools created a couple of new code
sections "__ex_table and __dbe_table" that were not handled by the linker script
in my kernel (2.4.0-test9), hence ended up a strange low addresses. I
interpreted the warnings and the 'wrong' address in the final srec as a address
translation problem. Once I added these sections to the linker script the
warnings and 'bad' address's went away.

A second issue:
The kernel built by these new tools will not boot. Complains about illegal
instructions as soon as init is launched. The first address that traps is a sw
inside the __bzero routine.  I'll have to dig a bit here I guess. Any leads
would be appreciated.

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6GJ7MRw009696
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 12:07:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6GJ7MUp009695
	for linux-mips-outgoing; Tue, 16 Jul 2002 12:07:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6GJ79Rw009686;
	Tue, 16 Jul 2002 12:07:10 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6GJBuXb028970;
	Tue, 16 Jul 2002 12:11:56 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA11596;
	Tue, 16 Jul 2002 12:11:57 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6GJBub18183;
	Tue, 16 Jul 2002 21:11:57 +0200 (MEST)
Message-ID: <3D347120.B9CAFF75@mips.com>
Date: Tue, 16 Jul 2002 21:16:48 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Ralf Baechle <ralf@oss.sgi.com>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Add sys/personality (Re: Personality)
References: <3D33DAB2.353A4399@mips.com> <20020716123632.B17038@dea.linux-mips.net> <20020716090728.A22128@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks.
Now that we are at it, what should personality return in case it's called with a
value, which isn't defined in the personality.h file.
Should it return -EINVAL ?
I don't think, that is the case at the moment, I believe you can set personality
to anything.

/Carsten


"H. J. Lu" wrote:

> On Tue, Jul 16, 2002 at 12:36:32PM +0200, Ralf Baechle wrote:
> > On Tue, Jul 16, 2002 at 10:34:58AM +0200, Carsten Langgaard wrote:
> >
> > > The include/linux/personality.h file has changed between the 2.4.3 and
> > > the 2.4.18 kernel.
> > > Now there is a define of personality (#define personality(pers) (pers &
> > > PER_MASK), but that breaks things for the users, if they include this
> > > file.
> > > The user wishes to call the glibc personality function (which do the
> > > syscall), and not use the above definition.
> > >
> > > So I guess we need a "#ifdef __KERNEL__" around some of the code in
> > > include/linux/personality.h (at least around the define of personality),
> > > which then has to go into the glibc kernel header files.
> >
> > The general policy about such problems is to not use kernel include files
> > from user applications directly.  Hjl - maybe time for <sys/personality.h>?
> >
>
> Here is a patch.
>
> H.J.
>
>   ------------------------------------------------------------------------
>
>    glibc-personality.patchName: glibc-personality.patch
>                           Type: Plain Text (text/plain)

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id QAA323761 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 16:33:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA14833 for linux-list; Thu, 4 Dec 1997 16:31:31 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA14618; Thu, 4 Dec 1997 16:31:02 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA22435; Thu, 4 Dec 1997 16:30:59 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA10385;
	Fri, 5 Dec 1997 01:30:56 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA30790;
	Fri, 5 Dec 1997 00:39:44 +0100
Message-ID: <19971205003943.08926@uni-koblenz.de>
Date: Fri, 5 Dec 1997 00:39:43 +0100
To: Greg Chesson <greg@xtp.engr.sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, adevries@engsoc.carleton.ca,
        linux@cthulhu.engr.sgi.com, rpm-list@redhat.com
Subject: Re: A question about architecture and byte order with RPMs
References: <m0xdgRS-0005FsC@lightning.swansea.linux.org.uk> <9712041142.ZM14920@xtp.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <9712041142.ZM14920@xtp.engr.sgi.com>; from Greg Chesson on Thu, Dec 04, 1997 at 11:42:21AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 04, 1997 at 11:42:21AM -0800, Greg Chesson wrote:

> Future MMUs are in the future.  I'm more interested in solving the problem
> in a device-independent way.  Also, doing it on a page basis is a bit
> restrictive and limits your options.

Basically I think that the reverse endian bit as it is implemented in
the kernel isn't too useful.  As things are in the EntryLo register
pair on R4000 and better no bit to do things on a per page base as
Alan suggests is left.  Well, at lest not in the lower six bits that
currently contain the control information.  If the reverse endian
bit would also reverse accesses to userspace when running in kernel
mode, it'd be much better for performance as most of the byteswapping
could be left out.  Ok, this in the hope some silicon guys are reading
on this list. (Are there any?)

As far as your original suggestion goes - yes, there is a way to declare
variable attributes in GCC.  It works like:

  unsigned int zumbitsu __attribute__((unaligned));

This for example tells GCC that the variable zumbitsu may not be
allocated correctly aligned and it should generate code that takes
care of that.  Goodbye, address error :-)  This stuff is documented
in the GCC info pages, search for ``variable attributes'' and
``function attributes''.

Extending that mechanism to do byteorder swapping shouldn't be too
hard.  I however don't believe this to be a too useful mechanism
for most applications because a compiler doesn't know if used in
a particular context struct foo has to be swapped or not.

Did you propose this mechanism for Risc/OS 6?

  Ralf

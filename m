Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id TAA1159992 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Dec 1997 19:46:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA16374 for linux-list; Thu, 11 Dec 1997 19:45:47 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA16369; Thu, 11 Dec 1997 19:45:45 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA28524; Thu, 11 Dec 1997 19:45:42 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-09.uni-koblenz.de [141.26.249.9])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id EAA25059;
	Fri, 12 Dec 1997 04:45:10 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA03725;
	Fri, 12 Dec 1997 04:42:07 +0100
Message-ID: <19971212044207.36704@uni-koblenz.de>
Date: Fri, 12 Dec 1997 04:42:07 +0100
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indy crash during bootup
References: <19971208150602.52582@brian.uni-koblenz.de> <ralf@uni-koblenz.de> <9712091934.ZM3116@mdhill.interlog.com> <19971210040210.27443@uni-koblenz.de> <9712110612.ZM1219@mdhill.interlog.com> <19971212033448.01867@uni-koblenz.de> <199712120315.TAA27978@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199712120315.TAA27978@fir.engr.sgi.com>; from William J. Earl on Thu, Dec 11, 1997 at 07:15:22PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 11, 1997 at 07:15:22PM -0800, William J. Earl wrote:

> ralf@uni-koblenz.de writes:
> ...
>  > William: would an attempt to manipulate the R4600 second level cache on
>  > a Indy without such a cache result in a bus error interrupt?
> ...
>      Yes.  The memory address of the cache controller will not exist.  Avoid
> referencing it when the cache is not configured.  If the kernel is not
> reading the cache configuration from the CPU module EEPROM, then it should
> test for the existence of the cache controller by referencing it within
> some sort of exception trap which returns control gracefully with an error
> indication if a bus error occurs.  Note that you might get a bus error exception
> (on a read) rather than a bus error interrupt (on a write).

Ok, this prooves that my theories have been correct.  In fact the Indy
code tries to be intelligent about recognicing a second level cache but
fails to get things right when flushing the cache.  Assume this bug to
be fixed for the next release.

There seems to be something else wrong with the cache handling.  My R5000
Indy has a second level cache according to hinv but it doesn't show up
in the results of lmbench running under Linux.

>click click<

Indeed, we only activate the second level cache for R4600 machines.  I
guess the next kernel release will be *faster* :-)

  Ralf

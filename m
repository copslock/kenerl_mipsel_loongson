Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 16:06:55 +0200 (CEST)
Received: from p508B64CB.dip.t-dialin.net ([80.139.100.203]:22920 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123897AbSJBOGy>; Wed, 2 Oct 2002 16:06:54 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g92E6gU17282;
	Wed, 2 Oct 2002 16:06:42 +0200
Date: Wed, 2 Oct 2002 16:06:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
Message-ID: <20021002160642.E16482@linux-mips.org>
References: <3D9AF333.BC304A34@mips.com> <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl> <20021002154638.B16482@linux-mips.org> <3D9AFC8F.261F0C37@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9AFC8F.261F0C37@mips.com>; from carstenl@mips.com on Wed, Oct 02, 2002 at 04:02:55PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 02, 2002 at 04:02:55PM +0200, Carsten Langgaard wrote:

> > Much of the code is so generic it almost deserves to live in a directory
> > even higher in the hierarchy.  If you look at the 32-bit compat code for
> > the various 64-bit architectures of Linux (in particular sparc64 and ia64),
> > it's a single huge cut'n'paste session.  Not much of that code is actually
> > architecture dependant.
> 
> That would be even better, but unfortunately a lot of the structures used in
> the compat code is not exactly the same across architectures :-(
> But it should be possible to merges a lot this stuff into a generic
> (architecture independent) set of functions.

True.  The basic plan would be to provide the structure definitions and
some architecture dependencies from headers and keep the generic compat
code in a linux-32 directory.

The syscalls are still fairly harmless - the true pain are all the ioctls
that keep growing and changing like weed ...

  Ralf

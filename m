Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 20:14:20 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:64004 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1123904AbSJZSOT>;
	Sat, 26 Oct 2002 20:14:19 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 185WNK-0004oF-00; Sat, 26 Oct 2002 14:13:34 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 185VSB-0002x1-00; Sat, 26 Oct 2002 14:14:31 -0400
Date: Sat, 26 Oct 2002 14:14:31 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Roland McGrath <roland@redhat.com>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
Message-ID: <20021026181431.GA11105@nevyn.them.org>
Mail-Followup-To: "H. J. Lu" <hjl@lucon.org>,
	Roland McGrath <roland@redhat.com>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
References: <20021020172331.A26834@lucon.org> <200210252336.g9PNaww03056@magilla.sf.frob.com> <20021025164132.A23230@lucon.org> <20021026044549.GA15461@nevyn.them.org> <20021025215543.A26333@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025215543.A26333@lucon.org>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 25, 2002 at 09:55:43PM -0700, H. J. Lu wrote:
> On Sat, Oct 26, 2002 at 12:45:49AM -0400, Daniel Jacobowitz wrote:
> > Not everyone uses your MIPS patches; I have a completely functional
> > MIPS system with:
> > 0019df30 l     O .data  000011b8              _new_sys_errlist
> > 0019df30 l     O .data  000001ec              _old_sys_errlist
> 
> It doesn't tell anything. Please, please show size of sys_errlist in
> glibc 2.0 for mips. I am not even sure if you can run mips binaries
> compiled against glibc 2.0 with glibc 2.2/2.3.

I didn't use 2.0 for MIPS either.  And I got the wrong impression from
your last message; sorry!

Here's what my MIPS glibc has:
0019df30 g    DO .data  000001ec (GLIBC_2.0)  sys_errlist
0019df30 g    DO .data  000011b8  GLIBC_2.2   sys_errlist
0019df30 g    DO .data  000001ec (GLIBC_2.0)  _sys_errlist
0019df30 g    DO .data  000011b8  GLIBC_2.2   _sys_errlist

So: I don't know where the GLIBC_2.1 version came from, or why we need
a GLIBC_2.3 version, or why we should change the size of the GLIBC_2.0
version.  Your patch looks good; should you wipe the GLIBC_2.1 version
also?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

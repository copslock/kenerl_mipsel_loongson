Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 06:47:40 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:55058 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1123891AbSJZErk>;
	Sat, 26 Oct 2002 06:47:40 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 185Jkk-0003nv-00; Sat, 26 Oct 2002 00:44:54 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 185IpZ-00044j-00; Sat, 26 Oct 2002 00:45:49 -0400
Date: Sat, 26 Oct 2002 00:45:49 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Roland McGrath <roland@redhat.com>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: Fix errlist for mips
Message-ID: <20021026044549.GA15461@nevyn.them.org>
Mail-Followup-To: "H. J. Lu" <hjl@lucon.org>,
	Roland McGrath <roland@redhat.com>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@linux-mips.org
References: <20021020172331.A26834@lucon.org> <200210252336.g9PNaww03056@magilla.sf.frob.com> <20021025164132.A23230@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025164132.A23230@lucon.org>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 25, 2002 at 04:41:32PM -0700, H. J. Lu wrote:
> On Fri, Oct 25, 2002 at 04:36:58PM -0700, Roland McGrath wrote:
> > You know better than I what existing mips libc.so.6 ABIs have for the size
> > of sys_errlist.  But for the current version, 123 omits many of the errno
> > values I see in asm-mips/errno.h, and EDQUOT really is 1133.  So I don't
> > see how your change can be right.
> 
> That is what was in glibc 2.0 for mips. However, glibc 2.2 is the first
> glibc version I worked on. I don't have any mips binaries compiled
> against glibc 2.0. As far as I know, none of glibc prior to the one
> with all my mips patches applied ever worked 100% correct on mips.

Not everyone uses your MIPS patches; I have a completely functional
MIPS system with:
0019df30 l     O .data  000011b8              _new_sys_errlist
0019df30 l     O .data  000001ec              _old_sys_errlist

(That's 1134*4 in the new one and 123*4 in the older one).  There's a
lot of these beasts deployed and I'd hate to see an incompatible change
now!

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

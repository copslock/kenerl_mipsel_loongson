Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 15:41:37 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:4114 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122958AbSIENlh>;
	Thu, 5 Sep 2002 15:41:37 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17mxpE-00032F-00
	for <linux-mips@linux-mips.org>; Thu, 05 Sep 2002 09:41:40 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17mwt1-0003l2-00
	for <linux-mips@linux-mips.org>; Thu, 05 Sep 2002 09:41:31 -0400
Date: Thu, 5 Sep 2002 09:41:31 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905134131.GB13975@nevyn.them.org>
Mail-Followup-To: linux-mips@linux-mips.org
References: <3D76FC6B.C9AA72F3@mips.com> <Pine.GSO.3.96.1020905111911.2423D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905111911.2423D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 11:23:33AM +0200, Maciej W. Rozycki wrote:
> On Thu, 5 Sep 2002, Carsten Langgaard wrote:
> 
> > >  The (n)64 versions seem suitable and the o32 ones do not as n32 only
> > > crops addresses to 32-bit -- data may still be 64-bit (e.g. file position
> > > pointers).
> > 
> > Please notice, that a 'long' is 32-bit for n32, so we need to do the same
> > conversion for a lot of syscalls, as we already do for o32.
> 
>  Any reference?  AFAIK, long is 64-bit for n32 and only void * is 32-bit. 
> It doesn't make sense otherwise. 

Nope, it looks like long is 32-bit according to GCC.  It means that
64-bit quantities (long long, structures) can go in integer registers.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

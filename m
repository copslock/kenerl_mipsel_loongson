Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g63GamRw010196
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 09:36:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g63GalsT010195
	for linux-mips-outgoing; Wed, 3 Jul 2002 09:36:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g63GagRw010175
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 09:36:42 -0700
Received: from dsl254-114-096.nyc1.dsl.speakeasy.net ([216.254.114.96] helo=nevyn.them.org)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17PnBD-0007Pj-00; Wed, 03 Jul 2002 11:40:35 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17PnBH-0003KE-00; Wed, 03 Jul 2002 12:40:39 -0400
Date: Wed, 3 Jul 2002 12:40:39 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Eric Christopher <echristo@redhat.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>, binutils@sources.redhat.com,
   gcc@gcc.gnu.org
Subject: Re: RFC: Use -Wa,-xgot for Linux/mips (Re: MIPS GOT overflow in gcc 3.2.)
Message-ID: <20020703164039.GA12583@nevyn.them.org>
Mail-Followup-To: "H. J. Lu" <hjl@lucon.org>,
	Eric Christopher <echristo@redhat.com>, linux-mips@oss.sgi.com,
	GNU C Library <libc-alpha@sources.redhat.com>,
	binutils@sources.redhat.com, gcc@gcc.gnu.org
References: <20020701184640.A2043@lucon.org> <1025575632.30577.64.camel@ghostwheel.cygnus.com> <1025579401.1785.0.camel@ghostwheel.cygnus.com> <20020703093518.A2401@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703093518.A2401@lucon.org>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 03, 2002 at 09:35:18AM -0700, H. J. Lu wrote:
> On Mon, Jul 01, 2002 at 08:09:59PM -0700, Eric Christopher wrote:
> > 
> > > AFAIK it happens to mozilla as well.
> > > 
> > > Guh.
> > 
> > There are a few different possible solutions, one is to do the
> > -fPIC/-fpic split, another is to copy to SGI multigot, I'm sure there
> > are other solutions as well...
> > 
> 
> I am enclosing a kludge here. With that, I got
> 
> http://gcc.gnu.org/ml/gcc-testresults/2002-07/msg00062.html
> 
> Any comments?

Did you see my message about mixing GOT models?  I'd need Ralf or Eric to
confirm this, but I'm pretty sure there's a lot of luck involved in
your workaround.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

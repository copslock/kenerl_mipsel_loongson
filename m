Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g63GkFRw010734
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 09:46:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g63GkFc8010733
	for linux-mips-outgoing; Wed, 3 Jul 2002 09:46:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g63GkARw010722
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 09:46:10 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020703165005.RGDG8262.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Wed, 3 Jul 2002 16:50:05 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id F1424125D3; Wed,  3 Jul 2002 09:50:03 -0700 (PDT)
Date: Wed, 3 Jul 2002 09:50:03 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>, binutils@sources.redhat.com,
   gcc@gcc.gnu.org
Subject: Re: RFC: Use -Wa,-xgot for Linux/mips (Re: MIPS GOT overflow in gcc 3.2.)
Message-ID: <20020703095003.B2527@lucon.org>
References: <20020701184640.A2043@lucon.org> <1025575632.30577.64.camel@ghostwheel.cygnus.com> <1025579401.1785.0.camel@ghostwheel.cygnus.com> <20020703093518.A2401@lucon.org> <20020703164039.GA12583@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020703164039.GA12583@nevyn.them.org>; from dan@debian.org on Wed, Jul 03, 2002 at 12:40:39PM -0400
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 03, 2002 at 12:40:39PM -0400, Daniel Jacobowitz wrote:
> On Wed, Jul 03, 2002 at 09:35:18AM -0700, H. J. Lu wrote:
> > On Mon, Jul 01, 2002 at 08:09:59PM -0700, Eric Christopher wrote:
> > > 
> > > > AFAIK it happens to mozilla as well.
> > > > 
> > > > Guh.
> > > 
> > > There are a few different possible solutions, one is to do the
> > > -fPIC/-fpic split, another is to copy to SGI multigot, I'm sure there
> > > are other solutions as well...
> > > 
> > 
> > I am enclosing a kludge here. With that, I got
> > 
> > http://gcc.gnu.org/ml/gcc-testresults/2002-07/msg00062.html
> > 
> > Any comments?
> 
> Did you see my message about mixing GOT models?  I'd need Ralf or Eric to

A testcase?


H.J.

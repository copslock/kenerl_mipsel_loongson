Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f65EQwW18320
	for linux-mips-outgoing; Thu, 5 Jul 2001 07:26:58 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f65EQvV18317
	for <linux-mips@oss.sgi.com>; Thu, 5 Jul 2001 07:26:57 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 347037FA; Thu,  5 Jul 2001 16:26:55 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 107E43F18; Thu,  5 Jul 2001 16:27:05 +0200 (CEST)
Date: Thu, 5 Jul 2001 16:27:05 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: linux 2.4.5: sysmips(MIPS_ATOMIC_SET) is broken (yep, again...)
Message-ID: <20010705162705.B6963@paradigm.rfc822.org>
References: <Pine.GSO.3.96.1010705125923.11517B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.GSO.3.96.1010705125923.11517B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jul 05, 2001 at 01:14:16PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 05, 2001 at 01:14:16PM +0200, Maciej W. Rozycki wrote:
> Hi,
> 
>  Once again a sysmips() patch.  This time the exception fixup code is
> broken -- it never returns (well, it probably returns *somewhere* via a
> following fixup entry).  Also for whatever reason the R3k code is missing. 
> 
>  The following patch fixes it.  While I was at it, I modified contraints a
> bit and replaced some of embedded "\t" chars with tabs (the code was
> completely unreadable before -- now it should be a bit better, as much as
> embedded asm can be).
> 
>  The R3k variant works fine for me.  I was unable to thest the ll/sc one,
> but the semantics should be unchanged, i.e. if it worked before, so it
> will now.  The patch should go into Linus' tree as well. 

How is this patch supposed to work in the means of how does it come around
the -MAXERRNO stuff in scall32 ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

Received:  by oss.sgi.com id <S42464AbQJBXqO>;
	Mon, 2 Oct 2000 16:46:14 -0700
Received: from u-211.karlsruhe.ipdial.viaginterkom.de ([62.180.21.211]:63758
        "EHLO u-211.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42461AbQJBXpx>; Mon, 2 Oct 2000 16:45:53 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869523AbQJBXov>;
        Tue, 3 Oct 2000 01:44:51 +0200
Date:   Tue, 3 Oct 2000 01:44:51 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20001003014451.B614@bacchus.dhis.org>
References: <20000930121823.A32244@bacchus.dhis.org> <Pine.GSO.3.96.1001002134626.6563H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1001002134626.6563H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Oct 02, 2000 at 01:59:03PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 02, 2000 at 01:59:03PM +0200, Maciej W. Rozycki wrote:

> > >  Well, I asked for testing before the commit, but nobody bothered to write
> > > anything, so I assumed everything is correct, sigh...
> > 
> > Not sigh ...  The lesson that not speaking up is a also wrong!
> 
>  Well, if nobody reports a problem with a patch, it means it's either fine
> or nobody bothered to test it.  For me both cases mean it's OK to apply
> it. 

Sure.

> > The ddiv usage outside of do_div / do_div64_32 is actually ok because
> 
>  But can't we receive an exception for some reason???

No, the only exceptions we still may have to deal with are asynchronous
ones, that is cache error and bus error.  Oh yes, trace exception on
certain special CPUs that have support for tracing in hw.

> > interrupts are always disabled.  We don't have the same guarantee for
> > do_div / do_div64_32 calls.
> 
>  Yep -- it's used for printk.

>  I'd see two approaches: either wipe 64-bit code out completely (clean and
> elegant -- I'd vote for it, even though there is performance penalty) or
> disable interrupts around the 64-bit division (the window would be small
> and it would still be a performance win, but it's ugly as hell).  What do
> you think? 

I have a nice little solution, we can wrap the divide with ll / sc.  If
the sc ever fails we took an exception and retry ...

(I think I just felt like comming up with a coding stunt ;-)

  Ralf

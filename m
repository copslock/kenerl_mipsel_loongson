Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4TMZUB13580
	for linux-mips-outgoing; Tue, 29 May 2001 15:35:30 -0700
Received: from hermes.mvista.com ([12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4TMZQd13577
	for <linux-mips@oss.sgi.com>; Tue, 29 May 2001 15:35:26 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4TMWp024909;
	Tue, 29 May 2001 15:32:51 -0700
Message-ID: <3B142367.791F28AF@mvista.com>
Date: Tue, 29 May 2001 15:32:07 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, Joe deBlaquiere <jadb@redhat.com>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010528172454.15200I-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Fri, 25 May 2001, Jun Sun wrote:
> 
> > Alright, I rolled my sleeve and digged into IRIX 6.5, and guess what?
> > sysmips() does NOT have MIPS_ATOMIC_SET (2001) on IRIX!  See the header below.
> 
>  I remember Ralf writing of this being a compatibility call with RISC/OS
> (is it the original OS of MIPS, Inc.?), IIRC.  Ralf: am I right?
> 
> > So apparently MIPS_ATOMIC_SET was invented for Linux only, probably just to
> > implement _test_and_set().  (It would be interesting to see how IRIX implement
> > _test_and_set() on MIPS I machines.  However, the machine I have access uses
> > ll/sc instructions).
> 
>  Does IRIX actually run on anything below ISA II?
>

I assume nobody answering the above questions means nobody really care.  So we
can safely move ahead without worrying about them. :-)
 
> > To me, either 1.a) or 2) is fine with me, although I have a slight faovr over
> > 2) (perhaps because I don't like assembly code and the extra "vertical"
> > calling layer introduced in 1.a)
> 
>  What about 3) -- a new syscall with a different semantics and no need to
> care about limitations of current implementations (especially the
> sysmips() bag).  

Having a new syscall is fine with me, although seems a little more instrusive
than adding a subcall to sysmips().

> I've just sent a proposal for discussion.  I'm looking
> forward for constructive feedback.
> 

The patch looks good to me.

BTW, why wouldn't you choose to have three arguments in the syscall, where the
last one is a pointer to the variable to hold the return value?  Doing that
would avoid tricky register manipulation on both calling side (fetching return
value from $v1) and kernel side (setting regs.regs[3]).

Jun

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34IBE226939
	for linux-mips-outgoing; Wed, 4 Apr 2001 11:11:14 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34IBEM26936
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 11:11:14 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f34I7P019995;
	Wed, 4 Apr 2001 11:07:25 -0700
Message-ID: <3ACB62A4.90B5630@mvista.com>
Date: Wed, 04 Apr 2001 11:06:28 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses> <20010402234850.B25228@paradigm.rfc822.org> <017801c0bbc3$78c706a0$0deca8c0@Ulysses> <20010403003059.E25228@paradigm.rfc822.org> <3ACA09BF.C8EF0D6C@mvista.com> <20010404120211.C11161@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian Lohoff wrote:
> 
> On Tue, Apr 03, 2001 at 10:34:55AM -0700, Jun Sun wrote:
> > > A major problem get the thing in which the configure try to
> > > begin to build executables and guess on the behaviour of the
> > > OS to run on. This ends to be a hack and reminds me on
> > > "pre gnu configure" times where one had to deal
> > > with hundrets of "config.h" or "os.h" files.
> >
> > While it is a pain for some packages, it is actually not too bad for
> > most of them.  I think we (mvista) are rolling out cross-compiled 250+
> > packages for 5 major CPU architectures and 21 sub-architectures - where
> > most of them are based on debian sources. :-)
> 
> We already had the discussion on parts of that implementation. Honestly -
> I dont like the stuff - Rolling out mips packages as "noarch" is
> simply broken - 

That part is fixed in the coming BIG release.  

Honestly, I am not an expert on packeging.  It is basically somebody else's
job here at mvista.  Nevertheless, the point is we cross-compiled it. :-)

Like I said, there are times I do wish and often have to compile natively (the
one that comes to mind is mp3 player).  Due to the embedded constraints, we
pretty much *have* to do cross-compiling for at least some customers on some
systems.  So the argument is that since we are already doing it any way, we
might as well do it all the way.

BTW, we actually do have native compiling as well - probably for something
like mp3 player.  

(Flo, you really cannot beat the argument of having both. :-0)

Jun

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NL0kb23332
	for linux-mips-outgoing; Wed, 23 May 2001 14:00:46 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NL0gF23328;
	Wed, 23 May 2001 14:00:42 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4NKwg013342;
	Wed, 23 May 2001 13:58:42 -0700
Message-ID: <3B0C246D.CF9CDA2F@mvista.com>
Date: Wed, 23 May 2001 13:58:21 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Florian Lohoff <flo@rfc822.org>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010523202819.5196G-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Wed, 23 May 2001, Jun Sun wrote:
> 
> > Same old questions : Where is the definition of sysmips()?  What is considered
> > standard implementation of sysmips() so that we can do reverse-engineering?
> > Irix?
> 
>  I think Ralf can comment it.
> 
> > Even if Irix is considered standard implementation of sysmips(), I wonder if
> > we need to mirror it.  Here is my reasoning.
> >
> > The sytem V ABI specifies _test_and_set() as the exntended system call.
> 
>  I think we want to execute IRIX binaries. 

That would make sense to keep sysmips() as it is if your statement is true. 
But I thought the binary comptability with IRIX has long been broken.  Can
someone confirm that?

If binary compatbility with IRIX is broken now, I don't think we should care
to fix it in the future - obviously. :-)

Jun

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33Hdlc11291
	for linux-mips-outgoing; Tue, 3 Apr 2001 10:39:47 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33HdlM11288
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 10:39:47 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f33HZp013008;
	Tue, 3 Apr 2001 10:35:51 -0700
Message-ID: <3ACA09BF.C8EF0D6C@mvista.com>
Date: Tue, 03 Apr 2001 10:34:55 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <20010402151425.A8471@bacchus.dhis.org> <00fa01c0bbaa$0bd7cb60$0deca8c0@Ulysses> <20010402234850.B25228@paradigm.rfc822.org> <017801c0bbc3$78c706a0$0deca8c0@Ulysses> <20010403003059.E25228@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian Lohoff wrote:
> 
> On Tue, Apr 03, 2001 at 12:22:48AM +0200, Kevin D. Kissell wrote:
> >
> > I'm not sure exactly what you mean here.  That no one would
> > consider using your Debian cross environment?  That no one
> 
> I am not building cross, i am not building the debian cross
> toolchain. Just for completeness.
> 
> > would consider doing cross-development?   What part of it
> > seems to you to be a show-stopper?
> 
> A major problem get the thing in which the configure try to
> begin to build executables and guess on the behaviour of the
> OS to run on. This ends to be a hack and reminds me on
> "pre gnu configure" times where one had to deal
> with hundrets of "config.h" or "os.h" files.
> 

While it is a pain for some packages, it is actually not too bad for most of
them.  I think we (mvista) are rolling out cross-compiled 250+ packages for 5
major CPU architectures and 21 sub-architectures - where most of them are
based on debian sources. :-)

> If you are going to use anything like a package format
> might it be "rpm" or "deb" the dependencies tend to be
> utterly broken as the dependcies are guessed by stuff like
> "ldd" output and friends.
>

There are some tools which make it work right.  mvista has one.  I think
Merceij has one too.
 
Jun

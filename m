Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6Q1q7i00438
	for linux-mips-outgoing; Wed, 25 Jul 2001 18:52:07 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6Q1q3V00434;
	Wed, 25 Jul 2001 18:52:03 -0700
Received: from localhost (wjhun@localhost)
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f6Q1p7d19776;
	Wed, 25 Jul 2001 18:51:07 -0700
Date: Wed, 25 Jul 2001 18:51:07 -0700 (PDT)
From: William Jhun <wjhun@ayrnetworks.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Phil Hopely <phil@ayrnetworks.com>,
   "John D. Davis" <johnd@stanford.edu>,
   Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Replacing the Console driver
In-Reply-To: <20010726033230.B7478@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.21.0107251845290.12368-100000@earth.ayrnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 26 Jul 2001, Ralf Baechle wrote:

> On Thu, Jul 26, 2001 at 01:20:19AM +0100, Alan Cox wrote:
> 
> > > I haven't checked more recent versions, but I think recent mess (uses same cpu cores
> > > as mame) supports early macs, so there may be an implementation example there?..
> > 
> > Early macintosh doesn't have an MMU as standard, The MacII had an optional
> > MMU (for running A/UX) and it became standard on the later Mac systems.
> 
> MC68851?

Yeah, but most home computers based on M68k didn't contain these (and they
probably weren't that cheap). The 68030 had it built in (except the
68EC030). Most of the 68k home computer OSes, like AmigaDOS (and probably
MacOS and Atari ST too) didn't come built with support for an MMU, so even
if you had one, it would only be useful for either running some UNIX
variant or advanced debugging tools (Amiga users remember good 'ol
Enforcer?).

Anyway, like I said, if anyone sees software emulation routines for a
somewhat modern MMU, I'd be interested. I'm sure it's been done (though
I'd like to see some routines that make use of the native MMU via some
kernel interface). It might be slow but it'd make for a killer
general-purpose debugging system. Or gobs of geeky fun.

Will


> 
>   Ralf
> 

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6M9dXm05927
	for linux-mips-outgoing; Sun, 22 Jul 2001 02:39:33 -0700
Received: from fe070.worldonline.dk (fe070.worldonline.dk [212.54.64.208])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6M9dVV05919
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 02:39:32 -0700
Received: (qmail 16487 invoked by uid 0); 22 Jul 2001 09:39:24 -0000
Received: from unknown (HELO tuxedo.skovlyporten.dk) (213.237.49.98)
  by fe070.worldonline.dk with SMTP; 22 Jul 2001 09:39:24 -0000
Received: by tuxedo.skovlyporten.dk (Postfix, from userid 501)
	id 75B192608F; Sun, 22 Jul 2001 11:39:23 +0200 (CEST)
Date: Sun, 22 Jul 2001 11:39:23 +0200
From: Lars Munch Christensen <c948114@student.dtu.dk>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Lars Munch Christensen <c948114@student.dtu.dk>, linux-mips@oss.sgi.com
Subject: Re: mips64 linker bug?
Message-ID: <20010722113923.A17752@tuxedo.skovlyporten.dk>
References: <20010721112715.C2335@tuxedo.skovlyporten.dk> <20010721172309.A25467@bacchus.dhis.org> <20010721181733.A3591@tuxedo.skovlyporten.dk> <20010721210737.D25928@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721210737.D25928@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Jul 21, 2001 at 09:07:37PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 09:07:37PM +0200, Ralf Baechle wrote:
> On Sat, Jul 21, 2001 at 06:17:33PM +0200, Lars Munch Christensen wrote:
> 
> > Thanks...What should I do now? Change my code to mips32 or are there some
> > patches to binutils that I can use, to get it working?
> 
> Depends on what you want to do?

I'm working on a very small, single address space, microkernel and I have
the MIPS Malta with a 5Kc CPU to develop it on. The 5Kc is compatible
with mips32 but I must admit, I really like to have my kernel
running 64bit :). Is there a working binutils for 64 bit code floating
around somewhere or should I stick with the mips32 stuff?

I tried the binutil from ftp://ftp.ds2.pg.gda.pl/pub/macro/SRPMS/ but
they where unable to compile with target mips64-linux.

Thanks
Lars Munch

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OL1dwJ018774
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 14:01:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OL1dmO018773
	for linux-mips-outgoing; Wed, 24 Apr 2002 14:01:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OL1ZwJ018767
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 14:01:35 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020424210157.CNBQ91.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Wed, 24 Apr 2002 21:01:57 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 61767125C7; Wed, 24 Apr 2002 14:01:56 -0700 (PDT)
Date: Wed, 24 Apr 2002 14:01:56 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Updates for RedHat 7.1/mips
Message-ID: <20020424140156.A28438@lucon.org>
References: <20020423155925.A8846@lucon.org> <20020424135339.A24558@idiom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020424135339.A24558@idiom.com>; from espin@idiom.com on Wed, Apr 24, 2002 at 01:53:39PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 24, 2002 at 01:53:39PM -0700, Geoffrey Espin wrote:
> On Tue, Apr 23, 2002 at 03:59:25PM -0700, H . J . Lu wrote:
> > I updated glibc, python, gcc, gdb, rpm, openssl, binutils and toolchain at
> > ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
> > Let know know if there are any problems.
> 
> I've been using your old October toolchain-20011020-* quite happily.
> So foolishly, I upgraded to this new toolchain*rpm for mipsel on i386.
> 
> When building a linux-mips.sourceforge.net -based kernel, if I
> include CONFIG_PCI in the configuration, I get:
> 
> drivers/char/char.o(.data+0x3990): undefined reference to `local symbols in discarded section .text.exit'
> make: *** [vmlinux] Error 1
> 
> 

That is a kernel bug which has been fixed in the newer kernel. From my
binutils release note:

Changes from binutils 2.11.92.0.10:

1. Update from binutils 2001 1121.
2. Fix a linker symbol version bug for common symbols.
3. Update handling relocations against the discarded sections. You may
need to apply the kernel patch enclosed here to your kernel source. If
you still see things like

drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols in discarded
 section .text.exit'

in the final kernel link, that means you have compiled a driver into
the kernel which has a reference to the symbol in a discarded section.
Kernel 2.4.17 or above should work fine.


H.J.

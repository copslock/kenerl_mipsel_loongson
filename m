Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g23NJHi25154
	for linux-mips-outgoing; Sun, 3 Mar 2002 15:19:17 -0800
Received: from dea.linux-mips.net (a1as07-p52.stg.tli.de [195.252.188.52])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g23NJB925150
	for <linux-mips@oss.sgi.com>; Sun, 3 Mar 2002 15:19:11 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g23MJ6w17252;
	Sun, 3 Mar 2002 23:19:06 +0100
Date: Sun, 3 Mar 2002 23:19:06 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Rani Assaf <rani@paname.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Changes to head.S
Message-ID: <20020303231906.A17147@dea.linux-mips.net>
References: <20020303185049.A1788@paname.org> <20020303225630.A16898@dea.linux-mips.net> <20020303230449.K1788@paname.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020303230449.K1788@paname.org>; from rani@paname.org on Sun, Mar 03, 2002 at 11:04:49PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 03, 2002 at 11:04:49PM +0100, Rani Assaf wrote:

> On Sun, Mar 03, 2002 at 10:56:31PM +0100, Ralf Baechle wrote:
> > you're observing an alignment problem I suspect you're using a too old
> > egcs 1.1.2 variant.
> 
> Hmm.. It's the redhat one on ftp://oss.sgi.com/pub/linux/mips/:
> 
> Reading specs from
> /opt/Mipsel/bin/../lib/gcc-lib/mipsel-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)

Just doublechecked it.  The way the alignment guarantee works is through
these two lines in the linker script arch/mips/ld.script.in:

  . = ALIGN(8192);
  .data.init_task : { *(.data.init_task) }

> Is there anything newer/better (I thought  that this is the place were
> H.J. Lu binutils/gcc is stored)?
> 
> BTW, is there any interest in integrating the RC32355 support into the
> main tree?

Sure, send patches to me.

> (I can provide the code that runs on IDT eval boards though
> we're not using them anymore).

I certainly would appreciate somebody to take care of maintaining support
for such eval boards.  By now the number of supported platforms means
that the code for platforms otherwise soon would start to bitrot.

  Ralf

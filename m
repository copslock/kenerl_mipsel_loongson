Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5ULOfnC025415
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 30 Jun 2002 14:24:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5ULOfrl025414
	for linux-mips-outgoing; Sun, 30 Jun 2002 14:24:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from erebor.lep.brno.cas.cz (erebor.lep.brno.cas.cz [195.178.65.162])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5ULOWnC025405
	for <linux-mips@oss.sgi.com>; Sun, 30 Jun 2002 14:24:34 -0700
Received: from ladis by erebor.lep.brno.cas.cz with local (Exim 3.12 #1 (Debian))
	id 17OmOE-0001g3-00; Sun, 30 Jun 2002 23:37:50 +0200
Date: Sun, 30 Jun 2002 23:37:50 +0200
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: [RFC][PATCH]
Message-ID: <20020630233750.C6248@erebor.psi.cz>
References: <20020629184128.GX17216@lug-owl.de> <20020630144238.A342@dea.linux-mips.net> <20020630132020.GF17216@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020630132020.GF17216@lug-owl.de>; from jbglaw@lug-owl.de on Sun, Jun 30, 2002 at 03:20:20PM +0200
From: Ladislav Michl <ladis@psi.cz>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jun 30, 2002 at 03:20:20PM +0200, Jan-Benedict Glaw wrote:
> On Sun, 2002-06-30 14:42:38 +0200, Ralf Baechle <ralf@oss.sgi.com>
> wrote in message <20020630144238.A342@dea.linux-mips.net>:
> > On Sat, Jun 29, 2002 at 08:41:29PM +0200, Jan-Benedict Glaw wrote:
> > > Please give me a comment on this patch. I'm currently tryin' to make the
> > > HAL2 driver work (yes, I've got my Indy out of the edge again and I'm
> > > going to use it as my desktop machine).
> > > 
> > > It fixes a compilation problem on dmabuf.c. There, DMA_AUTOINIT isn't
> > > defined. As ./include/asm-mips/dma.h looks like the asm-i386 file in
> > > general, I've copied the #define from the i386 port (and reformated the
> > > passus...).
> > > 
> > > If you think it'o okay, please apply it (and drop me a note:-p)
> > 
> > Sort of the right thing - why the heck does the Indy sound code have to
> > rely on code for the that antique PC DMA controller ...
> 
> Well, OSS has some 'soundbase.o', in which dmabuf.o is linked into.

you need soundcore.o and hal2.o only.

> Possibly which code path is not used at all on Indy, but the #define has
> to be there... So there's no real answer, but running 2.4.16 (from

the real answer is that you are trying to build support for OSS drivers,
which has definitely nothing to do with HAL2 driver. disable it.

> Debian installer) and 'insmod -f'ing the just compiled 2.4.19-rc1 hal2.o
> into that kernel ends up in useable sound. So this is some working way
> of doing sound.
> 
> Btw., I think I'll have a deeper look at hal2.o - the smallest load lets
> sound proceed in snail mode:-(

can you describe it better? (it has always worked for me ;-))

	ladis

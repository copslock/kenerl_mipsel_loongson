Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5UCcxnC020225
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 30 Jun 2002 05:38:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5UCcxbX020224
	for linux-mips-outgoing; Sun, 30 Jun 2002 05:38:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-65.ka.dial.de.ignite.net [62.180.196.65])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5UCcrnC020215
	for <linux-mips@oss.sgi.com>; Sun, 30 Jun 2002 05:38:54 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5UCgc500360
	for linux-mips@oss.sgi.com; Sun, 30 Jun 2002 14:42:38 +0200
Date: Sun, 30 Jun 2002 14:42:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com
Subject: Re: [RFC][PATCH]
Message-ID: <20020630144238.A342@dea.linux-mips.net>
References: <20020629184128.GX17216@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020629184128.GX17216@lug-owl.de>; from jbglaw@lug-owl.de on Sat, Jun 29, 2002 at 08:41:29PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 29, 2002 at 08:41:29PM +0200, Jan-Benedict Glaw wrote:

> Please give me a comment on this patch. I'm currently tryin' to make the
> HAL2 driver work (yes, I've got my Indy out of the edge again and I'm
> going to use it as my desktop machine).
> 
> It fixes a compilation problem on dmabuf.c. There, DMA_AUTOINIT isn't
> defined. As ./include/asm-mips/dma.h looks like the asm-i386 file in
> general, I've copied the #define from the i386 port (and reformated the
> passus...).
> 
> If you think it'o okay, please apply it (and drop me a note:-p)

Sort of the right thing - why the heck does the Indy sound code have to
rely on code for the that antique PC DMA controller ...

  Ralf

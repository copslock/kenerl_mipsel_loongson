Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2004 20:33:45 +0100 (BST)
Received: from fed1rmmtao10.cox.net ([IPv6:::ffff:68.230.241.29]:54148 "EHLO
	fed1rmmtao10.cox.net") by linux-mips.org with ESMTP
	id <S8225003AbUJJTdl>; Sun, 10 Oct 2004 20:33:41 +0100
Received: from liberty.homelinux.org ([68.2.43.39]) by fed1rmmtao10.cox.net
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20041010193333.XOTV27792.fed1rmmtao10.cox.net@liberty.homelinux.org>;
          Sun, 10 Oct 2004 15:33:33 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id MAA31722;
	Sun, 10 Oct 2004 12:33:05 -0700
Date: Sun, 10 Oct 2004 12:33:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pete Popov <ppopov@embeddedalley.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: PATCH
Message-ID: <20041010123305.A23745@home.com>
References: <1097428659.4627.10.camel@localhost.localdomain> <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.61.0410102000530.5826@waterleaf.sonytel.be>; from geert@linux-m68k.org on Sun, Oct 10, 2004 at 08:01:28PM +0200
Return-Path: <mmporter@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mporter@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 10, 2004 at 08:01:28PM +0200, Geert Uytterhoeven wrote:
> On Sun, 10 Oct 2004, Pete Popov wrote:
> > Ralf, or anyone else, any suggestions on how to get a patch like the one
> > below accepted in 2.6? It's needed due to the 36 bit address of the
> > pcmcia controller on the Au1x CPUs.
> 
> Perhaps you can ask the PPC people? Book E PPC has 36-bit I/O as well.
 
FWIW, it's specifically PPC440 cores that have a 36-bit address space.
It should be noted that nobody has as of yet expressed public interest
in having PCMCIA working on PPC440. I just ran into a person with a
custom board last week interfacing a CF card that would need a similar
patch to handle ppc's phys_addr_t.

To answer Pete's original question, I would suggest posting the patch
to http://lists.infradead.org/mailman/listinfo/linux-pcmcia which is
where PCMCIA subsystem development conversations are taking place. It
might be good to cc: rmk since he's been the de facto PCMCIA
maintainer.

-Matt

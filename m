Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 14:00:49 +0100 (BST)
Received: from loopy.telegraphics.com.au ([IPv6:::ffff:202.45.126.152]:46277
	"EHLO loopy.telegraphics.com.au") by linux-mips.org with ESMTP
	id <S8225956AbVF0NA1>; Mon, 27 Jun 2005 14:00:27 +0100
Received: by loopy.telegraphics.com.au (Postfix, from userid 1001)
	id D21E6A7401; Mon, 27 Jun 2005 22:59:47 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by loopy.telegraphics.com.au (Postfix) with ESMTP id CBBB3A73FC;
	Mon, 27 Jun 2005 22:59:47 +1000 (EST)
Date:	Mon, 27 Jun 2005 22:59:47 +1000 (EST)
From:	Finn Thain <fthain@telegraphics.com.au>
To:	Jeff Garzik <jgarzik@pobox.com>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@vger.kernel.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux MIPS <linux-mips@linux-mips.org>,
	Linux net <linux-net@vger.kernel.org>
Subject: Re: [PATCH] macsonic/jazzsonic drivers update
In-Reply-To: <42BEEC32.7040807@pobox.com>
Message-ID: <Pine.LNX.4.61.0506272150290.9188@loopy.telegraphics.com.au>
References: <200503070210.j272ARii023023@hera.kernel.org>
 <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org>
 <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au>
 <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au>
 <20050615142717.GD9411@linux-mips.org> <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au>
 <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au>
 <20050616092257.GE5202@linux-mips.org> <Pine.LNX.4.61.0506162129450.31164@loopy.telegraphics.com.au>
 <Pine.LNX.4.61.0506270227510.1015@loopy.telegraphics.com.au>
 <42BEEC32.7040807@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <fthain@telegraphics.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fthain@telegraphics.com.au
Precedence: bulk
X-list: linux-mips



On Sun, 26 Jun 2005, Jeff Garzik wrote:

> Patch looks OK to me.  Comments:
> 
> 1) Either Geert or Ralf can merge this, with my ACK.
> 
> 2) Would be nice to get it tested on the machines you list as untested.
> 
> 3) [possible problem in driver, not your changes] I wonder if IRQ_HANDLED is
> ever returned for shared interrupts?  I don't know enough about the platform
> interrupt architecture to answer this question.

I don't know about jazz machines, but macsonic uses one of two IRQs, and 
neither one can be shared.

> 4) Remove casts to/from void.  This is especially noticable in all the casts
> of the netdev_priv() return value.

OK. I'll wait to hear from the other interested parties and if there's no 
objection to the first patch, I'll post a second patch that just removes 
the unecessary casts.

Thanks for your review.

-f

> 5) If it doesn't cause too much patch noise, consider using enums rather than
> #defines, for numeric constants.  This gives the compiler more type
> information and makes the symbols visible in a debugger.  This is a
> -maintainer preference- issue overall, so don't sweat it if you disagree.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

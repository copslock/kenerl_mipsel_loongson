Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jun 2005 18:57:11 +0100 (BST)
Received: from mail.dvmed.net ([IPv6:::ffff:216.237.124.58]:16332 "EHLO
	mail.dvmed.net") by linux-mips.org with ESMTP id <S8225196AbVFZR4v>;
	Sun, 26 Jun 2005 18:56:51 +0100
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DmbMT-0006tC-Qz; Sun, 26 Jun 2005 17:56:06 +0000
Message-ID: <42BEEC32.7040807@pobox.com>
Date:	Sun, 26 Jun 2005 13:56:02 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Finn Thain <fthain@telegraphics.com.au>
CC:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@vger.kernel.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux MIPS <linux-mips@linux-mips.org>,
	Linux net <linux-net@vger.kernel.org>
Subject: Re: [PATCH] macsonic/jazzsonic drivers update
References: <200503070210.j272ARii023023@hera.kernel.org> <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org> <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au> <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au> <20050615142717.GD9411@linux-mips.org> <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au> <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au> <20050616092257.GE5202@linux-mips.org> <Pine.LNX.4.61.0506162129450.31164@loopy.telegraphics.com.au> <Pine.LNX.4.61.0506270227510.1015@loopy.telegraphics.com.au>
In-Reply-To: <Pine.LNX.4.61.0506270227510.1015@loopy.telegraphics.com.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Finn Thain wrote:
> Here is the latest sonic driver update, which I've been rattling on about 
> for some time now. There are several reasons for this patch,
> 
> - Adopt the DMA API (jazzsonic, macsonic & core driver)
> 
> - Adopt the driver model (macsonic)
> 
>   This part was cribbed from jazzsonic. As a consequence, macsonic once 
>   again works as a module. Driver model is also used by the DMA calls.
> 
> - Support 16 bit cards (macsonic & core driver, also affects jazzsonic)
> 
>   This code was adapted from the mac68k linux 2.2 kernel, where it has 
>   languished for a long time.
> 
> - Support more mac cards (macsonic)
> 
>   Also from mac68k repo.
> 
> - Zero-copy buffer handling (core driver)
> 
>   Provides a nice performance improvement. The new algorithm incidentally 
>   helped to replace the old Jazz DMA code.
> 
> A nice consequence of this patch is that one can now diff jazzsonic.c and 
> macsonic.c and get a comprehensible result. Maybe that will make them 
> easier to maintain.
> 
> The patch has been tested on a variety of macs (several 32-bit quadra 
> built-in NICs, a 16-bit LC PDS NIC and a 16-bit comm-slot NIC), but only 
> compile tested for MIPS Jazz.
> 
> The DMA API has been implemented for m68k by Roman Zippel, and his patch 
> is now required for macsonic to function. There is also a patch available 
> which implements that API for Jazz machines (by Thomas I believe).
> 
> It would be nice if someone could test this on a little endian Jazz 
> machine.
> 
> Comments and criticism welcomed.
> 
> -f
> 
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Patch looks OK to me.  Comments:

1) Either Geert or Ralf can merge this, with my ACK.

2) Would be nice to get it tested on the machines you list as untested.

3) [possible problem in driver, not your changes] I wonder if 
IRQ_HANDLED is ever returned for shared interrupts?  I don't know enough 
about the platform interrupt architecture to answer this question.

4) Remove casts to/from void.  This is especially noticable in all the 
casts of the netdev_priv() return value.

5) If it doesn't cause too much patch noise, consider using enums rather 
than #defines, for numeric constants.  This gives the compiler more type 
information and makes the symbols visible in a debugger.  This is a 
-maintainer preference- issue overall, so don't sweat it if you disagree.

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TBjwnC008489
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 04:45:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TBjwVI008488
	for linux-mips-outgoing; Wed, 29 May 2002 04:45:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from irongate.swansea.linux.org.uk (pc2-cwma1-5-cust12.swa.cable.ntl.com [80.5.121.12])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TBjsnC008484
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 04:45:55 -0700
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.2/8.11.6) with ESMTP id g4TCo0Z1012278;
	Wed, 29 May 2002 13:50:01 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.2/8.12.2/Submit) id g4TCnw0Q012270;
	Wed, 29 May 2002 13:49:58 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: PCI Graphics/Video Card for Malta Board?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Malek <dan@embeddededge.com>, "Kevin D. Kissell" <kevink@mips.com>,
   Jun Sun <jsun@mvista.com>, "Steven J. Hill" <sjhill@realitydiluted.com>,
   Linux/MIPS Development
	 <linux-mips@oss.sgi.com>
In-Reply-To: <Pine.GSO.4.21.0205291014450.2890-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0205291014450.2890-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 13:49:58 +0100
Message-Id: <1022676598.4124.165.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2002-05-29 at 09:17, Geert Uytterhoeven wrote:
> On 29 May 2002, Alan Cox wrote:
> > Old S3 cards are very easy to configure. 3Dfx Voodoo 2 is great as we

> Of course I'm part of the problem myself, since I never got anything out of the
> Vision968 and Trio64V+ in my PPC box. Except by emulating the BIOS code and
> using vga16fb...

I've had no problem with Russell King's ARM code. And for the 3dfx
voodoo2 (UKP 9 off ebay) none at all. The voodoo seems to have always
been designed to be totally soft configured and as its not a primary
video card the bios/firmware all leaves it alone

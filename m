Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4T8IUnC022249
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 01:18:30 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4T8IT9k022248
	for linux-mips-outgoing; Wed, 29 May 2002 01:18:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4T8IPnC022244
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 01:18:26 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA07277;
	Wed, 29 May 2002 10:17:49 +0200 (MET DST)
Date: Wed, 29 May 2002 10:17:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dan Malek <dan@embeddededge.com>, "Kevin D. Kissell" <kevink@mips.com>,
   Jun Sun <jsun@mvista.com>, "Steven J. Hill" <sjhill@realitydiluted.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: PCI Graphics/Video Card for Malta Board?
In-Reply-To: <1022630067.9255.146.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0205291014450.2890-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 29 May 2002, Alan Cox wrote:
> Old S3 cards are very easy to configure. 3Dfx Voodoo 2 is great as we

<sarcastic>
I guess that's why we still don't have working frame buffer devices for them?
There are at least 3 frame buffer devices for the Trio floating around the net,
but none of them work on my cards.
</sarcastic>

Of course I'm part of the problem myself, since I never got anything out of the
Vision968 and Trio64V+ in my PPC box. Except by emulating the BIOS code and
using vga16fb...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

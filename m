Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2003 12:18:20 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:51353 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225420AbTLJMST>;
	Wed, 10 Dec 2003 12:18:19 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBACIEQG005262;
	Wed, 10 Dec 2003 13:18:14 +0100 (MET)
Date: Wed, 10 Dec 2003 13:18:15 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kumba <kumba@gentoo.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
In-Reply-To: <3FD6EF32.6070808@gentoo.org>
Message-ID: <Pine.GSO.4.21.0312101203110.6456-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 10 Dec 2003, Kumba wrote:
> Geert Uytterhoeven wrote:
> > This `tulip halting', is it `transmit timed out', following by the chip being
> > thrown in 10-base2 mode and not recovering until ifconfig down/up?
> > 
> > I see that one on my PPC box, and I do have a fix. It's not perfect, but the
> > box now recovers within 3 minutes, instead of needing manual intervention.
> 
> To be honest, I'm not sure what's actually occuring.  At first I thought 
> it was simply halting, but it does not appear to halt completely.  Data 
> will still trickle in *very* slowly.  If ping wouldn't time out after a 
> few seconds, I would bet the box would respond after about 3 minutes. 
> restarting the config does reset it back.

That's different from what I'm seeing. My box doesn't respond at all.

> Now that you mention mode switching, however, May fit in with some data 
> I gleaned using mii-diag that I spoke of in #mipslinux awhile back. 
> When the tulip driver was working fine, mii-diag reported this:
> 
>   MII PHY #1 transceiver registers:
>     1000 782d 7810 0003 01e1 45e1 0001 0000
>     0000 0000 0000 0000 0000 0000 0000 0000
>     0000 0000 4000 0000 3ffb 0010 0000 0002
>     0001 0000 0000 0000 0000 0000 0000 0000
> 
> 
> Notice the setting of the 21st register (3rd row, 5th value).  When the 
> tulip driver started acting up, that value changed to this:
> 
>   MII PHY #1 transceiver registers:
>     1000 782d 7810 0003 01e1 45e1 0001 0000
>     0000 0000 0000 0000 0000 0000 0000 0000
>     0000 0000 4000 0000 38c8 0010 0000 0002
>     0001 0000 0000 0000 0000 0000 0000 0000
> 
> I didn't do very detailed searching for the meaning of the registers, 
> and never found out what the 21st register's specific purpose was, but 
> is this the mode switching you're mentioning perhaps?

I don't know what these registers mean, but tulip_select_media() doesn't seem
to affect the 21st register directly. Perhaps as a hardware side effect?

> If so, I'll give your patch a run, see if it works and if the recovery 
> time can be shortened, or help to isolate the problem so it can be nailed.

Here it is. I've been using it on 2.4.21 for more than 6 months. I upgraded to
2.4.23 9 days ago, and so far I haven't seen any of the printk()s, though.

Without the patch, the driver switches from 10-baseT to 10-base2
unconditionally if the problem happens.
With the patch, the switch is performed only if there's no 10-baseT link beat,
and the driver recovers after a few minutes. This may still cause an annoying
hick up, but the network (incl. open TCP connections) recovers.

I have a 21041, using 10-baseT on a 10 Mbit hub. What Tulip does the Cube have?

--- linux-2.4.23/drivers/net/tulip/tulip_core.c.orig	Fri Nov 28 21:04:35 2003
+++ linux-2.4.23/drivers/net/tulip/tulip_core.c	Sun Nov 30 11:37:45 2003
@@ -580,7 +580,15 @@
 				} else
 					dev->if_port = 0;
 			else
+			{
+printk("tulip: old driver would switch to 10base2, ");
+			if (dev->if_port != 0 || (csr12 & 0x0004) != 0) {
+printk("and we do\n");
 				dev->if_port = 1;
+			} else {
+printk("but we don't\n");
+			}
+			}
 			tulip_select_media(dev, 0);
 		}
 	} else if (tp->chip_id == DC21140 || tp->chip_id == DC21142

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

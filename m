Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2003 09:41:43 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:54431 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225392AbTLJJlm>;
	Wed, 10 Dec 2003 09:41:42 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBA9faQG020329;
	Wed, 10 Dec 2003 10:41:36 +0100 (MET)
Date: Wed, 10 Dec 2003 10:41:37 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kumba <kumba@gentoo.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
In-Reply-To: <3FD64CE1.8030907@gentoo.org>
Message-ID: <Pine.GSO.4.21.0312101039270.6357-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 9 Dec 2003, Kumba wrote:
> Rainer Canavan wrote:
> > I haven't tried my Qube2 yet, since that one's already wrapped up and
> > ready for Karsten Merker to pick up - he's going to send it to the 
> > Tulip Expert, so those problems may go away soon, hopefully. As to 
> > kernel versions starting about 2.4.17, I've never had the tulip driver
> > running reliably on my Qube2, but always got at least 2.4.18 and later 
> > working properly on my nasRaq (there was some patching involved at times, 
> > if I recall correctly).
> 
> Are these patches lying around someplace by chance?  I've used the 
> patches on Paul Martin's site (which enables detection of the cobalt's 
> "modified" tulip), as well as a patch from Karsten which fixed serial 
> console and also enabled the tulip driver.  Both of those patches don't 
> seem to fix the tulip's issue of halting though, so either I have broken 
> hardware, or I've done something unique in my setup that triggers the issue.

This `tulip halting', is it `transmit timed out', following by the chip being
thrown in 10-base2 mode and not recovering until ifconfig down/up?

I see that one on my PPC box, and I do have a fix. It's not perfect, but the
box now recovers within 3 minutes, instead of needing manual intervention.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

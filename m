Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 10:48:11 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:10664 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225073AbUJGJsH>;
	Thu, 7 Oct 2004 10:48:07 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i979m3Mp004503;
	Thu, 7 Oct 2004 11:48:03 +0200 (MEST)
Date: Thu, 7 Oct 2004 11:48:02 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: priya.mani@wipro.com
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: __up, __down_trylock & __down_interruptible for MIPS
In-Reply-To: <6BF015B686198842A1C8F84F4B7E6D2601276C2F@chn-snr-msg.wipro.com>
Message-ID: <Pine.GSO.4.61.0410071147110.9319@waterleaf.sonytel.be>
References: <6BF015B686198842A1C8F84F4B7E6D2601276C2F@chn-snr-msg.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Oct 2004 priya.mani@wipro.com wrote:
> Thanks but I did try that and did not find kernel version above 2.3.
> Since I am behind a firewall I got speacial access to the
> ftp.linux-mips.org and logged into the site to find the linux under pub
> which contains only upto kernel version 2.3. Am I going the wrong path?

If you want access to the current Linux/MIPS tree, you have to convince your
management to allow CVS access to cvs.linux-mips.org.

> -----Original Message-----
> From: geert@sonycom.com [mailto:geert@sonycom.com] On Behalf Of Geert
> Uytterhoeven
> Sent: Thursday, October 07, 2004 1:40 PM
> To: Priya Balasubramanian (WT01 - EMBEDDED & PRODUCT ENGINEERING
> SOLUTIONS)
> Cc: Ralf Baechle; Linux/MIPS Development
> Subject: RE: __up, __down_trylock & __down_interruptible for MIPS
> 
> 
> On Thu, 7 Oct 2004 priya.mani@wipro.com wrote:
> > I too doubted that the kernel which I am using is not in proper shape.
> > Please could you point me to a proper link where I can download it
> from.
> > I am in need of a proper working kernel version 2.4.25 or above.
> >
> > Hope you can lead me to a proper link for this!
> 
> http://cvs.linux-mips.org/kernel.html
> 
> and check out the 2.4 branch (or mainline if you want 2.6).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 11:36:51 +0000 (GMT)
Received: from p508B51DF.dip.t-dialin.net ([IPv6:::ffff:80.139.81.223]:6295
	"EHLO p508B51DF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225557AbSLWLed>; Mon, 23 Dec 2002 11:34:33 +0000
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:60325 "EHLO
	mail.sonytel.be") by ralf.linux-mips.org with ESMTP
	id <S868822AbSLVJYP>; Sun, 22 Dec 2002 10:24:15 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA16192;
	Sun, 22 Dec 2002 10:20:05 +0100 (MET)
Date: Sun, 22 Dec 2002 10:20:10 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: ilya@theIlya.com
cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: O2 VICE support
In-Reply-To: <20021210191120.GE609@gateway.total-knowledge.com>
Message-ID: <Pine.GSO.4.21.0212221019420.11631-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 10 Dec 2002 ilya@theIlya.com wrote:
> Attached is patch set to add support to kernel for O2 video compression engine
> (VICE). It should apply cleanly to latest CVS.

> +config O2_VICE
> +    tristate "O2 VICE Engine Support"
> +    depends on SGI_IP32
> +    ---help---
> +      This option enables O2 VICE Engine support.
> +      VICE stands for Video Image Compression Engine. This is very powerfull
> +      piece of silicon, that can greatly speed up lots of graphics, vide, or
> +      sound related tasks. To be able to use it, you will also need special
> +      library, that can be found at <insert URL here>
                                       ^^^^^^^^^^^^^^^^^

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

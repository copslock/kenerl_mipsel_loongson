Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Feb 2003 09:20:11 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:49044 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8224939AbTBWJUK>;
	Sun, 23 Feb 2003 09:20:10 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA03622;
	Sun, 23 Feb 2003 10:19:17 +0100 (MET)
Date: Sun, 23 Feb 2003 10:19:23 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Baitis <baitisj@evolution.com>
cc: Dan Malek <dan@embeddededge.com>, ppopov@mvista.com,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: fixup_bigphys_addr and DBAu1500 dev board
In-Reply-To: <20030221195031.I20129@luca.pas.lab>
Message-ID: <Pine.GSO.4.21.0302231016050.28469-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 21 Feb 2003, Jeff Baitis wrote:
> -#define outw_p(val,port)                                               \
> -do {                                                                   \
> -       *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
> -               __ioswab16(val);                                        \
> -       SLOW_DOWN_IO;                                                   \
> -} while(0)
> +/* baitisj */
> +static inline u16 outw_p(u16 val, unsigned long port)
> +{
> +    register u16 retval;
> +    do {
> +        retval = *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) =
> +            __ioswab16(val);
> +        SLOW_DOWN_IO;
> +    } while(0);
> +    return retval;
> +}

You don't need the `do { ... } while (0)' construct in an inline function.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

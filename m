Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2003 19:51:16 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:10672 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225694AbTABTvQ>;
	Thu, 2 Jan 2003 19:51:16 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id UAA07041;
	Thu, 2 Jan 2003 20:47:50 +0100 (MET)
Date: Thu, 2 Jan 2003 20:47:49 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix possible buffer overflow problem in promlib
In-Reply-To: <m2hecrbb3p.fsf@demo.mitica>
Message-ID: <Pine.GSO.4.21.0301022047090.4873-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On 2 Jan 2003, Juan Quintela wrote:
>         as the issue about prom.h is still not clear, please aply the
>         trivial part.

>  void prom_printf(char *fmt, ...)
>  {
>  	va_list args;
> -	char ppbuf[1024];
> +	char ppbuf[BUFSIZE];

What about making ppbuf static, to reduce stack usage?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Received:  by oss.sgi.com id <S554044AbRAQN6l>;
	Wed, 17 Jan 2001 05:58:41 -0800
Received: from [193.74.243.200] ([193.74.243.200]:54178 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S554041AbRAQN6c>;
	Wed, 17 Jan 2001 05:58:32 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA14934;
	Wed, 17 Jan 2001 14:57:12 +0100 (MET)
Date:   Wed, 17 Jan 2001 14:57:12 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com
Subject: Re: 2.4.0 Kernel - Summary
In-Reply-To: <20010117145034.B2517@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10101171455070.739-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 17 Jan 2001, Florian Lohoff wrote:
> Its probably a problem with console and tty output getting mixed.
> Definitly a bigger issue as one should merge driver/sbus/zs.c and
> driver/sgi/char/sgiserial.c to one driver. (And probably even
> the Decstation one)

And a zillion other SCC drivers, like e.g. drivers/char/vme_scc.c...

Currently there's one-size-fits-all(?) driver for 16550 (serial.c) and a
collection of SCC drivers spread across the whole tree.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

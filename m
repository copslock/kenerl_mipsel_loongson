Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 16:13:47 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:62672 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTFQPNp>;
	Tue, 17 Jun 2003 16:13:45 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h5HFDbpI026698;
	Tue, 17 Jun 2003 17:13:38 +0200 (MEST)
Date: Tue, 17 Jun 2003 17:13:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Juan Quintela <quintela@trasno.org>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ladislav Michl <ladis@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <86of0wiw5f.fsf@trasno.mitica>
Message-ID: <Pine.GSO.4.21.0306171712100.17930-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Juan Quintela wrote:
> Problems:
> a - you want all your messages in your console, and your console is not
>   the console used by early_printk.  Some meassages dissapear, why?
>   because early_printk is the default -> you don't want early_printk
>   by default.uu

No, if the `real' console has the CON_PRINTBUFFER flag set, all old buffered
messages will be sent again to that console upon registration.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

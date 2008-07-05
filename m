Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2008 09:24:17 +0100 (BST)
Received: from winston.telenet-ops.be ([195.130.137.75]:2491 "EHLO
	winston.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28590565AbYGEIWc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Jul 2008 09:22:32 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by winston.telenet-ops.be (Postfix) with SMTP id E584DA0046;
	Sat,  5 Jul 2008 10:22:30 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by winston.telenet-ops.be (Postfix) with ESMTP id CC5D6A002F;
	Sat,  5 Jul 2008 10:22:30 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m658MUYi007236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 5 Jul 2008 10:22:30 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m658MUar007233;
	Sat, 5 Jul 2008 10:22:30 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sat, 5 Jul 2008 10:22:30 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [SPAM] [PATCH] IP32: Add platform devices for audio and volume
 button
In-Reply-To: <20080704231213.3C6121DA77A@solo.franken.de>
Message-ID: <Pine.LNX.4.64.0807051020170.5733@anakin>
References: <20080704231213.3C6121DA77A@solo.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 5 Jul 2008, Thomas Bogendoerfer wrote:
> +static __init int sgio2audio_devinit(void)
> +{
> +	struct platform_device *pd;
> +	int ret;
> +
> +	pd = platform_device_alloc("sgio2audio", -1);
> +	if (!pd)
> +		return -ENOMEM;
> +
> +	ret = platform_device_add(pd);
> +	if (ret)
> +		platform_device_put(pd);

This sequence is exactly what platform_device_register_simple() does, right?

BTW, I'm also still wondering what's the most efficient way of creating
platform devices. There's also platform_device_register()...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

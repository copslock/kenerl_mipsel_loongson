Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2008 20:09:35 +0100 (BST)
Received: from nelson.telenet-ops.be ([195.130.133.66]:38853 "EHLO
	nelson.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20032132AbYGKTJd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jul 2008 20:09:33 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by nelson.telenet-ops.be (Postfix) with SMTP id 6638450010;
	Fri, 11 Jul 2008 21:09:32 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by nelson.telenet-ops.be (Postfix) with ESMTP id 53ACD50009;
	Fri, 11 Jul 2008 21:09:32 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m6BJ9VHZ013028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 Jul 2008 21:09:31 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m6BJ9V8b013025;
	Fri, 11 Jul 2008 21:09:31 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 11 Jul 2008 21:09:31 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] IP22: Add platform device for Indy volume buttons
In-Reply-To: <20080711183432.1CEEDC2EB7@solo.franken.de>
Message-ID: <Pine.LNX.4.64.0807112107360.7822@anakin>
References: <20080711183432.1CEEDC2EB7@solo.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 11 Jul 2008, Thomas Bogendoerfer wrote:
> --- a/arch/mips/sgi-ip22/ip22-platform.c
> +++ b/arch/mips/sgi-ip22/ip22-platform.c
> @@ -182,3 +182,14 @@ static int __init sgi_hal2_devinit(void)
>  }
>  
>  device_initcall(sgi_hal2_devinit);
> +
> +static int __init sgi_button_devinit(void)
> +{
> +	if (ip22_is_fullhouse())
> +		return 0; /* full house has no volume buttons */
> +
> +	return IS_ERR(platform_device_register_simple("sgiindybtns",
> +						      0, NULL, 0));
                                                      ^
Shouldn't the instance id be -1, as there can be only one?
(cfr. Documentation/driver-model/platform.txt)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

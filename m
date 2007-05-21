Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 22:32:04 +0100 (BST)
Received: from assei1bl6.telenet-ops.be ([195.130.133.68]:61907 "EHLO
	assei1bl6.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20024352AbXEUVb7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 22:31:59 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by assei1bl6.telenet-ops.be (Postfix) with SMTP id 99FC6220098;
	Mon, 21 May 2007 23:31:48 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by assei1bl6.telenet-ops.be (Postfix) with ESMTP id 0C160220094;
	Mon, 21 May 2007 23:31:46 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l4LLVkRG006154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2007 23:31:46 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l4LLViZC006151;
	Mon, 21 May 2007 23:31:45 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 21 May 2007 23:31:44 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Ralf Baechle <ralf@linux-mips.org>, florian.fainelli@telecomint.eu,
	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH UPDATE] Add MIPS generic GPIO support
In-Reply-To: <20070522000558.7dc5b747.yoichi_yuasa@tripeaks.co.jp>
Message-ID: <Pine.LNX.4.64.0705212331210.6011@anakin>
References: <20070521.001238.41198930.anemo@mba.ocn.ne.jp>
 <20070521161303.0d9db8e4.yoichi_yuasa@tripeaks.co.jp>
 <200705210729.l4L7TZB3079730@mbox31.po.2iij.net> <20070521.231200.74752428.anemo@mba.ocn.ne.jp>
 <20070522000558.7dc5b747.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 May 2007, Yoichi Yuasa wrote:
> --- mips-orig/include/asm-mips/gpio.h	1970-01-01 09:00:00.000000000 +0900
> +++ mips/include/asm-mips/gpio.h	2007-05-21 17:07:51.769161250 +0900
> @@ -0,0 +1,6 @@
> +#ifndef __ASM_MIPS_GPIO_H
> +#define __ASM_MIPS_GPIO_H
> +
> +#include <gpio.h>
            ^^^^^^^^
> +
> +#endif /* __ASM_MIPS_GPIO_H */

Just wondering, where is it supposed to find <gpio.h>?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

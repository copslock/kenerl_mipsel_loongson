Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 17:06:16 +0100 (BST)
Received: from witte.sonytel.be ([80.88.33.193]:12974 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S3465716AbVJTQF4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2005 17:05:56 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j9KG5sva018619;
	Thu, 20 Oct 2005 18:05:54 +0200 (MEST)
Date:	Thu, 20 Oct 2005 18:05:53 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	David Daney <ddaney@avtrex.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Patch: ATI Xilleon port 11/11 default config for xilleon STW
 5X226.
In-Reply-To: <17239.48636.650235.544443@dl2.hq2.avtrex.com>
Message-ID: <Pine.LNX.4.62.0510201805240.12888@numbat.sonytel.be>
References: <17239.48636.650235.544443@dl2.hq2.avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 20 Oct 2005, David Daney wrote:
> +#
> +# Graphics support
> +#
> +# CONFIG_FB is not set

Ooh, no frame buffer device? ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 10:27:38 +0200 (CEST)
Received: from witte.sonytel.be ([80.88.33.193]:6575 "EHLO witte.sonytel.be")
	by ftp.linux-mips.org with ESMTP id S8133407AbWEJI1a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 10:27:30 +0200
Received: from pademelon.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id k4A8RPCQ015616;
	Wed, 10 May 2006 10:27:25 +0200 (MEST)
Date:	Wed, 10 May 2006 10:27:25 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] [MIPS] create consistency in "system type" selection
In-Reply-To: <20060509213453.GA32050@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.62.0605101026450.17487@pademelon.sonytel.be>
References: <20060509213453.GA32050@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 9 May 2006, Martin Michlmayr wrote:
> The "system type" Kconfig options on MIPS are not consistent.  For
> some platforms, only the name is listed while other entries are
> prepended with "Support for".  Remove this as it doesn't make sense
> when describing the "system type".  This is in line with how e.g.
> ARM handles this.

I guess the `Support for' prefix came from the era you could compile one kernel
that supported multiple systems.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

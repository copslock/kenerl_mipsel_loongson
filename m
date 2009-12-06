Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Dec 2009 21:26:47 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52896 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493274AbZLFU0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Dec 2009 21:26:44 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 79D46F01D7; Sun,  6 Dec 2009 21:26:42 +0100 (CET)
Date:   Sun, 6 Dec 2009 09:47:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v8 5/8] Loongson: YeeLoong: add hardware monitoring
        driver
Message-ID: <20091206084717.GD2766@ucw.cz>
References: <cover.1260082252.git.wuzhangjin@gmail.com> <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

Hi!

> +static int get_battery_current(void)
> +{
> +	s16 value;
> +
> +	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
> +		(ec_read(REG_BAT_CURRENT_LOW));
> +
> +	if (value < 0)
> +		value = ~value + 1;
> +
> +	return value;
> +}

What is going on here? I thought the value is already in two's
complement... Is the above equivalent of

	      if (value < 0)
	      	 value = -value; 

? If so, why? If not, can you add a comment?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

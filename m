Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 15:44:54 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43004 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493005AbZLDOou (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 15:44:50 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8A94EF04E2; Fri,  4 Dec 2009 15:44:49 +0100 (CET)
Date:   Fri, 4 Dec 2009 09:08:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org
Subject: Re: [PATCH v7 5/8] Loongson: YeeLoong: add hardware monitoring
        driver
Message-ID: <20091204080813.GB1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com> <102732263f647e47216c1f2cb121c30226cc995e.1259932036.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102732263f647e47216c1f2cb121c30226cc995e.1259932036.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

Hi!

> +static int get_cpu_temp(void)
> +{
> +	int value;
> +
> +	value = ec_read(REG_TEMPERATURE_VALUE);
> +
> +	if (value & (1 << 7))
> +		value = (value & 0x7f) - 128;
> +	else
> +		value = value & 0xff;

wtf?

Maybe value should be 's8'?

> +static int get_battery_current(void)
> +{
> +	int value;
> +
> +	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
> +		(ec_read(REG_BAT_CURRENT_LOW));
> +
> +	if (value & 0x8000)
> +		value = 0xffff - value;

Another version of  pair-complement conversion; this one is broken --
off by 1.

> +static int parse_arg(const char *buf, unsigned long count, int *val)
> +{
> +	if (!count)
> +		return 0;
> +	if (sscanf(buf, "%i", val) != 1)
> +		return -EINVAL;
> +	return count;
> +}

We have strict_strtoul for a reason...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

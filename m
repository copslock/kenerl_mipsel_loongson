Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 08:53:25 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:38576 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491045AbZLHHxW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 08:53:22 +0100
Received: by pxi6 with SMTP id 6so3906415pxi.0
        for <multiple recipients>; Mon, 07 Dec 2009 23:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=4Xhz3xF/WU4xG71WNh8ATKGonFefN/OgssnrD1YvgBU=;
        b=Q2xNomNxrj+GFJOFzcfUormKMFvWYPuc2zrMRLOqBiXL7EtelKTlDRvhShTisLefhy
         Ano1Ii0QFBoeDUsHNSJWV046oGFS0BqmUQVU99LFENoQ+sN3YX3yt4J+jLBZyLwGdymI
         IbLiNdGKLySgjPYQ3wH/xiQlytU7XJlsSTwM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=aE4AlpJwZnCoe1m/2nVV1ehlsnMY92k9Q3HEOAhndYXMqMdYlwGI/69n1Uv7LaUSuQ
         D+dKk3yr1jaSeJxlLeKf2KOnH0M8K1WXVzSELG3y7Kbi1B5EDlnrRAqnDntzGC4kQZAW
         z9dTVKpdeHvKWCk12FIpNXIVJxTWR6bh+Kdog=
Received: by 10.114.188.37 with SMTP id l37mr8044012waf.221.1260258795301;
        Mon, 07 Dec 2009 23:53:15 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm5787320pzk.15.2009.12.07.23.53.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 23:53:12 -0800 (PST)
Subject: Re: [PATCH v8 3/8] Loongson: YeeLoong: add backlight driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
In-Reply-To: <3c77f3891e73e189cceef7155dc9cb6503084a4b.1260082252.git.wuzhangjin@gmail.com>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <d6bb11d33fe01abd6de945117ce647af73841f00.1260082252.git.wuzhangjin@gmail.com>
         <5a8742a71e96ba40bee34fb37478cc8339e76530.1260082252.git.wuzhangjin@gmail.com>
         <3c77f3891e73e189cceef7155dc9cb6503084a4b.1260082252.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 08 Dec 2009 15:52:44 +0800
Message-ID: <1260258764.3315.82.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-12-06 at 15:01 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds YeeLoong Backlight Driver, it provides standard
> interface(/sys/class/backlight/) for user-space applications(e.g.
> kpowersave, gnome-power-manager) to control the brightness of the
> backlight.
[...]
> +static int yeeloong_set_brightness(struct backlight_device *bd)
> +{
> +	unsigned int level, current_level;
> +	static unsigned int old_level;
> +
> +	level = (bd->props.fb_blank == FB_BLANK_UNBLANK &&
> +		 bd->props.power == FB_BLANK_UNBLANK) ?
> +	    bd->props.brightness : 0;
> +
> +	if (level > MAX_BRIGHTNESS)
> +		level = MAX_BRIGHTNESS;
> +	else if (level < 0)
> +		level = 0;
> +
> +	/* Avoid to modify the brightness when EC is tuning it */
> +	if (old_level != level) {
> +		current_level = ec_read(REG_DISPLAY_BRIGHTNESS);
> +		if (old_level == current_level)
> +			ec_write(REG_DISPLAY_BRIGHTNESS, level);
> +	}
> +	old_level = level;

Will move the above line into the end of "if { ... }".

Regards,
	Wu Zhangjin

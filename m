Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 16:05:31 +0100 (CET)
Received: from [209.85.222.197] ([209.85.222.197]:52766 "EHLO
        mail-pz0-f197.google.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493126AbZLDPF1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 16:05:27 +0100
Received: by pzk35 with SMTP id 35so2400822pzk.22
        for <multiple recipients>; Fri, 04 Dec 2009 07:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=l8EsSlb2aImqQx1YbPtnsurQeBRtJIUeoc8BrZgnErc=;
        b=V5IuDmhk71TosHMGwIwtypiqtLjreXcswCR7Bn8XDEM43rNLrgaVqbIZR4iUbmE7Bu
         SwsiU63QmXmzEozuSOmyM8kr90qvLGlICTGuH04z3QKEx9GdVXxVwhpRA9DfcOrjF5JS
         RZ9gHcPTNRFLRLXF5XY0tu1cRTbcOUE7HIniY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=WiP2EgrcT4Ncd3fDLzEJcoslQr4bb3P6cG9FAqjlfvCOLrvcUJxd3VToIy8DyP1w5B
         lhJj1MjL5op6A230boXYkDG6aH9DCl3vi2zYHiQs+WBJol+dwPdC/d8ZrWEDXhx8y+l+
         RRMRZCdMXbYpYhSSxGqd5AZwWPimwwX/mYE3Y=
Received: by 10.114.7.9 with SMTP id 9mr4277155wag.71.1259939109323;
        Fri, 04 Dec 2009 07:05:09 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2562532pzk.10.2009.12.04.07.05.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 07:05:08 -0800 (PST)
Subject: Re: [PATCH v7 6/8] Loongson: YeeLoong: add video output driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org, luming.yu@intel.com
In-Reply-To: <20091204081124.GC1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com>
         <5fd87c1f64a3c6d3e51fc6b0224cc1be3cb0d9d5.1259932036.git.wuzhangjin@gmail.com>
         <20091204081124.GC1540@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 04 Dec 2009 23:04:36 +0800
Message-ID: <1259939076.9554.7.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-12-04 at 09:11 +0100, Pavel Machek wrote:
> On Fri 2009-12-04 21:36:43, Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds Video Output Driver, it provides standard
> > interface(/sys/class/video_output) to turn on/off the video output of
> > LCD, CRT.
> > 
> 
> > diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
> > index 9c8385c..4a89c01 100644
> > --- a/drivers/platform/mips/Kconfig
> > +++ b/drivers/platform/mips/Kconfig
> > @@ -21,6 +21,7 @@ config LEMOTE_YEELOONG2F
> >  	select SYS_SUPPORTS_APM_EMULATION
> >  	select APM_EMULATION
> >  	select HWMON
> > +	select VIDEO_OUTPUT_CONTROL
> >  	default m
> >  	help
> >  	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
> 
> default m is evil.
> 

why? this module can be loaded automatically, so, I let it be a module
by default.

> > +	if (status == BIT_DISPLAY_LCD_ON) {
> > +		/* Turn on LCD */
> > +		outb(0x31, 0x3c4);
> > +		value = inb(0x3c5);
> > +		value = (value & 0xf8) | 0x03;
> > +		outb(0x31, 0x3c4);
> > +		outb(value, 0x3c5);
> > +		/* Turn on backlight */
> > +		ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_ON);
> > +	} else {
> > +		/* Turn off backlight */
> > +		ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_OFF);
> > +		/* Turn off LCD */
> > +		outb(0x31, 0x3c4);
> > +		value = inb(0x3c5);
> > +		value = (value & 0xf8) | 0x02;
> > +		outb(0x31, 0x3c4);
> > +		outb(value, 0x3c5);
> > +	}
> 
> IIRC this is opencoded in suspend support; should that get common
> helpers?
> 
> > +	if (status == BIT_CRT_DETECT_PLUG) {
> > +		if (ec_read(REG_CRT_DETECT) == BIT_CRT_DETECT_PLUG) {
> > +			/* Turn on CRT */
> > +			outb(0x21, 0x3c4);
> > +			value = inb(0x3c5);
> > +			value &= ~(1 << 7);
> > +			outb(0x21, 0x3c4);
> > +			outb(value, 0x3c5);
> > +		}
> > +	} else {
> > +		/* Turn off CRT */
> > +		outb(0x21, 0x3c4);
> > +		value = inb(0x3c5);
> > +		value |= (1 << 7);
> > +		outb(0x21, 0x3c4);
> > +		outb(value, 0x3c5);
> > +	}
> 
> This looks suspiciously similar to one another and to code
> above. Perhaps some more helpers?
> 

Yes, lots of duplicated source code above, thanks!

Regards,
	Wu Zhangjin

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 17:30:26 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:36285 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492914AbZLDQaW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 17:30:22 +0100
Received: by pxi6 with SMTP id 6so714019pxi.0
        for <multiple recipients>; Fri, 04 Dec 2009 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=u2gLDyxrC9BjabwZXR9sf061r5jwuKspjFs+3ivl4bc=;
        b=mHmDFi37Qc8w9Ts860jywncImBgmXN3dv2zhsG3RelHfGMb/k45f+bMnABAS82aQRW
         GcxITNjqv7LFjjDsoFmPuHiTxDqziUb2kOir76MnGX0jZ1udFdE7MrxrVNDpUt9/M9t+
         abB9kCYDcu0gvOQDSc1NRhVH8pHOY5znAKAxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=cUTVwVLcr5IiRqDEQPePYG+aRXe0tULyr4Uf0alfMDLsjsr0+gAALF/MkbOHSZ+q4Z
         fZNyrr/JFccdCyNbuD3X4uFpnq4RiQ7qVa9TsqTvuGZV6cJxZTtAZmRZJJNR1Un/3wcz
         FTNTKprxWTgTnpFuZgVpPrLOjFL1Wg2IXPcZY=
Received: by 10.114.237.19 with SMTP id k19mr4353492wah.69.1259944213206;
        Fri, 04 Dec 2009 08:30:13 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm2602676pzk.15.2009.12.04.08.30.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 08:30:12 -0800 (PST)
Subject: Re: [PATCH v7 5/8] Loongson: YeeLoong: add hardware monitoring
 driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org
In-Reply-To: <20091204080813.GB1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com>
         <102732263f647e47216c1f2cb121c30226cc995e.1259932036.git.wuzhangjin@gmail.com>
         <20091204080813.GB1540@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 05 Dec 2009 00:29:45 +0800
Message-ID: <1259944185.9554.8.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-12-04 at 09:08 +0100, Pavel Machek wrote:
> Hi!
> 
> > +static int get_cpu_temp(void)
> > +{
> > +	int value;
> > +
> > +	value = ec_read(REG_TEMPERATURE_VALUE);
> > +
> > +	if (value & (1 << 7))
> > +		value = (value & 0x7f) - 128;
> > +	else
> > +		value = value & 0xff;
> 
> wtf?
> 
> Maybe value should be 's8'?
> 
> > +static int get_battery_current(void)
> > +{
> > +	int value;
> > +
> > +	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
> > +		(ec_read(REG_BAT_CURRENT_LOW));
> > +
> > +	if (value & 0x8000)
> > +		value = 0xffff - value;
> 
> Another version of  pair-complement conversion; this one is broken --
> off by 1.
> 
> > +static int parse_arg(const char *buf, unsigned long count, int *val)
> > +{
> > +	if (!count)
> > +		return 0;
> > +	if (sscanf(buf, "%i", val) != 1)
> > +		return -EINVAL;
> > +	return count;
> > +}
> 
> We have strict_strtoul for a reason...
> 

Done, thanks!

Regards,
	Wu Zhangjin

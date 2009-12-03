Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 17:45:32 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:57478 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493530AbZLCQpZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 17:45:25 +0100
Received: by pwi18 with SMTP id 18so184638pwi.24
        for <linux-mips@linux-mips.org>; Thu, 03 Dec 2009 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=VDq6w8GMKaQTSKuRgUgOMOd+wgaI9kvlq27e7EhUChM=;
        b=mOjaOmmT9+2SYpu72dB/WX9yXXQqDsMBowMP98LcKJj46w+Lx0dQoPqPYFt4uwHNA5
         y9V4jryNvPvJk0wdsPx6Z6kGchZCXUSCzMD5gFrTrDPbgWxDDs0H+MtQzHQfjeCk6tZy
         hFIXLQarYhN/MIFyjI0oSZ9gnXDVFM5/MEt0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=HK60iBTNHjBBtZrKvtkQImpnhFNTV/v60Q3cPUu3e5EZXsa+r/X1uZdMVUa8f8d/22
         7d3jbHb6XJQUtZkR6lyKoLs+PCUFvL6PPwlnE/tB05XIj7GgeVofqOo9R91S0zCUa9Jl
         KDSIHBq24vjIDZGwUqHF595a5rbrigADVYKsw=
Received: by 10.114.164.38 with SMTP id m38mr2495064wae.219.1259858718446;
        Thu, 03 Dec 2009 08:45:18 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1800401pzk.10.2009.12.03.08.45.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 08:45:17 -0800 (PST)
Subject: Re: [rtc-linux] [PATCH v1 2/3] RTC: rtc-cmos.c: enable
 RTC_DM_BINARY of RTC_LIB for fuloong2e and fuloong2f
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Alessandro Zummo <a.zummo@towertech.it>
Cc:     rtc-linux@googlegroups.com, Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-mips@linux-mips.org,
        David Brownell <dbrownell@users.sourceforge.net>
In-Reply-To: <20091203172735.7c934f61@linux.lan.towertech.it>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
         <f05318584db5160d73af2cfb36b4e3e481a7e7a4.1257383766.git.wuzhangjin@gmail.com>
         <20091203172735.7c934f61@linux.lan.towertech.it>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 04 Dec 2009 00:44:56 +0800
Message-ID: <1259858696.7536.28.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-12-03 at 17:27 +0100, Alessandro Zummo wrote:
> On Thu,  5 Nov 2009 09:22:09 +0800
> Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> 
> >  	 */
> > -	if (is_valid_irq(rtc_irq) &&
> > -	    (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
> > -		dev_dbg(dev, "only 24-hr BCD mode supported\n");
> > +	if (is_valid_irq(rtc_irq) && !(rtc_control & RTC_24H)) {
> > +		dev_dbg(dev, "only 24-hr supported\n");
> 
>  If this check was there it's probably because there are problems
>  in some other parts of the driver. I'm not keen to add this without
>  some feedback by the original author or porter.
> 

Just found two authors or porters from the file: drivers/rtc/rtc-cmos.c

/*
 * RTC class driver for "CMOS RTC":  PCs, ACPI, etc
 *
 * Copyright (C) 1996 Paul Gortmaker (drivers/char/rtc.c)
 * Copyright (C) 2006 David Brownell (convert to new framework)
[...]

and found out their names in MAINTAINERS and put them in the CC list ;)

Regards,
	Wu Zhangjin

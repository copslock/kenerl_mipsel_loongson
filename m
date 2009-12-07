Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 10:41:51 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:60378 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492929AbZLGJlr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2009 10:41:47 +0100
Received: by pzk35 with SMTP id 35so3807419pzk.22
        for <multiple recipients>; Mon, 07 Dec 2009 01:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=iueJ1ZW90iKbeFUGWAPugb/6njng6PWnLl9laIu155A=;
        b=wq44n3qQQ0JoGWw8fDiKXwriH9TLrrqLRqo5MfbpKW0238mC2cZgn23QKQVdS23SIN
         8rOsOgnfyMB+p9DzJWoanZlLrGBGS5FjWWo56TE2rmaL78DaK/9ZgNUvsoeqFIyODE62
         UI5zWim8MkzCx9633mMO3Cw1FpT87AaTJW30c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=H6FQwCvgvdQVIp3vxc3nqFCFO98BG1sYujLquQqpLeCoQUn/+MaIIj6nQN14dlY6nf
         iIPn1kGE6Pe4trvKp87bfGrzM/2wyifvOorxRsItmms097aiKuzE+z3Ih30YgFOg6ZuM
         dq7KXM/w9EUCLOZ2PzqeM1iQYLWfnxkZXrdJY=
Received: by 10.114.49.6 with SMTP id w6mr11161027waw.148.1260178900188;
        Mon, 07 Dec 2009 01:41:40 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm5030721pzk.7.2009.12.07.01.41.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 01:41:39 -0800 (PST)
Subject: Re: [PATCH v8 5/8] Loongson: YeeLoong: add hardware monitoring
 driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20091207080446.GB23088@elf.ucw.cz>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
         <20091206084717.GD2766@ucw.cz> <1260147298.3126.2.camel@falcon.domain.org>
         <20091207080446.GB23088@elf.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 07 Dec 2009 17:41:10 +0800
Message-ID: <1260178870.9092.34.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-12-07 at 09:04 +0100, Pavel Machek wrote:
> > > What is going on here? I thought the value is already in two's
> > > complement... Is the above equivalent of
> > > 
> > > 	      if (value < 0)
> > > 	      	 value = -value; 
> > > 
> > > ? If so, why? If not, can you add a comment?
> > 
> > Right, then, will use this instead:
> > 
> > static int get_battery_current(void)
> > { 
> > 	s16 value;
> > 
> > 	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
> > 		(ec_read(REG_BAT_CURRENT_LOW));
> > 
> > 	return abs(value);
> > }
> 
> That's certainly better. But... why not return signed value? Current
> flowing from the battery is certainly very different from current
> flowing into it...

You are totally right ;)

Just test it, when flowing from the battery, the value is negative, and
when flowing into the battery, the value is positive, so, no abs()
needed. thanks!

BTW: This part of source code was written by another EC guy, not checked
it carefully, sorry ;)

Best Regards,
	Wu Zhangjin

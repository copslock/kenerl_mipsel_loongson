Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 01:55:40 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:62825 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494145AbZLGAzh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2009 01:55:37 +0100
Received: by pzk35 with SMTP id 35so3580512pzk.22
        for <multiple recipients>; Sun, 06 Dec 2009 16:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=bvUsoT+1Us6JY8GoEkBBRF4TMCISNFxR5cqkWDFWmO0=;
        b=Joo6PhUNwNj8jV5ASjnqLKiO/CBiojLnUJqDLCPjx9Omb1IL+o48RTgNuYoT56ihip
         HMa93nFQ/MdKJYb+OS51x5cUrv8o7D67ZSc+FSs5H9b3sw+H+SNJ+EWHIQVTs3McxlH6
         9/KX7y/iqf4jVYDCZNGgwEzozxpZfn7xEo4p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=I6uvZ2PaPM6y7ndiKCLZkEpzoJWk30r+wPwtscZ2JQAK5po1400Luc5yEAz7LlXANO
         OVLNqkqbH97j9IzY4INpPBZF1QGx8b6f8hEkqMOLOMud+C/gd4lfrmbKT9RxD8eOPjWg
         VOs3PO9WPPM+AOfqZblK2wgdoZa61AAwLFjqc=
Received: by 10.114.187.8 with SMTP id k8mr9981889waf.220.1260147328962;
        Sun, 06 Dec 2009 16:55:28 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm4737233pzk.9.2009.12.06.16.55.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 16:55:28 -0800 (PST)
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
In-Reply-To: <20091206084717.GD2766@ucw.cz>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
         <20091206084717.GD2766@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 07 Dec 2009 08:54:58 +0800
Message-ID: <1260147298.3126.2.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-12-06 at 09:47 +0100, Pavel Machek wrote: 
> Hi!
> 
> > +static int get_battery_current(void)
> > +{
> > +	s16 value;
> > +
> > +	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
> > +		(ec_read(REG_BAT_CURRENT_LOW));
> > +
> > +	if (value < 0)
> > +		value = ~value + 1;
> > +
> > +	return value;
> > +}
> 
> What is going on here? I thought the value is already in two's
> complement... Is the above equivalent of
> 
> 	      if (value < 0)
> 	      	 value = -value; 
> 
> ? If so, why? If not, can you add a comment?

Right, then, will use this instead:

static int get_battery_current(void)
{ 
	s16 value;

	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
		(ec_read(REG_BAT_CURRENT_LOW));

	return abs(value);
}

Thanks & Best Regards,
	Wu Zhangjin

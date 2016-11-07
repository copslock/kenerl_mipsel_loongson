Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 10:39:05 +0100 (CET)
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35536 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991344AbcKGJi5wbp-i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 10:38:57 +0100
Received: by mail-wm0-f53.google.com with SMTP id a197so169913810wmd.0
        for <linux-mips@linux-mips.org>; Mon, 07 Nov 2016 01:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/+Fx6VySCf4szsO+VRLC+kOZOZ/XuhFA9vbRn76iehI=;
        b=XvIE+8cieBdUcZehaEXPVftY5kMrqTfAuYV8Dge2waa/qrsW5eKk8RISv/27Q7QHat
         Du8UjHM8b6OIk9LPB3OA5XP/oOdS0XtfgmQE0UkJeUVHTgBecoJFbH8NUBX3TYpKDtsf
         rlpYQzcPF9940Y6qm56gEUnzc5OzJ9MaA8f78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/+Fx6VySCf4szsO+VRLC+kOZOZ/XuhFA9vbRn76iehI=;
        b=Eqs54JAhDOqxWf01984skMF2FWslUi0G3OOl1/FKogbDEf9qIgD00hg01sHCrzvvam
         sRLssKgIpnAe9XwiHpEWJ1uayisYl5rKH3uOs4oKNpqh+pZ0Mt687ZW/LWcxQt6nbaa5
         u6PoZaWjl5RK2ZneJMq0oc5AXZ8XiboJ1I5a2jCSfkBAkBchGedXhCM6fLR6Geb+6mQe
         +4xuB8fFcfQMbO91xji7TRLyqnliVn22iNtluhMugWF2fNkVkuzBgQXuA/mFuX7pEH+n
         YpF7xU2Mbl/OjNipN4BigVrF7j+3B0xLNgesc9Lq49E0O8YSgBa+2wdL1/rGPQQVkvXn
         DnOw==
X-Gm-Message-State: ABUngvehcbNDCgkKvOEzRJRtXRg+6EV1CvsPzFvAXjXLimLQ79moLMFuMQinRSWFKT/fv3q+
X-Received: by 10.194.109.168 with SMTP id ht8mr1091074wjb.36.1478511532533;
        Mon, 07 Nov 2016 01:38:52 -0800 (PST)
Received: from dell (host81-129-173-176.range81-129.btcentralplus.com. [81.129.173.176])
        by smtp.gmail.com with ESMTPSA id jb2sm29865376wjb.44.2016.11.07.01.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2016 01:38:51 -0800 (PST)
Date:   Mon, 7 Nov 2016 09:41:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] mfd: syscon: Support native-endian regmaps
Message-ID: <20161107094137.GD13127@dell>
References: <e50cd48c-e0c4-9bfc-b265-383a33eac569@roeck-us.net>
 <20161014091732.27536-1-paul.burton@imgtec.com>
 <6eee2835-43b2-ffa1-9be3-a1a9d8ed56cf@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6eee2835-43b2-ffa1-9be3-a1a9d8ed56cf@roeck-us.net>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sat, 05 Nov 2016, Guenter Roeck wrote:

> On 10/14/2016 02:17 AM, Paul Burton wrote:
> > The regmap devicetree binding documentation states that a native-endian
> > property should be supported as well as big-endian & little-endian,
> > however syscon in its duplication of the parsing of these properties
> > omits support for native-endian. Fix this by setting
> > REGMAP_ENDIAN_NATIVE when a native-endian property is found.
> > 
> 
> Any chance to get this patch applied to mainline ? It is in -next, but
> big endian mips malta images still fail to reboot in mainline.

Applied to -fixes.

> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > ---
> >  drivers/mfd/syscon.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > index 2f2225e..b93fe4c 100644
> > --- a/drivers/mfd/syscon.c
> > +++ b/drivers/mfd/syscon.c
> > @@ -73,8 +73,10 @@ static struct syscon *of_syscon_register(struct device_node *np)
> >  	/* Parse the device's DT node for an endianness specification */
> >  	if (of_property_read_bool(np, "big-endian"))
> >  		syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
> > -	 else if (of_property_read_bool(np, "little-endian"))
> > +	else if (of_property_read_bool(np, "little-endian"))
> >  		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
> > +	else if (of_property_read_bool(np, "native-endian"))
> > +		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
> > 
> >  	/*
> >  	 * search for reg-io-width property in DT. If it is not provided,
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

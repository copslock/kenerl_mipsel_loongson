Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Apr 2016 20:32:10 +0200 (CEST)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33223 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007359AbcDCScJH1Z-g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Apr 2016 20:32:09 +0200
Received: by mail-ob0-f171.google.com with SMTP id x3so157648448obt.0
        for <linux-mips@linux-mips.org>; Sun, 03 Apr 2016 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=VEb+vbzUQGAhNZyDVN+MmP7s2nGgwuzKnuRgZELHYu4=;
        b=XehghvNfor1Nv6BE5+z7amD/1hsgv4qETouSePtes1pzte8r9tmC/be1ikwLHebbwk
         R3n4hD7eQR99ePYuQ0nzBDdnb2vhj5MI7O/52XXlhyeLEZiBTCm4wjnne5fTIO/v6mI+
         0SonW1NmRB/Vwj5fhbgCQsFL513MAZo8y3X42Gog5++YXyYlN01Va1zyz2eL7p7hymOT
         3qkY665gvwTdxlALGV4w9jv2sX1xMuca1r6vm67R5XL1x9Q/4GogNawenLNqFH/H4CT+
         5h8r/qcs45xJEYtYL35wowUGUmL2/T0UpF5evLyoyQ9ylwx1iqy4az01/vDVOL241ldv
         JJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VEb+vbzUQGAhNZyDVN+MmP7s2nGgwuzKnuRgZELHYu4=;
        b=kWU6+p31UGvvGnUBlH7Ca7OuHKfiD4mdLb+9/KnS2OUaJ2zoZ/FsJYiSyENmypvSHp
         jMOjvIfwlm8kDiEgrsi9o+Q5L7rbiW2vNXg4HKj649Tdp2IYL+J5AnFAwTkMQsnGC1rV
         2u2LTpd8B5xWoTDAKtq9F0CPAVKY5B1WEqt/GrByPJ6x6rrGeUWiOz1WsZyuOt6PnYAV
         3gsoXzhaR1WRv+z4y9f0V5Eqz58HIPLR/57cJqu9BqCE0XYx4Sq+3nEed5fVmnoR0dVt
         +RWftUly4ZhCcFZZVD8xj+W0bBfB+hgSogk3JCOz0lzZIyXsaqo5QIJRp5K7a+ZVOOlj
         oTuQ==
X-Gm-Message-State: AD7BkJLwkK+cLX74qssfz06Hp+5lL/wrLcmTp+Uv2b5wn7pnWIxrEYfmj1zLY5ENyu4FtA==
X-Received: by 10.182.153.10 with SMTP id vc10mr2774933obb.10.1459708323190;
        Sun, 03 Apr 2016 11:32:03 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:14c4:8f1:9484:755e? ([2001:470:d:73f:14c4:8f1:9484:755e])
        by smtp.googlemail.com with ESMTPSA id xt3sm7383656obc.28.2016.04.03.11.32.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2016 11:32:02 -0700 (PDT)
Subject: Re: [PATCH] bmips: rename BCM63168 to BCM63268
To:     Simon Arlott <simon@fire.lp0.eu>,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
References: <1459684846-11308-1-git-send-email-noltari@gmail.com>
 <57012B92.6040102@simon.arlott.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5701619B.3090504@gmail.com>
Date:   Sun, 3 Apr 2016 11:31:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <57012B92.6040102@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 03/04/2016 07:41, Simon Arlott a écrit :
> On 03/04/16 13:00, Álvaro Fernández Rojas wrote:
>> BCM63168 and BCM63268 are very similar and Broadcom refers to them as BCM63268
> 
> They are practically the same but they both exist.
> 
>> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>> index 38b5bd5..bfee6ea 100644
>> --- a/arch/mips/bmips/setup.c
>> +++ b/arch/mips/bmips/setup.c
>> @@ -112,10 +112,10 @@ static void bcm6368_quirks(void)
>>  static const struct bmips_quirk bmips_quirk_list[] = {
>>  	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
>>  	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
>> +	{ "brcm,bcm63268",		&bcm6368_quirks			},
>>  	{ "brcm,bcm6328",		&bcm6328_quirks			},
>>  	{ "brcm,bcm6358",		&bcm6358_quirks			},
>>  	{ "brcm,bcm6368",		&bcm6368_quirks			},
>> -	{ "brcm,bcm63168",		&bcm6368_quirks			},
> 
> You can add "brcm,bcm63268" but you can't remove support for
> "brcm,bcm63168".

Agreed, this cannot be removed now.
-- 
Florian

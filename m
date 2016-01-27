Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 21:30:37 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33603 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011828AbcA0UafSopaN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 21:30:35 +0100
Received: by mail-pa0-f68.google.com with SMTP id pv5so876543pac.0;
        Wed, 27 Jan 2016 12:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=l7MEJZvnRcXCfUz0WEqjXy4zACf+zsW7AjCCg1itQfI=;
        b=ht+tkwDqJHFGZlKomkTKJWGNXk6EgK5xP8KXTGmzRG7y3LyH7Bh6xChVK3RUJGMP2T
         MIzXEBRL66264sUHhyoGDZtH+ANWZ5exXo0vIr8mKpMn7tgZWIxrkItGgVAQUiKGRciO
         znXXeIrjPIVc7dpdYpH4j5b/unHOF6sejvSWHiXHW86/L/2n1DBUujIMMpeK30/XjaYs
         YlaOm3DgbvXIOJ3vFaij+zp9Uhi0vw81hwuf5OIfKGyprNwfPZQA/uweDetdxUI73nWf
         QjVeCgaRZUN+zC8s54fCXg6k9WTpSKG5rhUPsixJRNNBkRho9WQVnLOptLkQjdbvw5pX
         ss6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=l7MEJZvnRcXCfUz0WEqjXy4zACf+zsW7AjCCg1itQfI=;
        b=UNEfz+CjO029wAk3s3F0IPprdP783zSEPEskBdA4iC2b+tPlA8+R+cTPSaYmiTyoDJ
         U87cVCH7CtZcHbwvhEGh04DYPwCnh+fY0C3GIKIbARjYTwTz6rWPjqaEh16eta8k7ls2
         bzr6Efa6l1eArDL9Af8HVw6ZMwbvePqxyTABtTJf73HpVAamRNEN4YjciTFudOe5a2fN
         w7yvFoSeaC7y5ySquM5j13n/ZmqKlIQHKMSW4IK/TRdESdIygeQEaDQITnPFMFHhKf0Q
         IghiSjoQUPnaagbwtXWy4sQvb6qtPIVdWQqjmQjuNiqI2rAQdNiMPB8b/zhXtzNNA0WJ
         k6XQ==
X-Gm-Message-State: AG10YOTmPs4Uw0y7ieAX21yFxAhToj19riuiOiyLNSPn6w2zt5qno3y6je8YGEIlHy3Brw==
X-Received: by 10.66.149.7 with SMTP id tw7mr45586534pab.72.1453926629441;
        Wed, 27 Jan 2016 12:30:29 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id xr8sm11005536pab.26.2016.01.27.12.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2016 12:30:28 -0800 (PST)
Message-ID: <56A928B1.6000001@gmail.com>
Date:   Wed, 27 Jan 2016 12:29:37 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Brian Norris <computersforpeace@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, cernekee@gmail.com,
        jogo@openwrt.org, simon@fire.lp0.eu
Subject: Re: [PATCH 2/2] MIPS: BMIPS: Enable partition parser in defconfig
References: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com> <1453925596-24661-3-git-send-email-f.fainelli@gmail.com> <20160127202302.GB41831@google.com>
In-Reply-To: <20160127202302.GB41831@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51490
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

On 27/01/16 12:23, Brian Norris wrote:
> On Wed, Jan 27, 2016 at 12:13:16PM -0800, Florian Fainelli wrote:
>> Enable CONFIG_MTD_BCM63XX_PARTS in arch/mips/configs/bmips_be_defconfig
>> since this is a necessary option to parse the built-in flash partition
>> table on BMIPS big-endian SoCs (Cable Modem and DSL).
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/mips/configs/bmips_be_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
>> index 24dcb90b0f64..acf7785c4cdb 100644
>> --- a/arch/mips/configs/bmips_be_defconfig
>> +++ b/arch/mips/configs/bmips_be_defconfig
>> @@ -36,6 +36,7 @@ CONFIG_DEVTMPFS_MOUNT=y
>>  CONFIG_PRINTK_TIME=y
>>  CONFIG_BRCMSTB_GISB_ARB=y
>>  CONFIG_MTD=y
>> +CONFIG_MTD_BCM63XX_PARTS=y
> 
> ^^ This doens't help, AFAICT, because this config doesn't have
> CONFIG_BCM63XX yet, which CONFIG_MTD_BCM63XX_PARTS depends on.
> 
> Or, is that part of what this series will help with: removing the
> dependency on CONFIG_BCM63XX?

Yes, I was assuming this would be relative to the patch series below so
this driver gets usable on BMIPS as well.

I leave to you and Ralf to resolve how you want to pick up patches in
this series and resolve the merge.

> 
> http://lists.infradead.org/pipermail/linux-mtd/2015-December/064380.html
> 
> Brian
> 
>>  CONFIG_MTD_CFI=y
>>  CONFIG_MTD_CFI_INTELEXT=y
>>  CONFIG_MTD_CFI_AMDSTD=y
>> -- 
>> 2.1.0
>>


-- 
Florian

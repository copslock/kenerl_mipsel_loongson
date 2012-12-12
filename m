Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 15:58:55 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:59815 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823128Ab2LLO6yR-s3A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 15:58:54 +0100
Received: by mail-la0-f49.google.com with SMTP id r15so691340lag.36
        for <multiple recipients>; Wed, 12 Dec 2012 06:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BrdTQJz6fgVJLsVXw4sLcITUwP+9RBYNq4X7KTnIur4=;
        b=vAu+cDGxfxs1zpNnIf3HxsnMhSqMWUNecTkVVsScTHvzNz6TPFFlCL8iATvd+TxV+C
         THz9NDoOfYTGDsnL+TTseIhSz9v0syv0qa0+tx7SDHGAZ164qzDxX9TSRtlxy8kEeSB0
         hh1lMclEYuXLiq7Jlpl1qrddNhSVL9tvPrHfMsYnDLOeWNm3RfHneWCfBGa4/yCNNKDS
         2qKPz5zKKjCUQRZs5xIz1bduOUz4UMQXSLJokWArw7P7vtY1qYMuyZs4zFbp03bJjGBj
         acDL3SLJLX1nC+p6d+CHdmJM4cG7CMMjorYiYYEqSsN1ZcCXJ1fXgFKL02kdytwQfbNd
         OGOw==
Received: by 10.112.103.202 with SMTP id fy10mr562164lbb.13.1355324328489;
        Wed, 12 Dec 2012 06:58:48 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id fe4sm4786613lbb.1.2012.12.12.06.58.47
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 06:58:47 -0800 (PST)
Message-ID: <50C89B2C.1070903@openwrt.org>
Date:   Wed, 12 Dec 2012 15:56:44 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] OF: MIPS: sead3: Implement OF support.
References: <1354857297-28863-1-git-send-email-sjhill@mips.com> <50C894D4.4090008@openwrt.org> <50C89A6C.705@metafoo.de>
In-Reply-To: <50C89A6C.705@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Le 12/12/12 15:53, Lars-Peter Clausen a écrit :
> On 12/12/2012 03:29 PM, Florian Fainelli wrote:
>> Hello Steven,
>>
>> Le 12/07/12 06:14, Steven J. Hill a écrit :
>> [snip]
>>
>>> +/ {
>>> +    #address-cells = <1>;
>>> +    #size-cells = <1>;
>>> +    compatible = "mips,sead-3";
>>> +
>>> +    cpus {
>>> +        cpu@0 {
>>> +            compatible = "mips,mips14Kc,mips14KEc";
>>> +        };
>> You probably want this the other way around:
>>
>> mips14KEc,mips14Kc,mips
>>
>> you should always have the left-most string being the most descriptive about
>> the hardware and the last one being the less descriptive and thus less
>> "specializing" in order to be backward compatible.
> This is one compatible string though, what you describe is for when use
> multiple compatible string. E.g.
> compatible = "mips14KEc", "mips14Kc", "mips";
>
> The "mips" in Stevens patch is probably the vendor prefix. Maybe a more
> correct compatible would be.
>
> compatible = "mips,mips14KEc", "mips,mips14Kc";

Right, this should be the proper compatible string. Steven's patch does 
not make any use of this compatible string right now anyway.

>
> But in anyway the patch should also add documentation under
> Documentation/devicetree/bindings describing the binding.
>
Obviously
--
Florian

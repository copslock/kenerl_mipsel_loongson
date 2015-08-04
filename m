Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 14:18:31 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34772 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012355AbbHDMS2odl4J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 14:18:28 +0200
Received: by wibud3 with SMTP id ud3so174442225wib.1;
        Tue, 04 Aug 2015 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=N1ZXHWyM11px6WnDu3grK1qmL//rFE9mg9+o175FV7I=;
        b=cH+zZNc8IRRN0O0OvkfWSwVhDLODbto3wVwXaZIEfioKhW7XPHDAWFRtx5QwT7WKyl
         qmpW2cA+JP2IdoqJvHvCwcNSEyiB7BVrINN3+LndBSbXXNcNKd18roORCjTRG3HIifhy
         Lhp1NBnvT1eCbIQu7GsHlPhN1+mFVJ1VMIFOz36kq2UijxJr/N22NnHJMYt5X7cM++8e
         kKJTtUlSJfqgGBcUQ4bibHX4yej0L1rzTTuboGy9dDRrZ3BzmhY8+2Amgc0jAHpqhZmT
         uHYmmwYnz0485dToIy4/JF2UzsPbgx6Z10f4q7LXEoo1oY/DH4Apm5Vqc/R+5c5A9vuc
         KyrA==
X-Received: by 10.180.182.33 with SMTP id eb1mr7309675wic.8.1438690702166;
        Tue, 04 Aug 2015 05:18:22 -0700 (PDT)
Received: from [192.168.1.14] (blg183.neoplus.adsl.tpnet.pl. [83.28.200.183])
        by smtp.gmail.com with ESMTPSA id fb3sm2091362wib.21.2015.08.04.05.18.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Aug 2015 05:18:21 -0700 (PDT)
Message-ID: <55C0AD8C.8090306@gmail.com>
Date:   Tue, 04 Aug 2015 14:18:20 +0200
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Bryan Wu <cooloney@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-leds@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] LED/MIPS: Move SEAD3 LED driver to where it belongs.
References: <20150803150401.GD2843@linux-mips.org> <55BF89D0.2080303@cogentembedded.com>
In-Reply-To: <55BF89D0.2080303@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jacek.anaszewski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jacek.anaszewski@gmail.com
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

Hi Ralf, Sergei,

On 08/03/2015 05:33 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 08/03/2015 06:04 PM, Ralf Baechle wrote:
>
>> Fixes the following randconfig problem
>
>> leds-sead3.c:(.text+0x7dc): undefined reference to
>> `led_classdev_unregister'
>> leds-sead3.c:(.text+0x7e8): undefined reference to
>> `led_classdev_unregister'
>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Bryan Wu <cooloney@gmail.com>
>> Cc: Richard Purdie <rpurdie@rpsys.net>
>> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
>> Cc: Markos Chandras <markos.chandras@imgtec.com>
>> Cc: linux-leds@vger.kernel.org
>> Cc: linux-mips@linux-mips.org
>
> [...]
>
>> diff --git a/arch/mips/mti-sead3/leds-sead3.c b/drivers/leds/leds-sead3.c
>> similarity index 99%
>> rename from arch/mips/mti-sead3/leds-sead3.c
>> rename to drivers/leds/leds-sead3.c
>> index c938cee..eb97a32 100644
>> --- a/arch/mips/mti-sead3/leds-sead3.c
>> +++ b/drivers/leds/leds-sead3.c
>
>      Oh, so you started to use -M finally. :-)
>
>> @@ -59,6 +59,7 @@ static int sead3_led_remove(struct platform_device
>> *pdev)
>>   {
>>       led_classdev_unregister(&sead3_pled);
>>       led_classdev_unregister(&sead3_fled);
>> +
>
>     Unrelated white space change?

Ralf, please split this change to the separate patch.
You could also reorder include directives to be arranged in
an alphabetical order.

>>       return 0;
>>   }
>
> MBR, Sergei
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Best Regards,
Jacek Anaszewski

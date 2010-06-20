Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2010 03:30:50 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:51225 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491073Ab0FTBar (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Jun 2010 03:30:47 +0200
Received: by pwj6 with SMTP id 6so1110819pwj.36
        for <multiple recipients>; Sat, 19 Jun 2010 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=U5tupSyYqe0SUDRD0W1oFKtB1SpC/prq12mUZ3KtVz8=;
        b=vPMEKr2Osd3ljo2+1Y/3ZarJpEw8QG/C1Hpcv0LZV8+bZT2y/2c5hsJ3LUzFJ+vm5J
         prXv5rijlrJdTrJ1IWXapQTNBIdT0p+hRWZIW4TAIUHZrsw1+S6k0i+7sa4C/J9B45sk
         Nknn+frL7VIWemq8Wg8OdG9bWDspdFnwj3zT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xbweHEPQNahqHFVwdxflMMLZSQJkYSrz1sNWUOaybb5SIoFQgllDpoQ/toseQgYxRv
         Zf+boSkwxxZ/VJanZ23yJK5zB9uuAAT1wAWCf8D+slseMBfdWLg17koFBXOiZYjJERaz
         lJdHsPpIzlQOKdavwcx8aT3WdOFgKeUR5zVEY=
Received: by 10.114.139.6 with SMTP id m6mr2415022wad.91.1276997438241;
        Sat, 19 Jun 2010 18:30:38 -0700 (PDT)
Received: from [192.168.1.4] ([116.238.50.60])
        by mx.google.com with ESMTPS id a23sm129772538wam.14.2010.06.19.18.30.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Jun 2010 18:30:37 -0700 (PDT)
Message-ID: <4C1D6F34.5050703@gmail.com>
Date:   Sun, 20 Jun 2010 09:30:28 +0800
From:   Wan ZongShun <mcuos.com@gmail.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     rtc-linux@googlegroups.com, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: [rtc-linux] [PATCH v3] RTC: Add JZ4740 RTC driver
References: <1276924111-11158-16-git-send-email-lars@metafoo.de> <1276975790-25623-1-git-send-email-lars@metafoo.de> <4C1D6B27.7070408@gmail.com> <4C1D6D76.8030109@metafoo.de>
In-Reply-To: <4C1D6D76.8030109@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcuos.com@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13683

Lars-Peter Clausen :
> Wan ZongShun wrote:
>>> This patch adds support for the RTC unit on JZ4740 SoCs.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>>> Cc: Paul Gortmaker <p_gortmaker@yahoo.com>
>>> Cc: rtc-linux@googlegroups.com
>>>
>>> -- 
>>> Changes since v1
>>> - Use dev_get_drvdata directly instead of wrapping it in dev_to_rtc
>>> - Add common implementation for jz4740_rtc_{alarm,update}_irq_enable
>>> - Check whether rtc structure could be allocated
>>> - Remove deadlocks which could occur if the HW was broken
>>>
>>> Changes since v2
>>> - Use kzalloc instead of kmalloc
>>> - Propagate errors in jz4740_rtc_reg_write up to its callers
>> Acked-by: Wan ZongShun <mcuos.com@gmail.com>
>>
>> Andrew, the v3 patch has fixed some above issues, it looks good to me
>> now.
>> Could you please consider merging it to your git tree?
>>
> Hi
> 
> As written in the introduction mail to this thread it would be good if
> the majority of the patches could go through Ralfs tree.
> So if the patch is good an "Acked-by:" would be preferable.
> 
Okay, Sound like good to me, please do you want to do.
Acked-by: Wan ZongShun <mcuos.com@gmail.com>

> Thanks,
> - Lars
> 
> 
> 

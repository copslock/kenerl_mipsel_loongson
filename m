Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 09:58:01 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:41979
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993256AbeEGH5yFV5tX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 May 2018 09:57:54 +0200
Received: by mail-oi0-x243.google.com with SMTP id 11-v6so24294224ois.8
        for <linux-mips@linux-mips.org>; Mon, 07 May 2018 00:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/VzuEq7u+284TbkrLjTHvh+qrVteUcrV4bO1LSCVkAc=;
        b=kzenOqN4GFagoPS2ESPeEaKhAuUmeouhUK0zGBOf0vyNSe0yByDF+d9P3fWGiJKRNv
         zNnv329X8SUu57eJcJwwSt5EtPOBs5w/s1dpDx6FdLyFmKmcxidPAx0BxF/N0U8LMMoD
         OrjbPeOQhwIZ3aQMZ4hrcNuhg4jT+9yGWxIK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/VzuEq7u+284TbkrLjTHvh+qrVteUcrV4bO1LSCVkAc=;
        b=rZnP026NBKIQb741sKQ5UUkVSf/XnOJ0F1YXWDFF+PQRh09zCdF14Q+xWvnCIK+Lkk
         vOFPhWzhIcNQ2agXwz/NNGGEUZF+z8LyHOImhtrdE1L/yU8pacRoL9c8IBJpeMB3JuLt
         OiSddg3WGFawBpJxDpGPMfFMiysnRfMNVuQ8HZSY9Ovqail1cDKSSbaAr5G8tVgc0ivI
         rwO9GygIwd8LDcL+JE33pul0nlE8JMOv7PX8ds8aOTBXhaV2O1et9bOsIFrKpC9gFztH
         yMLegca/G/xe/pYvqogl7a+BeenK1Zqu2q4wWtmgTtM/RCTUmMhi4cfkV70ZLzg1kG7M
         jRSA==
X-Gm-Message-State: ALQs6tBBZMlbFk20s2TczKafR3Wqllk2TypFtMiOZQiN/NF3dukn2+rV
        dhkI3BBw0Hq6byOC+Szli9RD59WA37ezQzv9ZzkAgw==
X-Google-Smtp-Source: AB8JxZqNVsHDoBkEq5u8b7yXL9VWFcFhCdc5PeXdzqva5QInZFfFFZJolYRgJQAe+s67zwkC5ZAaymfoJ19JZJnWEUc=
X-Received: by 2002:aca:accf:: with SMTP id v198-v6mr22903246oie.320.1525679867728;
 Mon, 07 May 2018 00:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d77:0:0:0:0:0 with HTTP; Mon, 7 May 2018 00:57:47 -0700 (PDT)
In-Reply-To: <CAK8P3a2eXo6MkLLkzQVDtk_W+2x+68iphsX3MXAtzpTYDaREiQ@mail.gmail.com>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
 <2d0bcca30f61036e413ba01c686ce6506f187462.1525417306.git.baolin.wang@linaro.org>
 <CAK8P3a2eXo6MkLLkzQVDtk_W+2x+68iphsX3MXAtzpTYDaREiQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 7 May 2018 15:57:47 +0800
Message-ID: <CAMz4kuJBw3MFvdju7MoLxcW8wJuBbhiXe_TQut2dw2_dpAVQZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, chenhc@lemote.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <baolin.wang@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baolin.wang@linaro.org
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

On 6 May 2018 at 11:04, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, May 4, 2018 at 3:07 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Since struct timespec is not y2038 safe on 32bit machines, this patch
>> converts update_persistent_clock() to update_persistent_clock64() using
>> struct timespec64.
>>
>> The rtc_mips_set_time() and rtc_mips_set_mmss() interfaces were using
>> 'unsigned long' type that is not y2038 safe on 32bit machines, moreover
>> there is only one platform implementing rtc_mips_set_time() and two
>> platforms implementing rtc_mips_set_mmss(), so we can just make them each
>> implement update_persistent_clock64() directly, to get that helper out
>> of the common mips code by removing rtc_mips_set_time() and
>> rtc_mips_set_mmss() interfaces.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Looks good overall, but I still found a bug and one minor issue. With
> those fixed,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>> diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
>> index 9e992cf..934db6f 100644
>> --- a/arch/mips/dec/time.c
>> +++ b/arch/mips/dec/time.c
>> @@ -59,14 +59,15 @@ void read_persistent_clock64(struct timespec64 *ts)
>>  }
>>
>>  /*
>> - * In order to set the CMOS clock precisely, rtc_mips_set_mmss has to
>> + * In order to set the CMOS clock precisely, update_persistent_clock64 has to
>>   * be called 500 ms after the second nowtime has started, because when
>>   * nowtime is written into the registers of the CMOS clock, it will
>>   * jump to the next second precisely 500 ms later.  Check the Dallas
>>   * DS1287 data sheet for details.
>>   */
>> -int rtc_mips_set_mmss(unsigned long nowtime)
>> +int update_persistent_clock64(struct timespec64 now)
>>  {
>> +       time64_t nowtime = now.tv_sec;
>>         int retval = 0;
>>         int real_seconds, real_minutes, cmos_minutes;
>>         unsigned char save_control, save_freq_select;
>
>
> It looks like you now get an invalid 64-bit division in here,
> you have to change it to either use div_u64_rem() or possibly
> time64_to_tm() or rtc_time64_to_tm() (the latter requires
> CONFIG_RTC_LIB).

I will use div_u64_rem() to calculate real_seconds and real_minutes.

>
>> diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
>> index d75c887..061815e 100644
>> --- a/arch/mips/lasat/ds1603.c
>> +++ b/arch/mips/lasat/ds1603.c
>> @@ -98,7 +98,7 @@ static void rtc_write_byte(unsigned int byte)
>>         }
>>  }
>>
>> -static void rtc_write_word(unsigned long word)
>> +static void rtc_write_word(time64_t word)
>>  {
>>         int i;
>>
>
> I would say this function should take a 'u32' argument (or keep the
> unsigned long) to match the name and implementation, but then have a
> type cast in the caller with a comment about the loss of range and overflow
> in y2106.

OK.

>
>> diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
>> index 6f74224..76f7b62 100644
>> --- a/arch/mips/lasat/sysctl.c
>> +++ b/arch/mips/lasat/sysctl.c
>> @@ -73,8 +73,12 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
>>         if (r)
>>                 return r;
>>
>> -       if (write)
>> -               rtc_mips_set_mmss(rtctmp);
>> +       if (write) {
>> +               ts.tv_sec = rtctmp;
>> +               ts.tv_nsec = 0;
>> +
>> +               update_persistent_clock64(ts);
>> +       }
>>
> ... and probably also a comment here to explain that we can't actually use
> the full 64-bit range because of HW limits.
>

OK. Thanks for your comments.

-- 
Baolin.wang
Best Regards

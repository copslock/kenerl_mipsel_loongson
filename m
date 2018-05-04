Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 08:23:26 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:45711
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbeEDGXTwuOJe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2018 08:23:19 +0200
Received: by mail-oi0-x243.google.com with SMTP id b130-v6so18221785oif.12
        for <linux-mips@linux-mips.org>; Thu, 03 May 2018 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tpDAjOk4CfkAwXnsVkyXW8Y7XibRYdiqMPiH5aZEV5g=;
        b=XScgim0YheMkMVyHG+jXQxBfu+LqhkmvVlvMfIx5z7RRFqunrcqzVw1CAPuiS+pIwJ
         Cs+5bpDEnqcW7VVJMXyFkXvwhtwmMl0SBNmZEkOIMwPkccojwv5TAclgE4rrPzoBH9+M
         SskjOPgKpI45PKBRkum51d9wa+rwYAzIasPy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tpDAjOk4CfkAwXnsVkyXW8Y7XibRYdiqMPiH5aZEV5g=;
        b=ml3/fNOQN4Ti5OpYAiyqZ5/Vr+Dn9w4suBX/aas7REWPHPG2+9eYsUGCp2uDiVCKC5
         NKrJ3oVdZ9cpUtikOrZZTrAgi9OWua6QUCQlURoS//1v79USzU/Vr7pIJOtKCVOkhiBS
         32LepWmQlkWTW9ns2t+7+ZAUz4Fo8DT4zlXYfVAw9Ijcc+0KMvUaobOe4oagBif0FD+K
         ltEJ6yQtGn+KZ7oG8NllDjydjbHt6PKEzZOV7Wwdz8Bat9iuLVSU0lmg6bHgUTmETUsb
         jxFD7u309gKUV1SFi+LrbXhty/8EHzCDhyJouhO8UfiAnFQ/Uvwu0cmWIkOOU1+Mct0b
         JcPg==
X-Gm-Message-State: ALQs6tBy4mFHCxCgOzqEWh3vF/sN9Jox/5Lm9AmIgsKNETdaBm14rqNa
        AU4rTftZ6m9JmLFplWWBUbr383DSwCZjbhdekSFHuQ==
X-Google-Smtp-Source: AB8JxZqXJ8L3zu7BbNR7vYwbEG91NzZk7ME8z3daH/yZHi1we1+JMujzGFN2lZ8gmQ+oGKjY3+V36nsJwFkfHseSiKM=
X-Received: by 2002:aca:5e86:: with SMTP id s128-v6mr9009442oib.68.1525414993485;
 Thu, 03 May 2018 23:23:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2d77:0:0:0:0:0 with HTTP; Thu, 3 May 2018 23:23:13 -0700 (PDT)
In-Reply-To: <CAK8P3a3TJ-5+22_CSYjdtL3pXEVHC7t_KzaOX6PG4X_1R1bMxQ@mail.gmail.com>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
 <e8ddeeea84626e43dcac4f0731992cbad932ce7a.1525262725.git.baolin.wang@linaro.org>
 <CAK8P3a3TJ-5+22_CSYjdtL3pXEVHC7t_KzaOX6PG4X_1R1bMxQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 4 May 2018 14:23:13 +0800
Message-ID: <CAMz4ku+WbtBGGcmsYmMexxcBTJONHF3J-T8Sxo7wgHoZZCVt1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
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
X-archive-position: 63860
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

On 4 May 2018 at 06:31, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 2, 2018 at 10:53 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
>> index 17d4cd2..c4e2a1a 100644
>> --- a/arch/mips/include/asm/time.h
>> +++ b/arch/mips/include/asm/time.h
>> @@ -27,8 +27,8 @@
>>   *     rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
>>   *                     to be set.  Used by RTC sync-up.
>>   */
>> -extern int rtc_mips_set_time(unsigned long);
>> -extern int rtc_mips_set_mmss(unsigned long);
>> +extern int rtc_mips_set_time(time64_t);
>> +extern int rtc_mips_set_mmss(time64_t);
>>
>
> I think these should just get removed, and each implementation replaced
> with a direct update_persistent_clock64() function.

I thought this was one minor modification that will reduce the risk of
introducing other issues, but as you suggested we can do some complete
cleanup by removing set_mmss/set_time. OK, I will do that.

>
>> -int update_persistent_clock(struct timespec now)
>> +int update_persistent_clock64(struct timespec64 now)
>>  {
>>         return rtc_mips_set_mmss(now.tv_sec);
>>  }
>
> And this one also removed

Sure.

>
>> @@ -69,7 +69,7 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
>>                 if (rtctmp < 0)
>>                         rtctmp = 0;
>>         }
>> -       r = proc_dointvec(table, write, buffer, lenp, ppos);
>> +       r = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>>         if (r)
>>                 return r;
>>
>> @@ -224,7 +224,7 @@ int proc_lasat_prid(struct ctl_table *table, int write,
>>         {
>>                 .procname       = "rtc",
>>                 .data           = &rtctmp,
>> -               .maxlen         = sizeof(int),
>> +               .maxlen         = sizeof(time64_t),
>>                 .mode           = 0644,
>>                 .proc_handler   = proc_dolasatrtc,
>>         },
>
> Something seems wrong here: time64_t is not the same as 'unsigned long',
> and the 'rtctmp' variable is still 'unsigned int'. Not sure what the right fix
> would be (we don't seem to have a sysctl helper for s64), but the change
> here makes it worse.

After checking again, I agree with you. So I will keep the original code here.

-- 
Baolin.wang
Best Regards

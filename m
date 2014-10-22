Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 20:01:24 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:53030 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012150AbaJVSBV4qO1U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 20:01:21 +0200
Received: by mail-pd0-f182.google.com with SMTP id y10so3922128pdj.41
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LzE3GKJLj83gYmGDGwyCb3nQk+K97lIExwKzaLoub+4=;
        b=XdI5AgxyK6dwR8FG0X+myJcoDZSYbsz+MWa3WKPvrQLxrDXtB32mBME/EXDutr3LUY
         Z2XNP2m+2XoZUXDwLAi2hyoQvlLHDE5QGC0VLJmKO7PjrT4K+nZBLOaKTxJ6mwoCb3D/
         KjW5SuvDltpov90tAYXRIm1xVhuVJ7QN6GyDBy+E+8fq2hByvfpwO0FO3X9Dp7LDjt5a
         0Bfq/UoUxDr7Q8Qa+HwYNEkBzOdVF2fY1ttEdc0XGjeUMKvoj3QbaCsbyYVVG6u52kYL
         PkcGPtDxhoZY+NaH8EN+4vPREbWYrQ+nNTISJkhvsmxwwhxD3kdptpvOhjyTfwQe6nx8
         TZoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LzE3GKJLj83gYmGDGwyCb3nQk+K97lIExwKzaLoub+4=;
        b=PZSEEHQ7gOA6UYMiEPCOWNborttgR/aQmJBwSTdBAfYpJ2AT6Lx8WZKeeEiZBqsNrh
         ah9t6ZxcC5EwjC6ylvUlAlydtsHh2q4UshaSgtA6EB5ii3pI0062rudoE3Tnr3THA7+9
         BD3zfAunafP6/Fo3B4xKoOffmOJfEODMPQyCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LzE3GKJLj83gYmGDGwyCb3nQk+K97lIExwKzaLoub+4=;
        b=b94vnPaOvslfMhhuZv6LcLSmU4A7NSJQgEQH6wNhiq/HTUepFpI2OoXgrx8ghqPGPO
         OQfJpD9+OtYgNLGvzXiP4G/5sFLT6uHdis3CmO5ue3uVwyUyWPhui/N0fakUV29YoKRR
         eQ1ak/aU1hAg4nbzZq0bEc37i9+Ly4eugBLUTCwnUzQLRCfCCYNgmI+FFju6Zn+qWWOI
         GvqjsWk1gzdU90Regdbo3Z8MFyOl+0C+BO0Bfqs+au7/i37WJ2xb23+4IZRIthYWYRBz
         ULDZSwM9u73XXrhlIcNKw0hxqLXuBOHEg9+gsrwgBxm1rDIBifnxei7TB8PLQVd7XQzs
         UX4A==
X-Gm-Message-State: ALoCoQmuLcQ5R4tsrsJ9gqjLdSdS20gKKC41/NstfqLS+e/h36fqa1+e4+nAtXNVDOi+LV+iOcng
MIME-Version: 1.0
X-Received: by 10.67.29.177 with SMTP id jx17mr43692516pad.56.1414000875451;
 Wed, 22 Oct 2014 11:01:15 -0700 (PDT)
Received: by 10.70.118.170 with HTTP; Wed, 22 Oct 2014 11:01:15 -0700 (PDT)
In-Reply-To: <544779F8.2040505@imgtec.com>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
        <1413831846-32100-4-git-send-email-abrestic@chromium.org>
        <544779F8.2040505@imgtec.com>
Date:   Wed, 22 Oct 2014 11:01:15 -0700
X-Google-Sender-Auth: ify3pXF4NnovbWe5l-E4QeBRZJc
Message-ID: <CAL1qeaE=QqHmyAecqdt=9chsLGHU82a-SkgFns0ae-y6Jy24iQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] MIPS: sead3: Stop using GIC REG macros
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paul.burton@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Wed, Oct 22, 2014 at 2:33 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> On 10/20/2014 08:03 PM, Andrew Bresticker wrote:
>>
>> Stop using the REG macros from gic.h and instead use proper iomem
>> accessors.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>   arch/mips/mti-sead3/sead3-int.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/mips/mti-sead3/sead3-int.c
>> b/arch/mips/mti-sead3/sead3-int.c
>> index 69ae185..995c401 100644
>> --- a/arch/mips/mti-sead3/sead3-int.c
>> +++ b/arch/mips/mti-sead3/sead3-int.c
>> @@ -20,16 +20,15 @@
>>   #define SEAD_CONFIG_BASE              0x1b100110
>>   #define SEAD_CONFIG_SIZE              4
>>   -static unsigned long sead3_config_reg;
>> +static void __iomem *sead3_config_reg;
>>     void __init arch_init_irq(void)
>>   {
>>         if (!cpu_has_veic)
>>                 mips_cpu_irq_init();
>>   -     sead3_config_reg = (unsigned
>> long)ioremap_nocache(SEAD_CONFIG_BASE,
>> -               SEAD_CONFIG_SIZE);
>> -       gic_present = (REG32(sead3_config_reg) &
>> SEAD_CONFIG_GIC_PRESENT_MSK) >>
>> +       sead3_config_reg = ioremap_nocache(SEAD_CONFIG_BASE,
>> SEAD_CONFIG_SIZE);
>> +       gic_present = (readl(sead3_config_reg) &
>> SEAD_CONFIG_GIC_PRESENT_MSK) >>
>>                 SEAD_CONFIG_GIC_PRESENT_SHF;
>>         pr_info("GIC: %spresent\n", (gic_present) ? "" : "not ");
>>         pr_info("EIC: %s\n",
>
>
> I think you need to use the __raw_readl() variant here and for all other
> similar changes.

Thanks, will do.

-Andrew

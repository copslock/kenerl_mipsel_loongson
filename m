Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 05:47:20 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63473 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903435Ab2HPDrM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 05:47:12 +0200
Received: by lbbgf7 with SMTP id gf7so1160897lbb.36
        for <multiple recipients>; Wed, 15 Aug 2012 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=VzIT+pOKBGBURYjCpsYFFaKrPltwepyBeYhvKotD3gw=;
        b=azgbP2NttR/4z0qia8K1siIJwLGHPQv7mq4r2yt7BKp4d/ZObh4inPJaPvCgOyJMlM
         zINF2cssRgFsnwiKDLCB2905dg2Xzv/WIz8oJaU/vlMFjL3bjrr1Zh78A2R2NRXeASYb
         Tc5YPHmGIGeXTG3eTGkNrtcErZH2Kg3QHpuA/904AtgEryWMwarKx6R7zpZaCod0CQno
         XbyL3D3nXVqtWOjK/sm7m6sBW9T1rcjOW5DMpgMEAboRh2B0lB6aQKKvQfYS4g0+/qvb
         0cyv3I57zA21Br/P6Lfvh0sO5hrXSb4yDWcqWFTQ+zPs/A9BuoJQb3k7sGIikm8qrXHg
         41HA==
MIME-Version: 1.0
Received: by 10.112.82.33 with SMTP id f1mr58459lby.35.1345088826876; Wed, 15
 Aug 2012 20:47:06 -0700 (PDT)
Received: by 10.152.111.138 with HTTP; Wed, 15 Aug 2012 20:47:06 -0700 (PDT)
In-Reply-To: <20120814114856.GA17040@linux-mips.org>
References: <1344862344-27434-1-git-send-email-chenhc@lemote.com>
        <20120814114856.GA17040@linux-mips.org>
Date:   Thu, 16 Aug 2012 11:47:06 +0800
X-Google-Sender-Auth: N23f4-7LkWKTo8q6OnoFbgQfrlM
Message-ID: <CAAhV-H4rbDp86cnrYn-2t05Sv17=LV6Hfchb=dBSeD3oc6x5kQ@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Yong Zhang <yong.zhang@windriver.com>, stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On Tue, Aug 14, 2012 at 7:48 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Aug 13, 2012 at 08:52:24PM +0800, Huacai Chen wrote:
>
>> When poweroff machine, kernel_power_off() call disable_nonboot_cpus().
>> And if we have HOTPLUG_CPU configured, disable_nonboot_cpus() is not an
>> empty function but attempt to actually disable the nonboot cpus. Since
>> system state is SYSTEM_POWER_OFF, play_dead() won't be called and thus
>> disable_nonboot_cpus() hangs. Therefore, we make this patch to avoid
>> poweroff failure.
>
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index e9a5fd7..69b17a9 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -72,9 +72,7 @@ void __noreturn cpu_idle(void)
>>                       }
>>               }
>>  #ifdef CONFIG_HOTPLUG_CPU
>> -             if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
>> -                 (system_state == SYSTEM_RUNNING ||
>> -                  system_state == SYSTEM_BOOTING))
>> +             if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))
>
> Looks good - but I'm wondering if the "!cpu_isset(cpu, cpu_callin_map)"
> can be removed as well?
I removed "!cpu_isset(cpu, cpu_callin_map)" and it works well on
Loongson, but I don't know whether it will affect cavium-octeon...

>
> Also, which -stable branches is this patch applicable?
>
>   Ralf
>

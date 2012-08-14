Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 16:24:36 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45341 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903669Ab2HNOY3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 16:24:29 +0200
Received: by lbbgf7 with SMTP id gf7so257670lbb.36
        for <multiple recipients>; Tue, 14 Aug 2012 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Q/o1rFV1LG7kCmY/t0T98tzzzUre3tu2hZizdNYnh8g=;
        b=M6UGzd9sLMNKrLMumU4z1uxQohro0if5ni9aEPZE0TWS4n/lJ2wZZpyrRB9i1U8PF+
         +hYs66X6XJhsdvmCAhlXpOi7xN9EvyA918JXCF3Cp758cU+rMupQvjrxmK4JmFXQl/Iy
         S/T0jApEtvEzOpzPAlAaECapwzgPt7FyGN4Vi3G10CJ8sQLpf5SAyvfzwzOAWrbc8/Rt
         9JqimXa/ToJ9SmRupWgwb9PfQNI/h1Hm7VExwG3PygvUJzuhdzsJJV/Ibth3aMMhnSGs
         QwAsht5qEPIZPp2nxFxKWu4sxpPWl+cP4uQOReneezQRv/KPrOKlpepuznDAwVjJ4kSo
         Ck6g==
MIME-Version: 1.0
Received: by 10.152.110.46 with SMTP id hx14mr3479267lab.21.1344954263432;
 Tue, 14 Aug 2012 07:24:23 -0700 (PDT)
Received: by 10.152.111.138 with HTTP; Tue, 14 Aug 2012 07:24:23 -0700 (PDT)
In-Reply-To: <20120814114856.GA17040@linux-mips.org>
References: <1344862344-27434-1-git-send-email-chenhc@lemote.com>
        <20120814114856.GA17040@linux-mips.org>
Date:   Tue, 14 Aug 2012 22:24:23 +0800
X-Google-Sender-Auth: OdjvaVSow-eFKblR3wnQTBWGSpk
Message-ID: <CAAhV-H7s0Fc0TVLaJoVWschvoZGnZtiQ1X1fS61H_+=a5Tc0Aw@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Yong Zhang <yong.zhang@windriver.com>, stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34158
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
For X86, IA64, ARM, SPARC64 and most other arch, "!cpu_online(cpu)" is
the only condition of play_dead(). I keep "!cpu_isset(cpu,
cpu_callin_map)" because this does't refuse poweroff and I don't know
why the old condition of play_dead() is so complex.

>
> Also, which -stable branches is this patch applicable?
3.3, 3.4 and 3.5 branch can use it, 3.2 and earlier kernels should do
some small changes.

>
>   Ralf
>

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 12:51:17 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43840 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903655Ab2FSKvN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jun 2012 12:51:13 +0200
Received: by lbbgg6 with SMTP id gg6so5873721lbb.36
        for <multiple recipients>; Tue, 19 Jun 2012 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZpC7sTvnzu8pgkF8RWX4ul3erXw8uXLvj8xgFDVbzo4=;
        b=xQtsamDcyxusERHIrIHoVwlXO5lwAmX/0qk6pWxSUQneqZdrBcz/NGMph5JaCnHowg
         vJG5VbMIIyLJCHIv8WQ5eyREAxn8vWrcvd23Ark2DnvTgTEb94ByJkB12T7xI339IgXq
         cWnyzKzdp9LDoLNITK0Go0OsnWZ68UfDCiIIfJAX9tm+12PcSyoucd0zzWhOjQFuQcA0
         AKbBw2qTXj7NRiB0caVPDk2Sweo4g5OYtAx8t2bhTBl8s+eKrWoccN+dzk/vUDmd4F+V
         xvxB2hksHfce/DaJFU9vx5MtNdAYBnUJwZbnxEGPLFcy6rG0mBIiOz2JEtlsmDfJ8m7a
         6xYA==
MIME-Version: 1.0
Received: by 10.112.37.71 with SMTP id w7mr8067497lbj.2.1340103067768; Tue, 19
 Jun 2012 03:51:07 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Tue, 19 Jun 2012 03:51:07 -0700 (PDT)
In-Reply-To: <20120619093113.GB305@windriver.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-16-git-send-email-chenhc@lemote.com>
        <20120619093113.GB305@windriver.com>
Date:   Tue, 19 Jun 2012 18:51:07 +0800
Message-ID: <CAAhV-H5cErPcKYV1Onc-b5S4qRunKbwZOACe2B8NLF0af6TrZQ@mail.gmail.com>
Subject: Re: [PATCH V2 15/16] MIPS: Loongson 3: Add CPU Hotplug support.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Yong Zhang <yong.zhang@windriver.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

On Tue, Jun 19, 2012 at 5:31 PM, Yong Zhang <yong.zhang@windriver.com> wrote:
> On Tue, Jun 19, 2012 at 02:50:23PM +0800, Huacai Chen wrote:
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index e9a5fd7..69b17a9 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -72,9 +72,7 @@ void __noreturn cpu_idle(void)
>>                       }
>>               }
>>  #ifdef CONFIG_HOTPLUG_CPU
>> -             if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
>> -                 (system_state == SYSTEM_RUNNING ||
>> -                  system_state == SYSTEM_BOOTING))
>> +             if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))
>>                       play_dead();
>
> I think patch like this should be separated from BSP code.
>
> BTW, what's the story behind this change?
When poweroff, disable_nonboot_cpus() is called, and if HOTPLUG_CPU is
configured, disable_nonboot_cpus() is not an empty function but try to
offline nonboot cores. If without this change, poweroff fails.

>
> Thanks,
> Yong

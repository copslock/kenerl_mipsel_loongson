Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 19:57:47 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:37655 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903633Ab2EQR5i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 19:57:38 +0200
Received: by lbbgg6 with SMTP id gg6so1897877lbb.36
        for <linux-mips@linux-mips.org>; Thu, 17 May 2012 10:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=AIH9icvXfQeCjf2FcwOfqEV9nUQJXQ51G0GNXBTpODY=;
        b=UBsygHD97LQ1GdtWW3hUu6sOTrg0kE8NZ73Vy775xvlLcLWGeORlDKA4JFys2z/wru
         xQ1RQ18OLXYz0103Pd59C5Al9wu/56JprDslp4skPCFOb7849LTCKNTepzISrBHvlV/a
         wX4QPh98MnugDBe47zj+cgTPSpXUzfReXRT1IjEwwR3kxQtmga6E/zQtpRP/dw8oph3b
         dte/UtzTgzDquV1pCh+kD2DszQfllD2/sf3rXxNzWh6vmQ6amDb0KAyPQgL2M1tTsxS7
         F6m4OLMTmD/ZSc3xNSCMAw2XUSukHanDXdhqafE7rTS7rRwp0gVUxIr94TK9F895Fg+W
         5m0Q==
Received: by 10.152.105.235 with SMTP id gp11mr7956368lab.44.1337277452539;
        Thu, 17 May 2012 10:57:32 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id gv8sm8703072lab.14.2012.05.17.10.57.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 10:57:31 -0700 (PDT)
Message-ID: <4FB53BC2.7060300@mvista.com>
Date:   Thu, 17 May 2012 21:56:18 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     Yong Zhang <yong.zhang0@gmail.com>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] patchset focus on MIPS SMP woes
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com> <4FB523C1.4070902@cavium.com>
In-Reply-To: <4FB523C1.4070902@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnr0YukQEoS4s8rcyK1IseO5gcosZSOFVQyuchuNpFPYhf5VBYj7TM0ment5OpZ3YIrXSmj
X-archive-position: 33354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/17/2012 08:13 PM, David Daney wrote:

>> From: Yong Zhang<yong.zhang@windriver.com>

>> Since commit 5fbd036b [sched: Cleanup cpu_active madness] and
>> commit 2baab4e9 [sched: Fix select_fallback_rq() vs cpu_active/cpu_online],
>> it's more safe to put notify_cpu_starting() and set_cpu_online() with
>> irq disabled, otherwise we will have a typical race condition which
>> above two commits try to resolve:

>> CPU1 CPU2
>> __cpu_up();
>> mp_ops->boot_secondary();
>> start_secondary();
>> ->init_secondary();
>> local_irq_enable();
>> <IRQ>
>> do something;
>> wake up softirqd;
>> try_to_wake_up();
>> select_fallback_rq();
>> /* select wrong cpu */
>> set_cpu_online();


>> This patchset fix the above issue as well as set_cpu_online is
>> called on the caller cpu.

>> BTW, I'm only running it on Cavium board because of limited source,
>> so if anyone is interested to test it on other board, that's great :)

>> Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>

>> Yong Zhang (8):
>> MIPS: Octeon: delay enable irq to ->smp_finish()
>> MIPS: BMIPS: delay irq enable to ->smp_finish()
>> MIPS: SMTC: delay irq enable to ->smp_finish()
>> MIPS: Yosemite: delay irq enable to ->smp_finish()
>> MIPS: call ->smp_finish() a little late
>> MIPS: call set_cpu_online() on the uping cpu with irq disabled
>> MIPS: smp: Warn on too early irq enable
>> MIPS: sync-r4k: remove redundant irq operation

> This entire patch set (modulo the change log grammar items noted by Sergei):

    I noted not only change log grammar, also comment grammar. And a missing 
summary in commit reference. :-)

> Acked-by: David Daney <david.daney@cavium.com>

WBR, Sergei

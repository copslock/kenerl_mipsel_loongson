Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2012 19:50:32 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:34911 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902755Ab2HRRuZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2012 19:50:25 +0200
Received: by eekc13 with SMTP id c13so1162624eek.36
        for <multiple recipients>; Sat, 18 Aug 2012 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5cbwiIiBjZYJxobxgmPJR56stCDW7dhU+YFdIT8yItM=;
        b=vlycQ3EGpPsBFeoOmUhZsfe21xg2/Q3Ehw3q+BozfsGAcnaSAPfNo0thndzXmt89R5
         acAoUfyH+p4adCTwR9EzYALzYCd9WJ1XMJvFGaWoUDrNI/p15Two9z+ywCozpMVVwUWh
         I7cYnv5Fb2xZOzrNDKCoERY4y++7uWbRKHJ5HWLramC4J679tETOeyb/iBj7HsxcvLgq
         YzOjEwfARm9fxwVA1f08ucW4ioOnT3Q4UOCBXMmPV0wFzXnlR8Uzt5SFV6YMvF3+b5rK
         gfeQTxSyEWfAgWOjcYVnUu2+8Q9iXhqKFu2+cBaRpjWxr2cD1zpeNOY//kjI58mmdU99
         CWig==
MIME-Version: 1.0
Received: by 10.14.1.9 with SMTP id 9mr2082924eec.9.1345312220388; Sat, 18 Aug
 2012 10:50:20 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Sat, 18 Aug 2012 10:50:20 -0700 (PDT)
In-Reply-To: <1344862344-27434-1-git-send-email-chenhc@lemote.com>
References: <1344862344-27434-1-git-send-email-chenhc@lemote.com>
Date:   Sat, 18 Aug 2012 10:50:20 -0700
Message-ID: <CAJiQ=7DGRxHp2hv79xpBdB_gV=iTiQaap=aytMe8=cNcm29Vrg@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Yong Zhang <yong.zhang@windriver.com>, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Aug 13, 2012 at 5:52 AM, Huacai Chen <chenhc@lemote.com> wrote:
> When poweroff machine, kernel_power_off() call disable_nonboot_cpus().
> And if we have HOTPLUG_CPU configured, disable_nonboot_cpus() is not an
> empty function but attempt to actually disable the nonboot cpus. Since
> system state is SYSTEM_POWER_OFF, play_dead() won't be called and thus
> disable_nonboot_cpus() hangs. Therefore, we make this patch to avoid
> poweroff failure.

I have seen the same problem; sometimes it causes a kernel oops too.

>  #ifdef CONFIG_HOTPLUG_CPU
> -               if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
> -                   (system_state == SYSTEM_RUNNING ||
> -                    system_state == SYSTEM_BOOTING))
> +               if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))
>                         play_dead();

This fix works for me.

Acked-by: Kevin Cernekee <cernekee@gmail.com>

I do see SMP boot problems ("Attempted to kill the idle task!" panic)
on a 4-way box if the !cpu_isset() check is removed.

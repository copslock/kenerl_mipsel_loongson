Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 04:45:39 +0100 (CET)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33021 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006543AbbC0Dpdx2a2J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2015 04:45:33 +0100
Received: by wgel2 with SMTP id l2so1515271wge.0;
        Thu, 26 Mar 2015 20:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Is5AjzKuvjEKcw2feJk/JvdUrOXSEzuhGsBefKSnG4g=;
        b=iNI91R/KbiL7XQkTFdPU6NO/66yzEf5YXEaC1B6mP8KKm5eNJBP5bHS5XX8CwyfEbv
         hmmshWzGF1H3yw93yRb3ER6U/VqSqro9hBr9EePEkfX5TfjL+dYTk6aAtPazqDowEnPz
         bjpc+xPi+9315LwYLLEXTJbLnoee9NDToWWEANkQMgpTbmd7W2iyTYknjOJFTA1PYkHC
         zu6KqwPzQvbA4rnzuEJuqVCvvr9ACiYP+nkM6KPm2MrVuevKLJPwh2HGALTEhCH4JLKL
         EDJQkRcmcBXyh9EJOvl8Yk59VOCgPDstR9VefKYs1npD4bdQGUv09sPyiOzYtnMiSXQb
         nDPw==
MIME-Version: 1.0
X-Received: by 10.194.110.38 with SMTP id hx6mr33158861wjb.128.1427427929506;
 Thu, 26 Mar 2015 20:45:29 -0700 (PDT)
Received: by 10.28.62.131 with HTTP; Thu, 26 Mar 2015 20:45:29 -0700 (PDT)
In-Reply-To: <20150326130517.GD9705@linux-mips.org>
References: <1426213836-28600-1-git-send-email-chenhc@lemote.com>
        <20150326130517.GD9705@linux-mips.org>
Date:   Fri, 27 Mar 2015 11:45:29 +0800
X-Google-Sender-Auth: v-gSVtdph7QLYaJYSpTmdyHqRXM
Message-ID: <CAAhV-H6GsdmiC=bGXdYmMP4EAtDNcf_GC8i19U8=hJGZf8BW-g@mail.gmail.com>
Subject: Re: [PATCH V8 8/8] MIPS: Loongson: Make CPUFreq usable for Loongson-3
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-pm@vger.kernel.org,
        Hongliang Tao <taohl@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46562
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

Hi, Ralf,

This is a problem, but it seems not a very big problem. Because X86
also use percpu's loops_per_jiffy to implement udelay(), and percpu's
loops_per_jiffy also adjusted after cpufreq transition.

Please look at arch/x86/lib/delay.c, arch/x86/kernel/tsc.c.

Huacai

On Thu, Mar 26, 2015 at 9:05 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Mar 13, 2015 at 10:30:36AM +0800, Huacai Chen wrote:
>
>> Loongson-3A/3B support frequency scaling. But due to hardware
>> limitation, Loongson-3A's frequency scaling is not independent for
>> each core, we suggest enable Loongson-3A's CPUFreq only when there is
>> one core online. Loongson-3B can adjust frequency independently for
>> each core, so it can be always enabled.
>>
>> Each package has only one register (ChipConfig or FreqCtrl) to control
>> frequency, so we need spinlocks to protect register access for multi-
>> cores. However, we cannot use spinlock when a core becomes into "wait"
>> status (frequency = 0), so we only enable "wait" when there is one core
>> in a package online.
>>
>> arch/mips/kernel/smp.c is modified to guarantee udelay_val has the
>> correct value while both CPU hotplug and CPUFreq are enabled.
>
> With clockscaling you have a fundamental problem with udelay.  If the clock
> is increased for a CPU that already has computed the number of iterations
> of the delay loop for the old, lower clock rate, it is possible that
> udelay won't wait for long enough.
>
> The opposite case would result in waiting too long but that's not a big
> problem as udelay only guarantees a minimum waiting time.
>
> So you probably need a different delay mechanism than the classic delay
> loop on SMP with clockscaling.
>
>   Ralf
>

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2014 19:33:59 +0200 (CEST)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:40850 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6875432AbaHGRdszgD2R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Aug 2014 19:33:48 +0200
Received: by mail-ig0-f181.google.com with SMTP id h3so4853080igd.14
        for <multiple recipients>; Thu, 07 Aug 2014 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=47zCfPyD3FKNWpbglS30eI1a7gc/2A0L13MjuyCPUd8=;
        b=wlX4oIsgudkW2/Wmsf2a+jmolR3/JjuFWiRKcG5kos2Kg412ilSUz6fEByoATI+56N
         ehsyjis1qjG7PK/lFduMLgQkG3/GeDj4WrxHQkKk/fCtj1FWuGXs+SW6ohN6L/D+Gr0/
         VoZk96VWL2rBFjEhLMen747+PMuQndu9gHlRYeT2hvKYHFAkUczdLuYHKFmr996LRw2G
         NWiKaVDsDnpXzHVZKfrjc/oWsWLHFTOSiWv6EImVt4e1mrhD6LHGw1RRrcEEafKQJp2I
         YmEh1Oq/8VXk3IlJ9GjIqWUZyfZHI775I2i7Qchg/PblZKh2+Q9nBpSBjozyM348K0VR
         UZ0g==
X-Received: by 10.50.43.164 with SMTP id x4mr27819108igl.27.1407432822612;
        Thu, 07 Aug 2014 10:33:42 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ka6sm1943178igb.8.2014.08.07.10.33.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 10:33:41 -0700 (PDT)
Message-ID: <53E3B874.80008@gmail.com>
Date:   Thu, 07 Aug 2014 10:33:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Wei.Yang@windriver.com, a.p.zijlstra@chello.nl, paulus@samba.org,
        mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v1] MIPS: perf: Mark pmu interupt IRQF_NO_THREAD
References: <1407217067-1144-1-git-send-email-Wei.Yang@windriver.com> <20140807114831.GB29898@linux-mips.org>
In-Reply-To: <20140807114831.GB29898@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 08/07/2014 04:48 AM, Ralf Baechle wrote:
> On Tue, Aug 05, 2014 at 01:37:47PM +0800, Wei.Yang@windriver.com wrote:
>
>> From: Yang Wei <Wei.Yang@windriver.com>
>>
>> In RT kernel, I ran into the following calltrace, so PMU interrupts cannot
>> be threaded
>>
>> in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/0
>> INFO: lockdep is turned off.
>> Call Trace:
>> [<ffffffff8088595c>] dump_stack+0x1c/0x50
>> [<ffffffff801a958c>] __might_sleep+0x13c/0x148
>> [<ffffffff80891c54>] rt_spin_lock+0x3c/0xb0
>> [<ffffffff801ad29c>] __wake_up+0x3c/0x80
>> [<ffffffff80243ba4>] perf_event_wakeup+0x8c/0xf8
>> [<ffffffff80243c50>] perf_pending_event+0x40/0x78
>> [<ffffffff8023d88c>] irq_work_run+0x74/0xc0
>> [<ffffffff80152640>] mipsxx_pmu_handle_shared_irq+0x110/0x228
>> [<ffffffff8015276c>] mipsxx_pmu_handle_irq+0x14/0x30
>> [<ffffffff801ffda4>] handle_irq_event_percpu+0xbc/0x470
>> [<ffffffff80204478>] handle_percpu_irq+0x98/0xc8
>> [<ffffffff801ff284>] generic_handle_irq+0x4c/0x68
>> [<ffffffff8089748c>] do_IRQ+0x2c/0x48
>> [<ffffffff80105864>] plat_irq_dispatch+0x64/0xd0
>
> Hm...  I don't see why based on this backtrace you concluce the
> handler needs to be marked IRQF_NO_THREAD.  However there's another
> reason to mark it IRQF_NO_THREAD.  IRQ threads may be rescheduled to
> other CPUs but this handler is fiddling with per-CPU resources.
>

Also by its nature, the profiling code needs synchronous access to the 
register state of the interrupted code.  If you are running on a 
different thread, then I don't think this would be available.

> See https://patchwork.linux-mips.org/patch/2818/ for a similar
> scenario a few years ago.
>
>    Ralf
>
>

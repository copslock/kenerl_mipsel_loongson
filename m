Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jul 2018 01:50:23 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:39171
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990945AbeGMXuQOL30b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Jul 2018 01:50:16 +0200
Received: by mail-oi0-x241.google.com with SMTP id d189-v6so65210916oib.6;
        Fri, 13 Jul 2018 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hUf/o21pbN/wqjp3RMv4x0Lv8IGoryFqN+JLzDari6o=;
        b=gBpQNfQcABvsGp6kvGfY2U3DBgqMhOMSdTTWFRqC4J8mFxkQaTBd0b8Rts8QaV/BcB
         RLnZHrPDoTpkXm6O7pFi3TTB8qR1lpNo+kr2yEQ5TUC8QO2wwzmAKmYJhMlEwKaStoDD
         7sGJKw5Xv3lltEssCNZrNmYaMJgvtDjyNdNgyzUKd+zMJ5K8lbKs6SItxqyj3yfOaSAP
         hQ+u+jJrP+moFpRC7MIbcwBRBARF5QYT4hy74DrgBF73OWuFbRgMumNiCRh6UUhb1JzI
         r3ZSM4P3pUAPHgtqs1EkcDmwAkfiQEjKThAUETdYJ8ZUCzT7xyoYZfzgcD5CC17/ToUH
         lcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hUf/o21pbN/wqjp3RMv4x0Lv8IGoryFqN+JLzDari6o=;
        b=WkBm47MtsCXsgFJaSvzvlpC9qQ1tmprR3AdatndmDpV50M2s5EKSvPPXnOnbNbkB0H
         HHBuMw22FHT3Ech8RMH/51X2UjWj35wZNP6gxdtW+aJjrJEbOd77kZMpdrULGtbot4iK
         8qL2RjUo9ICykcJ8U9kRMfbThAvB1vXVvhyVkN4h8WpRV/rym0T9Qjcgi12n1pUb4v6S
         yzRgXMIA5trdz9wQWMYGPKtp2+/DOlYFHvUVtLPQ4VVvaG9guOBpx1TB/gtkjRreYxU7
         SO0FnaK+vaZpq1cbbQ0clzC+dIhR+pwu1KME2mq172K+LT8I8dL+iTAN2k8JsPfx/zQc
         SQMw==
X-Gm-Message-State: AOUpUlHtqB56O8N9dt8UPt6ty1TMZh6Y0I9hzy3pdluiBL3sz/TSR18u
        DbobMbaN+oBpTe3G/7+1PJGYhbSOfeqEFaFhnZo=
X-Google-Smtp-Source: AAOMgpdU6yD87M58cppkdz+YTdqrTgDYBOXEP1ZMdvahKEQwBarrBc47PWvztwOaAeGfgTmysjufXqmV92WDyKRHi6E=
X-Received: by 2002:aca:ef87:: with SMTP id n129-v6mr9503995oih.161.1531525809726;
 Fri, 13 Jul 2018 16:50:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5e0c:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 16:50:09
 -0700 (PDT)
In-Reply-To: <9b062a19-d9a7-b360-26b1-d28b8dfc35a3@linux.ibm.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com> <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com> <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com> <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com> <20180712145849.GB15265@redhat.com>
 <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com> <9b062a19-d9a7-b360-26b1-d28b8dfc35a3@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 13 Jul 2018 16:50:09 -0700
Message-ID: <CAPhsuW5njYcYXxYYEUsdVWem3qwk2z_bra_eRpwHwEy9TA-LHQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <liu.song.a23@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liu.song.a23@gmail.com
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

On Fri, Jul 13, 2018 at 12:55 AM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Hi Song,
>
> On 07/13/2018 01:23 AM, Song Liu wrote:
>> I guess I got to the party late. I found this thread after I started developing
>> the same feature...
>>
>> On Thu, Jul 12, 2018 at 7:58 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 07/11, Ravi Bangoria wrote:
>>>>
>>>>> However, I still think it would be better to avoid uprobe exporting and modifying
>>>>> set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
>>>>> I'll re-check...
>>>>
>>>> Good that you bring this up. Actually, we can implement same logic
>>>> without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
>>>> in uprobe_write_opcode(). No need to export struct uprobe outside,
>>>> no need to change set_swbp() / set_orig_insn() syntax. Just that we
>>>> need to pass arch_uprobe object to uprobe_write_opcode().
>>>
>>> Yes, but you still need to modify set_swbp/set_orig_insn to pass the new
>>> arg to uprobe_write_opcode(). OK, this is fine.
>>>
>>>
>>>> But, I wanted to discuss about making ref_ctr_offset a uprobe property
>>>> or a consumer property, before posting v6:
>>>>
>>>> If we make it a consumer property, the design becomes flexible for
>>>> user. User will have an option to either depend on kernel to handle
>>>> reference counter or he can create normal uprobe and manipulate
>>>> reference counter on his own. This will not require any changes to
>>>> existing tools. With this approach we need to increment / decrement
>>>> reference counter for each consumer. But, because of the fact that our
>>>> install_breakpoint() / remove_breakpoint() are not balanced, we have
>>>> to keep track of which reference counter have been updated in which
>>>> mm, for which uprobe and for which consumer. I.e. Maintain a list of
>>>> {uprobe, consumer, mm}.
>>
>> Is it possible to maintain balanced refcount by modifying callers of
>> install_breakpoint() and remove_breakpoint()? I am actually working
>> toward this direction. And I found some imbalance between
>>      register_for_each_vma(uprobe, uc)
>> and
>>      register_for_each_vma(uprobe, NULL)
>>
>> From reading the thread, I think there are other sources of imbalance.
>> But I think it is still possible to fix it? Please let me know if this is not
>> realistic...
>
>
> I don't think so. It all depends on memory layout of the process, the
> execution sequence of tracer vs target, how binary is loaded or how mmap()s
> are called. To achieve a balance you need to change current uprobe
> implementation. (I haven't explored to change current implementation because
> I personally think there is no need to). Let me show you a simple example on
> my Ubuntu 18.04 (powerpc vm) with upstream kernel:
>
> -------------
>   $ cat loop.c
>     #include <stdio.h>
>     #include <unistd.h>
>
>     void foo(int i)
>     {
>             printf("Hi: %d\n", i);
>             sleep(1);
>     }
>
>     void main()
>     {
>             int i;
>             for (i = 0; i < 100; i++)
>                     foo(i);
>     }
>
>   $ sudo ./perf probe -x ~/loop foo
>   $ sudo ./perf probe install_breakpoint uprobe mm vaddr
>   $ sudo ./perf probe remove_breakpoint uprobe mm vaddr
>
>   term1~$ ./loop
>
>   term2~$ sudo ./perf record -a -e probe:* -o perf.data.kprobe
>
>   term3~$ sudo ./perf record -a -e probe_loop:foo
>           ^C
>
>   term2~$ ...
>           ^C[ perf record: Woken up 1 times to write data ]
>           [ perf record: Captured and wrote 0.217 MB perf.data.probe (10 samples) ]
>
>   term2~$ sudo ./perf script -i perf.data.kprobe
>     probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
>     probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
>     probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5055500 vaddr=0x7fffa2620844
>     probe:install_breakpoint: (c00000000032e4e8) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5055500 vaddr=0x7fffa2620844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108e0844
>      probe:remove_breakpoint: (c00000000032e938) uprobe=0xc0000000a40d0e00 mm=0xc0000000b5072900 vaddr=0x1108d0844
> -------------
>
> Here install_breakpoint() for our target (mm: 0xc0000000b5072900) was
> called 2 times where as remove_breakpoint() was called 6 times.
>
> Because, there is an imbalance, and if you make reference counter a
> consumer property, you have two options. Either you have to fix
> current uprobe infrastructure to solve this imbalance. Or maintain
> a list of already updated counter as I've explained(in reply to Oleg).
>
> Now,
>
>   uprobe_register()
>     register_for_each_vma()
>       install_breakpoint()
>
> gets called for each consumer, but
>
>   uprobe_mmap()
>     install_breakpoint()
>
> gets called only once. Now, if you make ref_ctr_offset a consumer
> property, you have to increment reference counter for each consumer
> in case of uprobe_mmap(). Also, you have to make sure you update
> reference counter only once for each consumer because install/
> remove_breakpoint() are not balanced. Now, what if reference
> counter increment fails for any one consumer? You have to rollback
> already updated ones, which brings more complication.

Hmm... what happens when we have multiple uprobes sharing the same
reference counter? It feels equally complicate to me. Or did I miss any
cases here?


>
> Now, other complication is, generally vma holding reference counter
> won't be present when install_breakpoint() gets called from
> uprobe_mmap(). I've introduced delayed_uprobes for this. This is
> anyway needed with any approach.

Yeah, I am aware of this problem. But I haven't started looking into a fix.

>
> The only advantage I was seeing by making reference counter a
> consumer property was a user flexibility to update reference counter
> on his own. But I've already proposed a solution for that.
>
> So, I personally don't suggest to make ref_ctr_offset a consumer
> property because I, again personally, don't think it's a consumer
> property.
>
> Please feel free to say if this all looks crap to you :)
>

These all make sense. Multiple consumer case does make the problem
a lot more complicated

For the example you showed above (~/loop:foo), will the following patch
fixes the imbalance? It worked in my tests.

Thanks,
Song

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 15:51:28 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:47079
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992966AbeC0NvTAgHYm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Mar 2018 15:51:19 +0200
Received: by mail-lf0-x244.google.com with SMTP id j68-v6so33401446lfg.13;
        Tue, 27 Mar 2018 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y6PiAbP+0RgCdplau6Qz9CsZc8YXQN1l/gRCGxg/XVE=;
        b=uqr24jU4sVyHw0e/+PkE0RYys0+iT9CSSRkD5S4Oe6cHbxqd7hFjhA4ZEsRlGandlz
         QMEMxdLUUqf5ag21KZK1oKaYNFUoXhsL2mCyaFcJRa419ptJAdLKmlub8SXXHaNEtJ2L
         Pt8SCbAWRYHlNhZ6Ny3te/pXLbcXNhvLPdgvpfi2K0G17WDRxSsR2QmicTUe5BGJQ0Ps
         7OzXh5W/lPNYy0ZGO6L7rdgP8I1ReIF6mHlH7JwkItuxcH5XMljBxRbBFWUbUJsPMCEe
         Gh2ynCColLCPcSuZ7oLVLxl1120K2NmpspMoO3JKR6kUUjF1Sty3ofZVWGE5ldb6fNNG
         Pl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y6PiAbP+0RgCdplau6Qz9CsZc8YXQN1l/gRCGxg/XVE=;
        b=ejRAOVhZa5felhKp0xcMA/RSSLVi00D0YAqc3c97VxmxWlbp/0q1CrVxe9nugJP3jU
         0LTuOCygrmL5mtmkVMhEWbvYaVk7vYbiRvbMloS4Vwu9iLUyRorDLPoOS7gmkVZzh7Tl
         D6ImWs6k0Pm7IMM9AxGY1gNpD+t7l9EN2SxtToVaB/S5AFjwvSEkD2UD36JhNc8gfH48
         Ktrr1JxiWJJ5a4n15D8QtU+72K9xJ1hUwi0H7nfAIqzKTi9D0u0LAFU5r9AZn7GWX1CY
         C7VpBUHT6aYRtZ67mmnHWuu5bvagB88jUeNtzkuME/Tv/THKEcTHLEo5KN+8Ef1L17S0
         pZkw==
X-Gm-Message-State: AElRT7HFmEFYn+iHdPCrm3sQNY1utFz5PYQ5m4tl2wQl8YxJmqUHyRET
        3AeWSdkp3zmuhuf4yqhWsEU=
X-Google-Smtp-Source: AG47ELtfgwkyoXaPbaeUDmGoF1ghT43pbnOR/I5cqs5nTddvtwfdZ4kCvF2bXXTfG+BmYUg7RWljmA==
X-Received: by 2002:a19:fe2:: with SMTP id 95-v6mr30490583lfp.13.1522158672115;
        Tue, 27 Mar 2018 06:51:12 -0700 (PDT)
Received: from [10.0.36.227] ([31.44.93.2])
        by smtp.gmail.com with ESMTPSA id y70-v6sm249076lfk.24.2018.03.27.06.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 06:51:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180327072432.GY5652@dhcp22.suse.cz>
Date:   Tue, 27 Mar 2018 16:51:08 +0300
Cc:     Matthew Wilcox <willy@infradead.org>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, jejb@parisc-linux.org,
        Helge Deller <deller@gmx.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        Hugh Dickins <hughd@google.com>, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, Andrew Morton <akpm@linux-foundation.org>,
        steve.capper@arm.com, punit.agrawal@arm.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Kees Cook <keescook@chromium.org>, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, ross.zwisler@linux.intel.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blackzert@gmail.com
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


> On 27 Mar 2018, at 10:24, Michal Hocko <mhocko@kernel.org> wrote:
> 
> On Mon 26-03-18 22:45:31, Ilya Smith wrote:
>> 
>>> On 26 Mar 2018, at 11:46, Michal Hocko <mhocko@kernel.org> wrote:
>>> 
>>> On Fri 23-03-18 20:55:49, Ilya Smith wrote:
>>>> 
>>>>> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
>>>>> 
>>>>> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>>>>>> Current implementation doesn't randomize address returned by mmap.
>>>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>>>> creation. After that mmap build very predictable layout of address
>>>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>>>> randomization of address on any mmap call.
>>>>> 
>>>>> Why should this be done in the kernel rather than libc?  libc is perfectly
>>>>> capable of specifying random numbers in the first argument of mmap.
>>>> Well, there is following reasons:
>>>> 1. It should be done in any libc implementation, what is not possible IMO;
>>> 
>>> Is this really so helpful?
>> 
>> Yes, ASLR is one of very important mitigation techniques which are really used 
>> to protect applications. If there is no ASLR, it is very easy to exploit 
>> vulnerable application and compromise the system. We can’t just fix all the 
>> vulnerabilities right now, thats why we have mitigations - techniques which are 
>> makes exploitation more hard or impossible in some cases.
>> 
>> Thats why it is helpful.
> 
> I am not questioning ASLR in general. I am asking whether we really need
> per mmap ASLR in general. I can imagine that some environments want to
> pay the additional price and other side effects, but considering this
> can be achieved by libc, why to add more code to the kernel?

I believe this is the only one right place for it. Adding these 200+ lines of 
code we give this feature for any user - on desktop, on server, on IoT device, 
on SCADA, etc. But if only glibc will implement ‘user-mode-aslr’ IoT and SCADA 
devices will never get it.

>>> 
>>>> 2. User mode is not that layer which should be responsible for choosing
>>>> random address or handling entropy;
>>> 
>>> Why?
>> 
>> Because of the following reasons:
>> 1. To get random address you should have entropy. These entropy shouldn’t be 
>> exposed to attacker anyhow, the best case is to get it from kernel. So this is
>> a syscall.
> 
> /dev/[u]random is not sufficient?

Using /dev/[u]random makes 3 syscalls - open, read, close. This is a performance
issue.

> 
>> 2. You should have memory map of your process to prevent remapping or big
>> fragmentation. Kernel already has this map.
> 
> /proc/self/maps?

Not any system has /proc and parsing /proc/self/maps is robust so it is the 
performance issue. libc will have to do it on any mmap. And there is a possible 
race here - application may mmap/unmap memory with native syscall during other 
thread reading maps.

>> You will got another one in libc.
>> And any non-libc user of mmap (via syscall, etc) will make hole in your map.
>> This one also decrease performance cause you any way call syscall_mmap 
>> which will try to find some address for you in worst case, but after you already
>> did some computing on it.
> 
> I do not understand. a) you should be prepared to pay an additional
> price for an additional security measures and b) how would anybody punch
> a hole into your mapping? 
> 

I was talking about any code that call mmap directly without libc wrapper.

>> 3. The more memory you use in userland for these proposal, the easier for
>> attacker to leak it or use in exploitation techniques.
> 
> This is true in general, isn't it? I fail to see how kernel chosen and
> user chosen ranges would make any difference.

My point here was that libc will have to keep memory representation as a tree 
and this tree increase attack surface. It could be hidden in kernel as it is right now.

> 
>> 4. It is so easy to fix Kernel function and so hard to support memory
>> management from userspace.
> 
> Well, on the other hand the new layout mode will add a maintenance
> burden on the kernel and will have to be maintained for ever because it
> is a user visible ABI.

Thats why I made this patch as RFC and would like to discuss this ABI here. I 
made randomize_va_space parameter to allow disable randomisation per whole 
system. PF_RANDOMIZE flag may disable randomization for concrete process (or 
process groups?). For architecture I’ve made info.random_shift = 0 , so if your 
arch has small address space you may disable shifting. I also would like to add 
some sysctl to allow process/groups to change this value and allow some 
processes to have shifts bigger then another. Lets discuss it, please.

> 
>>>> 3. Memory fragmentation is unpredictable in this case
>>>> 
>>>> Off course user mode could use random ‘hint’ address, but kernel may
>>>> discard this address if it is occupied for example and allocate just before
>>>> closest vma. So this solution doesn’t give that much security like 
>>>> randomization address inside kernel.
>>> 
>>> The userspace can use the new MAP_FIXED_NOREPLACE to probe for the
>>> address range atomically and chose a different range on failure.
>>> 
>> 
>> This algorithm should track current memory. If he doesn’t he may cause
>> infinite loop while trying to choose memory. And each iteration increase time
>> needed on allocation new memory, what is not preferred by any libc library
>> developer.
> 
> Well, I am pretty sure userspace can implement proper free ranges
> tracking…

I think we need to know what libc developers will say on implementing ASLR in 
user-mode. I am pretty sure they will say ‘nether’ or ‘some-day’. And problem 
of ASLR will stay forever.

Thanks,
Ilya

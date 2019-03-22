Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B050CC43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8529E2190A
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 17:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfCVRl2 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:41:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfCVRl1 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Mar 2019 13:41:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE834882FF;
        Fri, 22 Mar 2019 17:41:25 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86E1A1001E6F;
        Fri, 22 Mar 2019 17:41:06 +0000 (UTC)
Subject: Re: [PATCH v5 3/3] locking/rwsem: Optimize down_read_trylock()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        x86@kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
        linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-parisc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        nios2-dev@lists.rocketboards.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-4-longman@redhat.com>
 <20190322172501.3nbjw6e2wqsaisgw@shell.armlinux.org.uk>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <27c2fb96-daa4-ba2c-da06-e559dc5b693e@redhat.com>
Date:   Fri, 22 Mar 2019 13:41:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190322172501.3nbjw6e2wqsaisgw@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 22 Mar 2019 17:41:26 +0000 (UTC)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 03/22/2019 01:25 PM, Russell King - ARM Linux admin wrote:
> On Fri, Mar 22, 2019 at 10:30:08AM -0400, Waiman Long wrote:
>> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
>> it generate slightly better code.
>>
>> Before this patch, down_read_trylock:
>>
>>    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
>>    0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
>>    0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
>>    0x000000000000000b <+11>:    mov    %rdx,%rax
>>    0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
>>    0x0000000000000013 <+19>:    cmp    %rax,%rdx
>>    0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
>>    0x0000000000000018 <+24>:    mov    (%rdi),%rdx
>>    0x000000000000001b <+27>:    test   %rdx,%rdx
>>    0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
>>    0x0000000000000020 <+32>:    xor    %eax,%eax
>>    0x0000000000000022 <+34>:    retq
>>    0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
>>    0x000000000000002c <+44>:    or     $0x3,%rax
>>    0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
>>    0x0000000000000034 <+52>:    mov    $0x1,%eax
>>    0x0000000000000039 <+57>:    retq
>>
>> After patch, down_read_trylock:
>>
>>    0x0000000000000000 <+0>:	callq  0x5 <down_read_trylock+5>
>>    0x0000000000000005 <+5>:	xor    %eax,%eax
>>    0x0000000000000007 <+7>:	lea    0x1(%rax),%rdx
>>    0x000000000000000b <+11>:	lock cmpxchg %rdx,(%rdi)
>>    0x0000000000000010 <+16>:	jne    0x29 <down_read_trylock+41>
>>    0x0000000000000012 <+18>:	mov    %gs:0x0,%rax
>>    0x000000000000001b <+27>:	or     $0x3,%rax
>>    0x000000000000001f <+31>:	mov    %rax,0x20(%rdi)
>>    0x0000000000000023 <+35>:	mov    $0x1,%eax
>>    0x0000000000000028 <+40>:	retq
>>    0x0000000000000029 <+41>:	test   %rax,%rax
>>    0x000000000000002c <+44>:	jns    0x7 <down_read_trylock+7>
>>    0x000000000000002e <+46>:	xor    %eax,%eax
>>    0x0000000000000030 <+48>:	retq
>>
>> By using a rwsem microbenchmark, the down_read_trylock() rate (with a
>> load of 10 to lengthen the lock critical section) on a x86-64 system
>> before and after the patch were:
>>
>>                  Before Patch    After Patch
>>    # of Threads     rlock           rlock
>>    ------------     -----           -----
>>         1           14,496          14,716
>>         2            8,644           8,453
>> 	4            6,799           6,983
>> 	8            5,664           7,190
>>
>> On a ARM64 system, the performance results were:
>>
>>                  Before Patch    After Patch
>>    # of Threads     rlock           rlock
>>    ------------     -----           -----
>>         1           23,676          24,488
>>         2            7,697           9,502
>>         4            4,945           3,440
>>         8            2,641           1,603
>>
>> For the uncontended case (1 thread), the new down_read_trylock() is a
>> little bit faster. For the contended cases, the new down_read_trylock()
>> perform pretty well in x86-64, but performance degrades at high
>> contention level on ARM64.
> So, 70% for 4 threads, 61% for 4 threads - does this trend
> continue tailing off as the number of threads (and cores)
> increase?
>
I didn't try higher number of contending threads. I won't worry too much
about contention as trylock is a one-off event. The chance of having
more than one trylock happening simultaneously is very small.

Cheers,
Longman


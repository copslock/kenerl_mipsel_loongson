Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 16:00:33 +0100 (CET)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:44219 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011577AbaJ1PAbiSQTr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 16:00:31 +0100
Received: by mail-oi0-f52.google.com with SMTP id u20so635663oif.25
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZdDJGcz+L5NUeuPWt9Kcqge3EHnnZI8DRLvqqQm4lNA=;
        b=avHPCO6jLsb5GzpVw6NuIBNmKwsEF/Td4XKBSZdUqIbrkUX8qHE8qjHGhYc3RbiqIF
         NGQ6WNUgcjfq3PCeGPrY5v8B7EYWPZLxe+Jbf/cV1t9cQnY3447a/xySTlxNiGJF4rgU
         fjALSh+42lNDpPA7kJIO06Kz18pPLHKuMJcAcWM6N7zapu5aeog9EPGQvUyV6Fy31vFt
         Nxboga8s0Jjml8AOvZoWJ2U0XQvHGIXUScZJfevk+1QRSRJRzawY8rvKwBzzXS6ZLC96
         tf0RgiP9Qu+HYovNpMa/2OD0t5sYFgsmEfpAVTbg0J/IrpWrhci5W23Tuy2Uis5bLFXu
         DTwA==
MIME-Version: 1.0
X-Received: by 10.202.213.76 with SMTP id m73mr3085126oig.39.1414508425202;
 Tue, 28 Oct 2014 08:00:25 -0700 (PDT)
Received: by 10.202.231.73 with HTTP; Tue, 28 Oct 2014 08:00:25 -0700 (PDT)
In-Reply-To: <544FA8E2.3050404@imgtec.com>
References: <544F73CD.1010409@imgtec.com>
        <CAAmzW4NdBNhsPtx1yw+drN+J=a23SS3yLkgQdvQx-Giokwxu-Q@mail.gmail.com>
        <544F97D4.4030408@imgtec.com>
        <544F991E.3070500@imgtec.com>
        <CAAmzW4O6EFq-aaAi5gNFng1dhyXJdUmEMTR8meJfir=47iwmZw@mail.gmail.com>
        <CAAmzW4M0Ca3iQni-RRVuh152bjA=oezTrK+OE6qjaNqmG0q9nA@mail.gmail.com>
        <544FA8E2.3050404@imgtec.com>
Date:   Wed, 29 Oct 2014 00:00:25 +0900
Message-ID: <CAAmzW4OGLgneoccpP1=H4XA0_eL0vtwPvWh49J9TnV1=FL-3jw@mail.gmail.com>
Subject: Re: Boot problems on Malta with EVA (bisected to 12220dea07f1
 "mm/slab: support slab merge")
From:   Joonsoo Kim <js1304@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <js1304@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js1304@gmail.com
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

2014-10-28 23:32 GMT+09:00 Markos Chandras <Markos.Chandras@imgtec.com>:
> On 10/28/2014 02:21 PM, Joonsoo Kim wrote:
>> 2014-10-28 22:48 GMT+09:00 Joonsoo Kim <js1304@gmail.com>:
>>> 2014-10-28 22:24 GMT+09:00 Markos Chandras <Markos.Chandras@imgtec.com>:
>>>> On 10/28/2014 01:19 PM, Markos Chandras wrote:
>>>>> On 10/28/2014 01:01 PM, Joonsoo Kim wrote:
>>>>>> 2014-10-28 19:45 GMT+09:00 Markos Chandras <Markos.Chandras@imgtec.com>:
>>>>>>> Hi,
>>>>>>>
>>>>>>> It seems I am unable to boot my Malta with EVA. The problem appeared in
>>>>>>> the 3.18 merge window. I bisected the problem (between v3.17 and
>>>>>>> v3.18-rc1) and I found the following commit responsible for the broken boot.
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> Did you start to bisect from v3.18-rc1?
>>>>>> I'd like to be sure that this is another bug which is fixed by following commit.
>>>>>>
>>>>>> commit 85c9f4b04a08f6bc770b77530c22d04103468b8f
>>>>>> Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>>>>> Date:   Mon Oct 13 15:51:01 2014 -0700
>>>>>>
>>>>>>     mm/slab: fix unaligned access on sparc64
>>>>>>
>>>>>> This fix is merged into v3.18-rc1 sometime later that
>>>>>> 'support slab merge' is merged.
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>> Hi,
>>>>>
>>>>> I bisected from v3.17 until 3.18-rc1. But 3.18-rc2 and the latest
>>>>> mainline (f7e87a44ef60ad379e39b45437604141453bf0ec) still have the same
>>>>> problem
>>>>>
>>>>> btw i did more tests and this is not EVA specific. A maltaup_defconfig
>>>>> fails in the same way. I suspect all malta*_defconfigs will fail in a
>>>>> similar way which makes it probably easier for you to reproduce it on a
>>>>> QEMU.
>>>>>
>>>>
>>>> sorry maltaup_defconfig does not fail. maltasmvp_defconfig does. So it
>>>> might be a similar problem like the one fixed in
>>>> 85c9f4b04a08f6bc770b77530c22d04103468b8f
>>>
>>> Oops. Sorry. Above commit ('mm/slab: fix unaligned access on sparc64')
>>> is irrelevant to this problem.
>>>
>>> Anyway, your problem would be related to merging with incompatible slab cache.
>>> Best way to debug is printing source/target slab cache's object size and
>>> alignment and find the problem. I will try to reproduce it using QEMU.
>>
>> I found that cross compile for MIPS isn't easy job. :)
>
> You could grab the following toolchain
>
> https://sourcery.mentor.com/GNUToolchain/release2791
>
> (get the IA32 linux tar)
>
> unpack it somewhere (eg /tmp) and then
>
> make ARCH=mips maltasmvp_defconfig
> make ARCH=mips CROSS_COMPILE=/tmp/mips-2014.05/bin/mips-linux-gnu- -j8
> or something :)

Wow!! Really Thanks!
I will try it.

>> Could you help me to debug the problem with below patch?
>
> (there are a few build warnings with your patch
> mm/slab.c:2065:4: warning: format '%lu' expects argument of type 'long
> unsigned int', but argument 5 has type 'size_t' [-Wformat=]
> mm/slab.c:2065:4: warning: format '%lu' expects argument of type 'long
> unsigned int', but argument 7 has type 'unsigned int' [-Wformat=]
> mm/slab.c:2065:4: warning: format '%lu' expects argument of type 'long
> unsigned int', but argument 8 has type 'int' [-Wformat=]
> mm/slab.c:2065:4: warning: format '%lu' expects argument of type 'long
> unsigned int', but argument 9 has type 'int' [-Wformat=]
> )
>
> but here is the output from a QEMU boot right before the crash
>
> CPU frequency 200.00 MHz
> Calibrating delay loop... 1087.89 BogoMIPS (lpj=5439488)
> pid_max: default: 32768 minimum: 301
> __kmem_cache_alias: (cred_jar 92 0) to (kmalloc-128 128 128 128)
> __kmem_cache_alias: (files_cache 256 0) to (kmalloc-256 256 128 256)
> __kmem_cache_alias: (fs_cache 36 0) to (pid 64 64 44)
> __kmem_cache_alias: (names_cache 4096 0) to (kmalloc-4096 4096 128 4096)
> __kmem_cache_alias: (mnt_cache 160 0) to (filp 192 64 160)
> Mount-cache hash table entries: 4096 (order: 0, 16384 bytes)
> Mountpoint-cache hash table entries: 4096 (order: 0, 16384 bytes)
> __kmem_cache_alias: (pool_workqueue 256 256) to (kmalloc-256 256 128 256)

alignment is mismatch between pool_workqueue and kmalloc-256,
but, slab caches are merged, because they have same object size.
Perhaps, slab cache for pool_workqueue returns 128 byte aligned memory
and workqueue can't work well with it.

Quick fix may be something like below, but, I will try it on QEMU MIPS.

Thanks.

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3a6e0cf..d57b1a2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -269,6 +269,9 @@ struct kmem_cache *find_mergeable(size_t size, size_t align,
                if (s->size - size >= sizeof(void *))
                        continue;

+               if (align > s->align)
+                       continue;
+
                return s;
        }
        return NULL;

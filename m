Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2014 22:24:57 +0200 (CEST)
Received: from mail-oa0-f54.google.com ([209.85.219.54]:61666 "EHLO
        mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842577AbaHAUYtrfliz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2014 22:24:49 +0200
Received: by mail-oa0-f54.google.com with SMTP id n16so3410628oag.13
        for <linux-mips@linux-mips.org>; Fri, 01 Aug 2014 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7yDyjH8ma/1cLn/CI2FSIKLPzpMppBE74SpC7gPntes=;
        b=NSzeNkK8fHzNEQU+TYBOavOo1ZWBQdwdmfgzEXTLieZs7U1mzTa2FI+IOSySfUAU+e
         bAXvJg92pnBzNcCkxN0SXV9HVdy0EyR+QDlQl7i7L17Qmuu51gyDnnmLSkZbHkBubdPm
         M2ZxFKUH+Ucod19akxjgnqKg5RXUhtOsVPeVIStheMWUZ4FnqUJPUUuecquEdXWg2WXm
         wXHFx0+aD0EIXxiwX0q1Yzs8GTPf3bjUArOXkG4VSj2Pfg1UMVlmyw+s+C02u/IXPde5
         ek6Q3zw2S4FBl2vIvRK4rk9dq/0CkGcStgrEwi9Ojsi0mPWGQ9g6n/k6x/orLU6I6TWI
         ZUZA==
MIME-Version: 1.0
X-Received: by 10.60.175.234 with SMTP id cd10mr8152708oec.80.1406924683278;
 Fri, 01 Aug 2014 13:24:43 -0700 (PDT)
Received: by 10.76.130.47 with HTTP; Fri, 1 Aug 2014 13:24:43 -0700 (PDT)
In-Reply-To: <20140801131049.e94e0e6daec0180ac0236f68@linux-foundation.org>
References: <1406317427-10215-1-git-send-email-jcmvbkbc@gmail.com>
        <1406317427-10215-2-git-send-email-jcmvbkbc@gmail.com>
        <20140801131049.e94e0e6daec0180ac0236f68@linux-foundation.org>
Date:   Sat, 2 Aug 2014 00:24:43 +0400
Message-ID: <CAMo8BfLN0reEuE2u50Dkv4kyVmq0QMPJdQ4mR5RsQRX4HQFkVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/highmem: make kmap cache coloring aware
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Chris Zankel <chris@zankel.net>,
        Marc Gauthier <marc@cadence.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Steven Hill <Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

On Sat, Aug 2, 2014 at 12:10 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 25 Jul 2014 23:43:46 +0400 Max Filippov <jcmvbkbc@gmail.com> wrote:
>
>> VIPT cache with way size larger than MMU page size may suffer from
>> aliasing problem: a single physical address accessed via different
>> virtual addresses may end up in multiple locations in the cache.
>> Virtual mappings of a physical address that always get cached in
>> different cache locations are said to have different colors.
>> L1 caching hardware usually doesn't handle this situation leaving it
>> up to software. Software must avoid this situation as it leads to
>> data corruption.
>>
>> One way to handle this is to flush and invalidate data cache every time
>> page mapping changes color. The other way is to always map physical page
>> at a virtual address with the same color. Low memory pages already have
>> this property. Giving architecture a way to control color of high memory
>> page mapping allows reusing of existing low memory cache alias handling
>> code.
>>
>> Provide hooks that allow architectures with aliasing cache to align
>> mapping address of high pages according to their color. Such architectures
>> may enforce similar coloring of low- and high-memory page mappings and
>> reuse existing cache management functions to support highmem.
>>
>> This code is based on the implementation of similar feature for MIPS by
>> Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>.
>>
>
> It's worth mentioning that xtensa needs this.
>
> What is (still) missing from these changelogs is a clear description of
> the end-user visible effects.  Does it fix some bug?  If so what?  Is
> it a performace optimisation?  If so how much?  This info is the
> top-line reason for the patchset and should be presented as such.

Ok, let me try again.

>> --- a/mm/highmem.c
>> +++ b/mm/highmem.c
>> @@ -28,6 +28,9 @@
>>  #include <linux/highmem.h>
>>  #include <linux/kgdb.h>
>>  #include <asm/tlbflush.h>
>> +#ifdef CONFIG_HIGHMEM
>> +#include <asm/highmem.h>
>> +#endif
>
> Should be unneeded - the linux/highmem.h inclusion already did this.

Ok, I'll drop it.

> Apart from that it all looks OK to me.  I'm assuming this is 3.17-rc1
> material, but I am unsure because of the missing end-user-impact info.
> If it's needed in earlier kernels then we can tag it for -stable
> backporting but again, the -stable team (ie: Greg) will want so see the
> justification for that backport.

It's not a fix, for xtensa it's a part of a new feature, so no need
for backporting.

-- 
Thanks.
-- Max

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2014 02:40:36 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:57103 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860093AbaGaAkbW-z3z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2014 02:40:31 +0200
Received: by mail-ig0-f175.google.com with SMTP id uq10so8383205igb.14
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qCh2jt563I87BEwU1BXeA7VHrYdwwPHR8Abf9ToZ/KE=;
        b=LASRgIBcL/F6C4nyB5k81evZq8vTyChEXdDccdVkanGOsG5/i6YwYrBIQGdpNLumKT
         c3TIfcpPC4bDeUsihBzrgkxzKyBQ5YR5kLOR1vtiZKOlpRD3wXILse/KnHfhGdH22bpr
         AU3Ar3II722wz7Y5loS645GCJfRQIInMNmi+4x/R5V4Rq+7yiB7Uhx4RkpyOthjjxA2J
         4ygsfVRcjzi7Y5Lh4MK2/UgJF/pGxEgc5He+TvRu3G0qFYHSmzd9MOinCneearJxrD29
         9E5ShT8CvjtWamk3Ffsar8qmb9QntH4L+bOFFrKvHzCCbML079bXoGu8jpzoiCCdAmef
         jH2w==
MIME-Version: 1.0
X-Received: by 10.50.8.6 with SMTP id n6mr41946103iga.43.1406767224123; Wed,
 30 Jul 2014 17:40:24 -0700 (PDT)
Received: by 10.64.241.5 with HTTP; Wed, 30 Jul 2014 17:40:24 -0700 (PDT)
In-Reply-To: <20140730160118.GA4386@ohm.rr44.fr>
References: <tencent_0448A221440A321914235E33@qq.com>
        <20140726145116.GA14047@hall.aurel32.net>
        <CAAhV-H6UbeXG__c14qn+ToM_eR1SkOj+BN+7gqG1NxH=RGUBFA@mail.gmail.com>
        <20140730160118.GA4386@ohm.rr44.fr>
Date:   Thu, 31 Jul 2014 08:40:24 +0800
X-Google-Sender-Auth: XWcwu6CucCs1-q1ptdhWmWJF-xM
Message-ID: <CAAhV-H5ZzcxjQeEU6nMsnuzaT55_SOd18+vJtU4z1cpHyn_fhQ@mail.gmail.com>
Subject: Re: SMP IPI issues on Loongson 3A based machines
From:   Huacai Chen <chenhc@lemote.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Binbin Zhou <zhoubb@lemote.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Andreas Barth <aba@ayous.org>,
        Kent Overstreet <kmo@daterainc.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41829
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

Hi, Aurelien,

I have a quick look, both MIPS and SH use IPI to implement flush_dcache_page().
It seems Kent's email has changed, so CC his new address. :)

Huacai

On Thu, Jul 31, 2014 at 12:01 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> Hi Hucai,
>
> On Wed, Jul 30, 2014 at 04:35:26PM +0800, Huacai Chen wrote:
>> Hi, Aurelien,
>>
>> After some days debugging, we found the root cause: If we revert the
>> commit 21b40200cfe961 (aio: use flush_dcache_page()), everything is
>> OK. This commit add two flush_dcache_page() in irq disabled context,
>> but in MIPS, flush_dcache_page() is implemented via call_function IPI.
>> Unfortunately, call_function IPI shouldn't be called in irq disabled
>> context, otherwise there will be deadlock.
>
> Thanks a lot for digging into the problem. I will try to revert this
> patch to confirm it fixes the problem for us, and I'll keep you updated.
>
>> I don't know how to solve this problem, since commit 21b40200
>> shouldn't be reverted (Loongson can revert it because of
>> hardware-maintained cache, but other MIPS need this). May be the
>> original author (Kent Overstreet) have good ideas?
>
> Maybe we should look if it's possible to reduce the window where
> interrupts are disabled in this function, but I guess we'll have to wait
> for Kent about that. Do we know if other MIPS systems or other
> architectures also implement the flush_dcache_page() function via IPI?
>
> Thanks,
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net
>

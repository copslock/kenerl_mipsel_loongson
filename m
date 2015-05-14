Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 00:43:13 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34935 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012567AbbENWnJoi0Jq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 00:43:09 +0200
Received: by pabru16 with SMTP id ru16so6573329pab.2;
        Thu, 14 May 2015 15:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wnGmdHeJHbQFNQmp+FtC00XX7o1EogFNhts44PUCIQE=;
        b=S4BdIarnBbuDOB5bezivrF3iRPqds/L0Mlk7Kq+eJt/ljKmTMOZneUE4KubkI8ujYC
         SrY4OGq/5Tn6Qecxq1dAowVvXgavTjASNq+dt4VPoXZUCKVhPU/SbKdQ1go6M5Oh86Cs
         BxdcFT4ALVtY1fqCFv6W7elQ0kMLmvoDneqUfhWiG5JKhVCsuLJ9NtAApT0nbax9RLMD
         xLHJIeVK2ciRlVSUR+G8mgeXh7PbjOkGrLQWU663qsvTG10ppajh0m6zRSG0bD+/z9rR
         JRFR5vUzJ5kDuT9K29P7dLPr7uD+03xudBKvdkonRufZHf0B+2drQTS15j8SfyEeAt4m
         4fXw==
X-Received: by 10.66.119.174 with SMTP id kv14mr12100006pab.5.1431643380480;
        Thu, 14 May 2015 15:43:00 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id id2sm201882pbb.56.2015.05.14.15.42.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 15:42:59 -0700 (PDT)
Message-ID: <555524E2.6080700@gmail.com>
Date:   Thu, 14 May 2015 15:42:42 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     mina86@mina86.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Zubair.Kakakhel@imgtec.com, Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Flush cache after DMA_FROM_DEVICE for agressively
 speculative CPUs
References: <20150514014924.36593.68642.stgit@ubuntu-yegoshin> <CAJiQ=7CU+MyaypO-9Np8aChVpVX_Vobdtoytt0q4Vz7LY9qHsA@mail.gmail.com>
In-Reply-To: <CAJiQ=7CU+MyaypO-9Np8aChVpVX_Vobdtoytt0q4Vz7LY9qHsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 13/05/15 19:49, Kevin Cernekee wrote:
> On Wed, May 13, 2015 at 6:49 PM, Leonid Yegoshin
> <Leonid.Yegoshin@imgtec.com> wrote:
>> Some MIPS CPUs have an aggressive speculative load and may erroneuosly load
>> some cache line in the middle of DMA transaction. CPU discards result but cache
>> doesn't. If DMA happens from device then additional cache invalidation is needed
>> on that CPU's after DMA.
>>
>> Found in test.
>>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> ---
>>  arch/mips/mm/dma-default.c |   10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
>> index 609d1241b0c4..ccf49ecfbf8c 100644
>> --- a/arch/mips/mm/dma-default.c
>> +++ b/arch/mips/mm/dma-default.c
>> @@ -67,11 +67,13 @@ static inline struct page *dma_addr_to_page(struct device *dev,
>>   * systems and only the R10000 and R12000 are used in such systems, the
>>   * SGI IP28 Indigo² rsp. SGI IP32 aka O2.
>>   */
>> -static inline int cpu_needs_post_dma_flush(struct device *dev)
>> +static inline int cpu_needs_post_dma_flush(struct device *dev,
>> +                                          enum dma_data_direction direction)
>>  {
>>         return !plat_device_is_coherent(dev) &&
>>                (boot_cpu_type() == CPU_R10000 ||
>>                 boot_cpu_type() == CPU_R12000 ||
>> +               (cpu_has_maar && (direction != DMA_TO_DEVICE)) ||
>>                 boot_cpu_type() == CPU_BMIPS5000);
> 
> Can all of these CPUs safely skip the post_dma_flush on DMA_TO_DEVICE
> (not just maar)?

Agreed that would seem like the logical thing to do. You could then just
skip the call to cpu_needs_post_dma_flush() and move the direction test
in arch/mips/mm/dma-default.c for instance?
-- 
Florian

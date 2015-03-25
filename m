Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 18:09:14 +0100 (CET)
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34883 "EHLO
        mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008424AbbCYRJNE3U0C convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Mar 2015 18:09:13 +0100
Received: by qgh3 with SMTP id 3so40928923qgh.2;
        Wed, 25 Mar 2015 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0Rl84e8id8x9qdUFWNJro/P42jxkeDSFd7EA9QhwBZc=;
        b=da9ln+LMo/eknHkipX36An/zfw9ch3PmPhWE+Qf6HuGbjeFxeVP6qrkE3ktt589vX4
         EYrI8b9ZT/rWVIoB+xpV6qL0Yxsn3ciRQxff1B7ietEwVx10nhx/+XXWiRoAK1CN5OBW
         mVmp5u2XUzo/leSPQMQOygmfJqiarSVE6XI9jFRPTlRRm1bUzvMi4bvLItcDe8SBgxK2
         sDvi9Wmw8ZN/GTXu7+cC0vzs3p+8V+AKESwibl5g3RUTNZebsioQUapPpdwkEQe5AFN/
         BooyqX7MDExLgINswB6L3/V+rD/hOsrXEAZBezfzojS5KREaEB6bujl/kvBXPJB3EzP4
         yj2Q==
X-Received: by 10.55.56.75 with SMTP id f72mr20768030qka.75.1427303347906;
 Wed, 25 Mar 2015 10:09:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.90.18 with HTTP; Wed, 25 Mar 2015 10:08:47 -0700 (PDT)
In-Reply-To: <20150325092358.GA31933@linux-mips.org>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
 <1419529760-9520-16-git-send-email-cernekee@gmail.com> <20150325092358.GA31933@linux-mips.org>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 25 Mar 2015 10:08:47 -0700
Message-ID: <CAJiQ=7Cca_rc+g5uo-7h6PUSu3QCbC=Ev1-hnqoqz1wy_EKeZQ@mail.gmail.com>
Subject: Re: [PATCH V6 15/25] MIPS: BMIPS: Flush the readahead cache after DMA
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jonas Gorski <jogo@openwrt.org>, Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46524
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

On Wed, Mar 25, 2015 at 2:23 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Dec 25, 2014 at 09:49:10AM -0800, Kevin Cernekee wrote:
>
>> BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
>> the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
>> may cause parts of the DMA buffer to be prefetched into the RAC.  To
>> avoid possible coherency problems, flush the RAC upon DMA completion.
>>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>>  arch/mips/mm/dma-default.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
>> index af5f046..38ee47a 100644
>> --- a/arch/mips/mm/dma-default.c
>> +++ b/arch/mips/mm/dma-default.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/highmem.h>
>>  #include <linux/dma-contiguous.h>
>>
>> +#include <asm/bmips.h>
>>  #include <asm/cache.h>
>>  #include <asm/cpu-type.h>
>>  #include <asm/io.h>
>
> Aside of platform-specific headers having no business of getting
> included directly in a generic arch file

<asm/bmips.h> covers all BMIPS CPUs across multiple platforms.

The intention was to add code needed to support BMIPS CPUs into a
central place, rather than duplicating it in the platform code for
each of the BMIPS-based systems: arch/mips/{bcm63xx,bmips,brcmstb}.

> this also breaks the build
> of many platforms:
>
>   CC      arch/mips/mm/dma-default.o
> In file included from arch/mips/mm/dma-default.c:21:0:
> ./arch/mips/include/asm/bmips.h: In function ‘bmips_read_zscm_reg’:
> ./arch/mips/include/asm/bmips.h:97:160: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   cache_op(Index_Load_Tag_S, ZSCM_REG_BASE + offset);
>                                                                                                                                                                 ^
> ./arch/mips/include/asm/bmips.h: In function ‘bmips_write_zscm_reg’:
> ./arch/mips/include/asm/bmips.h:118:160: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   cache_op(Index_Store_Tag_S, ZSCM_REG_BASE + offset);
>
> I think the broken platforms are all the 64 bit platforms.

Hmm, looks like I might need to use 0x97000000UL for ZSCM_REG_BASE.

If this fixes the build should I resubmit, or do you really want the
BMIPS flush code moved into another file?

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:39:41 +0100 (CET)
Received: from mail-qg0-f45.google.com ([209.85.192.45]:55528 "EHLO
        mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009241AbaLTBjhZ3osU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 02:39:37 +0100
Received: by mail-qg0-f45.google.com with SMTP id f51so1424174qge.32;
        Fri, 19 Dec 2014 17:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/jaWKYwppjodNEJvgE3+MZDYdYwk0YNZryN3VrMHSso=;
        b=w0BfcEkno2Ppb0rZ8COTpuSLb/HNdyA7nCjtKojzHXkYP4HDHnhVfiK8+9wzi4oGgc
         0V1NnrsRdMGoJ7DFm3FnCi984Ahlz7xxpOuPZkS6MFnu/IowbMv4Tzl056yC9pjPTEhD
         mqNYAxWs0IAsKLf7yWKpPz2LsMcLyL8MSW4R/itd9XXzbPokeyDZuRq+wg37IMjX2Rop
         awwExwmM00e7zu9UFwXi9nnGwFmlj3RwdBQDSSuv7VADpZvETGt2DT0Sszy1jMq+WIoT
         MXhkullOpO9o2q8ysryoj1g7dWLTJDAdN3YDIhySHnb7RgL/yDbSvDl1RBawiR55pXMd
         9p2A==
X-Received: by 10.229.7.199 with SMTP id e7mr3652622qce.26.1419039570662; Fri,
 19 Dec 2014 17:39:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Fri, 19 Dec 2014 17:39:09 -0800 (PST)
In-Reply-To: <CAOiHx=nX9jJEFZmkA-1fWj47whq85wj-ZgUxnZBwpAYDUfAO4w@mail.gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
 <1418422034-17099-14-git-send-email-cernekee@gmail.com> <CAOiHx=nX9jJEFZmkA-1fWj47whq85wj-ZgUxnZBwpAYDUfAO4w@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Fri, 19 Dec 2014 17:39:09 -0800
Message-ID: <CAJiQ=7AZdwCX6bmLD1B4TzfmKriE3HVEEa5zP3WRnENZjGS-hA@mail.gmail.com>
Subject: Re: [PATCH V5 13/23] MIPS: BMIPS: Flush the readahead cache after DMA
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <computersforpeace@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44863
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

On Mon, Dec 15, 2014 at 1:43 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Fri, Dec 12, 2014 at 11:07 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
>> the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
>> may cause parts of the DMA buffer to be prefetched into the RAC.  To
>> avoid possible coherency problems, flush the RAC upon DMA completion.
>
> According to what I have, any cpu [d-]cache invalidate operation
> should already flush the full RAC unless explicitly disabled in the
> RAC configuration - is this intended as an optimization/shortcut?

Correct - performing a RAC flush instead of blasting the entire range
again via CACHE instructions should be considerably faster in most
cases.  CACHE instructions are not pipelined on BMIPS3300/43xx.

There may be a couple of old CPU versions (possibly 130nm) that don't
automatically perform the RAC flush on each CACHE instruction.  Also,
a fun bit of trivia: MVA based cache flushes on B15 do flush the RAC,
but index based instructions do not.

>>  static inline int cpu_needs_post_dma_flush(struct device *dev)
>>  {
>
> The place for it seems a bit misplaced; I would not expect
> cpu_needs_post_dma_flush() to have any side effects.

Maybe we should rename the function?  To just cpu_post_dma_flush()?

(Or call a separate function from each site - but that seems unnecessary.)

>> +       if (boot_cpu_type() == CPU_BMIPS3300 ||
>> +           boot_cpu_type() == CPU_BMIPS4350 ||
>> +           boot_cpu_type() == CPU_BMIPS4380) {
>> +               void __iomem *cbr = BMIPS_GET_CBR();
>> +
>> +               /* Flush stale data out of the readahead cache */
>> +               __raw_writel(0x100, cbr + BMIPS_RAC_CONFIG);
>
> Hm, according to what I have, bits [6:0] of RAC_CONFIG are R/W
> configuration bits, and this will overwrite them:
>
> CFE> dm 0xff400000 4
> ff400000: 02a07015                                        ..p.
> CFE> sm 0xff400000 0x100 4
> ff400000: 02a00000                                        ....
>
> (As far as I can tell, RAC was previously enabled for instruction
> cache misses , and now isn't any more for anything, so effectively
> disabled?)
>
> Also for BMIPS4350 (and I guess 4380) there seems to be a second
> RAC_CONFIG register at 0x8, I guess for the second thread? Does it
> need flushing, too?

I'll defer to Florian for the final word since he has access to the
documentation, but going from memory:

RAC_CONFIG should probably be a read/modify/write.  I'm pretty sure
there are important RW configuration bits in there.  I may have
incorrectly translated the "set bit 8" code from here:

https://github.com/Broadcom/stblinux-3.3/blob/master/linux/arch/mips/mm/c-brcmstb.c#L374

There is only one RAC for all CPUs, and we've never had to flush
anything via CBR+0x08.

BCM7038 had a different flush register, located out in the regular
system bus (GISB) space, and it didn't require a R/M/W.  That might
have been what I was thinking of.

Thanks for catching that.

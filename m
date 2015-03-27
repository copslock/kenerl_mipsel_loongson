Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2015 22:34:46 +0100 (CET)
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33924 "EHLO
        mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009753AbbC0Velp0Hbs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2015 22:34:41 +0100
Received: by qgep97 with SMTP id p97so145608499qge.1;
        Fri, 27 Mar 2015 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7H+cMWBnweuqMmuGF1H5dI/5e4UGKb9yLwwWfp2jT+0=;
        b=mrh3Hth2VcoG7MgOdLKkSyST7gA2LePj+gsvo4Nt5TypWWi9LtVcDDMQ1nIC8kPzTd
         0zMwtB4RZN68BJTQI08/cTaZTF+bBF/JLy+snNl3BGvS77rXVWCLDQFjKcOzqyny05AO
         EgvUoKCRtnDhE3uo0jfpocMtN+/NGwih5LZbI91lDP5LMZvhSXDt6t6wJBVxi1oZhXF5
         zFCDDSqqQ20Y3szbGlzhWmc356sD7B3P2UP1rYii90tJcxxKTs3nXQ6q3GgqrVs21u8V
         8Yqnf1PgYJn8+yPiPjtULtsnW7VDElzuj/y2O4OatlaA1v6zDRMDLn83keC32Dbb13Yd
         +q5A==
X-Received: by 10.140.108.116 with SMTP id i107mr26238774qgf.73.1427492076871;
 Fri, 27 Mar 2015 14:34:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.90.18 with HTTP; Fri, 27 Mar 2015 14:34:16 -0700 (PDT)
In-Reply-To: <20150327120405.GP1385@linux-mips.org>
References: <1427345715-16516-1-git-send-email-f.fainelli@gmail.com>
 <1427345715-16516-2-git-send-email-f.fainelli@gmail.com> <20150327120405.GP1385@linux-mips.org>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Fri, 27 Mar 2015 14:34:16 -0700
Message-ID: <CAJiQ=7DeNDzu0Sk014aOaWsFP3AVnBc4G7RU=6dCQe2iKLBM5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: BMIPS: Flush the readahead cache after DMA
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46571
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

On Fri, Mar 27, 2015 at 5:04 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Mar 25, 2015 at 09:55:14PM -0700, Florian Fainelli wrote:
>
>> From: Kevin Cernekee <cernekee@gmail.com>
>>
>> BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
>> the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
>> may cause parts of the DMA buffer to be prefetched into the RAC.  To
>> avoid possible coherency problems, flush the RAC upon DMA completion.
>>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/mips/include/asm/bmips.h |  2 +-
>>  arch/mips/mm/dma-default.c    | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> I'm not keen on including platform-specific files that may blow up on
> another platform.  So what I suggest instead is something like rewriting
> cpu_needs_post_dma_flush() to invoke a platform-specific hook function
> plat_post_dma_flush() which would be defined in <asm/dma-coherence.h>
> rsp. <mach/dma-coherence.h>.
>
> I'm going to whip up something.

Hi Ralf,

Regarding this patch:
http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=47df84c7341a4816b69b784b01fce304a15777a2

The same change is also needed for mach-bcm63xx (in-tree) and
mach-brcmstb (out-of-tree).  Somewhat confusingly, mach-bmips is a
"Generic BMIPS kernel" but it isn't the only platform which uses BMIPS
processors that have readahead caches.

I am hoping that someday mach-bmips will have support for all
mach-bcm63xx and mach-brcmstb platforms/peripherals, but we aren't
quite there yet.

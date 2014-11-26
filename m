Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 23:55:16 +0100 (CET)
Received: from mail-qa0-f54.google.com ([209.85.216.54]:40062 "EHLO
        mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007103AbaKZWzP1phhh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 23:55:15 +0100
Received: by mail-qa0-f54.google.com with SMTP id i13so2624408qae.13
        for <multiple recipients>; Wed, 26 Nov 2014 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S+BQQlcyc/5Ezrymsc7oX3Ixe2TRGEcA7v+RXo63HJw=;
        b=NiA17hgg9Sk+Oflc5I94QXeYKK2FoqTqE7b7TRe7ILmnE+xOb1P5CoPsDUBeBm7ASP
         0I77gNC6z1czXrcWgAjVAy+hqG/GXINQFIqYQzve99tBNofz3oXOTKIRj8pltQJ8iyjA
         6Wpp09JvspIFEOeLExJK4Jm+x2/JfPpwB7UvAystR7hNLBgzCoOfCn5jLod4jaSd/JqY
         LXRrBg0jQ09mWADm0wlsvdZjvV3Li5YAWT9QztLAcafvpmCI5NI3PbgW1lG3Fmr0uvNg
         yBIthfmuqWNmdM814pvefp4x08SFAm+huf3V4xicEauDL8CstYPkaj9Rk3meNd8LWbX2
         OjbQ==
X-Received: by 10.140.102.169 with SMTP id w38mr48563149qge.95.1417042509545;
 Wed, 26 Nov 2014 14:55:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 26 Nov 2014 14:54:49 -0800 (PST)
In-Reply-To: <6239602.L0sNsMk5KV@wuerfel>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
 <3146555.WCj2bhBSnP@wuerfel> <CAJiQ=7DwhSySAa19OxfUDkvT4DLWaZ3uhPU2QJzQ6Gc7YCvDgg@mail.gmail.com>
 <6239602.L0sNsMk5KV@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 26 Nov 2014 14:54:49 -0800
Message-ID: <CAJiQ=7AJn_qDfuD=4MEDpxisrGaZ8U+62nP=xNEhBtz77omF4w@mail.gmail.com>
Subject: Re: [PATCH V3 11/11] MIPS: Add multiplatform BMIPS target
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jonas Gorski <jogo@openwrt.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44480
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

On Wed, Nov 26, 2014 at 1:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> For the BMIPS case:
>>
>> plat_map_dma_mem* and plat_dma_addr_to_phys are just performing
>> remapping, so dma-ranges would work.
>>
>> plat_unmap_dma_mem is used to perform an extra BMIPS-specific
>> cacheflush operation.
>
> Yes, the cacheflush again would have to be abstracted. This is normally
> done using either a platform-specific dma_map_ops struct, or using
> a further abstraction with another function pointer.
>
> I'm surprised that you need the special flush operation only
> for 'unmap' and not for 'dma_sync_*_for_cpu'. Can you check that
> you are actually doing the right thing for drivers that reuse
> a DMA buffer with the streaming API?

That's a fantastic question.  I checked an older BCM7xxx kernel tree
and noticed that we used to implement plat_extra_sync_for_device()
locally to do this, but the API was "garbage collected" last year:

commit 4e7f72660c39a81cc5745d5c6f23f9500f80d8d8
Author: Felix Fietkau <nbd@openwrt.org>
Date:   Thu Aug 15 11:28:30 2013 +0200

    MIPS: Remove unnecessary platform dma helper functions

    The semantics stay the same - on Cavium Octeon the functions were dead
    code (it overrides the MIPS DMA ops) - on other platforms they contained
    no code at all.

    Signed-off-by: Felix Fietkau <nbd@openwrt.org>
    Cc: linux-mips@linux-mips.org
    Patchwork: https://patchwork.linux-mips.org/patch/5720/
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>


If nobody objects, I can revert this change and then add the extra
flush to arch/mips/bmips/dma.c.

Or I can add some BMIPS-specific code to dma-default.c, similar to
cpu_needs_post_dma_flush().  Could even add it to that function
directly, although that is less intuitive:

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index af5f046..ee6d12c 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/dma-contiguous.h>

+#include <asm/bmips.h>
 #include <asm/cache.h>
 #include <asm/cpu-type.h>
 #include <asm/io.h>
@@ -69,6 +70,18 @@ static inline struct page *dma_addr_to_page(struct
device *dev,
  */
 static inline int cpu_needs_post_dma_flush(struct device *dev)
 {
+    if (boot_cpu_type() == CPU_BMIPS3300 ||
+        boot_cpu_type() == CPU_BMIPS4350 ||
+        boot_cpu_type() == CPU_BMIPS4380) {
+        void __iomem *cbr = BMIPS_GET_CBR();
+
+        /* Flush stale data out of the readahead cache */
+        __raw_writel(0x100, cbr + BMIPS_RAC_CONFIG);
+        __raw_readl(cbr + BMIPS_RAC_CONFIG);
+
+        return 0;
+    }
+
     return !plat_device_is_coherent(dev) &&
            (boot_cpu_type() == CPU_R10000 ||
         boot_cpu_type() == CPU_R12000 ||


This would allow for eliminating all flushes from
arch/mips/bmips/dma.c, so the entire file could go away when we switch
to the common dma-ranges code.

Any preferences?

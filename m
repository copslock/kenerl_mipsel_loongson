Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 13:09:09 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34730 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992147AbcLSMJBl89hY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 13:09:01 +0100
Received: by mail-lf0-f68.google.com with SMTP id 30so5766263lfy.1;
        Mon, 19 Dec 2016 04:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HzJ4J8G5QlBGE6MrgpIKrlDlhj7Pz9qHzJK06J+AeNA=;
        b=lDq110aLaW3lXjDpbRBDc5H9cuelGjKvr9/APM4Urt/axqBpgi6hLsEUiWd/jTGnhm
         SPsr/m511kzwkFCNeiERNx5zl5K+DvjBvJPJTdxJakdCQaJedQx6wJyxiDIf6VkJuCl+
         jbuI8ehJECwaFUMMBltXdvxz3sx5+RvZHyyrb4j+9E0Pu/QDmkiIip83td7L46NEfl3T
         zSzkxFRP29T/E4T2Dzd/WY2+KQqENzxYfSCudIBXXcuKI8stiXwbNemZvg4EHclGe4//
         tfQwdSYYplKQmTH+kzlYSuhcb99yl7eUTMpn2/QJcGcybJQ/PrG0nIhMJ4xkMECVTWfI
         LxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HzJ4J8G5QlBGE6MrgpIKrlDlhj7Pz9qHzJK06J+AeNA=;
        b=SU3aOotzUYJhE774Es8j5+Z52FIbQrZ433got76IMS7E0jZ2lCUxMMu0qZG0DdgiX9
         dwchLUGW/A1LHLjKA45Mgkp2pcGp4/juHsxHVdi60hKhY9v9gOzW4mR0DGooKdrvfj9o
         CzK46q4Uqbcqj4Pv7JmV5T/GjU+oOh7LX1qcSRWraboHH+tZhQ4Xz+9Z2GygmF0LKwIV
         0OiULMzDV1t7nxgRCdf/mnPoe7xc0KawRVuJ5Jzw0W7FjgFtnmJu3Lyg+7/lVWChfZp8
         NjBE7VuhjpZ2TQSbImuIH3uHmRSjN8baBZWXffNnYKDx0+xc5qXmfxSVb1mJ/pqAeeKB
         UgNw==
X-Gm-Message-State: AKaTC00sRjh0i0wRi4QOuym2edPTTiPBG5tPEbNtQgZC7Bxz74gscbeSPq0H6F+2diviiw==
X-Received: by 10.25.135.130 with SMTP id j124mr5756782lfd.88.1482149336050;
        Mon, 19 Dec 2016 04:08:56 -0800 (PST)
Received: from mobilestation ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id x17sm3763558lja.6.2016.12.19.04.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Dec 2016 04:08:55 -0800 (PST)
Date:   Mon, 19 Dec 2016 15:09:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        james.hogan@imgtec.com, alexander.sverdlin@nokia.com,
        robh+dt@kernel.org, frowand.list@gmail.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/21] MIPS memblock: Add print out method of kernel
 virtual memory layout
Message-ID: <20161219120900.GA30965@mobilestation>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <1482113266-13207-20-git-send-email-fancer.lancer@gmail.com>
 <db27f41e-4121-bb83-6533-6727c26b9c5b@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db27f41e-4121-bb83-6533-6727c26b9c5b@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Mon, Dec 19, 2016 at 12:04:54PM +0000, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
Hello Matt.

> Hi Serge,
> 
> 
> On 19/12/16 02:07, Serge Semin wrote:
> >It's useful to have some printed map of the kernel virtual memory,
> >at least for debugging purpose.
> >
> >Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >---
> >  arch/mips/mm/init.c | 47 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> >diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> >index 13a032f..35e7ba8 100644
> >--- a/arch/mips/mm/init.c
> >+++ b/arch/mips/mm/init.c
> >@@ -32,6 +32,7 @@
> >  #include <linux/hardirq.h>
> >  #include <linux/gfp.h>
> >  #include <linux/kcore.h>
> >+#include <linux/sizes.h>
> >  #include <asm/asm-offsets.h>
> >  #include <asm/bootinfo.h>
> >@@ -106,6 +107,49 @@ static void __init zone_sizes_init(void)
> >  }
> >  /*
> >+ * Print out kernel memory layout
> >+ */
> >+#define MLK(b, t) b, t, ((t) - (b)) >> 10
> >+#define MLM(b, t) b, t, ((t) - (b)) >> 20
> >+#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> >+static void __init mem_print_kmap_info(void)
> >+{
> >+	pr_notice("Virtual kernel memory layout:\n"
> >+		  "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> >+		  "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> >+#ifdef CONFIG_HIGHMEM
> >+		  "    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> >+#endif
> >+		  "    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> >+		  "      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
> >+		  "      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
> >+		  "      .init : 0x%p" " - 0x%p" "   (%4td kB)\n",
> >+		MLM(PAGE_OFFSET, (unsigned long)high_memory),
> >+		MLM(VMALLOC_START, VMALLOC_END),
> >+#ifdef CONFIG_HIGHMEM
> >+		MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
> >+#endif
> >+		MLK(FIXADDR_START, FIXADDR_TOP),
> >+		MLK_ROUNDUP(_text, _etext),
> >+		MLK_ROUNDUP(_sdata, _edata),
> >+		MLK_ROUNDUP(__init_begin, __init_end));
> 
> Please drop printing the kernel addresses, or at least only do it if KASLR
> is not turned on, otherwise you're removing the advantage of KASLR, that
> critical kernel addresses cannot be determined easily from userspace.
> 
> It may be better to merge the functionality of show_kernel_relocation
> http://lxr.free-electrons.com/source/arch/mips/kernel/relocate.c#L354
> into this function, but only print it under the same conditions as
> currently, i.e.
> #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
> http://lxr.free-electrons.com/source/arch/mips/kernel/setup.c#L530
> 
> Thanks,
> Matt
> 

Understood. Will be fixed within the next patchset.

> >+
> >+	/* Check some fundamental inconsistencies. May add something else? */
> >+#ifdef CONFIG_HIGHMEM
> >+	BUILD_BUG_ON(VMALLOC_END < PAGE_OFFSET);
> >+	BUG_ON(VMALLOC_END < (unsigned long)high_memory);
> >+#endif
> >+	BUILD_BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) < PAGE_OFFSET);
> >+	BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) <
> >+					(unsigned long)high_memory);
> >+	BUILD_BUG_ON(FIXADDR_TOP < PAGE_OFFSET);
> >+	BUG_ON(FIXADDR_TOP < (unsigned long)high_memory);
> >+}
> >+#undef MLK
> >+#undef MLM
> >+#undef MLK_ROUNDUP
> >+
> >+/*
> >   * Not static inline because used by IP27 special magic initialization code
> >   */
> >  void setup_zero_pages(void)
> >@@ -492,6 +536,9 @@ void __init mem_init(void)
> >  	/* Free highmemory registered in memblocks */
> >  	mem_init_free_highmem();
> >+	/* Print out kernel memory layout */
> >+	mem_print_kmap_info();
> >+
> >  	/* Print out memory areas statistics */
> >  	mem_init_print_info(NULL);
> 

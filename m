Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 03:36:02 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:33124
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993060AbeIYBf5qR5sW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 03:35:57 +0200
Received: by mail-pg1-x543.google.com with SMTP id y18-v6so6931476pge.0;
        Mon, 24 Sep 2018 18:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Nt3UGAe2ghv2I3b32rDyWQzeC0rBjAmbAzPPihUJ1I=;
        b=FIdFF9ovKydNpN1ismDcpC8KZedLbezkaplTjaztdWyoLv33rhDl7Sk5A6a38Evv/r
         GkTCIUdL0ZXFei4+IG8jVhIComTEozDfoQOqwa7wbxH/635eydRt19heKg/Yuc3l02nu
         iYcB6YVAHCFFVIcMjf1Y31fIl9qjG4C6IEqMTr8OA6HxGGdJau05AisD7eyhIDAS5ybF
         svDq5jG7mQPxAajTk8YEpuEj2N2QV/2koy4karpKitKk29aVIeKKvviOra2p45Ju4CUS
         +SWH7zdLPo4OzkL2nDvI3Cz9eGmsPSRHg6WSOvfaaKjY6YhI2nNzBzmqGkn7G8Dlv6fA
         loDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5Nt3UGAe2ghv2I3b32rDyWQzeC0rBjAmbAzPPihUJ1I=;
        b=G4GP9OBmqdJsx1fYKP1LwVLKIne4YJ/6p9W/DkUrLg+kPCD2cnEO+sbqq69VhFW+xJ
         jDpJKgJhFpaXKXvQk/0zwwid/Wq40ckreS86UK0p+GnkiWJR8zSaHTjW5BrpySdivOW0
         Y4gaekgM6zwfDlhIlVYDx+Noq/b/2RYe3zbfP73nUrquF7Gfz9EqV9OzhRvWp9nlT+kA
         4IPhfAW2RBgZX+s3ikeyaX3GhyqzaJV4cbGFbo2OyY2NQ4mefrwwJedxzf8ohXmfZxTK
         l+2CxlPCUwoR9Ova0wB5ZvVm6dhM7uSpdGXgqinfiWDZ2q07we/P3MR4nKzIs4UR8TzE
         V2UA==
X-Gm-Message-State: ABuFfogVtlNzPC5zvihD1xlt7yHojTMoRrqzC/LrTvi6BkiiqbJItMIW
        bh9Rv/0Py9txfCsHFQAUWt4=
X-Google-Smtp-Source: ACcGV60AUxSkpNf88uB0cfWG5HrRPvOdihANP7JquyyOpuwdR+ODgWJCQ6dmtfJMbAWCO4Rca7Ni9g==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr1098541pgh.348.1537839351034;
        Mon, 24 Sep 2018 18:35:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g66-v6sm716784pfk.39.2018.09.24.18.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 18:35:50 -0700 (PDT)
Date:   Mon, 24 Sep 2018 18:35:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        SZ Lin <sz.lin@moxa.com>
Subject: Re: [PATCH 4.9 111/111] MIPS: VDSO: Drop gic_get_usm_range() usage
Message-ID: <20180925013548.GA28493@roeck-us.net>
References: <20180924113103.337261320@linuxfoundation.org>
 <20180924113116.349047480@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924113116.349047480@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Mon, Sep 24, 2018 at 01:53:18PM +0200, Greg Kroah-Hartman wrote:
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 

This patch breaks v4.4.y and v4.9.y builds.
It includes asm/mips-cps.h which doesn't exist in those releases.

Building mips:malta_defconfig:smp:initrd ... failed
------------
Error log:
arch/mips/kernel/vdso.c:23:26: fatal error: asm/mips-cps.h: No such file or directory

Guenter

> ------------------
> 
> From: Paul Burton <paul.burton@imgtec.com>
> 
> commit 00578cd864d45ae4b8fa3f684f8d6f783dd8d15d upstream.
> 
> We don't really need gic_get_usm_range() to abstract discovery of the
> address of the GIC user-visible section now that we have access to its
> base address globally.
> 
> Switch to calculating it ourselves, which will allow us to stop
> requiring the irqchip driver to care about a counter exposed to userland
> for use via the VDSO.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/17040/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/mips/kernel/vdso.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -13,7 +13,6 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
> -#include <linux/irqchip/mips-gic.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
> @@ -21,6 +20,7 @@
>  #include <linux/timekeeper_internal.h>
>  
>  #include <asm/abi.h>
> +#include <asm/mips-cps.h>
>  #include <asm/page.h>
>  #include <asm/vdso.h>
>  
> @@ -101,9 +101,8 @@ int arch_setup_additional_pages(struct l
>  {
>  	struct mips_vdso_image *image = current->thread.abi->vdso;
>  	struct mm_struct *mm = current->mm;
> -	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
> +	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
>  	struct vm_area_struct *vma;
> -	struct resource gic_res;
>  	int ret;
>  
>  	if (down_write_killable(&mm->mmap_sem))
> @@ -127,7 +126,7 @@ int arch_setup_additional_pages(struct l
>  	 * only map a page even though the total area is 64K, as we only need
>  	 * the counter registers at the start.
>  	 */
> -	gic_size = gic_present ? PAGE_SIZE : 0;
> +	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
>  	vvar_size = gic_size + PAGE_SIZE;
>  	size = vvar_size + image->size;
>  
> @@ -168,13 +167,9 @@ int arch_setup_additional_pages(struct l
>  
>  	/* Map GIC user page. */
>  	if (gic_size) {
> -		ret = gic_get_usm_range(&gic_res);
> -		if (ret)
> -			goto out;
> +		gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >> PAGE_SHIFT;
>  
> -		ret = io_remap_pfn_range(vma, base,
> -					 gic_res.start >> PAGE_SHIFT,
> -					 gic_size,
> +		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
>  					 pgprot_noncached(PAGE_READONLY));
>  		if (ret)
>  			goto out;
> 
> 

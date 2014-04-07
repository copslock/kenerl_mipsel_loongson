Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 19:46:31 +0200 (CEST)
Received: from mail-bk0-f45.google.com ([209.85.214.45]:33708 "EHLO
        mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816479AbaDGRq3gGnnf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 19:46:29 +0200
Received: by mail-bk0-f45.google.com with SMTP id na10so699957bkb.4
        for <multiple recipients>; Mon, 07 Apr 2014 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1W2gU+Q0r8j4IbslunvTGRMGsdCB4huSrKbN3KNF8RM=;
        b=BvV4QNHqY2I2KH7bwnrvDSC2pAlxVupMAIq6SK58vVbEJ6g1nk07fcuB6KaYuO6v8E
         Fvvpcf+GyiMxIa/VI2WmZJD2Y6EC/JOx9281oAkXXxJcgA73t7r2GfXxecBbXNLv4x7a
         k1c96Ce92QXriGu4MMwSTiaSeqDi4nfZffp/dcxKG0+v4aZTM000u+m3u0f78P/UVCaf
         rPUA0vzqPA9IGqwrcF3RbWEAx8dmett2sW4p+7CI3cR2Ag4OOsenkbdp5vUQItT/5FSP
         sPRAdlAiiwZ65T8zP8KNjhjfhFDcOf4T8BMV4JeLWAEvESSF4TUYHWtlM/QXe0T3hirt
         Nf7w==
X-Received: by 10.204.108.141 with SMTP id f13mr295bkp.94.1396892784152;
        Mon, 07 Apr 2014 10:46:24 -0700 (PDT)
Received: from alberich ([31.213.120.212])
        by mx.google.com with ESMTPSA id rk5sm7535954bkb.6.2014.04.07.10.46.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 07 Apr 2014 10:46:21 -0700 (PDT)
Date:   Mon, 7 Apr 2014 19:46:17 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     Rob Herring <robherring2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 01/20] mips: octeon: convert to use
 unflatten_and_copy_device_tree
Message-ID: <20140407174617.GA12379@alberich>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
 <1396563423-30893-2-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1396563423-30893-2-git-send-email-robherring2@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
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

On Thu, Apr 03, 2014 at 05:16:44PM -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The octeon FDT code can be simplified by using
> unflatten_and_copy_device_tree function. This removes all accesses to
> FDT header data by the arch code.

Hi Rob,

I think (in general) this modification is ok. But I suggest to use
following (slightly modified) version.


Thanks,

Andreas

-- 8< --
Subject: MIPS: Octeon: Convert to use unflatten_and_copy_device_tree

From: Rob Herring <robh@kernel.org>

The octeon FDT code can be simplified by using
unflatten_and_copy_device_tree function. This removes all accesses to
FDT header data by the arch code.

[andreas.herrmann: * Fixed compile problem:
 arch/mips/cavium-octeon/setup.c: In function 'device_tree_init':
 arch/mips/cavium-octeon/setup.c:1070:7: error: assignment discards 'const' qualifier from pointer target type [-Werror]
 arch/mips/cavium-octeon/setup.c:1073:7: error: assignment discards 'const' qualifier from pointer target type [-Werror]
                   * Removed (now) obsolete extern declarations (for __dtb_octeon_3xxx_end,
                     __dtb_octeon_68xx_end)]

Tested-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/cavium-octeon/setup.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 331b837..72ae938 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1053,36 +1053,26 @@ void prom_free_prom_memory(void)
 int octeon_prune_device_tree(void);
 
 extern const char __dtb_octeon_3xxx_begin;
-extern const char __dtb_octeon_3xxx_end;
 extern const char __dtb_octeon_68xx_begin;
-extern const char __dtb_octeon_68xx_end;
 void __init device_tree_init(void)
 {
-	int dt_size;
-	struct boot_param_header *fdt;
+	const void *fdt;
 	bool do_prune;
 
 	if (octeon_bootinfo->minor_version >= 3 && octeon_bootinfo->fdt_addr) {
 		fdt = phys_to_virt(octeon_bootinfo->fdt_addr);
 		if (fdt_check_header(fdt))
 			panic("Corrupt Device Tree passed to kernel.");
-		dt_size = be32_to_cpu(fdt->totalsize);
 		do_prune = false;
 	} else if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
-		fdt = (struct boot_param_header *)&__dtb_octeon_68xx_begin;
-		dt_size = &__dtb_octeon_68xx_end - &__dtb_octeon_68xx_begin;
+		fdt = &__dtb_octeon_68xx_begin;
 		do_prune = true;
 	} else {
-		fdt = (struct boot_param_header *)&__dtb_octeon_3xxx_begin;
-		dt_size = &__dtb_octeon_3xxx_end - &__dtb_octeon_3xxx_begin;
+		fdt = &__dtb_octeon_3xxx_begin;
 		do_prune = true;
 	}
 
-	/* Copy the default tree from init memory. */
-	initial_boot_params = early_init_dt_alloc_memory_arch(dt_size, 8);
-	if (initial_boot_params == NULL)
-		panic("Could not allocate initial_boot_params");
-	memcpy(initial_boot_params, fdt, dt_size);
+	initial_boot_params = (void *)fdt;
 
 	if (do_prune) {
 		octeon_prune_device_tree();
@@ -1090,7 +1080,7 @@ void __init device_tree_init(void)
 	} else {
 		pr_info("Using passed Device Tree.\n");
 	}
-	unflatten_device_tree();
+	unflatten_and_copy_device_tree();
 }
 
 static int __initdata disable_octeon_edac_p;
-- 
1.7.9.5

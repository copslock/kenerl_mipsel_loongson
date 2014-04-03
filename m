Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 00:18:04 +0200 (CEST)
Received: from mail-oa0-f51.google.com ([209.85.219.51]:44878 "EHLO
        mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822270AbaDCWRcyNgic (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 00:17:32 +0200
Received: by mail-oa0-f51.google.com with SMTP id i4so2743118oah.10
        for <multiple recipients>; Thu, 03 Apr 2014 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=07Ck94LCQxmgS3KCX+p5oW0WzAqYvgQFS4VpSQIGUNU=;
        b=lLKDOrFtv9bD/l7iZaJVJ6Paz0k0+V+xFrn9YhvUlfZSbVK1rYXsM3nA3aglsqHF2Z
         yXEGS/COf0WUlC4eRtRexgWLyqxpaQIvbc4uBOnJVR/rrmPyj6/5SSzMV6Dc4xX0euGP
         WvMjmrMc9zA1+XYzmSxPYHSz4msrTIbn5qBU4bFSrB3h83SzAeNqJnUWKdqGvEII3L/J
         9zyeK/B7Wf2UJs9+ox4xmybt6rvf+VAu/l1TBIY9GZ503jWGK2O5kjqmQzsVDsHOoDjW
         jjTxz0AqahFr+J+98f3hhLhrBrmIPqnAIS+kvI8aHPDa2xX7lIbr8tSZwiEBHfqJDulF
         ntjA==
X-Received: by 10.60.162.7 with SMTP id xw7mr12410017oeb.13.1396563446619;
        Thu, 03 Apr 2014 15:17:26 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id dh8sm27577997oeb.10.2014.04.03.15.17.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Apr 2014 15:17:26 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 01/20] mips: octeon: convert to use unflatten_and_copy_device_tree
Date:   Thu,  3 Apr 2014 17:16:44 -0500
Message-Id: <1396563423-30893-2-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

From: Rob Herring <robh@kernel.org>

The octeon FDT code can be simplified by using
unflatten_and_copy_device_tree function. This removes all accesses to
FDT header data by the arch code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/cavium-octeon/setup.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 331b837..0b27411 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1058,31 +1058,23 @@ extern const char __dtb_octeon_68xx_begin;
 extern const char __dtb_octeon_68xx_end;
 void __init device_tree_init(void)
 {
-	int dt_size;
-	struct boot_param_header *fdt;
+	void *fdt;
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
+	initial_boot_params = fdt;
 
 	if (do_prune) {
 		octeon_prune_device_tree();
@@ -1090,7 +1082,7 @@ void __init device_tree_init(void)
 	} else {
 		pr_info("Using passed Device Tree.\n");
 	}
-	unflatten_device_tree();
+	unflatten_and_copy_device_tree();
 }
 
 static int __initdata disable_octeon_edac_p;
-- 
1.8.3.2

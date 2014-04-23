Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 03:19:16 +0200 (CEST)
Received: from mail-oa0-f43.google.com ([209.85.219.43]:47331 "EHLO
        mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825879AbaDWBS4LMtTL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 03:18:56 +0200
Received: by mail-oa0-f43.google.com with SMTP id eb12so302312oac.2
        for <multiple recipients>; Tue, 22 Apr 2014 18:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QaF2swIeaiUdOP5eZeMAhxU0mCQK5nfAsD60oyTQe/w=;
        b=ZFlijuHH/jJ0HewVP4Liuscu2jlSc52yjBrF8QvgfLvrM3rgFr2sdpdxhdPSKxbB1M
         z3YtRnixUA8kBBiGzamE2jvOaFqEEH49ujPbi/JoXh9JQlD/Fv4d7OS7cLASsktLY4LX
         mZoZPLc154GcteLSOy3x3woN8romNZNgjwEv0YR2OsQYUD6+C5GIro0KD3ubrayNC226
         HYYPgUEa7Mof2K4HJ3PvxF2VjVWWui/ul9kVvW/t25pHVw6iZRQP3H4BmF/ec5fjk2CD
         i5+lPn+xGvwFSj9wPP9QeKAsOh5fExtkAZAsJkQ2FYNiaKWkyMqVKaHJo1ND7G4sm9wE
         x/Wg==
X-Received: by 10.182.113.227 with SMTP id jb3mr7474431obb.3.1398215929881;
        Tue, 22 Apr 2014 18:18:49 -0700 (PDT)
Received: from localhost.localdomain (72-48-77-163.dyn.grandenetworks.net. [72.48.77.163])
        by mx.google.com with ESMTPSA id f1sm184735295oej.5.2014.04.22.18.18.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 18:18:49 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     Grant Likely <grant.likely@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: [PATCH v2 01/21] mips: octeon: convert to use unflatten_and_copy_device_tree
Date:   Tue, 22 Apr 2014 20:18:01 -0500
Message-Id: <1398215901-25609-2-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39901
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
v2: fix build error

 arch/mips/cavium-octeon/setup.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 331b837..f1bec00 100644
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
1.9.1

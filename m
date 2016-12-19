Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:12:47 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33097 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992943AbcLSCIL4P7IK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:11 +0100
Received: by mail-lf0-f66.google.com with SMTP id y21so6156970lfa.0;
        Sun, 18 Dec 2016 18:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8LDg1TTkvlgPqBPMtNZJ2j4fJU69WpTo7qb3+VC0l44=;
        b=e6TPTH7HelHC9PSt4KpU1HHXi1ZjDuNued9/FVlNqiWI0oiJS4E2k6R3dFdZjkFTaw
         lxWW+QCJE+NhHUaK4hsPrkXoMCLbEoRXE/wP7sFz46AE7eYhaWanlcnvQ+Ab39HL08HI
         4unZbLfcczWFTb76ek9CMYJAtAN/Vy1jqMlAEfQh7GeiphOrqrx3JGQrjL2as8Sp/Mup
         EveHfDXNMJ8HSBnqvhzNwj0YJ7T2/XpaBbKD38mdk+oR+rdnXIwTF2nNsyVec4tJ+01U
         q9muBPjUYLJlExRn8hfexrYrpuu8otSNlsARNE8GzFO33YT+ujnDfQC3358uxfTLzy77
         BHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8LDg1TTkvlgPqBPMtNZJ2j4fJU69WpTo7qb3+VC0l44=;
        b=LJf7ByNSP0G4ADdjqx9DUBxijyLRxqSCv95OtrdDKe5c8UtYNP7bpC+4b8iKR3Uy+g
         RHxUo9XXwoHFP+JpWiJnsNWWP/RlnxTYdOqwf9KdasWZUGmudFQKPPJ9lf/OgcCYUnj6
         K8ui6txEWy1CUYRwdEEua38huEpt9K2aLKWcmO+bAa9pu+cCKOSJVSIDCCngrIE83Soh
         gN7t0ho4QFQuByGCkWcUoJPdjVid3qPOrpHp04RHXCJDOVFJlM64vBPjbM6XDHlPTwEp
         0iZ5VZfURsApNXk5uF8kZJyNHhJ0jRgs4gkbVQtQEfIhn2IJH5JnNWvfZ2YoRjEfCL/9
         g+8A==
X-Gm-Message-State: AIkVDXJ7YTXjge/GQNrDL0fUZ/JAcwp9stHhBrhNIYl4HsRpHPQm42igMJruaj04GqVRRQ==
X-Received: by 10.46.8.25 with SMTP id 25mr6135150lji.21.1482113286376;
        Sun, 18 Dec 2016 18:08:06 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:05 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 12/21] MIPS memblock: Add memblock print outs in debug
Date:   Mon, 19 Dec 2016 05:07:37 +0300
Message-Id: <1482113266-13207-13-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56074
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

When debugging it is useful to have a list of all memory regions
added and reserved in the system. Ones are printed right from
memblock if memblock_debug is enabled.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index d2f410d..409d23d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -200,11 +200,16 @@ void __init detect_memory_region(phys_addr_t start, phys_addr_t sz_min, phys_add
 	add_memory_region(start, size, BOOT_MEM_RAM);
 }
 
+/*
+ * Print declared memory layout
+ */
 static void __init print_memory_map(void)
 {
 	int i;
 	const int field = 2 * sizeof(unsigned long);
 
+	/* Print the added memory map  */
+	pr_info("Determined physical RAM map:\n");
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		printk(KERN_INFO " memory: %0*Lx @ %0*Lx ",
 		       field, (unsigned long long) boot_mem_map.map[i].size,
@@ -228,6 +233,9 @@ static void __init print_memory_map(void)
 			break;
 		}
 	}
+
+	/* Print memblocks if memblock_debug is set */
+	memblock_dump_all();
 }
 
 /*
@@ -795,11 +803,11 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* Sanity check the specified memory */
 	sanity_check_meminfo();
 
-	pr_info("Determined physical RAM map:\n");
-	print_memory_map();
-
 	bootmem_init();
 
+	/* Print memory map initialized by arch-specific code and params */
+	print_memory_map();
+
 	device_tree_init();
 	sparse_init();
 	plat_swiotlb_setup();
-- 
2.6.6

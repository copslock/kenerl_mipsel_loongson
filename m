Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:09:28 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36736 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992244AbcLSCIBwE5SK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:01 +0100
Received: by mail-lf0-f66.google.com with SMTP id o20so6141392lfg.3;
        Sun, 18 Dec 2016 18:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aJivAl0WCJIEGfFDNoU4GZzBim6nTlfaERlbdSYrE0M=;
        b=I22OhYCHMpxWpO99vccQKTzG/ypDA5v5IMaRpRoMS4vuPaN2B2+rRZYNC42no/GQqR
         06/YIVUM7LqOy+orKUy9Lij1FfPO2bXX81xJFZOOlobUUd6WWIw12neDF6gHUP9nkTPF
         k/ILzRd0WS2orRfOEl/z453vE5qM0xAek2SlDMSAjYx2CAJG2N25DHcXt6xdHxHIYpyK
         60DLRFTTZNeUo4Q9Ye8j7mRCkA4Uyzb1YqqXwKnul74LkRIBnjVyAWMfmXSEiaTD6DLX
         zWFxQ2/CAYDUUzJ1TXgS83kF2NwzxJmzEBToVQFbB8+cjJBqHWXRCzg53yD39UFlNLSy
         gH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aJivAl0WCJIEGfFDNoU4GZzBim6nTlfaERlbdSYrE0M=;
        b=IFPx8pI4kO8CKolptW5AZPd+KRjOKixatVPfAEdXf24NrxELoHDiz6jBxvLIsGEE2A
         oF3BwGTbf2epHgSnPOWbK5Yu64vGMnFJ1/ABqVeX+a2BlN+hlvCIGCp2jT/Rgv7SbL18
         U1nkgEyU8FBF+P/b77Qtjtwgw/7xvJbhKr6hxkBLUdMDf6J9BIxr6NSZqYBuNLTcfba4
         fbwqNvRGn/3H0O6EpLsEE/3kE0iBgl/G40qXV3MheAuLn9VwTBG+NRdK3/bk3fqfiHNN
         lwUwLosuW0I1VP3LxV3fYKKN1ecDMkHBHZjMk5kiLYpvoXgDX+NuIj1Tie2im5fIUzZq
         OpfA==
X-Gm-Message-State: AIkVDXKonbZeRxASzRqJnpSZdFs/CdSNYB4RtNMZUW9xggwgVG/m+fDroGZs4zrL6o30Fg==
X-Received: by 10.46.33.165 with SMTP id h37mr6267220lji.57.1482113276376;
        Sun, 18 Dec 2016 18:07:56 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:07:55 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 03/21] MIPS memblock: Alter traditional add_memory_region() method
Date:   Mon, 19 Dec 2016 05:07:28 +0300
Message-Id: <1482113266-13207-4-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56066
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

There is no safe and fast way to get rid of boot_mem_map usage in
the wide set of platform code. But it's luck, that the architecture
specific code doesn't make any direct changes in the boot_mem_map
structure. Additionally the platform specific code registers the
available memory using traditional add_memory_region() method.
It's obvious, that one needs to be modified adding regions to both
new memblock allocator and old boot_mem_map subsystem. In this way
most of architecture specific code won't be broken.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 51 ++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 084ba6c..9da6f8a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -82,10 +82,19 @@ static struct resource data_resource = { .name = "Kernel data", };
 
 static void *detect_magic __initdata = detect_memory_region;
 
+/*
+ * General method to add RAM regions to the system
+ *
+ * NOTE Historically this method has been used to register memory blocks within
+ *      MIPS kernel code in the boot_mem_map array. So we need to support it
+ * up until it's discarded from platform-depended code.
+ * On the other hand it might be good to have it, since we can check regions
+ * before actually adding them
+ */
 void __init add_memory_region(phys_addr_t start, phys_addr_t size, long type)
 {
 	int x = boot_mem_map.nr_map;
-	int i;
+	int ret, i;
 
 	/*
 	 * If the region reaches the top of the physical address space, adjust
@@ -94,15 +103,51 @@ void __init add_memory_region(phys_addr_t start, phys_addr_t size, long type)
 	if (start + size - 1 == (phys_addr_t)ULLONG_MAX)
 		--size;
 
-	/* Sanity check */
+	/* Sanity check the region */
 	if (start + size < start) {
 		pr_warn("Trying to add an invalid memory region, skipped\n");
 		return;
 	}
 
+	/* Make sure the type is supported */
+	if (type != BOOT_MEM_RAM && type != BOOT_MEM_INIT_RAM &&
+	    type != BOOT_MEM_ROM_DATA && type != BOOT_MEM_RESERVED) {
+		pr_warn("Invalid type of memory region, skipped\n");
+		return;
+	}
+
 	/*
-	 * Try to merge with existing entry, if any.
+	 * According to the request_resource logic RAM, INIT and ROM shouldn't
+	 * intersect each other but being subset of one memory space
 	 */
+	if (type != BOOT_MEM_RESERVED && memblock_is_memory(start)) {
+		pr_warn("Drop already added memory region %08zx @ %pa\n",
+			(size_t)size, &start);
+		return;
+	}
+
+	/*
+	 * Add the region to the memblock allocator. Reserved regions should be
+	 * in the memory as well to be actually reserved.
+	 */
+	ret = memblock_add_node(start, size, 0);
+	if (ret < 0) {
+		pr_err("Could't add memblock %08zx @ %pa\n",
+			(size_t)size, &start);
+		return;
+	}
+
+	/* Reserve memory region passed with the corresponding flags */
+	if (type != BOOT_MEM_RAM) {
+		ret = memblock_reserve(start, size);
+		if (ret < 0) {
+			pr_err("Could't reserve memblock %08zx @ %pa\n",
+				(size_t)size, &start);
+			return;
+		}
+	}
+
+	/* Try to combine with existing entry, if any. */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		struct boot_mem_map_entry *entry = boot_mem_map.map + i;
 		unsigned long top;
-- 
2.6.6

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 14:12:20 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994744AbeBUNLQuXGRT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 14:11:16 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E12D51242;
        Wed, 21 Feb 2018 13:10:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Malaterre <mathieu.malaterre@gmail.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Mathieu Malaterre <malat@debian.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 114/163] MIPS: Fix incorrect mem=X@Y handling
Date:   Wed, 21 Feb 2018 13:49:03 +0100
Message-Id: <20180221124536.453895962@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@mips.com>

commit 67a3ba25aa955198196f40b76b329b3ab9ad415a upstream.

Commit 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing") added a
fix to ensure that the memory range between PHYS_OFFSET and low memory
address specified by mem= cmdline argument is not later processed by
free_all_bootmem.  This change was incorrect for systems where the
commandline specifies more than 1 mem argument, as it will cause all
memory between PHYS_OFFSET and each of the memory offsets to be marked
as reserved, which results in parts of the RAM marked as reserved
(Creator CI20's u-boot has a default commandline argument 'mem=256M@0x0
mem=768M@0x30000000').

Change the behaviour to ensure that only the range between PHYS_OFFSET
and the lowest start address of the memories is marked as protected.

This change also ensures that the range is marked protected even if it's
only defined through the devicetree and not only via commandline
arguments.

Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
Fixes: 73fbc1eba7ff ("MIPS: fix mem=X@Y commandline processing")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # v4.11+
Tested-by: Mathieu Malaterre <malat@debian.org>
Patchwork: https://patchwork.linux-mips.org/patch/18562/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/setup.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -375,6 +375,7 @@ static void __init bootmem_init(void)
 	unsigned long reserved_end;
 	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
+	phys_addr_t ramstart = (phys_addr_t)ULLONG_MAX;
 	bool bootmap_valid = false;
 	int i;
 
@@ -395,7 +396,8 @@ static void __init bootmem_init(void)
 	max_low_pfn = 0;
 
 	/*
-	 * Find the highest page frame number we have available.
+	 * Find the highest page frame number we have available
+	 * and the lowest used RAM address
 	 */
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
@@ -407,6 +409,8 @@ static void __init bootmem_init(void)
 		end = PFN_DOWN(boot_mem_map.map[i].addr
 				+ boot_mem_map.map[i].size);
 
+		ramstart = min(ramstart, boot_mem_map.map[i].addr);
+
 #ifndef CONFIG_HIGHMEM
 		/*
 		 * Skip highmem here so we get an accurate max_low_pfn if low
@@ -436,6 +440,13 @@ static void __init bootmem_init(void)
 		mapstart = max(reserved_end, start);
 	}
 
+	/*
+	 * Reserve any memory between the start of RAM and PHYS_OFFSET
+	 */
+	if (ramstart > PHYS_OFFSET)
+		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
+				  BOOT_MEM_RESERVED);
+
 	if (min_low_pfn >= max_low_pfn)
 		panic("Incorrect memory mapping !!!");
 	if (min_low_pfn > ARCH_PFN_OFFSET) {
@@ -664,9 +675,6 @@ static int __init early_parse_mem(char *
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
 
-	if (start && start > PHYS_OFFSET)
-		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
-				BOOT_MEM_RESERVED);
 	return 0;
 }
 early_param("mem", early_parse_mem);

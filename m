Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2015 17:16:46 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:49285 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009786AbbGBPQoBliOU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2015 17:16:44 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t62FG8Ir025727
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 2 Jul 2015 15:16:09 GMT
Received: from [10.151.15.185] ([10.151.15.185])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t62FG19R022745;
        Thu, 2 Jul 2015 17:16:02 +0200
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Joe Perches <joe@perches.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Yusuf Khan <yusuf.khan@nokia.com>,
        Michael Kreuzer <michael.kreuzer@nokia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: [PATCH RFC] mips: bootmem: Don't use memory holes for page bitmap
Message-ID: <559555B1.7000207@nokia.com>
Date:   Thu, 2 Jul 2015 17:16:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2385
X-purgate-ID: 151667::1435850171-000076F8-595BB698/0/0
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

Commit f9a7febd leads to a fact that mapstart and therefore a page bitmap for
bootmem allocator immediately follows initrd_end. This doesn't always work
well on Octeon, where there are holes in PFN ranges (refer to 5b3b1688 and
4MB-aligned PFN allocation). Depending on the inird location it could happen,
that mapstart would be in an area not allocated by plat_mem_setup() in
arch/mips/cavium-octeon/setup.c, but in the alignment hole between initrd and
the next PFN area. Later on this memory will be unconditionally made available
to buddy allocator at the end of free_all_bootmem_core() (mm/bootmem.c).
All of this results in Linux using the memory not designated for Linux in
Octeon's plat_mem_setup(), which in turn means corruption of the memory used
by another OS/baremetal code on the same SoC.

It doesn't look to me as a problem of Octeon platform code, but rather as an
inability of f9a7febd to deal correctly with the fragmented memory-mappings.
Proposed fix moves the check for initrd address to the same calculation-loop
in bootmem_init() (arch/mips/kernel/setup.c), which also accounts for kernel
code location. This should result in mapstart located starting from the first
PFN area after kernel code AND initrd.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---

Tested on CN63xx (Octeon2) -based HW.

 arch/mips/kernel/setup.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index be73c49..008b337 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -337,6 +337,11 @@ static void __init bootmem_init(void)
 			min_low_pfn = start;
 		if (end <= reserved_end)
 			continue;
+#ifdef CONFIG_BLK_DEV_INITRD
+		/* mapstart should be after initrd_end */
+		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
+			continue;
+#endif
 		if (start >= mapstart)
 			continue;
 		mapstart = max(reserved_end, start);
@@ -366,14 +371,6 @@ static void __init bootmem_init(void)
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	/*
-	 * mapstart should be after initrd_end
-	 */
-	if (initrd_end)
-		mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
-#endif
-
 	/*
 	 * Initialize the boot-time allocator with low memory only.
 	 */

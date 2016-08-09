Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:22:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6210 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992535AbcHIMWLtYLyf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:22:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5451F3E0C3555;
        Tue,  9 Aug 2016 13:21:52 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 9 Aug 2016 13:21:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: Allow memory reaching top of physical
Date:   Tue, 9 Aug 2016 13:21:48 +0100
Message-ID: <97c186f23c1176b8d0eaaf7a8b0dad1a16b851de.1470745146.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <cover.842913b0756706569a896ef308bb5bf98be4f0ce.1470745146.git-series.james.hogan@imgtec.com>
References: <cover.842913b0756706569a896ef308bb5bf98be4f0ce.1470745146.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Memory regions added with add_memory_region() at the top of the physical
address space will have their end address overflow to 0. This causes
them to be rejected as invalid, and would cause various other issues
later on.

This causes issues on Malta and Boston platforms when wanting to use all
2GB of RAM on a 32-bit kernel, either via highmem (using physical
addresses 0x90000000..0xFFFFFFFF), or with the Malta Enhanced Virtual
Addressing (EVA) layout which exposes the whole 0x80000000..0xFFFFFFFF
physical address range to kernel mode at 0x00000000..0x7FFFFFFF.

Due to the abundance of these non-overflow assumptions and the fact that
memblock already avoids the arithmetic overflow by limiting the size of
new memory regions without the arch code knowing it (in particular
mem_init_free_highmem() will trigger a page dump due to nonzero mapcount
on the last page), it is simpler and safer to just limit the size of the
region in a similar way to memblock but at the arch level to allow most
of the RAM to be used without arithmetic overflows.

Therefore we detect this case specifically and reduce the size of the
region slightly to avoid the arithmetic overflows and cause the last
page to be ignored.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/setup.c | 7 +++++++
 1 file changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 36cf8d65c47d..3be0e6ba2797 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -87,6 +87,13 @@ void __init add_memory_region(phys_addr_t start, phys_addr_t size, long type)
 	int x = boot_mem_map.nr_map;
 	int i;
 
+	/*
+	 * If the region reaches the top of the physical address space, adjust
+	 * the size slightly so that (start + size) doesn't overflow
+	 */
+	if (start + size - 1 == (phys_addr_t)ULLONG_MAX)
+		--size;
+
 	/* Sanity check */
 	if (start + size < start) {
 		pr_warn("Trying to add an invalid memory region, skipped\n");
-- 
git-series 0.8.7

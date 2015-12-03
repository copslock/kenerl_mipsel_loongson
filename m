Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 11:10:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45050 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012932AbbLCKIddiojZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 11:08:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id D5C006FB0824
        for <linux-mips@linux-mips.org>; Thu,  3 Dec 2015 10:08:25 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 3 Dec 2015 10:08:27 +0000
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 3 Dec 2015 10:08:27 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 7/9] MIPS: bootmem: When relocatable, free memory below kernel
Date:   Thu, 3 Dec 2015 10:08:15 +0000
Message-ID: <1449137297-30464-8-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

The kernel reserves all memory before the _end symbol as bootmem,
however, once the kernel can be relocated elsewhere in memory this may
result in a large amount of wasted memory. The assumption is that the
memory between the link and relocated address of the kernel may be
released back to the available memory pool.

Memory statistics for a Malta with the kernel relocating by
16Mb, without the patch:
Memory: 105952K/131072K available (4604K kernel code, 242K rwdata,
892K rodata, 1280K init, 183K bss, 25120K reserved, 0K cma-reserved)
And with the patch:
Memory: 122336K/131072K available (4604K kernel code, 242K rwdata,
892K rodata, 1280K init, 183K bss, 8736K reserved, 0K cma-reserved)

The 16Mb offset is removed from the reserved region and added back to
the available region.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 arch/mips/kernel/setup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 479515109e5b..15c3e5892ced 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -464,6 +464,19 @@ static void __init bootmem_init(void)
 	 */
 	reserve_bootmem(PFN_PHYS(mapstart), bootmap_size, BOOTMEM_DEFAULT);
 
+#ifdef CONFIG_RELOCATABLE
+	/* The kernel reserves all memory below it's _end symbol as bootmem,
+	 * but the kernel may now be at a much higher address. The memory
+	 * between the original and new locations may be returned to the system.
+	 */
+	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
+		unsigned long offset;
+
+		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
+		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
+	}
+#endif
+
 	/*
 	 * Reserve initrd memory if needed.
 	 */
-- 
2.1.4

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:56:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25044 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026815AbbEVP4Cxfcuh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:56:02 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 657E26163D99E;
        Fri, 22 May 2015 16:55:55 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:55:58 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:55:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 15/15] MIPS: malta: setup post-I/O hole RAM on non-EVA
Date:   Fri, 22 May 2015 16:51:14 +0100
Message-ID: <1432309875-9712-16-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

If the system has more than 256MB RAM (ie. more than will fit in the
unmapped kseg[01] regions before the I/O hole) then set up a region to
use that memory via its alias in the upper half of the physical address
space, where the I/O hole is not present. This allows highmem to be used
on Malta without needing to manually specify mem= parameters on the
kernel command line.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mti-malta/malta-dtshim.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index 9074951..6320b44 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -23,7 +23,7 @@ static unsigned char fdt_buf[16 << 10] __initdata;
 /* determined physical memory size, not overridden by command line args	 */
 extern unsigned long physical_memsize;
 
-#define MAX_MEM_ARRAY_ENTRIES 1
+#define MAX_MEM_ARRAY_ENTRIES 2
 
 static unsigned __init gen_fdt_mem_array(__be32 *mem_array, unsigned long size)
 {
@@ -37,6 +37,12 @@ static unsigned __init gen_fdt_mem_array(__be32 *mem_array, unsigned long size)
 	} else {
 		size_preio = min_t(unsigned long, size, 256 << 20);
 		mem_array[1] = cpu_to_be32(PHYS_OFFSET + size_preio);
+
+		if (size > size_preio) {
+			entries++;
+			mem_array[2] = cpu_to_be32(0x80000000 + size_preio);
+			mem_array[3] = cpu_to_be32(size - size_preio);
+		}
 	}
 
 	BUG_ON(entries > MAX_MEM_ARRAY_ENTRIES);
-- 
2.4.1

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:38:38 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44847 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870567AbaA0U2DStN-0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:28:03 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 54/58] MIPS: malta: malta-memory: Use the PHYS_OFFSET to build the memory map
Date:   Mon, 27 Jan 2014 20:19:41 +0000
Message-ID: <1390853985-14246-55-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_27_58
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

PHYS_OFFSET is used to denote the physical start address of the
first bank of RAM. When the Malta board is in EVA mode, the physical
start address of RAM is shifted to 0x80000000 so it's necessary to use
this macro in order to make the code EVA agnostic.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/malta-memory.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index cd04008..9235aee8 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -81,11 +81,11 @@ fw_memblock_t * __init fw_getmdesc(int eva)
 	memset(mdesc, 0, sizeof(mdesc));
 
 	mdesc[0].type = fw_dontuse;
-	mdesc[0].base = 0x00000000;
+	mdesc[0].base = PHYS_OFFSET;
 	mdesc[0].size = 0x00001000;
 
 	mdesc[1].type = fw_code;
-	mdesc[1].base = 0x00001000;
+	mdesc[1].base = mdesc[0].base + 0x00001000UL;
 	mdesc[1].size = 0x000ef000;
 
 	/*
@@ -96,17 +96,17 @@ fw_memblock_t * __init fw_getmdesc(int eva)
 	 * devices.
 	 */
 	mdesc[2].type = fw_dontuse;
-	mdesc[2].base = 0x000f0000;
+	mdesc[2].base = mdesc[0].base + 0x000f0000UL;
 	mdesc[2].size = 0x00010000;
 
 	mdesc[3].type = fw_dontuse;
-	mdesc[3].base = 0x00100000;
+	mdesc[3].base = mdesc[0].base + 0x00100000UL;
 	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) -
-		mdesc[3].base;
+		0x00100000UL;
 
 	mdesc[4].type = fw_free;
-	mdesc[4].base = CPHYSADDR(PFN_ALIGN(&_end));
-	mdesc[4].size = memsize - mdesc[4].base;
+	mdesc[4].base = mdesc[0].base + CPHYSADDR(PFN_ALIGN(&_end));
+	mdesc[4].size = memsize - CPHYSADDR(mdesc[4].base);
 
 	return &mdesc[0];
 }
-- 
1.8.5.3

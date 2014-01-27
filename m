Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:38:19 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44846 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831312AbaA0U2DOmAGO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:28:03 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 55/58] MIPS: malta: malta-memory: Add free_init_pages_eva() callback
Date:   Mon, 27 Jan 2014 20:19:42 +0000
Message-ID: <1390853985-14246-56-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 39173
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

Use a Malta specific function to free the init section once the
kernel has booted. When operating in EVA mode, the physical memory
is shifted to 0x80000000. Kernel is loaded into 0x80000000 (virtual)
so the offset between physical and virtual addresses is 0.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/malta-memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 9235aee8..6d0f4ab 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -111,6 +111,12 @@ fw_memblock_t * __init fw_getmdesc(int eva)
 	return &mdesc[0];
 }
 
+static void free_init_pages_eva_malta(void *begin, void *end)
+{
+	free_init_pages("unused kernel", __pa_symbol((unsigned long *)begin),
+			__pa_symbol((unsigned long *)end));
+}
+
 static int __init fw_memtype_classify(unsigned int type)
 {
 	switch (type) {
@@ -128,6 +134,8 @@ void __init fw_meminit(void)
 	fw_memblock_t *p;
 
 	p = fw_getmdesc(config_enabled(CONFIG_EVA));
+	free_init_pages_eva = (config_enabled(CONFIG_EVA) ?
+			       free_init_pages_eva_malta : NULL);
 
 	while (p->size) {
 		long type;
-- 
1.8.5.3

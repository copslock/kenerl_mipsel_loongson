Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2014 14:32:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39462 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817664AbaEWMcJcdQTf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 May 2014 14:32:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CBF7A8F1FD932;
        Fri, 23 May 2014 13:32:00 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 23 May 2014 13:32:02 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.137) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 23 May 2014 13:32:02 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: malta: memory.c: Initialize the 'memsize' variable
Date:   Fri, 23 May 2014 13:31:31 +0100
Message-ID: <1400848292-19544-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.137]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40252
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

If the 'memsize' environmental variable is not set by the bootloader
the 'memsize' variable is not initialized, leading to potential memory
problems. This patch fixes the problem by setting the initial
value to '0' to force the kernel to set a good default memory size.

Cc: <stable@vger.kernel.org> # v3.15+
Reported-by: Matheus Almeida <Matheus.Almeida@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/malta-memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 6d0f4ab..f2364e4 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -27,7 +27,7 @@ unsigned long physical_memsize = 0L;
 fw_memblock_t * __init fw_getmdesc(int eva)
 {
 	char *memsize_str, *ememsize_str __maybe_unused = NULL, *ptr;
-	unsigned long memsize, ememsize __maybe_unused = 0;
+	unsigned long memsize = 0, ememsize __maybe_unused = 0;
 	static char cmdline[COMMAND_LINE_SIZE] __initdata;
 	int tmp;
 
-- 
1.9.3

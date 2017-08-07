Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 00:40:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10584 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995123AbdHGWjAdhreI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 00:39:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AEC90132D5053;
        Mon,  7 Aug 2017 23:38:49 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Aug 2017 23:38:54
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Nathan Sullivan <nathan.sullivan@ni.com>
Subject: [PATCH 4/4] MIPS: NI 169445: Fix lack of ITS root node
Date:   Mon, 7 Aug 2017 15:37:24 -0700
Message-ID: <20170807223724.19408-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170807223724.19408-1-paul.burton@imgtec.com>
References: <20170807223724.19408-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59405
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

For some reason the root node was missing in the NI 169445 flattened
image tree source, leading to the following build error when attempting
to generate the flattened image tree binary:

  ITB     arch/mips/boot/vmlinux.gz.itb
Error: arch/mips/boot/vmlinux.gz.its:90.1-2 syntax error
FATAL ERROR: Unable to parse input tree
/usr/bin/mkimage: Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
make[1]: *** [arch/mips/boot/Makefile:165: arch/mips/boot/vmlinux.gz.itb] Error 255
make: *** [arch/mips/Makefile:371: vmlinux.gz.itb] Error 2

Fix this by adding in the root node.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 65dca6aed98d ("MIPS: NI 169445 board support")
Cc: Nathan Sullivan <nathan.sullivan@ni.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/generic/board-ni169445.its.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/generic/board-ni169445.its.S b/arch/mips/generic/board-ni169445.its.S
index d12e12fe90be..e4cb4f95a8cc 100644
--- a/arch/mips/generic/board-ni169445.its.S
+++ b/arch/mips/generic/board-ni169445.its.S
@@ -1,4 +1,4 @@
-{
+/ {
 	images {
 		fdt@ni169445 {
 			description = "NI 169445 device tree";
-- 
2.14.0

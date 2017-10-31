Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 22:41:29 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:33300 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991940AbdJaVlVy01Gl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 22:41:21 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 21:41:15 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 31 Oct 2017 14:40:42 -0700
From:   James Hogan <james.hogan@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
CC:     James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Nathan Sullivan <nathan.sullivan@ni.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH for-4.14] MIPS: generic: Fix NI 169445 its build
Date:   Tue, 31 Oct 2017 21:41:07 +0000
Message-ID: <20171031214107.15596-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509486062-452059-3089-435384-5
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186462
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

Since commit 04a85e087ad6 ("MIPS: generic: Move NI 169445 FIT image
source to its own file"), a generic 32r2el_defconfig kernel fails to
build with the following build error:

  ITB     arch/mips/boot/vmlinux.gz.itb
Error: arch/mips/boot/vmlinux.gz.its:111.1-2 syntax error
FATAL ERROR: Unable to parse input tree
mkimage Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument

This is because arch/mips/generic/board-ni169445.its.S doesn't include
the necessary "/" node path before the first open brace, which did
previously exist when it was in arch/mips/generic/vmlinux.its.S.

Fixes: 04a85e087ad6 ("MIPS: generic: Move NI 169445 FIT image source to its own file")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Nathan Sullivan <nathan.sullivan@ni.com>
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
2.14.1

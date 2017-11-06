Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2017 21:20:07 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:47411 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990593AbdKFUUASMijm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Nov 2017 21:20:00 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 06 Nov 2017 20:19:19 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 6 Nov 2017 12:18:18 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <stable@vger.kernel.org>
CC:     James Hogan <james.hogan@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, James Hogan <jhogan@kernel.org>
Subject: [PATCH BACKPORT 3.15..4.13] MIPS: Fix CM region target definitions
Date:   Mon, 6 Nov 2017 20:19:02 +0000
Message-ID: <20171106201902.20659-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509999553-452060-31094-973433-10
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186646
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60726
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

From: Paul Burton <paul.burton@mips.com>

commit 6a6cba1d945a7511cdfaf338526871195e420762 upstream.

The default CM target field in the GCR_BASE register is encoded with 0
meaning memory & 1 being reserved. However the definitions we use for
those bits effectively get these two values backwards - likely because
they were copied from the definitions for the CM regions where the
target is encoded differently. This results in use setting up GCR_BASE
with the reserved target value by default, rather than targeting memory
as intended. Although we currently seem to get away with this it's not a
great idea to rely upon.

Fix this by changing our macros to match the documentated target values.

The incorrect encoding became used as of commit 9f98f3dd0c51 ("MIPS: Add
generic CM probe & access code") in the Linux v3.15 cycle, and was
likely carried forwards from older but unused code introduced by
commit 39b8d5254246 ("[MIPS] Add support for MIPS CMP platform.") in the
v2.6.26 cycle.

Fixes: 9f98f3dd0c51 ("MIPS: Add generic CM probe & access code")
Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17562/
Signed-off-by: James Hogan <jhogan@kernel.org>
[jhogan@kernel.org: Backported 3.15..4.13]
---
 arch/mips/include/asm/mips-cm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index cfdbab015769..163317fd3d7e 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -240,8 +240,8 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define CM_GCR_BASE_GCRBASE_MSK			(_ULCAST_(0x1ffff) << 15)
 #define CM_GCR_BASE_CMDEFTGT_SHF		0
 #define CM_GCR_BASE_CMDEFTGT_MSK		(_ULCAST_(0x3) << 0)
-#define  CM_GCR_BASE_CMDEFTGT_DISABLED		0
-#define  CM_GCR_BASE_CMDEFTGT_MEM		1
+#define  CM_GCR_BASE_CMDEFTGT_MEM		0
+#define  CM_GCR_BASE_CMDEFTGT_RESERVED		1
 #define  CM_GCR_BASE_CMDEFTGT_IOCU0		2
 #define  CM_GCR_BASE_CMDEFTGT_IOCU1		3
 
-- 
2.14.1

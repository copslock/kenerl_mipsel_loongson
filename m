Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 14:57:08 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38348 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827313AbaAON4s3mwG1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 14:56:48 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 01/10] MIPS: inst.h: define COP0 wait op
Date:   Wed, 15 Jan 2014 13:55:28 +0000
Message-ID: <1389794137-11361-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_13_56_42
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39002
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

The func field for the wait instruction was missing from inst.h - this
patch adds it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index b39ba25..b4a24bd 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -118,7 +118,8 @@ enum bcop_op {
 enum cop0_coi_func {
 	tlbr_op	      = 0x01, tlbwi_op	    = 0x02,
 	tlbwr_op      = 0x06, tlbp_op	    = 0x08,
-	rfe_op	      = 0x10, eret_op	    = 0x18
+	rfe_op	      = 0x10, eret_op	    = 0x18,
+	wait_op       = 0x20,
 };
 
 /*
-- 
1.8.4.2

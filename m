Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 16:36:41 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:16045 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991759AbcJQOf4HKFb4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 16:35:56 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id E7EEDE560B3D8;
        Mon, 17 Oct 2016 15:35:46 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 15:35:50 +0100
Received: from localhost (10.100.200.11) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct
 2016 15:35:49 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/4] MIPS: Remove RESTORE_ALL_AND_RET
Date:   Mon, 17 Oct 2016 15:34:38 +0100
Message-ID: <20161017143438.17298-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161017143438.17298-1-paul.burton@imgtec.com>
References: <20161017143438.17298-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.11]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55458
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

The RESTORE_ALL_AND_RET macro is never used. Remove the dead code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/include/asm/stackframe.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 41e6836..b183d5e 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -380,14 +380,6 @@
 		RESTORE_SP
 		.endm
 
-		.macro	RESTORE_ALL_AND_RET
-		RESTORE_TEMP
-		RESTORE_STATIC
-		RESTORE_AT
-		RESTORE_SOME
-		RESTORE_SP_AND_RET
-		.endm
-
 /*
  * Move to kernel mode and disable interrupts.
  * Set cp0 enable bit as sign that we're running on the kernel stack
-- 
2.10.0

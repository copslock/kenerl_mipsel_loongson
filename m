Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:00:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:33179 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837156AbaDPM6v4C8yp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:58:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A3CF341C8900
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:58:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:58:45 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:58:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 19/39] MIPS: inst.h: define microMIPS sync op
Date:   Wed, 16 Apr 2014 13:53:10 +0100
Message-ID: <1397652810-4336-20-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39826
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

The opcode for the sync instruction within POOL32AXf was missing. This
patch adds it for use by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index b7492c6..89e9155 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -303,6 +303,7 @@ enum mm_32axf_minor_op {
 	mm_tlbwr_op = 0x0cd,
 	mm_jalrs_op = 0x13c,
 	mm_jalrshb_op = 0x17c,
+	mm_sync_op = 0x1ad,
 	mm_syscall_op = 0x22d,
 	mm_eret_op = 0x3cd,
 };
-- 
1.8.5.3

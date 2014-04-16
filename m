Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:59:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:55966 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837154AbaDPM6kkH-m7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:58:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1AA7D88857795
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:58:32 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 13:58:34 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:58:33 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:58:32 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 16/39] MIPS: MT: define write_c0_tchalt macro
Date:   Wed, 16 Apr 2014 13:53:07 +0100
Message-ID: <1397652810-4336-17-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 39823
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

Define a macro to write to the current TCs TCHalt register. This will be
used by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mipsmtregs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index 6efa79a..5f8052c 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -36,6 +36,8 @@
 
 #define read_c0_tcbind()		__read_32bit_c0_register($2, 2)
 
+#define write_c0_tchalt(val)		__write_32bit_c0_register($2, 4, val)
+
 #define read_c0_tccontext()		__read_32bit_c0_register($2, 5)
 #define write_c0_tccontext(val)		__write_32bit_c0_register($2, 5, val)
 
-- 
1.8.5.3

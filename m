Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 18:04:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6786 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030076AbcERQEwXwvb8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 18:04:52 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id BAA3A4F1B9150;
        Wed, 18 May 2016 17:04:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 17:04:45 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 17:04:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Fix write_gc0_* macros when writing zero
Date:   Wed, 18 May 2016 17:04:38 +0100
Message-ID: <1463587478-5815-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The versions of the __write_{32,64}bit_gc0_register() macros for when
there is no virt support in the assembler use the "J" inline asm
constraint to allow integer zero, but this needs to be accompanied by
the "z" formatting string so that it turns into $0. Fix both macros to
do this.

Fixes: bad50d79255a ("MIPS: Fix VZ probe gas errors with binutils <2.24")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 25d01577d0b5..18bb6f9f0d16 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1770,7 +1770,7 @@ do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
 		".set\tnoat\n\t"					\
-		"move\t$1, %0\n\t"					\
+		"move\t$1, %z0\n\t"					\
 		"# mtgc0\t$1, $%1, %2\n\t"				\
 		".word\t(0x40610200 | %1 << 11 | %2)\n\t"		\
 		".set\tpop"						\
@@ -1783,7 +1783,7 @@ do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
 		".set\tnoat\n\t"					\
-		"move\t$1, %0\n\t"					\
+		"move\t$1, %z0\n\t"					\
 		"# dmtgc0\t$1, $%1, %2\n\t"				\
 		".word\t(0x40610300 | %1 << 11 | %2)\n\t"		\
 		".set\tpop"						\
-- 
2.4.10

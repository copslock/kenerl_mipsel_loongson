Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:58:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28957 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010645AbbAPKwezYFty (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:52:34 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4A76AED3F905C
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:52:27 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:52:29 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:52:26 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH RFC v2 25/70] MIPS: asm: local: Set the appropriate ISA level for MIPS R6
Date:   Fri, 16 Jan 2015 10:49:04 +0000
Message-ID: <1421405389-15512-26-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45169
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

MIPS R6 changed the opcodes for LL/SC instructions so we need to set
the appropriate ISA level.

Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/local.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 46dfc3c1fd49..ff8c94837995 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -47,7 +47,7 @@ static __inline__ long local_add_return(long i, local_t * l)
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"1:"	__LL	"%1, %2		# local_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
@@ -92,7 +92,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 		unsigned long temp;
 
 		__asm__ __volatile__(
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"1:"	__LL	"%1, %2		# local_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
-- 
2.2.1

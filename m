Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2010 01:43:29 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14691 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491028Ab0KBAnZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Nov 2010 01:43:25 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ccf5ed00001>; Mon, 01 Nov 2010 17:44:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 1 Nov 2010 17:43:55 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 1 Nov 2010 17:43:55 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oA20hFOZ026844;
        Mon, 1 Nov 2010 17:43:16 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oA20hA2w026834;
        Mon, 1 Nov 2010 17:43:11 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Camm Maguire <camm@maguirefamily.org>
Subject: [PATCH 1/2] MIPS: Quit clobbering personality bits.
Date:   Mon,  1 Nov 2010 17:43:07 -0700
Message-Id: <1288658588-26801-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 02 Nov 2010 00:43:55.0917 (UTC) FILETIME=[078CC3D0:01CB7A27]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The high bits of current->personality carry settings that we don't
want to clobber on each exec.  Only clobber them if the lower bits
that indicate either PER_LINUX or PER_LINUX32 are invalid.

The clobbering prevents us from using useful bits like
ADDR_NO_RANDOMIZE.

Reported-by: Camm Maguire <camm@maguirefamily.org>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Camm Maguire <camm@maguirefamily.org>
---
 arch/mips/include/asm/elf.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index fd1d39e..2ef5e82 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -249,7 +249,8 @@ extern struct mips_abi mips_abi_n32;
 
 #define SET_PERSONALITY(ex)						\
 do {									\
-	set_personality(PER_LINUX);					\
+	if (personality(current->personality) != PER_LINUX)		\
+		set_personality(PER_LINUX);				\
 									\
 	current->thread.abi = &mips_abi;				\
 } while (0)
@@ -296,6 +297,7 @@ do {									\
 
 #define SET_PERSONALITY(ex)						\
 do {									\
+	unsigned int p;							\
 	clear_thread_flag(TIF_32BIT_REGS);				\
 	clear_thread_flag(TIF_32BIT_ADDR);				\
 									\
@@ -304,7 +306,8 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
-	if (current->personality != PER_LINUX32)			\
+	p = personality(current->personality);				\
+	if (p != PER_LINUX32 && p != PER_LINUX)				\
 		set_personality(PER_LINUX);				\
 } while (0)
 
-- 
1.7.2.3

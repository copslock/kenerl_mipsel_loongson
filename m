Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 01:49:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18881 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013534AbbKMAsrE9FBl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 01:48:47 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 3AC5C5B0BDC63;
        Fri, 13 Nov 2015 00:48:37 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 13 Nov 2015
 00:48:40 +0000
Date:   Fri, 13 Nov 2015 00:48:39 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: ELF: Restructure personality macros
In-Reply-To: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511130006430.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Update the ELF personality macros used for individual ABIs to make 
actions in the same order across all of them and match formatting too.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-set-personality-shuffle.diff
Index: linux-sfr-test/arch/mips/include/asm/elf.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/elf.h	2015-11-11 02:20:23.314234000 +0000
+++ linux-sfr-test/arch/mips/include/asm/elf.h	2015-11-11 02:20:27.589266000 +0000
@@ -295,17 +295,16 @@ extern struct mips_abi mips_abi_n32;
 
 #define SET_PERSONALITY2(ex, state)					\
 do {									\
-	if (personality(current->personality) != PER_LINUX)		\
-		set_personality(PER_LINUX);				\
-									\
 	clear_thread_flag(TIF_HYBRID_FPREGS);				\
 	set_thread_flag(TIF_32BIT_FPREGS);				\
 									\
-	mips_set_personality_fp(state);					\
-									\
 	current->thread.abi = &mips_abi;				\
 									\
+	mips_set_personality_fp(state);					\
 	mips_set_personality_nan(state);				\
+									\
+	if (personality(current->personality) != PER_LINUX)		\
+		set_personality(PER_LINUX);				\
 } while (0)
 
 #endif /* CONFIG_32BIT */
@@ -316,6 +315,7 @@ do {									\
 #define __SET_PERSONALITY32_N32()					\
 	do {								\
 		set_thread_flag(TIF_32BIT_ADDR);			\
+									\
 		current->thread.abi = &mips_abi_n32;			\
 	} while (0)
 #else
@@ -331,9 +331,9 @@ do {									\
 		clear_thread_flag(TIF_HYBRID_FPREGS);			\
 		set_thread_flag(TIF_32BIT_FPREGS);			\
 									\
-		mips_set_personality_fp(state);				\
-									\
 		current->thread.abi = &mips_abi_32;			\
+									\
+		mips_set_personality_fp(state);				\
 	} while (0)
 #else
 #define __SET_PERSONALITY32_O32(ex, state)				\

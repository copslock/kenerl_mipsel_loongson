Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:51:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12889 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860090AbaGKPriutloS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:47:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8D0C36D2D74B3
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:47:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:47:32 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:47:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 13/13] MIPS: mark MSA experimental
Date:   Fri, 11 Jul 2014 16:47:25 +0100
Message-ID: <1405093645-5380-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41148
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

In light of the commit 16f77de82f2d (Revert "MIPS: Save/restore MSA
context around signals") the MSA support in the kernel is incomplete.
Until the replacement for the former sigcontext changes is agreed upon
and in tree, mark MSA experimental & disable it by default.

MSA is only implemented by one CPU supported by the kernel, the P5600.
The P5600 is a 32 bit core, and thus MSA can only be used when the
experimental CONFIG_MIPS_O32_FP64_SUPPORT option is enabled. Therefore
MSA is only being used in experimental settings anyway and this change
doesn't actually make any difference beyond clarifying the state of
MSA support.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 857a49c..d747273 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2110,10 +2110,9 @@ config CPU_MICROMIPS
 	  microMIPS ISA
 
 config CPU_HAS_MSA
-	bool "Support for the MIPS SIMD Architecture"
+	bool "Support for the MIPS SIMD Architecture (EXPERIMENTAL)"
 	depends on CPU_SUPPORTS_MSA
 	depends on 64BIT || MIPS_O32_FP64_SUPPORT
-	default y
 	help
 	  MIPS SIMD Architecture (MSA) introduces 128 bit wide vector registers
 	  and a set of SIMD instructions to operate on them. When this option
-- 
2.0.1

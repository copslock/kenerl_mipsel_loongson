Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:29:18 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2391 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834956Ab3CWS0nWJr0i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:43 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:19:25 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:20 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:19 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 939303928A; Sat, 23
 Mar 2013 11:26:18 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 6/9] MIPS: Netlogic: Remove unused code
Date:   Sat, 23 Mar 2013 23:57:58 +0530
Message-ID: <538a3b724e5ded4a1c4004517f9f3cc5f4bd926d.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532DA73YC8064119-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove unused functions and redundant comments from
arch/mips/include/asm/netlogic/haldefs.h

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/haldefs.h |   36 ------------------------------
 1 file changed, 36 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/haldefs.h b/arch/mips/include/asm/netlogic/haldefs.h
index 61fecb8..79c7ccc 100644
--- a/arch/mips/include/asm/netlogic/haldefs.h
+++ b/arch/mips/include/asm/netlogic/haldefs.h
@@ -42,34 +42,6 @@
  * and will provide a way to read 32/64 bit memory mapped registers in
  * all ABIs
  */
-/*
- * For o32 compilation, we have to disable interrupts and enable KX bit to
- * access 64 bit addresses or data.
- *
- * We need to disable interrupts because we save just the lower 32 bits of
- * registers in	 interrupt handling. So if we get hit by an interrupt while
- * using the upper 32 bits of a register, we lose.
- */
-static inline uint32_t nlm_save_flags_kx(void)
-{
-	return change_c0_status(ST0_KX | ST0_IE, ST0_KX);
-}
-
-static inline uint32_t nlm_save_flags_cop2(void)
-{
-	return change_c0_status(ST0_CU2 | ST0_IE, ST0_CU2);
-}
-
-static inline void nlm_restore_flags(uint32_t sr)
-{
-	write_c0_status(sr);
-}
-
-/*
- * The n64 implementations are simple, the o32 implementations when they
- * are added, will have to disable interrupts and enable KX before doing
- * 64 bit ops.
- */
 static inline uint32_t
 nlm_read_reg(uint64_t base, uint32_t reg)
 {
@@ -187,14 +159,6 @@ nlm_pcicfg_base(uint32_t devoffset)
 	return nlm_io_base + devoffset;
 }
 
-static inline uint64_t
-nlm_xkphys_map_pcibar0(uint64_t pcibase)
-{
-	uint64_t paddr;
-
-	paddr = nlm_read_reg(pcibase, 0x4) & ~0xfu;
-	return (uint64_t)0x9000000000000000 | paddr;
-}
 #elif defined(CONFIG_CPU_XLR)
 
 static inline uint64_t
-- 
1.7.9.5

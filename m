Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 10:40:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21661 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008719AbaIKIhmK43G4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 10:37:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EAB84343DD26F;
        Thu, 11 Sep 2014 09:37:29 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 09:37:31 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 11 Sep 2014 08:34:29 +0100
Received: from pburton-laptop.home (192.168.159.78) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 08:34:07 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/10] MIPS: ELF: add definition for the .MIPS.abiflags section
Date:   Thu, 11 Sep 2014 08:30:21 +0100
Message-ID: <1410420623-11691-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.78]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42512
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

New toolchains will generate a .MIPS.abiflags section, referenced by a
new PT_MIPS_ABIFLAGS program header. This section will provide
information about the requirements of the ELF, including the ISA level
the code is built for, the ASEs it requires, the size of various
registers and its expectations of the floating point mode. This patch
introduces a definition of the structure of this section and the program
header, for use in a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/elf.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 9343529..bfa4bbd 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -28,6 +28,7 @@
 #define PT_MIPS_REGINFO		0x70000000
 #define PT_MIPS_RTPROC		0x70000001
 #define PT_MIPS_OPTIONS		0x70000002
+#define PT_MIPS_ABIFLAGS	0x70000003
 
 /* Flags in the e_flags field of the header */
 #define EF_MIPS_NOREORDER	0x00000001
@@ -174,6 +175,30 @@ typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 typedef double elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
+struct mips_elf_abiflags_v0 {
+	uint16_t version;	/* Version of flags structure */
+	uint8_t isa_level;	/* The level of the ISA: 1-5, 32, 64 */
+	uint8_t isa_rev;	/* The revision of ISA: 0 for MIPS V and below,
+				   1-n otherwise */
+	uint8_t gpr_size;	/* The size of general purpose registers */
+	uint8_t cpr1_size;	/* The size of co-processor 1 registers */
+	uint8_t cpr2_size;	/* The size of co-processor 2 registers */
+	uint8_t fp_abi;		/* The floating-point ABI */
+	uint32_t isa_ext;	/* Mask of processor-specific extensions */
+	uint32_t ases;		/* Mask of ASEs used */
+	uint32_t flags1;	/* Mask of general flags */
+	uint32_t flags2;
+};
+
+#define MIPS_ABI_FP_ANY		0	/* FP ABI doesn't matter */
+#define MIPS_ABI_FP_DOUBLE	1	/* -mdouble-float */
+#define MIPS_ABI_FP_SINGLE	2	/* -msingle-float */
+#define MIPS_ABI_FP_SOFT	3	/* -msoft-float */
+#define MIPS_ABI_FP_OLD_64	4	/* -mips32r2 -mfp64 */
+#define MIPS_ABI_FP_XX		5	/* -mfpxx */
+#define MIPS_ABI_FP_64		6	/* -mips32r2 -mfp64 */
+#define MIPS_ABI_FP_64A		7	/* -mips32r2 -mfp64 -mno-odd-spreg */
+
 #ifdef CONFIG_32BIT
 
 /*
-- 
2.0.4

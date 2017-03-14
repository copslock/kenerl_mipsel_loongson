Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:33:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26377 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994910AbdCNK0CSNfKH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:26:02 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTP id 38AC4D7F0EFD5;
        Tue, 14 Mar 2017 10:25:53 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:25:55 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 1/8] MIPS: Add Octeon III register accessors & definitions
Date:   Tue, 14 Mar 2017 10:25:44 +0000
Message-ID: <306f747a0743b91bbfbc321572d28d0e42f9bbb8.1489486985.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.79b3feae3a98cb166c2d40a7bd4e854a5faedc89.1489486985.git-series.james.hogan@imgtec.com>
References: <cover.79b3feae3a98cb166c2d40a7bd4e854a5faedc89.1489486985.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57236
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

Add accessors for some VZ related Cavium Octeon III specific COP0
registers, along with field definitions. These will mostly be used by
KVM to set up interrupt routing and partition the TLB between root and
guest.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/mipsregs.h | 36 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index c6b8f96b80f9..ebe608d21d7e 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -974,6 +974,22 @@
 /* Flush FTLB */
 #define LOONGSON_DIAG_FTLB	(_ULCAST_(1) << 13)
 
+/* CvmCtl register field definitions */
+#define CVMCTL_IPPCI_SHIFT	7
+#define CVMCTL_IPPCI		(_U64CAST_(0x7) << CVMCTL_IPPCI_SHIFT)
+#define CVMCTL_IPTI_SHIFT	4
+#define CVMCTL_IPTI		(_U64CAST_(0x7) << CVMCTL_IPTI_SHIFT)
+
+/* CvmMemCtl2 register field definitions */
+#define CVMMEMCTL2_INHIBITTS	(_U64CAST_(1) << 17)
+
+/* CvmVMConfig register field definitions */
+#define CVMVMCONF_DGHT		(_U64CAST_(1) << 60)
+#define CVMVMCONF_MMUSIZEM1_S	12
+#define CVMVMCONF_MMUSIZEM1	(_U64CAST_(0xff) << CVMVMCONF_MMUSIZEM1_S)
+#define CVMVMCONF_RMMUSIZEM1_S	0
+#define CVMVMCONF_RMMUSIZEM1	(_U64CAST_(0xff) << CVMVMCONF_RMMUSIZEM1_S)
+
 /*
  * Coprocessor 1 (FPU) register names
  */
@@ -1733,6 +1749,13 @@ do {									\
 
 #define read_c0_cvmmemctl()	__read_64bit_c0_register($11, 7)
 #define write_c0_cvmmemctl(val) __write_64bit_c0_register($11, 7, val)
+
+#define read_c0_cvmmemctl2()	__read_64bit_c0_register($16, 6)
+#define write_c0_cvmmemctl2(val) __write_64bit_c0_register($16, 6, val)
+
+#define read_c0_cvmvmconfig()	__read_64bit_c0_register($16, 7)
+#define write_c0_cvmvmconfig(val) __write_64bit_c0_register($16, 7, val)
+
 /*
  * The cacheerr registers are not standardized.	 On OCTEON, they are
  * 64 bits wide.
@@ -2106,6 +2129,19 @@ do {									\
 #define write_gc0_kscratch5(val)	__write_ulong_gc0_register(31, 6, val)
 #define write_gc0_kscratch6(val)	__write_ulong_gc0_register(31, 7, val)
 
+/* Cavium OCTEON (cnMIPS) */
+#define read_gc0_cvmcount()		__read_ulong_gc0_register(9, 6)
+#define write_gc0_cvmcount(val)		__write_ulong_gc0_register(9, 6, val)
+
+#define read_gc0_cvmctl()		__read_64bit_gc0_register(9, 7)
+#define write_gc0_cvmctl(val)		__write_64bit_gc0_register(9, 7, val)
+
+#define read_gc0_cvmmemctl()		__read_64bit_gc0_register(11, 7)
+#define write_gc0_cvmmemctl(val)	__write_64bit_gc0_register(11, 7, val)
+
+#define read_gc0_cvmmemctl2()		__read_64bit_gc0_register(16, 6)
+#define write_gc0_cvmmemctl2(val)	__write_64bit_gc0_register(16, 6, val)
+
 /*
  * Macros to access the floating point coprocessor control registers
  */
-- 
git-series 0.8.10

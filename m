Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:20:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32640 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994797AbdCNKSMcrUVU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:12 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6BBCE8E6E0899;
        Tue, 14 Mar 2017 10:18:08 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 11/33] KVM: MIPS: Extend counters & events for VZ GExcCodes
Date:   Tue, 14 Mar 2017 10:15:18 +0000
Message-ID: <4eacde151238934247da00e7a5a83b0e2d29cfe2.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57206
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

Extend MIPS KVM stats counters and kvm_transition trace event codes to
cover hypervisor exceptions, which have their own GExcCode field in
CP0_GuestCtl0 with up to 32 hypervisor exception cause codes.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 10 ++++++++++
 arch/mips/kvm/mips.c             | 10 ++++++++++
 arch/mips/kvm/trace.h            | 18 +++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 0d308d4f2429..e8843784b784 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -145,6 +145,16 @@ struct kvm_vcpu_stat {
 	u64 fpe_exits;
 	u64 msa_disabled_exits;
 	u64 flush_dcache_exits;
+#ifdef CONFIG_KVM_MIPS_VZ
+	u64 vz_gpsi_exits;
+	u64 vz_gsfc_exits;
+	u64 vz_hc_exits;
+	u64 vz_grr_exits;
+	u64 vz_gva_exits;
+	u64 vz_ghfc_exits;
+	u64 vz_gpa_exits;
+	u64 vz_resvd_exits;
+#endif
 	u64 halt_successful_poll;
 	u64 halt_attempted_poll;
 	u64 halt_poll_invalid;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a743f67378ba..c507533ef6ea 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -59,6 +59,16 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "fpe",	  VCPU_STAT(fpe_exits),		 KVM_STAT_VCPU },
 	{ "msa_disabled", VCPU_STAT(msa_disabled_exits), KVM_STAT_VCPU },
 	{ "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCPU },
+#ifdef CONFIG_KVM_MIPS_VZ
+	{ "vz_gpsi",	  VCPU_STAT(vz_gpsi_exits),	 KVM_STAT_VCPU },
+	{ "vz_gsfc",	  VCPU_STAT(vz_gsfc_exits),	 KVM_STAT_VCPU },
+	{ "vz_hc",	  VCPU_STAT(vz_hc_exits),	 KVM_STAT_VCPU },
+	{ "vz_grr",	  VCPU_STAT(vz_grr_exits),	 KVM_STAT_VCPU },
+	{ "vz_gva",	  VCPU_STAT(vz_gva_exits),	 KVM_STAT_VCPU },
+	{ "vz_ghfc",	  VCPU_STAT(vz_ghfc_exits),	 KVM_STAT_VCPU },
+	{ "vz_gpa",	  VCPU_STAT(vz_gpa_exits),	 KVM_STAT_VCPU },
+	{ "vz_resvd",	  VCPU_STAT(vz_resvd_exits),	 KVM_STAT_VCPU },
+#endif
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), KVM_STAT_VCPU },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), KVM_STAT_VCPU },
 	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid), KVM_STAT_VCPU },
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index c858cf168078..6e43c89114b8 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -66,6 +66,15 @@ DEFINE_EVENT(kvm_transition, kvm_out,
 #define KVM_TRACE_EXIT_WAIT		32
 #define KVM_TRACE_EXIT_CACHE		33
 #define KVM_TRACE_EXIT_SIGNAL		34
+/* 32 exit reasons correspond to GuestCtl0.GExcCode (VZ) */
+#define KVM_TRACE_EXIT_GEXCCODE_BASE	64
+#define KVM_TRACE_EXIT_GPSI		64	/*  0 */
+#define KVM_TRACE_EXIT_GSFC		65	/*  1 */
+#define KVM_TRACE_EXIT_HC		66	/*  2 */
+#define KVM_TRACE_EXIT_GRR		67	/*  3 */
+#define KVM_TRACE_EXIT_GVA		72	/*  8 */
+#define KVM_TRACE_EXIT_GHFC		73	/*  9 */
+#define KVM_TRACE_EXIT_GPA		74	/* 10 */
 
 /* Tracepoints for VM exits */
 #define kvm_trace_symbol_exit_types				\
@@ -85,7 +94,14 @@ DEFINE_EVENT(kvm_transition, kvm_out,
 	{ KVM_TRACE_EXIT_MSA_DISABLED,	"MSA Disabled" },	\
 	{ KVM_TRACE_EXIT_WAIT,		"WAIT" },		\
 	{ KVM_TRACE_EXIT_CACHE,		"CACHE" },		\
-	{ KVM_TRACE_EXIT_SIGNAL,	"Signal" }
+	{ KVM_TRACE_EXIT_SIGNAL,	"Signal" },		\
+	{ KVM_TRACE_EXIT_GPSI,		"GPSI" },		\
+	{ KVM_TRACE_EXIT_GSFC,		"GSFC" },		\
+	{ KVM_TRACE_EXIT_HC,		"HC" },			\
+	{ KVM_TRACE_EXIT_GRR,		"GRR" },		\
+	{ KVM_TRACE_EXIT_GVA,		"GVA" },		\
+	{ KVM_TRACE_EXIT_GHFC,		"GHFC" },		\
+	{ KVM_TRACE_EXIT_GPA,		"GPA" }
 
 TRACE_EVENT(kvm_exit,
 	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
-- 
git-series 0.8.10

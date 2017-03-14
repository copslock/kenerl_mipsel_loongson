Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:35:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44406 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994914AbdCNK0GobxLH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:26:06 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1F9F082842B34;
        Tue, 14 Mar 2017 10:25:57 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:25:59 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Subject: [PATCH 6/8] KVM: MIPS/VZ: Emulate hit CACHE ops for Octeon III
Date:   Tue, 14 Mar 2017 10:25:49 +0000
Message-ID: <bac1a61ae21ab646b7973d93a9ad711eba90467a.1489486985.git-series.james.hogan@imgtec.com>
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
X-archive-position: 57240
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

Octeon III doesn't implement the optional GuestCtl0.CG bit to allow
guest mode to execute virtual address based CACHE instructions, so
implement emulation of a few important ones specifically for Octeon III
in response to a GPSI exception.

Currently the main reason to perform these operations is for icache
synchronisation, so they are implemented as a simple icache flush with
local_flush_icache_range().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/vz.c | 11 +++++++++++
 1 file changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 21f4495feb15..5c495277bf44 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -1105,6 +1105,17 @@ static enum emulation_result kvm_vz_gpsi_cache(union mips_instruction inst,
 	case Index_Writeback_Inv_D:
 		flush_dcache_line_indexed(va);
 		return EMULATE_DONE;
+	case Hit_Invalidate_I:
+	case Hit_Invalidate_D:
+	case Hit_Writeback_Inv_D:
+		if (boot_cpu_type() == CPU_CAVIUM_OCTEON3) {
+			/* We can just flush entire icache */
+			local_flush_icache_range(0, 0);
+			return EMULATE_DONE;
+		}
+
+		/* So far, other platforms support guest hit cache ops */
+		break;
 	default:
 		break;
 	};
-- 
git-series 0.8.10

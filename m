Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:49:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62218 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991932AbdAPMtttj6Kk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:49 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6CEEF5E752AF8;
        Mon, 16 Jan 2017 12:49:39 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:42 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/13] KVM: MIPS/T&E: Ignore user writes to CP0_Config7
Date:   Mon, 16 Jan 2017 12:49:22 +0000
Message-ID: <bfcd3ad7b4552091e431f6e4cbbb86ef50b43768.1484570878.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
References: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56319
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

Ignore userland writes to CP0_Config7 rather than reporting an error,
since we do allow reads of this register and it is claimed to exist in
the ioctl API.

This allows userland to blindly save and restore KVM registers without
having to special case certain registers as not being writable, for
example during live migration once dirty page logging is fixed.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 3 +++
 1 file changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index a9a8c8e450e4..970ab216b355 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -705,6 +705,9 @@ static int kvm_trap_emul_set_one_reg(struct kvm_vcpu *vcpu,
 			kvm_write_c0_guest_config5(cop0, v);
 		}
 		break;
+	case KVM_REG_MIPS_CP0_CONFIG7:
+		/* writes ignored */
+		break;
 	case KVM_REG_MIPS_COUNT_CTL:
 		ret = kvm_mips_set_count_ctl(vcpu, v);
 		break;
-- 
git-series 0.8.10

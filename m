Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2015 12:03:36 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:50303 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008703AbbFYKD0F-cDD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jun 2015 12:03:26 +0200
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Z8407-0002el-8i; Thu, 25 Jun 2015 10:03:19 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 31/71] MIPS: KVM: Do not sign extend on unsigned MMIO load
Date:   Thu, 25 Jun 2015 11:02:10 +0100
Message-Id: <1435226570-3669-32-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1435226570-3669-1-git-send-email-luis.henriques@canonical.com>
References: <1435226570-3669-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt14 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

commit ed9244e6c534612d2b5ae47feab2f55a0d4b4ced upstream.

Fix possible unintended sign extension in unsigned MMIO loads by casting
to uint16_t in the case of mmio_needed != 2.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9985/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ luis: backported to 3.16:
  - file rename: emulate.c -> kvm_mips_emul.c ]
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kvm/kvm_mips_emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 2071472bc3c4..18b4e2fdae33 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -2130,7 +2130,7 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		if (vcpu->mmio_needed == 2)
 			*gpr = *(int16_t *) run->mmio.data;
 		else
-			*gpr = *(int16_t *) run->mmio.data;
+			*gpr = *(uint16_t *)run->mmio.data;
 
 		break;
 	case 1:

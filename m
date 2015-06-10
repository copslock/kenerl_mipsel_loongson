Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 17:27:58 +0200 (CEST)
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:53691 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006891AbbFJP14nM7su (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2015 17:27:56 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.85)
        (envelope-from <jslaby@suse.cz>)
        id 1Z2huo-00077J-Dd; Wed, 10 Jun 2015 17:27:42 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 108/111] MIPS: KVM: Do not sign extend on unsigned MMIO load
Date:   Wed, 10 Jun 2015 17:27:37 +0200
Message-Id: <83de5204d38767e26524ad04e76fdc94ddd61bca.1433943052.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.4.2
In-Reply-To: <93091169a673f49c2574cddf1ef858cf0704f646.1433943052.git.jslaby@suse.cz>
References: <93091169a673f49c2574cddf1ef858cf0704f646.1433943052.git.jslaby@suse.cz>
In-Reply-To: <cover.1433943051.git.jslaby@suse.cz>
References: <cover.1433943051.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Nicholas Mc Guire <hofrat@osadl.org>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_mips_emul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index e75ef8219caf..c76f297b7149 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1626,7 +1626,7 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		if (vcpu->mmio_needed == 2)
 			*gpr = *(int16_t *) run->mmio.data;
 		else
-			*gpr = *(int16_t *) run->mmio.data;
+			*gpr = *(uint16_t *)run->mmio.data;
 
 		break;
 	case 1:
-- 
2.4.2

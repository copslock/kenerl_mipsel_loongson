Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2015 18:40:43 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:60401 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013359AbbLPRk0HpQOv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Dec 2015 18:40:26 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1a9G3p-0006SK-3k; Wed, 16 Dec 2015 17:40:21 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1a9G3m-0005Gf-S7; Wed, 16 Dec 2015 09:40:18 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 056/128] MIPS: KVM: Fix CACHE immediate offset sign extension
Date:   Wed, 16 Dec 2015 09:38:16 -0800
Message-Id: <1450287568-19808-57-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1450287568-19808-1-git-send-email-kamal@canonical.com>
References: <1450287568-19808-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit c5c2a3b998f1ff5a586f9d37e154070b8d550d17 upstream.

The immediate field of the CACHE instruction is signed, so ensure that
it gets sign extended by casting it to an int16_t rather than just
masking the low 16 bits.

Fixes: e685c689f3a8 ("KVM/MIPS32: Privileged instruction/target branch emulation.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kvm/emulate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 838d3a6..3d44b2d 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1407,7 +1407,7 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 
 	base = (inst >> 21) & 0x1f;
 	op_inst = (inst >> 16) & 0x1f;
-	offset = inst & 0xffff;
+	offset = (int16_t)inst;
 	cache = (inst >> 16) & 0x3;
 	op = (inst >> 18) & 0x7;
 
-- 
1.9.1

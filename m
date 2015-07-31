Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2015 22:29:46 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50413 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010750AbbGaU3oVT9Jt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2015 22:29:44 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 200C8596;
        Fri, 31 Jul 2015 20:29:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.10 89/89] MIPS: KVM: Do not sign extend on unsigned MMIO load
Date:   Fri, 31 Jul 2015 12:42:11 -0700
Message-Id: <20150731194033.508043433@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150731194030.516335023@linuxfoundation.org>
References: <20150731194030.516335023@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.10-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/kvm_mips_emul.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1626,7 +1626,7 @@ kvm_mips_complete_mmio_load(struct kvm_v
 		if (vcpu->mmio_needed == 2)
 			*gpr = *(int16_t *) run->mmio.data;
 		else
-			*gpr = *(int16_t *) run->mmio.data;
+			*gpr = *(uint16_t *)run->mmio.data;
 
 		break;
 	case 1:

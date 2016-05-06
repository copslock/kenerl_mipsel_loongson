Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 15:37:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15248 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028098AbcEFNgjiaB2k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 15:36:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id ECEAA735A6E59;
        Fri,  6 May 2016 14:36:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:31 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 1/7] MIPS: KVM/locore.S: Don't preserve host ASID around vcpu_run
Date:   Fri, 6 May 2016 14:36:18 +0100
Message-ID: <1462541784-22128-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53293
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

MIPS KVM uses different ASIDs for guest execution than for the host.
The host ASID is saved on the stack when entering the guest with
__kvm_mips_vcpu_run(), and restored again before returning back to the
caller (exit to userland).

- This does not take into account that pre-emption may have taken place
  during that time, which may have started a new ASID cycle and resulted
  in that process' ASID being invalidated and reused.

- This does not take into account that the process may have migrated to
  a different CPU during that time, with a different ASID assignment
  since they are managed per-CPU.

- It is actually redundant, since the host ASID will be restored
  correctly by kvm_arch_vcpu_put(), which is called almost immediately
  after kvm_arch_vcpu_ioctl_run() returns.

Therefore drop this code from locore.S

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/locore.S | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 81687ab1b523..c24facc85357 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -32,7 +32,6 @@
     EXPORT(x);
 
 /* Overload, Danger Will Robinson!! */
-#define PT_HOST_ASID        PT_BVADDR
 #define PT_HOST_USERLOCAL   PT_EPC
 
 #define CP0_DDATA_LO        $28,3
@@ -104,11 +103,6 @@ FEXPORT(__kvm_mips_vcpu_run)
 	mfc0	v0, CP0_STATUS
 	LONG_S	v0, PT_STATUS(k1)
 
-	/* Save host ASID, shove it into the BVADDR location */
-	mfc0	v1, CP0_ENTRYHI
-	andi	v1, 0xff
-	LONG_S	v1, PT_HOST_ASID(k1)
-
 	/* Save DDATA_LO, will be used to store pointer to vcpu */
 	mfc0	v1, CP0_DDATA_LO
 	LONG_S	v1, PT_HOST_USERLOCAL(k1)
@@ -551,12 +545,6 @@ __kvm_mips_return_to_host:
 	LONG_L	k0, PT_HOST_USERLOCAL(k1)
 	mtc0	k0, CP0_DDATA_LO
 
-	/* Restore host ASID */
-	LONG_L	k0, PT_HOST_ASID(sp)
-	andi	k0, 0xff
-	mtc0	k0,CP0_ENTRYHI
-	ehb
-
 	/* Load context saved on the host stack */
 	LONG_L	$0, PT_R0(k1)
 	LONG_L	$1, PT_R1(k1)
-- 
2.4.10

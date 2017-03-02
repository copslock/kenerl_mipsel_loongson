Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:44:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41299 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993888AbdCBJhcCFa1t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:32 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 0D312477AD698;
        Thu,  2 Mar 2017 09:37:24 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:25 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH 12/32] KVM: MIPS: Add 64BIT capability
Date:   Thu, 2 Mar 2017 09:36:39 +0000
Message-ID: <d58c0526010821c4eb776c7992bae6934fe36a9b.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56976
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

Add a new KVM_CAP_MIPS_64BIT capability to indicate that 64-bit MIPS
guests are available and supported. In this case it should still be
possible to run 32-bit guest code. If not available it won't be possible
to run 64-bit guest code and the instructions may not be available, or
the kernel may not support full context switching of 64-bit registers.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/virtual/kvm/api.txt | 25 +++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  1 +
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index bd54d7a30e37..cfe9f8b04b5e 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4179,3 +4179,28 @@ may be incompatible with the MIPS VZ ASE.
 
  1: The MIPS VZ ASE is in use, providing full hardware assisted
     virtualization, including standard guest virtual memory segments.
+
+8.4 KVM_CAP_MIPS_64BIT
+
+Architectures: mips
+
+This capability indicates the supported architecture type of the guest, i.e. the
+supported register and address width.
+
+The values returned when this capability is checked by KVM_CHECK_EXTENSION on a
+kvm VM handle correspond roughly to the CP0_Config.AT register field, and should
+be checked specifically against known values (see below). All other values are
+reserved.
+
+ 0: MIPS32 or microMIPS32.
+    Both registers and addresses are 32-bits wide.
+    It will only be possible to run 32-bit guest code.
+
+ 1: MIPS64 or microMIPS64 with access only to 32-bit compatibility segments.
+    Registers are 64-bits wide, but addresses are 32-bits wide.
+    64-bit guest code may run but cannot access MIPS64 memory segments.
+    It will also be possible to run 32-bit guest code.
+
+ 2: MIPS64 or microMIPS64 with access to all address segments.
+    Both registers and addresses are 64-bits wide.
+    It will be possible to run 64-bit or 32-bit guest code.
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f4b450d3c14b..6674b0ee1d82 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -889,6 +889,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
 #define KVM_CAP_MIPS_VZ 137
+#define KVM_CAP_MIPS_64BIT 138
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
git-series 0.8.10

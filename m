Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2014 22:30:21 +0200 (CEST)
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:58761
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854780AbaE1U3uyC0af (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 May 2014 22:29:50 +0200
Received: from localhost.localdomain (31.213.222.82) by
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 20:29:43 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v3 07/12] kvm tools: Provide per arch macro to specify type for KVM_CREATE_VM
Date:   Wed, 28 May 2014 22:28:01 +0200
Message-ID: <1401308886-17394-7-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401307735-16195-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: DB3PR07CA008.eurprd07.prod.outlook.com (10.242.134.48) To
 DM2PR07MB397.namprd07.prod.outlook.com (10.141.104.15)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(979002)(6009001)(6069001)(428001)(189002)(199002)(74662001)(76176999)(50986999)(83072002)(74502001)(21056001)(66066001)(99396002)(85852003)(64706001)(33646001)(50466002)(80022001)(47776003)(104166001)(89996001)(88136002)(20776003)(77156001)(50226001)(79102001)(4396001)(77982001)(92566001)(46102001)(92726001)(42186004)(76482001)(81342001)(62966002)(102836001)(81542001)(86362001)(93916002)(87286001)(19580395003)(36756003)(83322001)(48376002)(19580405001)(87976001)(31966008)(101416001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB397;H:localhost.localdomain;FPR:;MLV:ovrnspm;PTR:InfoNoRecords;MX:1;A:1;LANG:;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

This is is usually 0 for most archs. On mips we have two types.
TE (type 0) and MIPS-VZ (type 1). Default to 1 on mips.

Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/arm/include/arm-common/kvm-arch.h |    2 ++
 tools/kvm/kvm.c                             |    2 +-
 tools/kvm/mips/include/kvm/kvm-arch.h       |    5 +++++
 tools/kvm/powerpc/include/kvm/kvm-arch.h    |    2 ++
 tools/kvm/x86/include/kvm/kvm-arch.h        |    2 ++
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/kvm/arm/include/arm-common/kvm-arch.h b/tools/kvm/arm/include/arm-common/kvm-arch.h
index 5d2fab2..082131d 100644
--- a/tools/kvm/arm/include/arm-common/kvm-arch.h
+++ b/tools/kvm/arm/include/arm-common/kvm-arch.h
@@ -32,6 +32,8 @@
 
 #define KVM_IRQ_OFFSET		GIC_SPI_IRQ_BASE
 
+#define KVM_VM_TYPE		0
+
 #define VIRTIO_DEFAULT_TRANS(kvm)	\
 	((kvm)->cfg.arch.virtio_trans_pci ? VIRTIO_PCI : VIRTIO_MMIO)
 
diff --git a/tools/kvm/kvm.c b/tools/kvm/kvm.c
index 6046434..e1b9f6c 100644
--- a/tools/kvm/kvm.c
+++ b/tools/kvm/kvm.c
@@ -284,7 +284,7 @@ int kvm__init(struct kvm *kvm)
 		goto err_sys_fd;
 	}
 
-	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, 0);
+	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, KVM_VM_TYPE);
 	if (kvm->vm_fd < 0) {
 		pr_err("KVM_CREATE_VM ioctl");
 		ret = kvm->vm_fd;
diff --git a/tools/kvm/mips/include/kvm/kvm-arch.h b/tools/kvm/mips/include/kvm/kvm-arch.h
index 4a8407b..7eadbf4 100644
--- a/tools/kvm/mips/include/kvm/kvm-arch.h
+++ b/tools/kvm/mips/include/kvm/kvm-arch.h
@@ -17,6 +17,11 @@
 
 #define KVM_IRQ_OFFSET		1
 
+/*
+ * MIPS-VZ (trap and emulate is 0)
+ */
+#define KVM_VM_TYPE		1
+
 #define VIRTIO_DEFAULT_TRANS(kvm)	VIRTIO_PCI
 
 #include <stdbool.h>
diff --git a/tools/kvm/powerpc/include/kvm/kvm-arch.h b/tools/kvm/powerpc/include/kvm/kvm-arch.h
index f8627a2..fdd518f 100644
--- a/tools/kvm/powerpc/include/kvm/kvm-arch.h
+++ b/tools/kvm/powerpc/include/kvm/kvm-arch.h
@@ -44,6 +44,8 @@
 
 #define KVM_IRQ_OFFSET			16
 
+#define KVM_VM_TYPE			0
+
 #define VIRTIO_DEFAULT_TRANS(kvm)	VIRTIO_PCI
 
 struct spapr_phb;
diff --git a/tools/kvm/x86/include/kvm/kvm-arch.h b/tools/kvm/x86/include/kvm/kvm-arch.h
index a9f23b8..673bdf1 100644
--- a/tools/kvm/x86/include/kvm/kvm-arch.h
+++ b/tools/kvm/x86/include/kvm/kvm-arch.h
@@ -27,6 +27,8 @@
 
 #define KVM_IRQ_OFFSET		5
 
+#define KVM_VM_TYPE		0
+
 #define VIRTIO_DEFAULT_TRANS(kvm)	VIRTIO_PCI
 
 struct kvm_arch {
-- 
1.7.9.5

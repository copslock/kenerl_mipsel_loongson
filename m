Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 17:54:21 +0200 (CEST)
Received: from mail-bn1blp0190.outbound.protection.outlook.com ([207.46.163.190]:35387
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6838761AbaEFPwrFrjiR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 May 2014 17:52:47 +0200
Received: from CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) by
 CO1PR07MB938.namprd07.prod.outlook.com (10.141.72.28) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:39 +0000
Received: from alberich.caveonetworks.com (2.171.87.122) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:38 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 07/11] kvm tools: Provide per arch macro to specify type for KVM_CREATE_VM
Date:   Tue, 6 May 2014 17:51:27 +0200
Message-ID: <1399391491-5021-8-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.171.87.122]
X-ClientProxiedBy: DBXPR07CA010.eurprd07.prod.outlook.com (10.255.191.168)
 To CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
X-Forefront-PRVS: 0203C93D51
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(77982001)(83072002)(85852003)(89996001)(92566001)(31966008)(77156001)(99396002)(20776003)(47776003)(83322001)(19580405001)(74662001)(74502001)(19580395003)(92726001)(80022001)(33646001)(53416003)(66066001)(2009001)(4396001)(36756003)(88136002)(81542001)(101416001)(50226001)(42186004)(575784001)(93916002)(86362001)(81342001)(46102001)(79102001)(62966002)(50466002)(76482001)(87976001)(87286001)(50986999)(48376002)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR07MB396;H:alberich.caveonetworks.com;FPR:DA7BEDC5.FDD8698.77F8987F.8DF91ABA.201E0;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40030
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
 tools/kvm/mips/include/kvm/kvm-arch.h       |    2 ++
 tools/kvm/powerpc/include/kvm/kvm-arch.h    |    2 ++
 tools/kvm/x86/include/kvm/kvm-arch.h        |    2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/kvm/arm/include/arm-common/kvm-arch.h b/tools/kvm/arm/include/arm-common/kvm-arch.h
index b6c4bf8..a552163 100644
--- a/tools/kvm/arm/include/arm-common/kvm-arch.h
+++ b/tools/kvm/arm/include/arm-common/kvm-arch.h
@@ -32,6 +32,8 @@
 
 #define KVM_IRQ_OFFSET		GIC_SPI_IRQ_BASE
 
+#define KVM_VM_TYPE		0
+
 #define VIRTIO_DEFAULT_TRANS(kvm)	\
 	((kvm)->cfg.arch.virtio_trans_pci ? VIRTIO_PCI : VIRTIO_MMIO)
 
diff --git a/tools/kvm/kvm.c b/tools/kvm/kvm.c
index cfc0693..278b915 100644
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
index 4a8407b..0210f0b 100644
--- a/tools/kvm/mips/include/kvm/kvm-arch.h
+++ b/tools/kvm/mips/include/kvm/kvm-arch.h
@@ -17,6 +17,8 @@
 
 #define KVM_IRQ_OFFSET		1
 
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

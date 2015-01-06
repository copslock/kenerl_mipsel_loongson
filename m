Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 14:15:33 +0100 (CET)
Received: from mail-bn1bon0098.outbound.protection.outlook.com ([157.56.111.98]:17328
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025991AbbAFNPccPmeI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jan 2015 14:15:32 +0100
Received: from alberich (2.164.65.37) by
 BLUPR07MB387.namprd07.prod.outlook.com (10.141.27.24) with Microsoft SMTP
 Server (TLS) id 15.1.49.12; Tue, 6 Jan 2015 13:15:24 +0000
Date:   Tue, 6 Jan 2015 14:15:12 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: =?utf-8?B?W8OeQVRDSA==?= =?utf-8?Q?=5D?= kvmtool, mips: Support more
 than 256 MB guest memory
Message-ID: <20150106131512.GG4194@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.164.65.37]
X-ClientProxiedBy: AMSPR04CA0031.eurprd04.prod.outlook.com (10.242.87.149) To
 BLUPR07MB387.namprd07.prod.outlook.com (10.141.27.24)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-DmarcAction: None
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(3005003);SRVR:BLUPR07MB387;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(189002)(97736003)(33656002)(99396003)(120916001)(33716001)(23676002)(87976001)(122386002)(21056001)(40100003)(46102003)(106356001)(92566001)(19580395003)(83506001)(224303003)(107046002)(50466002)(19580405001)(105586002)(68736005)(229853001)(31966008)(77096005)(4396001)(42186005)(575784001)(86362001)(62966003)(77156002)(50986999)(54356999)(101416001)(110136001)(47776003)(20776003)(64706001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR07MB387;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2015 13:15:24.2642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR07MB387
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44976
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

Two guest memory regions need to be defined and two "mem=" parameters
need to be passed to guest kernel to support more than 256 MB.

Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/mips/include/kvm/kvm-arch.h |   10 +++++++++
 tools/kvm/mips/kvm.c                  |   36 +++++++++++++++++++++++++++------
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/kvm/mips/include/kvm/kvm-arch.h b/tools/kvm/mips/include/kvm/kvm-arch.h
index 7eadbf4..97bbf34 100644
--- a/tools/kvm/mips/include/kvm/kvm-arch.h
+++ b/tools/kvm/mips/include/kvm/kvm-arch.h
@@ -1,10 +1,20 @@
 #ifndef KVM__KVM_ARCH_H
 #define KVM__KVM_ARCH_H
 
+
+/*
+ * Guest memory map is:
+ *   0x00000000-0x0fffffff : System RAM
+ *   0x10000000-0x1fffffff : I/O (defined by KVM_MMIO_START and KVM_MMIO_SIZE)
+ *   0x20000000-    ...    : System RAM
+ * See also kvm__init_ram().
+ */
+
 #define KVM_MMIO_START		0x10000000
 #define KVM_PCI_CFG_AREA	KVM_MMIO_START
 #define KVM_PCI_MMIO_AREA	(KVM_MMIO_START + 0x1000000)
 #define KVM_VIRTIO_MMIO_AREA	(KVM_MMIO_START + 0x2000000)
+#define KVM_MMIO_SIZE		0x10000000
 
 /*
  * Just for reference. This and the above corresponds to what's used
diff --git a/tools/kvm/mips/kvm.c b/tools/kvm/mips/kvm.c
index fc0428b..10b441b 100644
--- a/tools/kvm/mips/kvm.c
+++ b/tools/kvm/mips/kvm.c
@@ -22,11 +22,28 @@ void kvm__init_ram(struct kvm *kvm)
 	u64	phys_start, phys_size;
 	void	*host_mem;
 
-	phys_start = 0;
-	phys_size  = kvm->ram_size;
-	host_mem   = kvm->ram_start;
+	if (kvm->ram_size <= KVM_MMIO_START) {
+		/* one region for all memory */
+		phys_start = 0;
+		phys_size  = kvm->ram_size;
+		host_mem   = kvm->ram_start;
 
-	kvm__register_mem(kvm, phys_start, phys_size, host_mem);
+		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
+	} else {
+		/* one region for memory that fits below MMIO range */
+		phys_start = 0;
+		phys_size  = KVM_MMIO_SIZE;
+		host_mem   = kvm->ram_start;
+
+		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
+
+		/* one region for rest of memory */
+		phys_start = KVM_MMIO_START + KVM_MMIO_SIZE;
+		phys_size  = kvm->ram_size - 0x10000000;
+		host_mem   = kvm->ram_start + KVM_MMIO_SIZE;
+
+		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
+	}
 }
 
 void kvm__arch_delete_ram(struct kvm *kvm)
@@ -108,8 +125,15 @@ static void kvm__mips_install_cmdline(struct kvm *kvm)
 	u64 argv_offset = argv_start;
 	u64 argc = 0;
 
-	sprintf(p + cmdline_offset, "mem=0x%llx@0 ",
-		 (unsigned long long)kvm->ram_size);
+
+	if ((u64) kvm->ram_size <= KVM_MMIO_SIZE)
+		sprintf(p + cmdline_offset, "mem=0x%llx@0 ",
+			(unsigned long long)kvm->ram_size);
+	else
+		sprintf(p + cmdline_offset, "mem=0x%llx@0 mem=0x%llx@0x%llx ",
+			(unsigned long long)KVM_MMIO_START,
+			(unsigned long long)kvm->ram_size - KVM_MMIO_START,
+			(unsigned long long)(KVM_MMIO_START + KVM_MMIO_SIZE));
 
 	strcat(p + cmdline_offset, kvm->cfg.real_cmdline); /* maximum size is 2K */
 
-- 
1.7.9.5

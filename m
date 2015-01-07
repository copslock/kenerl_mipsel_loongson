Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 15:06:36 +0100 (CET)
Received: from mail-bn1on0055.outbound.protection.outlook.com ([157.56.110.55]:16416
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010672AbbAGOGe1q4r0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Jan 2015 15:06:34 +0100
Received: from alberich (2.165.129.18) by
 BN1PR07MB390.namprd07.prod.outlook.com (10.141.58.145) with Microsoft SMTP
 Server (TLS) id 15.1.49.12; Wed, 7 Jan 2015 14:06:24 +0000
Date:   Wed, 7 Jan 2015 15:06:10 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     "Chen, Tiejun" <tiejun.chen@intel.com>
CC:     Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: =?utf-8?B?W8OeQVRDSA==?= =?utf-8?Q?=5D?= kvmtool, mips: Support
 more than 256 MB guest memory
Message-ID: <20150107140610.GI4194@alberich>
References: <20150106131512.GG4194@alberich>
 <54ACFEAD.2040901@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <54ACFEAD.2040901@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.165.129.18]
X-ClientProxiedBy: AM3PR07CA0031.eurprd07.prod.outlook.com (10.141.45.159) To
 BN1PR07MB390.namprd07.prod.outlook.com (10.141.58.145)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-DmarcAction: None
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(3005003);SRVR:BN1PR07MB390;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(601004);SRVR:BN1PR07MB390;
X-Forefront-PRVS: 044968D9E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(51704005)(189002)(479174004)(164054003)(24454002)(83506001)(105586002)(101416001)(76176999)(42186005)(50986999)(77096005)(68736005)(50466002)(120916001)(33716001)(110136001)(86362001)(575784001)(99396003)(40100003)(2950100001)(19580395003)(4396001)(19580405001)(47776003)(20776003)(64706001)(62966003)(107046002)(33656002)(77156002)(87976001)(31966008)(21056001)(106356001)(97736003)(92566001)(66066001)(46102003)(224303003)(54356999)(23676002)(122386002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB390;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB390;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2015 14:06:24.9407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR07MB390
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45002
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

On Wed, Jan 07, 2015 at 05:38:53PM +0800, Chen, Tiejun wrote:
> On 2015/1/6 21:15, Andreas Herrmann wrote:
> >Two guest memory regions need to be defined and two "mem=" parameters
> >need to be passed to guest kernel to support more than 256 MB.
> >
> >Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> >---
> >  tools/kvm/mips/include/kvm/kvm-arch.h |   10 +++++++++
> >  tools/kvm/mips/kvm.c                  |   36 +++++++++++++++++++++++++++------
> >  2 files changed, 40 insertions(+), 6 deletions(-)
> >
> >diff --git a/tools/kvm/mips/include/kvm/kvm-arch.h b/tools/kvm/mips/include/kvm/kvm-arch.h
> >index 7eadbf4..97bbf34 100644
> >--- a/tools/kvm/mips/include/kvm/kvm-arch.h
> >+++ b/tools/kvm/mips/include/kvm/kvm-arch.h
> >@@ -1,10 +1,20 @@
> >  #ifndef KVM__KVM_ARCH_H
> >  #define KVM__KVM_ARCH_H
> >
> >+
> >+/*
> >+ * Guest memory map is:
> >+ *   0x00000000-0x0fffffff : System RAM
> >+ *   0x10000000-0x1fffffff : I/O (defined by KVM_MMIO_START and KVM_MMIO_SIZE)
> >+ *   0x20000000-    ...    : System RAM
> >+ * See also kvm__init_ram().
> >+ */
> >+
> >  #define KVM_MMIO_START		0x10000000
> >  #define KVM_PCI_CFG_AREA	KVM_MMIO_START
> >  #define KVM_PCI_MMIO_AREA	(KVM_MMIO_START + 0x1000000)
> >  #define KVM_VIRTIO_MMIO_AREA	(KVM_MMIO_START + 0x2000000)
> >+#define KVM_MMIO_SIZE		0x10000000
> >
> >  /*
> >   * Just for reference. This and the above corresponds to what's used
> >diff --git a/tools/kvm/mips/kvm.c b/tools/kvm/mips/kvm.c
> >index fc0428b..10b441b 100644
> >--- a/tools/kvm/mips/kvm.c
> >+++ b/tools/kvm/mips/kvm.c
> >@@ -22,11 +22,28 @@ void kvm__init_ram(struct kvm *kvm)
> >  	u64	phys_start, phys_size;
> >  	void	*host_mem;
> >
> >-	phys_start = 0;
> >-	phys_size  = kvm->ram_size;
> >-	host_mem   = kvm->ram_start;
> >+	if (kvm->ram_size <= KVM_MMIO_START) {
> >+		/* one region for all memory */
> >+		phys_start = 0;
> >+		phys_size  = kvm->ram_size;
> >+		host_mem   = kvm->ram_start;
> >
> >-	kvm__register_mem(kvm, phys_start, phys_size, host_mem);
> >+		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
> >+	} else {
> >+		/* one region for memory that fits below MMIO range */
> >+		phys_start = 0;
> >+		phys_size  = KVM_MMIO_SIZE;
> 
> Here phys_size = KVM_MMIO_START is better to make more sense.

Yep, you are right.

> >+		host_mem   = kvm->ram_start;
> >+
> >+		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
> >+
> >+		/* one region for rest of memory */
> >+		phys_start = KVM_MMIO_START + KVM_MMIO_SIZE;
> >+		phys_size  = kvm->ram_size - 0x10000000;
> 
> and, phys_size = kvm->ram_size - KVM_MMIO_START.

Dito.

I'll adapt the patch.


Thanks,

Andreas


> Tiejun
>
> >+		host_mem   = kvm->ram_start + KVM_MMIO_SIZE;
> >+
> >+		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
> >+	}
> >  }
> >
> >  void kvm__arch_delete_ram(struct kvm *kvm)
> >@@ -108,8 +125,15 @@ static void kvm__mips_install_cmdline(struct kvm *kvm)
> >  	u64 argv_offset = argv_start;
> >  	u64 argc = 0;
> >
> >-	sprintf(p + cmdline_offset, "mem=0x%llx@0 ",
> >-		 (unsigned long long)kvm->ram_size);
> >+
> >+	if ((u64) kvm->ram_size <= KVM_MMIO_SIZE)
> >+		sprintf(p + cmdline_offset, "mem=0x%llx@0 ",
> >+			(unsigned long long)kvm->ram_size);
> >+	else
> >+		sprintf(p + cmdline_offset, "mem=0x%llx@0 mem=0x%llx@0x%llx ",
> >+			(unsigned long long)KVM_MMIO_START,
> >+			(unsigned long long)kvm->ram_size - KVM_MMIO_START,
> >+			(unsigned long long)(KVM_MMIO_START + KVM_MMIO_SIZE));
> >
> >  	strcat(p + cmdline_offset, kvm->cfg.real_cmdline); /* maximum size is 2K */
> >
> >

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2014 13:19:57 +0200 (CEST)
Received: from szxga02-in.huawei.com ([119.145.14.65]:41050 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859992AbaHLLTiTjwHM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2014 13:19:38 +0200
Received: from 172.24.2.119 (EHLO szxeml410-hub.china.huawei.com) ([172.24.2.119])
        by szxrg02-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
        with ESMTP id BYA83371;
        Tue, 12 Aug 2014 19:12:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.27.212) by szxeml410-hub.china.huawei.com
 (10.82.67.137) with Microsoft SMTP Server id 14.3.158.1; Tue, 12 Aug 2014
 19:11:58 +0800
Message-ID: <53E9F679.8060302@huawei.com>
Date:   Tue, 12 Aug 2014 19:11:53 +0800
From:   Yijing Wang <wangyijing@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
MIME-Version: 1.0
To:     David Vrabel <david.vrabel@citrix.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-mips@linux-mips.org>, <linux-ia64@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Xinwei Hu <huxinwei@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <sparclinux@vger.kernel.org>,
        <linux-s390@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        "Joerg Roedel" <joro@8bytes.org>, <x86@kernel.org>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <xen-devel@lists.xenproject.org>, <arnab.basu@freescale.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        Wuyun <wuyun.wu@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Xen-devel] [RFC PATCH 01/20] x86/xen/MSI: Eliminate arch_msix_mask_irq()
 and arch_msi_mask_irq()
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com> <1407828373-24322-2-git-send-email-wangyijing@huawei.com> <53E9D9DD.3060901@citrix.com>
In-Reply-To: <53E9D9DD.3060901@citrix.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.27.212]
X-CFilter-Loop: Reflected
Return-Path: <wangyijing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangyijing@huawei.com
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

On 2014/8/12 17:09, David Vrabel wrote:
> On 12/08/14 08:25, Yijing Wang wrote:
>> Commit 0e4ccb150 added two __weak arch functions arch_msix_mask_irq()
>> and arch_msi_mask_irq() to fix a bug found when running xen in x86.
>> Introduced these two funcntions make MSI code complex. This patch
>> reverted commit 0e4ccb150 and add #ifdef for x86 msi_chip to fix this
>> bug for simplicity. Also this is preparation for using struct
>> msi_chip instead of weak arch MSI functions in all platforms.
> [...]
>>  static struct irq_chip msi_chip = {
>>  	.name			= "PCI-MSI",
>> +#ifdef CONFIG_XEN
>> +	.irq_unmask		= nop_unmask_msi_irq,
>> +	.irq_mask		= nop_mask_msi_irq,
>> +#else
>>  	.irq_unmask		= unmask_msi_irq,
>>  	.irq_mask		= mask_msi_irq,
>> +#endif
> 
> No.  CONFIG_XEN kernels can run on Xen and bare metal so this must be a
> runtime option.

Hi David, that's my mistake, what about export struct irq_chip msi_chip, then
change the msi_chip->irq_mask/irq_unmask() in xen init functions.


Eg.

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 19b0eba..bb6af00 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -43,6 +43,10 @@ static inline void generic_apic_probe(void)
 }
 #endif

+#ifdef CONFIG_PCI_MSI
+extern struct irq_chip msi_chip;
+#endif
+
 #ifdef CONFIG_X86_LOCAL_APIC
[...]
+
+#ifdef CONFIG_PCI_MSI
+void xen_nop_msi_mask(struct irq_data *data)
 {
-       return 0;
 }
 #endif

@@ -424,8 +423,8 @@ int __init pci_xen_init(void)
        x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
        x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
        x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
-       x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-       x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+       msi_chip.irq_mask = xen_nop_msi_mask;
+       msi_chip.irq_unmask = xen_nop_msi_mask;
 #endif
        return 0;
 }
@@ -505,8 +504,8 @@ int __init pci_xen_initial_domain(void)
        x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
        x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
        x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-       x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
-       x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
+       msi_chip.irq_mask = xen_nop_msi_mask;
+       msi_chip.irq_unmask = xen_nop_msi_mask;
 #endif
        xen_setup_acpi_sci();


> 
> David
> 
> .
> 


-- 
Thanks!
Yijing

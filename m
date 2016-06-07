Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2016 10:04:43 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:49488 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042233AbcFGIEkM5OVA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2016 10:04:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id C4CBC181B6;
        Tue,  7 Jun 2016 10:04:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CLAa7SuxY0HR; Tue,  7 Jun 2016 10:04:32 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 3AF9F18184;
        Tue,  7 Jun 2016 10:04:31 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id E2C671B7F;
        Tue,  7 Jun 2016 10:04:30 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id D6CC116CC;
        Tue,  7 Jun 2016 10:04:30 +0200 (CEST)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by thoth.se.axis.com (Postfix) with ESMTP id D198110E8;
        Tue,  7 Jun 2016 10:04:30 +0200 (CEST)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id CCA4C800EB; Tue,  7 Jun 2016 10:04:30 +0200 (CEST)
Date:   Tue, 7 Jun 2016 10:04:30 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Yinghai Lu <yinghai@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v12 01/15] PCI: Let pci_mmap_page_range() take extra
 resource pointer
Message-ID: <20160607080430.GI3183@axis.com>
References: <20160604000642.28162-1-yinghai@kernel.org>
 <20160604000642.28162-2-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160604000642.28162-2-yinghai@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <jesper.nilsson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
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

On Fri, Jun 03, 2016 at 05:06:28PM -0700, Yinghai Lu wrote:
> This one is preparing patch for next one:
>   PCI: Let pci_mmap_page_range() take resource addr
> 
> We need to pass extra resource pointer to avoid searching that again
> for powerpc and microblaze prot set operation.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
> index 64a5fb9..082efb9 100644
> --- a/arch/cris/arch-v32/drivers/pci/bios.c
> +++ b/arch/cris/arch-v32/drivers/pci/bios.c
> @@ -14,7 +14,8 @@ void pcibios_set_master(struct pci_dev *dev)
>  	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
>  }
>  
> -int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
> +			struct vm_area_struct *vma,
>  			enum pci_mmap_state mmap_state, int write_combine)
>  {
>  	unsigned long prot;
> diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
> index b1b289d..65198cb 100644
> --- a/arch/cris/include/asm/pci.h
> +++ b/arch/cris/include/asm/pci.h
> @@ -42,9 +42,6 @@ struct pci_dev;
>  #define PCI_DMA_BUS_IS_PHYS	(1)
>  
>  #define HAVE_PCI_MMAP
> -extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> -			       enum pci_mmap_state mmap_state, int write_combine);
> -
>  
>  #endif /* __KERNEL__ */

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

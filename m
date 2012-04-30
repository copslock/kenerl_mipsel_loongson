Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 11:30:46 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2509 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903647Ab2D3Jaj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 11:30:39 +0200
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 30 Apr 2012 02:30:29 -0700
X-Server-Uuid: B730DE51-FC43-4C83-941F-F1F78A914BDD
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 30 Apr 2012 02:30:21 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2E2A69F9FB; Mon, 30
 Apr 2012 02:30:11 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server (
 TLS) id 14.1.339.1; Mon, 30 Apr 2012 02:30:10 -0700
Date:   Mon, 30 Apr 2012 14:59:57 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     "Sergei Shtylyov" <sshtylyov@mvista.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "Ganesan Ramalingam" <ganesanr@broadcom.com>
Subject: Re: [PATCH 02/12] MIPS: Netlogic: MSI enable fix for XLS
Message-ID: <20120430092956.GA22875@jayachandranc.netlogicmicro.com>
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1335618738-4679-3-git-send-email-jayachandranc@netlogicmicro.com>
 <4F9D8E12.9090006@mvista.com>
MIME-Version: 1.0
In-Reply-To: <4F9D8E12.9090006@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 6380843F3E025256380-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 33080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Apr 29, 2012 at 10:53:06PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 28-04-2012 17:12, Jayachandran C wrote:
> 
> >From: Ganesan Ramalingam<ganesanr@broadcom.com>
> 
> >MSI interrupts do not work on XLS after commit a776c49, because
> 
>    Please also specify that commit's summary in parens.
> 
> >the change disables MSI interrupts on the XLS PCIe bridges at boot-up.
> 
> >Fix this by enabling MSI interrupts on the bridge in the
> >arch_setup_msi_irq() function. Earlier, this was done from firmware
> >and we did not need to change the configuration in linux.
> 
> >Signed-off-by: Ganesan Ramalingam<ganesanr@broadcom.com>
> >Signed-off-by: Jayachandran C<jayachandranc@netlogicmicro.com>
> >---
> >  arch/mips/pci/pci-xlr.c |   30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> >
> >diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
> >index 50ff4dc..003e053 100644
> >--- a/arch/mips/pci/pci-xlr.c
> >+++ b/arch/mips/pci/pci-xlr.c
> [...]
> >@@ -168,17 +169,17 @@ static int get_irq_vector(const struct pci_dev *dev)
> >  	if (dev->bus->self == NULL)
> >  		return 0;
> >
> >-	switch	(dev->bus->self->devfn) {
> >-	case 0x0:
> >+	switch	(PCI_SLOT(dev->bus->self->devfn)) {
> >+	case 0:
> >  		return PIC_PCIE_LINK0_IRQ;
> >-	case 0x8:
> >+	case 1:
> >  		return PIC_PCIE_LINK1_IRQ;
> >-	case 0x10:
> >+	case 2:
> >  		if (nlm_chip_is_xls_b())
> >  			return PIC_PCIE_XLSB0_LINK2_IRQ;
> >  		else
> >  			return PIC_PCIE_LINK2_IRQ;
> >-	case 0x18:
> >+	case 3:
> >  		if (nlm_chip_is_xls_b())
> >  			return PIC_PCIE_XLSB0_LINK3_IRQ;
> >  		else
> 
>    This seems like un unrelated change...

This is just a slightly better way of writing the same logic, it does
not fix any issue.

We should have added this to the commit description, but I'm not sure
if it requires a separate patch.

JC.

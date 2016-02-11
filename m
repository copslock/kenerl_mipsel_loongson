Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 06:51:08 +0100 (CET)
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:17120
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008720AbcBKFvFM9l6A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 06:51:05 +0100
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (10.152.76.60) by BL2NAM02HT103.eop-nam02.prod.protection.outlook.com
 (10.152.77.110) with Microsoft SMTP Server (TLS) id 15.1.409.7; Thu, 11 Feb
 2016 05:50:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (TLS) id 15.1.409.7 via Frontend Transport; Thu, 11 Feb 2016 05:50:57
 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1aTk9Y-0006VV-Jg; Wed, 10 Feb 2016 21:50:56 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1aTk9Y-0006WI-EK; Wed, 10 Feb 2016 21:50:56 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u1B5ot9M006700;
        Wed, 10 Feb 2016 21:50:55 -0800
Received: from [172.22.159.25] (helo=XAP-PVEXCAS01.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharatku@xilinx.com>)
        id 1aTk9X-0006W5-2V; Wed, 10 Feb 2016 21:50:55 -0800
Received: from XAP-PVEXMBX01.xlnx.xilinx.com ([fe80::4c50:cc5:695a:c7f8]) by
 XAP-PVEXCAS01.xlnx.xilinx.com ([::1]) with mapi id 14.03.0248.002; Thu, 11
 Feb 2016 13:50:54 +0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Michal Simek <michals@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/6] PCI: xilinx: Unify INTx & MSI interrupt FIFO
 decode
Thread-Topic: [PATCH v3 2/6] PCI: xilinx: Unify INTx & MSI interrupt FIFO
 decode
Thread-Index: AQHRX2auqVVPAenjokWn6lnTz/Skzp8mXkXggAABK2A=
Date:   Thu, 11 Feb 2016 05:50:54 +0000
Message-ID: <8520D5D51A55D047800579B09414719825881B00@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
 <1454602213-967-3-git-send-email-paul.burton@imgtec.com>
 <8520D5D51A55D047800579B09414719825881ADE@XAP-PVEXMBX01.xlnx.xilinx.com>
In-Reply-To: <8520D5D51A55D047800579B09414719825881ADE@XAP-PVEXMBX01.xlnx.xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.96.57]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22122.006
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(189002)(199003)(50986999)(50466002)(19580395003)(54356999)(106116001)(2900100001)(55846006)(47776003)(76176999)(2940100001)(86362001)(19580405001)(189998001)(102836003)(97756001)(92566002)(46406003)(63266004)(106466001)(6806005)(1220700001)(11100500001)(2950100001)(2920100001)(87936001)(2501003)(23726003)(5004730100002)(5003600100002)(33656002)(5008740100001)(5250100002)(5001960100002)(6116002)(586003)(2906002)(4326007)(3846002)(5001770100001)(1096002)(2910100002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2NAM02HT103;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;MLV:sfv;MX:1;A:1;LANG:en;
X-MS-Office365-Filtering-Correlation-Id: 73103293-edc4-4dfb-20de-08d332a7503b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:BL2NAM02HT103;
X-Microsoft-Antispam-PRVS: <552a27b6743c4140bbc8dbf7214e78e1@BL2NAM02HT103.eop-nam02.prod.protection.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(13023025)(5005006)(8121501046)(13018025)(13017025)(13015025)(13024025)(10201501046)(3002001);SRVR:BL2NAM02HT103;BCL:0;PCL:0;RULEID:;SRVR:BL2NAM02HT103;
X-Forefront-PRVS: 08497C3D99
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2016 05:50:57.3695
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT103
Return-Path: <bharat.kumar.gogada@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bharat.kumar.gogada@xilinx.com
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

> > Subject: [PATCH v3 2/6] PCI: xilinx: Unify INTx & MSI interrupt FIFO
> > decode
> >
> > When decoding either an INTx or MSI interrupt, the driver has no way
> > to know which it will pull out of the interrupt FIFO. If both were
> > pending then this would lead to either the interrupt being handled
> > incorrectly (MSI interrupt treated as INTx) or not at all (INTx interrupt
> dropped by MSI path).
> > Unify the reading of the interrupt FIFO & act according to the type of
> > interrupt actually read.
> >
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP
> > driver")
> >
> > ---
> >
> > Changes in v3:
> > - Split out from Boston patchset.
> >
> > Changes in v2:
> > - Add Fixes tag.
> >
> >  drivers/pci/host/pcie-xilinx.c | 47
> > +++++++++++++-----------------------------
> >  1 file changed, 14 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx.c
> > b/drivers/pci/host/pcie-xilinx.c index
> > 1490bd1..afdfb09 100644
> > --- a/drivers/pci/host/pcie-xilinx.c
> > +++ b/drivers/pci/host/pcie-xilinx.c
> > @@ -397,7 +397,7 @@ static const struct irq_domain_ops
> intx_domain_ops
> > = {  static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)  {
> >  	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
> > -	u32 val, mask, status, msi_data;
> > +	u32 val, mask, status;
> >
> >  	/* Read interrupt decode and mask registers */
> >  	val = pcie_read(port, XILINX_PCIE_REG_IDR); @@ -437,8 +437,8 @@
> > static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
> >  		xilinx_pcie_clear_err_interrupts(port);
> >  	}
> >
> > -	if (status & XILINX_PCIE_INTR_INTX) {
> > -		/* INTx interrupt received */
> > +	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
> > +		/* Interrupt received */
> >  		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
> >
> >  		/* Check whether interrupt valid */ @@ -447,41 +447,22 @@
> static
> > irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
> >  			return IRQ_HANDLED;
> >  		}
> >
> > -		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
> > -			/* Clear interrupt FIFO register 1 */
> > -			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> > -				   XILINX_PCIE_REG_RPIFR1);
> > -
> > -			/* Handle INTx Interrupt */
> > +		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
> > +			irq = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
> > +				XILINX_PCIE_RPIFR2_MSG_DATA;
> > +		} else {
> >  			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
> >  				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
> > -			generic_handle_irq(irq_find_mapping(port-
> > >irq_domain,
> > -							    val));
> > +			irq = irq_find_mapping(port->irq_domain, val);
> >  		}
> > -	}
> >
> > -	if (status & XILINX_PCIE_INTR_MSI) {
> > -		/* MSI Interrupt */
> > -		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
> > +		/* Clear interrupt FIFO register 1 */
> > +		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> > +			   XILINX_PCIE_REG_RPIFR1);
> >
> > -		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
> > -			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
> > -			return IRQ_HANDLED;
> > -		}
> > -
> > -		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
> > -			msi_data = pcie_read(port,
> > XILINX_PCIE_REG_RPIFR2) &
> > -				   XILINX_PCIE_RPIFR2_MSG_DATA;
> > -
> > -			/* Clear interrupt FIFO register 1 */
> > -			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> > -				   XILINX_PCIE_REG_RPIFR1);
> > -
> > -			if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > -				/* Handle MSI Interrupt */
> > -				generic_handle_irq(msi_data);
> > -			}
> > -		}
> > +		if (IS_ENABLED(CONFIG_PCI_MSI) ||
> > +			!(val & XILINX_PCIE_RPIFR1_MSI_INTR))
> > +			generic_handle_irq(irq);
> >  	}
> >
> >  	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
> > --
> 
> Hi Paul,
> 
> Even with above condition you are still missing either MSI or legacy interrupt
> handling, when both MSI and legacy interrupts occurred.

It would be better if the condition when both legacy and MSI interrupts occurred can be handled separately, leaving the current individual interrupt cases as they are.

Bharat

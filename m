Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 07:20:56 +0100 (CET)
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:41784
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011485AbcBKGUxFk2jA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 07:20:53 +0100
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (10.152.72.55) by SN1NAM02HT197.eop-nam02.prod.protection.outlook.com
 (10.152.73.94) with Microsoft SMTP Server (TLS) id 15.1.409.7; Thu, 11 Feb
 2016 06:20:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server (TLS) id 15.1.415.6 via Frontend Transport; Thu, 11 Feb 2016 06:20:45
 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39472 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1aTkcO-0000fj-PD; Wed, 10 Feb 2016 22:20:44 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1aTkcO-0004HR-Jk; Wed, 10 Feb 2016 22:20:44 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u1B6KhAK006931;
        Wed, 10 Feb 2016 22:20:43 -0800
Received: from [172.22.159.25] (helo=XAP-PVEXCAS01.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharatku@xilinx.com>)
        id 1aTkcN-0004HG-6R; Wed, 10 Feb 2016 22:20:43 -0800
Received: from XAP-PVEXMBX01.xlnx.xilinx.com ([fe80::4c50:cc5:695a:c7f8]) by
 XAP-PVEXCAS01.xlnx.xilinx.com ([::1]) with mapi id 14.03.0248.002; Thu, 11
 Feb 2016 14:20:42 +0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Michal Simek <michals@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 4/6] PCI: xilinx: Clear interrupt FIFO during probe
Thread-Topic: [PATCH v3 4/6] PCI: xilinx: Clear interrupt FIFO during probe
Thread-Index: AQHRX2bENtvoFxlgyU+WXOgE/DHv/Z8mYZsw
Date:   Thu, 11 Feb 2016 06:20:42 +0000
Message-ID: <8520D5D51A55D047800579B09414719825881B1B@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
 <1454602213-967-5-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1454602213-967-5-git-send-email-paul.burton@imgtec.com>
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
X-Forefront-Antispam-Report: CIP:149.199.60.100;CTRY:US;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(199003)(189002)(86362001)(97756001)(5001770100001)(2950100001)(63266004)(2900100001)(2920100001)(106116001)(106466001)(46406003)(5003600100002)(55846006)(47776003)(92566002)(586003)(54356999)(76176999)(50986999)(33656002)(5008740100001)(23726003)(5250100002)(6116002)(4326007)(3846002)(2906002)(2501003)(189998001)(1220700001)(1096002)(5004730100002)(11100500001)(5001960100002)(50466002)(19580405001)(19580395003)(102836003)(87936001)(6806005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1NAM02HT197;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;MLV:sfv;A:1;MX:1;LANG:en;
X-MS-Office365-Filtering-Correlation-Id: a0835d28-b5d6-4499-e311-08d332ab7a12
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:SN1NAM02HT197;
X-Microsoft-Antispam-PRVS: <44dea5e5cf804d1bbd0819d35add2315@SN1NAM02HT197.eop-nam02.prod.protection.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(13015025)(5005006)(13024025)(8121501046)(13023025)(13018025)(13017025)(3002001)(10201501046);SRVR:SN1NAM02HT197;BCL:0;PCL:0;RULEID:;SRVR:SN1NAM02HT197;
X-Forefront-PRVS: 08497C3D99
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2016 06:20:45.2913
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM02HT197
Return-Path: <bharat.kumar.gogada@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51990
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

 > xilinx_pcie_init_port clears the pending interrupts in the interrupt decode
> register, but does not clear the interrupt FIFO. This would lead to spurious
> interrupts if any were present in the FIFO at probe time.
> Clear the interrupt FIFO prior to the interrupt decode register in order to
> start with a clean slate as expected.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")
> 
> ---
> 
> Changes in v3:
> - Split out from Boston patchset.
> 
> Changes in v2:
> - Add Fixes tag.
> 
>  drivers/pci/host/pcie-xilinx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c index
> 1eb74a2..6c5a503 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -568,6 +568,8 @@ static int xilinx_pcie_init_irq_domain(struct
> xilinx_pcie_port *port)
>   */
>  static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)  {
> +	u32 val;
> +
>  	if (xilinx_pcie_link_is_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
>  	else
> @@ -577,6 +579,17 @@ static void xilinx_pcie_init_port(struct
> xilinx_pcie_port *port)
>  	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
>  		   XILINX_PCIE_REG_IMR);
> 
> +	/* Clear interrupt FIFO */
> +	while (1) {
> +		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
> +
> +		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID))
> +			break;
> +
> +		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> +			   XILINX_PCIE_REG_RPIFR1);
> +	}
> +
Hi Paul,

This case will create problem with error case, suppose if we have continuous correctable errors on link this will always be while loop.

Bharat

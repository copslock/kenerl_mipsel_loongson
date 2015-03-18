Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 17:11:23 +0100 (CET)
Received: from mail-bn1bon0063.outbound.protection.outlook.com ([157.56.111.63]:39609
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008926AbbCRQLVEa-Gw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Mar 2015 17:11:21 +0100
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1718.namprd07.prod.outlook.com (25.163.39.17) with Microsoft SMTP
 Server (TLS) id 15.1.112.19; Wed, 18 Mar 2015 16:11:12 +0000
Message-ID: <5509A39C.6010707@caviumnetworks.com>
Date:   Wed, 18 Mar 2015 09:11:08 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        David Daney <ddaney@cavium.com>, <ddaney.cavm@gmail.com>,
        "ext Daney, David" <David.Daney@caviumnetworks.com>,
        Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masanari Iida <standby24x7@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rulf, Mathias (Nokia - DE/Ulm)" <mathias.rulf@nokia.com>
Subject: Re: [PATCH] pci: octeon: Remove udelay() causing huge IRQ latency
References: <55097811.8050003@nokia.com>
In-Reply-To: <55097811.8050003@nokia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BY2PR07CA072.namprd07.prod.outlook.com (10.141.251.47) To
 BN3PR0701MB1718.namprd07.prod.outlook.com (25.163.39.17)
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1718;
X-Forefront-Antispam-Report: BMV:1;SFV:NSPM;SFS:(10009020)(6009001)(164054003)(51704005)(479174004)(377454003)(24454002)(50986999)(62966003)(76176999)(54356999)(65816999)(77156002)(87976001)(33656002)(83506001)(47776003)(65806001)(65956001)(66066001)(575784001)(19580405001)(19580395003)(80316001)(59896002)(92566002)(36756003)(110136001)(40100003)(64126003)(122386002)(23676002)(53416004)(50466002)(42186005)(46102003)(2950100001)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1718;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Antispam-PRVS: <BN3PR0701MB171801498006199EBFAC24479A000@BN3PR0701MB1718.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5002010)(5005006);SRVR:BN3PR0701MB1718;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1718;
X-Forefront-PRVS: 051900244E
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2015 16:11:12.6646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1718
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 03/18/2015 06:05 AM, Alexander Sverdlin wrote:
> udelay() in PCI/PCIe read/write callbacks cause 30ms IRQ latency on Octeon
> platforms because these operations are called from PCI_OP_READ() and
> PCI_OP_WRITE() under raw_spin_lock_irqsave().
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Can you say how it was tested.  In principle I have no objections, but 
it would be nice to know how it was validated.

Thanks,
David Daney


> ---
>   arch/mips/include/asm/octeon/pci-octeon.h |    3 ---
>   arch/mips/pci/pci-octeon.c                |    6 ------
>   arch/mips/pci/pcie-octeon.c               |    8 --------
>   3 files changed, 0 insertions(+), 17 deletions(-)
>
> diff --git a/arch/mips/include/asm/octeon/pci-octeon.h b/arch/mips/include/asm/octeon/pci-octeon.h
> index 64ba56a..1884609 100644
> --- a/arch/mips/include/asm/octeon/pci-octeon.h
> +++ b/arch/mips/include/asm/octeon/pci-octeon.h
> @@ -11,9 +11,6 @@
>
>   #include <linux/pci.h>
>
> -/* Some PCI cards require delays when accessing config space. */
> -#define PCI_CONFIG_SPACE_DELAY 10000
> -
>   /*
>    * The physical memory base mapped by BAR1.  256MB at the end of the
>    * first 4GB.
> diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
> index a04af55..01c604a 100644
> --- a/arch/mips/pci/pci-octeon.c
> +++ b/arch/mips/pci/pci-octeon.c
> @@ -271,9 +271,6 @@ static int octeon_read_config(struct pci_bus *bus, unsigned int devfn,
>   	pci_addr.s.func = devfn & 0x7;
>   	pci_addr.s.reg = reg;
>
> -#if PCI_CONFIG_SPACE_DELAY
> -	udelay(PCI_CONFIG_SPACE_DELAY);
> -#endif
>   	switch (size) {
>   	case 4:
>   		*val = le32_to_cpu(cvmx_read64_uint32(pci_addr.u64));
> @@ -308,9 +305,6 @@ static int octeon_write_config(struct pci_bus *bus, unsigned int devfn,
>   	pci_addr.s.func = devfn & 0x7;
>   	pci_addr.s.reg = reg;
>
> -#if PCI_CONFIG_SPACE_DELAY
> -	udelay(PCI_CONFIG_SPACE_DELAY);
> -#endif
>   	switch (size) {
>   	case 4:
>   		cvmx_write64_uint32(pci_addr.u64, cpu_to_le32(val));
> diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
> index 1bb0b2b..99f3db4 100644
> --- a/arch/mips/pci/pcie-octeon.c
> +++ b/arch/mips/pci/pcie-octeon.c
> @@ -1762,14 +1762,6 @@ static int octeon_pcie_write_config(unsigned int pcie_port, struct pci_bus *bus,
>   	default:
>   		return PCIBIOS_FUNC_NOT_SUPPORTED;
>   	}
> -#if PCI_CONFIG_SPACE_DELAY
> -	/*
> -	 * Delay on writes so that devices have time to come up. Some
> -	 * bridges need this to allow time for the secondary busses to
> -	 * work
> -	 */
> -	udelay(PCI_CONFIG_SPACE_DELAY);
> -#endif
>   	return PCIBIOS_SUCCESSFUL;
>   }
>
>

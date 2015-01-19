Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 20:16:38 +0100 (CET)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34437 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011712AbbASTQgme5gS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 20:16:36 +0100
Received: by mail-ig0-f181.google.com with SMTP id hn18so441408igb.2;
        Mon, 19 Jan 2015 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=X4AXFkiGyy44V92llNSKxO/JUHWd5Kzz7FMNSpfE2EE=;
        b=VwOVseuu9s2+WdIowKqVpjHdO1UW9k+hBlXeoZ9cWk+nUeXQL9outxB23LgLWDQx2n
         UpNhrDYBuOVCPHm4Y4pbyTKYaQ6VkuNbZN2DJwvS3Lmhz9n+rsbQxNtg4R8cILssPeHK
         JpiqGFVfbD/z6UYTcmeWwn/DJVvMBpFs6B61kdzizPIcVJ/Jp4Dz56CbMSseNilwUFaj
         +NLPI//kTq1btDJZU2DoheECZXi5vuQazrp7OUmQSrW8VxRofoSDdQZ2X2ruOUc1+JS2
         GHvP8lhjKtTpCvtiDbtg4wGBcwyrvBvLiEXrA1qMXPBi93qO1wm8gsBhc9zaQUWXi7MH
         R03g==
X-Received: by 10.50.142.38 with SMTP id rt6mr21070643igb.17.1421694990776;
        Mon, 19 Jan 2015 11:16:30 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id fr4sm128164igd.4.2015.01.19.11.16.29
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 Jan 2015 11:16:30 -0800 (PST)
Message-ID: <54BD580C.6030701@gmail.com>
Date:   Mon, 19 Jan 2015 11:16:28 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Mark Rutland <mark.rutland@arm.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        Vinita Gupta <vgupta@caviumnetworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>, Tejun Heo <tj@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] SATA: OCTEON: support SATA on OCTEON platform
References: <1421681040-3392-1-git-send-email-aleksey.makarov@auriga.com> <20150119154357.GH21553@leverpostej>
In-Reply-To: <20150119154357.GH21553@leverpostej>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/19/2015 07:43 AM, Mark Rutland wrote:
> On Mon, Jan 19, 2015 at 03:23:58PM +0000, Aleksey Makarov wrote:
>> The OCTEON SATA controller is currently found on cn71XX devices.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
>> [aleksey.makarov@auriga.com: preparing for submission,
>> conflict resolution, fixes for the platform code]
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>> ---
>>   .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
>>   .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  31 ++++++
>>   arch/mips/cavium-octeon/octeon-platform.c          |   1 +
>>   drivers/ata/Kconfig                                |   9 ++
>>   drivers/ata/Makefile                               |   1 +
>>   drivers/ata/ahci_platform.c                        |  10 ++
>>   drivers/ata/sata_octeon.c                          | 107 +++++++++++++++++++++
>>   7 files changed, 160 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>>   create mode 100644 drivers/ata/sata_octeon.c
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> index 4ab09f2..1a5d3be 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> @@ -11,6 +11,7 @@ Required properties:
>>   - compatible        : compatible string, one of:
>>     - "allwinner,sun4i-a10-ahci"
>>     - "hisilicon,hisi-ahci"
>> +  - "cavium,octeon-7130-ahci"
>>     - "ibm,476gtr-ahci"
>>     - "marvell,armada-380-ahci"
>>     - "snps,dwc-ahci"
>> diff --git a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> new file mode 100644
>> index 0000000..222e66e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> @@ -0,0 +1,31 @@
>> +* UCTL SATA controller glue
>
> I'm not sure I follow. What does this mean?

Well, UCTL is the internal name of the hardware block.  It functions to 
connect a standard AHCI controller to the internal busses of the OCTEON SoC.

>
>> +
>> +Properties:
>> +- compatible: "cavium,octeon-7130-sata-uctl"
>> +
>> +  Compatibility with the cn7130 SOC.
>> +
>> +- reg: The base address of the UCTL register bank.
>> +
>> +- #address-cells: Must be <2>.
>> +
>> +- #size-cells: Must be <2>.
>> +
>> +- ranges: Empty to signify direct mapping of the children.
>
> Why can't these be any values which are sufficient to map children?

They can.  It happens to be the case that it is always empty.


>
>> +
>> +Example:
>> +
>> +	uctl@118006c000000 {
>> +	        compatible = "cavium,octeon-7130-sata-uctl";
>> +	        reg = <0x00011800 0x6c000000 0x00000000 0x00000100>;
>> +	        ranges;
>> +	        #address-cells = <0x00000002>;
>> +	        #size-cells = <0x00000002>;
>
> No need for all the zero-padding on these, they aren't addresses.

OK.

>
>> +	        sata@16c00 {
>> +	                compatible = "cavium,octeon-7130-ahci";
>> +	                reg = <0x00016c00 0x00000000 0x00000000 0x00000200>;
>> +	                interrupt-parent = <0x0000000d>;
>> +	                interrupts = <0x00000002 0x00000004>;
>> +	                cavium,qlm-trim-alias = "sata";
>
> What's this property for? It wasn't documented above, and doesn't exist
> in mainline.

It is not a part of the public interface, we will remove this line.

>
> [...]
>
>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>> index ae41107..4a0e5e3 100644
>> --- a/drivers/ata/Makefile
>> +++ b/drivers/ata/Makefile
>> @@ -17,6 +17,7 @@ obj-$(CONFIG_AHCI_SUNXI)	+= ahci_sunxi.o libahci.o libahci_platform.o
>>   obj-$(CONFIG_AHCI_ST)		+= ahci_st.o libahci.o libahci_platform.o
>>   obj-$(CONFIG_AHCI_TEGRA)	+= ahci_tegra.o libahci.o libahci_platform.o
>>   obj-$(CONFIG_AHCI_XGENE)	+= ahci_xgene.o libahci.o libahci_platform.o
>> +obj-$(CONFIG_SATA_OCTEON)	+= sata_octeon.o
>>
>>   # SFF w/ custom DMA
>>   obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 18d5398..bb36396 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -22,6 +22,12 @@
>>   #include <linux/ahci_platform.h>
>>   #include "ahci.h"
>>
>> +#if IS_ENABLED(CONFIG_SATA_OCTEON)
>> +void ahci_octeon_config(struct platform_device *pdev);
>> +#else
>> +static inline void ahci_octeon_config(struct platform_device *pdev) {}
>> +#endif
>> +
>>   static const struct ata_port_info ahci_port_info = {
>>   	.flags		= AHCI_FLAG_COMMON,
>>   	.pio_mask	= ATA_PIO4,
>> @@ -46,6 +52,9 @@ static int ahci_probe(struct platform_device *pdev)
>>   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>>   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>>
>> +	if (of_device_is_compatible(dev->of_node, "cavium,octeon-7130-ahci"))
>> +		ahci_octeon_config(pdev);
>> +
>
> If we really need this kind of thing, make a new struct and associate it
> with of_device_id::data in the table below. Then we make this path free
> from any device-specific code.
>

Good idea.

We will attempt to factor this into a separate driver module for the 
"cavium,octeon-7130-sata-uctl" block.  If that turns out to be too ugly, 
I would like to keep the code in this file, but with the change you suggest.

>>   	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info);
>>   	if (rc)
>>   		goto disable_resources;
>> @@ -67,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
>>   	{ .compatible = "ibm,476gtr-ahci", },
>>   	{ .compatible = "snps,dwc-ahci", },
>>   	{ .compatible = "hisilicon,hisi-ahci", },
>> +	{ .compatible = "cavium,octeon-7130-ahci", },
>>   	{},
>
> I was under the impression that the strings other than "generic-ahci"
> were only for compatibility with existing DTBs. Why do we need to add
> new platform-specific strings here?

Because it is an "existing DTB", The device tree doesn't contain the 
compatible property of "generic-ahci", only "cavium,octeon-7130-ahci".

>
> [...]
>
>> +void ahci_octeon_config(struct platform_device *pdev)
>> +{
>> +	union cvmx_sata_uctl_shim_cfg shim_cfg;
>> +
>> +	/* set-up endian mode */
>> +	shim_cfg.u64 = cvmx_read_csr(CVMX_SATA_UCTL_SHIM_CFG);
>> +#ifdef __BIG_ENDIAN
>> +	shim_cfg.s.dma_endian_mode = 1;
>> +	shim_cfg.s.csr_endian_mode = 1;
>> +#else
>> +	shim_cfg.s.dma_endian_mode = 0;
>> +	shim_cfg.s.csr_endian_mode = 0;
>> +#endif
>> +	shim_cfg.s.dma_read_cmd = 1; /* No allocate L2C */
>> +	cvmx_write_csr(CVMX_SATA_UCTL_SHIM_CFG, shim_cfg.u64);
>> +
>> +	/* Set a good dma_mask */
>> +	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
>> +	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>
> I thought a dma-ranges property in the DT could be used to set up the
> DMA mask appropriately?

The DT contains no dma-ranges property, and we know a priori, that it 
should be 64-bits.

>
> Thanks,
> Mark.
>
>

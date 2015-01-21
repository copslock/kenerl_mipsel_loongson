Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 17:54:59 +0100 (CET)
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51207 "EHLO
        foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011212AbbAUQy5SriaP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 17:54:57 +0100
Received: from foss-smtp-na-1.foss.arm.com (unknown [10.80.61.8])
        by foss-mx-na.foss.arm.com (Postfix) with ESMTP id 434E6279;
        Wed, 21 Jan 2015 10:54:48 -0600 (CST)
Received: from collaborate-mta1.arm.com (highbank-bc01-b06.austin.arm.com [10.112.81.134])
        by foss-smtp-na-1.foss.arm.com (Postfix) with ESMTP id 232B55FAD7;
        Wed, 21 Jan 2015 10:54:46 -0600 (CST)
Received: from leverpostej (leverpostej.cambridge.arm.com [10.1.205.151])
        by collaborate-mta1.arm.com (Postfix) with ESMTPS id D837913F91B;
        Wed, 21 Jan 2015 10:54:43 -0600 (CST)
Date:   Wed, 21 Jan 2015 16:54:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Aleksey Makarov <aleksey.makarov@auriga.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
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
Message-ID: <20150121165427.GA8722@leverpostej>
References: <1421681040-3392-1-git-send-email-aleksey.makarov@auriga.com>
 <20150119154357.GH21553@leverpostej>
 <54BD580C.6030701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54BD580C.6030701@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mark.rutland@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.rutland@arm.com
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

On Mon, Jan 19, 2015 at 07:16:28PM +0000, David Daney wrote:
> On 01/19/2015 07:43 AM, Mark Rutland wrote:
> > On Mon, Jan 19, 2015 at 03:23:58PM +0000, Aleksey Makarov wrote:
> >> The OCTEON SATA controller is currently found on cn71XX devices.
> >>
> >> Signed-off-by: David Daney <david.daney@cavium.com>
> >> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
> >> [aleksey.makarov@auriga.com: preparing for submission,
> >> conflict resolution, fixes for the platform code]
> >> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> >> ---
> >>   .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
> >>   .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  31 ++++++
> >>   arch/mips/cavium-octeon/octeon-platform.c          |   1 +
> >>   drivers/ata/Kconfig                                |   9 ++
> >>   drivers/ata/Makefile                               |   1 +
> >>   drivers/ata/ahci_platform.c                        |  10 ++
> >>   drivers/ata/sata_octeon.c                          | 107 +++++++++++++++++++++
> >>   7 files changed, 160 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
> >>   create mode 100644 drivers/ata/sata_octeon.c
> >>
> >> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> >> index 4ab09f2..1a5d3be 100644
> >> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> >> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> >> @@ -11,6 +11,7 @@ Required properties:
> >>   - compatible        : compatible string, one of:
> >>     - "allwinner,sun4i-a10-ahci"
> >>     - "hisilicon,hisi-ahci"
> >> +  - "cavium,octeon-7130-ahci"
> >>     - "ibm,476gtr-ahci"
> >>     - "marvell,armada-380-ahci"
> >>     - "snps,dwc-ahci"
> >> diff --git a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
> >> new file mode 100644
> >> index 0000000..222e66e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
> >> @@ -0,0 +1,31 @@
> >> +* UCTL SATA controller glue
> >
> > I'm not sure I follow. What does this mean?
> 
> Well, UCTL is the internal name of the hardware block.  It functions to 
> connect a standard AHCI controller to the internal busses of the OCTEON SoC.
> 
> >
> >> +
> >> +Properties:
> >> +- compatible: "cavium,octeon-7130-sata-uctl"
> >> +
> >> +  Compatibility with the cn7130 SOC.
> >> +
> >> +- reg: The base address of the UCTL register bank.
> >> +
> >> +- #address-cells: Must be <2>.
> >> +
> >> +- #size-cells: Must be <2>.
> >> +
> >> +- ranges: Empty to signify direct mapping of the children.
> >
> > Why can't these be any values which are sufficient to map children?
> 
> They can.  It happens to be the case that it is always empty.

Then why does the binding mandate those particular values? Whether or
not it currently happens to be the case is independent from the contract
that the binding defines.

Why does it not say something like:

#address-cells, #size-cells, and ranges must be present and hold
suitable values to map all child nodes.

[...]

> >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> >> index 18d5398..bb36396 100644
> >> --- a/drivers/ata/ahci_platform.c
> >> +++ b/drivers/ata/ahci_platform.c
> >> @@ -22,6 +22,12 @@
> >>   #include <linux/ahci_platform.h>
> >>   #include "ahci.h"
> >>
> >> +#if IS_ENABLED(CONFIG_SATA_OCTEON)
> >> +void ahci_octeon_config(struct platform_device *pdev);
> >> +#else
> >> +static inline void ahci_octeon_config(struct platform_device *pdev) {}
> >> +#endif
> >> +
> >>   static const struct ata_port_info ahci_port_info = {
> >>   	.flags		= AHCI_FLAG_COMMON,
> >>   	.pio_mask	= ATA_PIO4,
> >> @@ -46,6 +52,9 @@ static int ahci_probe(struct platform_device *pdev)
> >>   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> >>   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
> >>
> >> +	if (of_device_is_compatible(dev->of_node, "cavium,octeon-7130-ahci"))
> >> +		ahci_octeon_config(pdev);
> >> +
> >
> > If we really need this kind of thing, make a new struct and associate it
> > with of_device_id::data in the table below. Then we make this path free
> > from any device-specific code.
> >
> 
> Good idea.
> 
> We will attempt to factor this into a separate driver module for the 
> "cavium,octeon-7130-sata-uctl" block.  If that turns out to be too ugly, 
> I would like to keep the code in this file, but with the change you suggest.
> 
> >>   	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info);
> >>   	if (rc)
> >>   		goto disable_resources;
> >> @@ -67,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
> >>   	{ .compatible = "ibm,476gtr-ahci", },
> >>   	{ .compatible = "snps,dwc-ahci", },
> >>   	{ .compatible = "hisilicon,hisi-ahci", },
> >> +	{ .compatible = "cavium,octeon-7130-ahci", },
> >>   	{},
> >
> > I was under the impression that the strings other than "generic-ahci"
> > were only for compatibility with existing DTBs. Why do we need to add
> > new platform-specific strings here?
> 
> Because it is an "existing DTB", The device tree doesn't contain the 
> compatible property of "generic-ahci", only "cavium,octeon-7130-ahci".

While the DTB may already exist, the string "cavium,octeon-7130-ahci"
isn't in mainline, and as far as I can see has never been supported. We
_maintain_ support for existing DTBs, we don't just copy what some
forked kernel happens to do.

Trying to push that under the "don't break existing DTBs" rule is
bending the definition.

Thanks,
Mark.
 

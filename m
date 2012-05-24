Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 13:25:12 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:33404 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903663Ab2EXLZF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 May 2012 13:25:05 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4OBP4vY005795;
        Thu, 24 May 2012 12:25:04 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4OBP375005794;
        Thu, 24 May 2012 12:25:03 +0100
Date:   Thu, 24 May 2012 12:25:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [v2,4/5] MIPS: Malta PCI changes for PCI 2.1 compatibility and
 conflicts.
Message-ID: <20120524112503.GA2337@linux-mips.org>
References: <1333742869-17373-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1333742869-17373-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:linux-mips-request@eddie.linux-mips.org?Subject=unsubscribe>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.list-id.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:linux-mips-request@eddie.linux-mips.org?Subject=subscribe>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Apr 06, 2012 at 03:07:49PM -0500, Steven J. Hill wrote:

> diff --git a/arch/mips/mti-malta/malta-pci.c b/arch/mips/mti-malta/malta-pci.c
> index bf80921..afeb619 100644
> --- a/arch/mips/mti-malta/malta-pci.c
> +++ b/arch/mips/mti-malta/malta-pci.c
> @@ -241,8 +241,9 @@ void __init mips_pcibios_init(void)
>  		return;
>  	}
>  
> -	if (controller->io_resource->start < 0x00001000UL)	/* FIXME */
> -		controller->io_resource->start = 0x00001000UL;
> +	/* Change start address to avoid conflicts with ACPI and SMB devices */
> +	if (controller->io_resource->start < 0x00002000UL)	/* FIXME */
> +		controller->io_resource->start = 0x00002000UL;

I think raising this value to 0x2000 solves the FIXME which is there since
Maciej's 66d9ad704b25287bfee7e86a5af50b92642b9c72 commit in 2005.  Maciej,
do you recall you added the FIXME?

>  	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
>  	ioport_resource.end = controller->io_resource->end;
> diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
> index b7f37d4..b45b343 100644
> --- a/arch/mips/mti-malta/malta-setup.c
> +++ b/arch/mips/mti-malta/malta-setup.c
> @@ -222,3 +222,17 @@ void __init plat_mem_setup(void)
>  	board_be_init = malta_be_init;
>  	board_be_handler = malta_be_handler;
>  }
> +
> +/* Enable PCI 2.1 compatibility in PIIX4. */
> +static void __init quirk_dlcsetup(struct pci_dev *dev)
> +{
> +	u8 dlc;
> +
> +	/* Enable passive releases and delayed transactions. */
> +	(void) pci_read_config_byte(dev, 0x82, &dlc);
> +	dlc |= 7;
> +	(void) pci_write_config_byte(dev, 0x82, dlc);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
> +			quirk_dlcsetup);

See 9ead526ca4e6f3d9c7e6b79bb3fda113bd3b0eeb.  It would appear that your
patch turned stale about two and a half years before it was posted ;-)

  Ralf

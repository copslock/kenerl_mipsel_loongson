Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 09:52:25 +0100 (CET)
Received: from mail-bn1on0076.outbound.protection.outlook.com ([157.56.110.76]:11824
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013672AbaKNIwWUYYOr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 09:52:22 +0100
Received: from alberich (2.165.41.20) by
 BN1PR07MB390.namprd07.prod.outlook.com (10.141.58.145) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Fri, 14 Nov 2014 08:52:14 +0000
Date:   Fri, 14 Nov 2014 09:51:57 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 3/3] USB: host: Introduce flag to enable use of 64-bit
 dma_mask for ehci-platform
Message-ID: <20141114085157.GA13424@alberich>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1415914590-31647-4-git-send-email-andreas.herrmann@caviumnetworks.com>
 <CAGVrzcbAjMGBdTenpJv6_OQ4oPYGScQ0gMOFsO8gf-R7Wy-=Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAGVrzcbAjMGBdTenpJv6_OQ4oPYGScQ0gMOFsO8gf-R7Wy-=Lg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.165.41.20]
X-ClientProxiedBy: AM3PR04CA0044.eurprd04.prod.outlook.com (10.242.16.44) To
 BN1PR07MB390.namprd07.prod.outlook.com (10.141.58.145)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB390;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB390;
X-Forefront-PRVS: 03950F25EC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(377424004)(24454002)(51704005)(189002)(33656002)(33716001)(20776003)(99396003)(47776003)(64706001)(19580405001)(19580395003)(66066001)(83506001)(120916001)(4396001)(31966008)(42186005)(110136001)(50466002)(101416001)(95666004)(40100003)(105586002)(77156002)(106356001)(62966003)(77096003)(86362001)(92566001)(92726001)(122386002)(87976001)(76176999)(50986999)(97736003)(23676002)(107046002)(102836001)(21056001)(54356999)(46102003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB390;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB390;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44152
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

On Thu, Nov 13, 2014 at 08:44:17PM -0800, Florian Fainelli wrote:
> 2014-11-13 13:36 GMT-08:00 Andreas Herrmann
> <andreas.herrmann@caviumnetworks.com>:
> > ehci-octeon driver used a 64-bit dma_mask. With removal of ehci-octeon
> > and usage of ehci-platform ehci dma_mask is now limited to 32 bits
> > (coerced in ehci_platform_probe).
> >
> > Provide a flag in ehci platform data to allow use of 64 bits for
> > dma_mask.
> 
> Why not just allow enforcing an arbitrary DMA mask?

I thought about that but as it's currently just 32 or 64 bits
a flag is sufficient. (At the moment I am not aware that
other ehci-platform devices would require something else.)

I'll change the flag to a mask if desired.
Alan, what's your opinion about this?


Andreas

> > Cc: David Daney <david.daney@cavium.com>
> > Cc: Alex Smith <alex.smith@imgtec.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  arch/mips/cavium-octeon/octeon-platform.c |    4 +---
> >  drivers/usb/host/ehci-platform.c          |    3 ++-
> >  include/linux/usb/ehci_pdriver.h          |    1 +
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> > index eea60b6..12410a2 100644
> > --- a/arch/mips/cavium-octeon/octeon-platform.c
> > +++ b/arch/mips/cavium-octeon/octeon-platform.c
> > @@ -310,6 +310,7 @@ static struct usb_ehci_pdata octeon_ehci_pdata = {
> >  #ifdef __BIG_ENDIAN
> >         .big_endian_mmio        = 1,
> >  #endif
> > +       .dma_mask_64    = 1,
> >         .power_on       = octeon_ehci_power_on,
> >         .power_off      = octeon_ehci_power_off,
> >  };
> > @@ -331,8 +332,6 @@ static void __init octeon_ehci_hw_start(struct device *dev)
> >         octeon2_usb_clocks_stop();
> >  }
> >
> > -static u64 octeon_ehci_dma_mask = DMA_BIT_MASK(64);
> > -
> >  static int __init octeon_ehci_device_init(void)
> >  {
> >         struct platform_device *pd;
> > @@ -347,7 +346,6 @@ static int __init octeon_ehci_device_init(void)
> >         if (!pd)
> >                 return 0;
> >
> > -       pd->dev.dma_mask = &octeon_ehci_dma_mask;
> >         pd->dev.platform_data = &octeon_ehci_pdata;
> >         octeon_ehci_hw_start(&pd->dev);
> >
> > diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> > index 2da18ea..6df808b 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -155,7 +155,8 @@ static int ehci_platform_probe(struct platform_device *dev)
> >         if (!pdata)
> >                 pdata = &ehci_platform_defaults;
> >
> > -       err = dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32));
> > +       err = dma_coerce_mask_and_coherent(&dev->dev,
> > +               pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> >         if (err)
> >                 return err;
> >
> > diff --git a/include/linux/usb/ehci_pdriver.h b/include/linux/usb/ehci_pdriver.h
> > index 7eb4dcd..f69529e 100644
> > --- a/include/linux/usb/ehci_pdriver.h
> > +++ b/include/linux/usb/ehci_pdriver.h
> > @@ -45,6 +45,7 @@ struct usb_ehci_pdata {
> >         unsigned        big_endian_desc:1;
> >         unsigned        big_endian_mmio:1;
> >         unsigned        no_io_watchdog:1;
> > +       unsigned        dma_mask_64:1;
> >
> >         /* Turn on all power and clocks */
> >         int (*power_on)(struct platform_device *pdev);
> > --
> > 1.7.9.5
> >
> >
> 
> 
> 
> -- 
> Florian

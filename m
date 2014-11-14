Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 10:58:51 +0100 (CET)
Received: from mail-by2on0095.outbound.protection.outlook.com ([207.46.100.95]:34457
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013677AbaKNJ6sjtxQO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 10:58:48 +0100
Received: from alberich (2.165.41.20) by
 BN1PR07MB392.namprd07.prod.outlook.com (10.141.58.151) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Fri, 14 Nov 2014 09:58:39 +0000
Date:   Fri, 14 Nov 2014 10:58:24 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/3] USB: host: Remove ehci-octeon and ohci-octeon drivers
Message-ID: <20141114095824.GB13424@alberich>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1415914590-31647-2-git-send-email-andreas.herrmann@caviumnetworks.com>
 <20141114093150.GC24165@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20141114093150.GC24165@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.165.41.20]
X-ClientProxiedBy: AM2PR03CA0027.eurprd03.prod.outlook.com (25.160.207.37) To
 BN1PR07MB392.namprd07.prod.outlook.com (10.141.58.151)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB392;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB392;
X-Forefront-PRVS: 03950F25EC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(61484003)(189002)(199003)(51704005)(95666004)(15975445006)(83506001)(66066001)(4396001)(20776003)(47776003)(86362001)(46102003)(87976001)(107046002)(23676002)(19580405001)(15395725005)(19580395003)(40100003)(110136001)(15202345003)(42186005)(33716001)(105586002)(64706001)(31966008)(92566001)(92726001)(106356001)(97736003)(102836001)(101416001)(50986999)(122386002)(77096003)(76176999)(54356999)(33656002)(77156002)(62966003)(50466002)(21056001)(99396003)(120916001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB392;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB392;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44155
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

On Fri, Nov 14, 2014 at 10:31:51AM +0100, Ralf Baechle wrote:
> On Thu, Nov 13, 2014 at 10:36:28PM +0100, Andreas Herrmann wrote:
> 
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
> > From: Alan Stern <stern@rowland.harvard.edu>
> 
> Is there an echo?

Oops.
 
> Is there an echo?

LOL.

> > Remove special-purpose octeon drivers and instead use ehci-platform
> > and ohci-platform as suggested with
> > http://marc.info/?l=linux-mips&m=140139694721623&w=2
> > 
> > [andreas.herrmann:
> > 	fixed compile error]
> > 
> > Cc: David Daney <david.daney@cavium.com>
> > Cc: Alex Smith <alex.smith@imgtec.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > ---
> >  arch/mips/cavium-octeon/octeon-platform.c |  274 ++++++++++++++++++++++++++++-
> >  arch/mips/configs/cavium_octeon_defconfig |    3 +
> >  drivers/usb/host/Kconfig                  |   18 +-
> >  drivers/usb/host/Makefile                 |    1 -
> >  drivers/usb/host/ehci-hcd.c               |    5 -
> >  drivers/usb/host/ehci-octeon.c            |  188 --------------------
> >  drivers/usb/host/octeon2-common.c         |  200 ---------------------
> >  drivers/usb/host/ohci-hcd.c               |    5 -
> >  drivers/usb/host/ohci-octeon.c            |  202 ---------------------
> >  9 files changed, 285 insertions(+), 611 deletions(-)
> >  delete mode 100644 drivers/usb/host/ehci-octeon.c
> >  delete mode 100644 drivers/usb/host/octeon2-common.c
> >  delete mode 100644 drivers/usb/host/ohci-octeon.c
> 
> For the MIPS bits:
> 
> For the MIPS bits:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>
>   Ralf
> 
>   Ralf


Double thanks,

Andreas

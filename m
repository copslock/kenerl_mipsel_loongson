Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 11:24:00 +0100 (CET)
Received: from mail-bn1on0085.outbound.protection.outlook.com ([157.56.110.85]:62622
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006986AbaKYKX60BcvV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Nov 2014 11:23:58 +0100
Received: from alberich (2.164.211.155) by
 BN1PR07MB391.namprd07.prod.outlook.com (10.141.58.147) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Tue, 25 Nov 2014 10:23:50 +0000
Date:   Tue, 25 Nov 2014 11:23:36 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Greg KH <greg@kroah.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/3] USB: host: Remove ehci-octeon and ohci-octeon drivers
Message-ID: <20141125102336.GA15630@alberich>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1415914590-31647-2-git-send-email-andreas.herrmann@caviumnetworks.com>
 <20141125012134.GA5579@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20141125012134.GA5579@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.164.211.155]
X-ClientProxiedBy: AM2PR03CA0020.eurprd03.prod.outlook.com (25.160.207.30) To
 BN1PR07MB391.namprd07.prod.outlook.com (10.141.58.147)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB391;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB391;
X-Forefront-PRVS: 040655413E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(51704005)(189002)(199003)(24454002)(21056001)(40100003)(31966008)(15202345003)(19580395003)(19580405001)(33656002)(33716001)(15395725005)(101416001)(122386002)(46102003)(77156002)(4396001)(77096003)(50466002)(15975445006)(97736003)(62966003)(42186005)(83506001)(102836001)(110136001)(76176999)(54356999)(50986999)(107046002)(66066001)(120916001)(87976001)(92726001)(105586002)(64706001)(99396003)(106356001)(95666004)(86362001)(92566001)(23676002)(47776003)(20776003)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB391;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB391;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44428
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

On Mon, Nov 24, 2014 at 05:21:34PM -0800, Greg KH wrote:
> On Thu, Nov 13, 2014 at 10:36:28PM +0100, Andreas Herrmann wrote:
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Remove special-purpose octeon drivers and instead use ehci-platform
> > and ohci-platform as suggested with
> > http://marc.info/?l=linux-mips&m=140139694721623&w=2
> > 
> > [andreas.herrmann:
> > 	fixed compile error]
> > 
> > Cc: David Daney <david.daney@cavium.com>
> > Cc: Alex Smith <alex.smith@imgtec.com>
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > Acked-by: Ralf Baechle <ralf@linux-mips.org>
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
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
> This doesn't apply to my usb-next or usb-testing branch of usb.git on
> git.kernel.org, so I can't apply it :(

Sorry, I need to rebase it (on usb-next).


Andreas

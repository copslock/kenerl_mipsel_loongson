Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:13:23 +0100 (CET)
Received: from mail-by2on0074.outbound.protection.outlook.com ([207.46.100.74]:48255
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010145AbbAGLNVXOvSk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Jan 2015 12:13:21 +0100
Received: from BLUPR07MB385.namprd07.prod.outlook.com (10.141.27.18) by
 BLUPR07MB514.namprd07.prod.outlook.com (10.141.204.15) with Microsoft SMTP
 Server (TLS) id 15.1.53.17; Wed, 7 Jan 2015 11:13:12 +0000
Received: from alberich (2.165.129.18) by
 BLUPR07MB385.namprd07.prod.outlook.com (10.141.27.18) with Microsoft SMTP
 Server (TLS) id 15.1.53.17; Wed, 7 Jan 2015 11:13:08 +0000
Date:   Wed, 7 Jan 2015 12:12:55 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg KH <greg@kroah.com>, David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/2 resend v2] USB: host: Introduce flag to enable use of
 64-bit dma_mask for ehci-platform
Message-ID: <20150107111255.GH4194@alberich>
References: <20150106125015.GC4194@alberich>
 <Pine.LNX.4.44L0.1501061048230.1602-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1501061048230.1602-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.165.129.18]
X-ClientProxiedBy: AM2PR02CA0032.eurprd02.prod.outlook.com (25.160.28.170) To
 BLUPR07MB385.namprd07.prod.outlook.com (10.141.27.18)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-DmarcAction: None
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(3005003);SRVR:BLUPR07MB385;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(601004);SRVR:BLUPR07MB385;
X-Forefront-PRVS: 044968D9E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(51704005)(189002)(199003)(24454002)(77096005)(2171001)(2950100001)(62966003)(87976001)(77156002)(122386002)(21056001)(105586002)(106356001)(19580395003)(97736003)(83506001)(110136001)(19580405001)(107046002)(66066001)(4396001)(50466002)(33716001)(76176999)(46102003)(54356999)(50986999)(92566001)(120916001)(47776003)(20776003)(23676002)(99396003)(33656002)(42186005)(31966008)(68736005)(86362001)(40100003)(101416001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR07MB385;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB385;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2015 11:13:08.8557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR07MB385
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB514;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44983
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

On Tue, Jan 06, 2015 at 10:49:40AM -0500, Alan Stern wrote:
> On Tue, 6 Jan 2015, Andreas Herrmann wrote:
> 
> > ehci-octeon driver used a 64-bit dma_mask. With removal of ehci-octeon
> > and usage of ehci-platform ehci dma_mask is now limited to 32 bits
> > (coerced in ehci_platform_probe).
> > 
> > Provide a flag in ehci platform data to allow use of 64 bits for
> > dma_mask.
> > 
> > Cc: David Daney <david.daney@cavium.com>
> > Cc: Alex Smith <alex.smith@imgtec.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Is something like this also needed for ohci-platform?

No, I don't think so.

> Or are all OHCI implementations restricted to 32-bit DMA masks?

AFAIK OHCI supports only 32-bit memory addressing.


> Alan Stern

Andreas

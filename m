Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 13:52:38 +0100 (CET)
Received: from mail-by2on0092.outbound.protection.outlook.com ([207.46.100.92]:36832
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025955AbbAFMwgkYdd0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jan 2015 13:52:36 +0100
Received: from alberich (2.164.65.37) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.1.49.12; Tue, 6 Jan 2015 12:52:25 +0000
Date:   Tue, 6 Jan 2015 13:52:09 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Greg KH <greg@kroah.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 0/2 resend v2] USB: host: Misc patches to remove
 hard-coded octeon platform information
Message-ID: <20150106125209.GD4194@alberich>
References: <20141215132628.GA20109@alberich>
 <20150106124644.GA4194@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150106124644.GA4194@alberich>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.164.65.37]
X-ClientProxiedBy: AMSPR04CA0033.eurprd04.prod.outlook.com (10.242.87.151) To
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-DmarcAction: None
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(3005003);SRVR:CO1PR07MB396;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004);SRVR:CO1PR07MB396;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(209900001)(199003)(189002)(24454002)(51704005)(164054003)(99396003)(19580395003)(19580405001)(120916001)(101416001)(64706001)(110136001)(20776003)(2950100001)(47776003)(77156002)(62966003)(105586002)(23676002)(106356001)(122386002)(40100003)(42186005)(33716001)(33656002)(4396001)(87976001)(97736003)(54356999)(76176999)(15395725005)(31966008)(50986999)(50466002)(92566001)(86362001)(107046002)(21056001)(46102003)(68736005)(83506001)(15975445007)(77096005)(66066001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR07MB396;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:CO1PR07MB396;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2015 12:52:25.8187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR07MB396
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44975
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

On Tue, Jan 06, 2015 at 01:46:44PM +0100, Andreas Herrmann wrote:
> This is a re-submission of patches 2 and 3 from
> http://marc.info/?i=1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com
> (Only patch 1/3 made it into usb-next and meanwhile is in mainline.)
> 
> Please apply.
> 
> 
> Thanks,
> 
> Andreas
> 
> PS: It's v2 as with last submission I hit the merge window.
>     Patches are rebased to v3.19-rc2.
>     Only change is usage of a permanent link for the mail referenced


>     in commit message of patch 2/2.

In fact I meant commit message of patch 1 of 2.


Andreas

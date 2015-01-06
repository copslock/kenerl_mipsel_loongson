Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 13:47:06 +0100 (CET)
Received: from mail-bn1bon0071.outbound.protection.outlook.com ([157.56.111.71]:16327
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025949AbbAFMrENOiOa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jan 2015 13:47:04 +0100
Received: from alberich (2.164.65.37) by
 BLUPR07MB387.namprd07.prod.outlook.com (10.141.27.24) with Microsoft SMTP
 Server (TLS) id 15.1.49.12; Tue, 6 Jan 2015 12:46:55 +0000
Date:   Tue, 6 Jan 2015 13:46:44 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Greg KH <greg@kroah.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/2 resend v2] USB: host: Misc patches to remove hard-coded
 octeon platform information
Message-ID: <20150106124644.GA4194@alberich>
References: <20141215132628.GA20109@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20141215132628.GA20109@alberich>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.164.65.37]
X-ClientProxiedBy: DB4PR07CA019.eurprd07.prod.outlook.com (10.242.229.29) To
 BLUPR07MB387.namprd07.prod.outlook.com (10.141.27.24)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-DmarcAction: None
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(3005003);SRVR:BLUPR07MB387;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(209900001)(164054003)(199003)(189002)(97736003)(33656002)(99396003)(120916001)(33716001)(23676002)(87976001)(122386002)(21056001)(40100003)(46102003)(106356001)(92566001)(19580395003)(83506001)(107046002)(50466002)(19580405001)(105586002)(15975445007)(68736005)(229853001)(31966008)(2950100001)(77096005)(15395725005)(4396001)(42186005)(86362001)(62966003)(77156002)(50986999)(54356999)(101416001)(76176999)(110136001)(47776003)(20776003)(64706001)(66066001)(129325002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR07MB387;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2015 12:46:55.5246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR07MB387
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44970
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

This is a re-submission of patches 2 and 3 from
http://marc.info/?i=1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com
(Only patch 1/3 made it into usb-next and meanwhile is in mainline.)

Please apply.


Thanks,

Andreas

PS: It's v2 as with last submission I hit the merge window.
    Patches are rebased to v3.19-rc2.
    Only change is usage of a permanent link for the mail referenced
    in commit message of patch 2/2.

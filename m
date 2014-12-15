Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 14:26:59 +0100 (CET)
Received: from mail-bn1bon0093.outbound.protection.outlook.com ([157.56.111.93]:14208
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007135AbaLON06QTeOc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 14:26:58 +0100
Received: from CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) by
 CO1PR07MB157.namprd07.prod.outlook.com (10.242.167.13) with Microsoft SMTP
 Server (TLS) id 15.1.31.17; Mon, 15 Dec 2014 13:26:49 +0000
Received: from alberich (2.165.246.116) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.1.31.17; Mon, 15 Dec 2014 13:26:45 +0000
Date:   Mon, 15 Dec 2014 14:26:29 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Greg KH <greg@kroah.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>
Subject: [PATCH 0/2 resend] USB: host: Misc patches to remove hard-coded
 octeon platform information
Message-ID: <20141215132628.GA20109@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.165.246.116]
X-ClientProxiedBy: DB4PR07CA040.eurprd07.prod.outlook.com (10.242.229.50) To
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:CO1PR07MB396;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601003);SRVR:CO1PR07MB396;
X-Forefront-PRVS: 04267075BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(189002)(164054003)(199003)(68736005)(21056001)(42186005)(97736003)(105586002)(558084003)(62966003)(77156002)(20776003)(64706001)(47776003)(15975445007)(66066001)(87976001)(31966008)(110136001)(77096005)(92566001)(106356001)(229853001)(107046002)(19580405001)(101416001)(19580395003)(46102003)(40100003)(23676002)(99396003)(33656002)(86362001)(50986999)(83506001)(120916001)(4396001)(54356999)(15395725005)(122386002)(50466002)(129325002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR07MB396;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:CO1PR07MB396;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:CO1PR07MB157;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44668
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

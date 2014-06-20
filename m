Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 12:41:11 +0200 (CEST)
Received: from mail-by2lp0237.outbound.protection.outlook.com ([207.46.163.237]:43477
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6859945AbaFTKlGR4mBK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jun 2014 12:41:06 +0200
Received: from BLUPR0601MB0946.namprd06.prod.outlook.com (25.160.35.22) by
 BLUPR0601MB753.namprd06.prod.outlook.com (10.141.252.145) with Microsoft SMTP
 Server (TLS) id 15.0.959.24; Fri, 20 Jun 2014 10:40:58 +0000
Received: from [10.205.20.44] (205.168.23.154) by
 BLUPR0601MB0946.namprd06.prod.outlook.com (25.160.35.22) with Microsoft SMTP
 Server (TLS) id 15.0.969.15; Fri, 20 Jun 2014 10:40:57 +0000
Message-ID: <53A40FB0.2020503@ixiacom.com>
Date:   Fri, 20 Jun 2014 13:40:48 +0300
From:   Sorin Dumitru <sdumitru@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
Subject: Re: [PATCH] mips: n32: use compat getsockopt syscall
References: <1403250786-9763-1-git-send-email-sdumitru@ixiacom.com> <53A404D2.3030303@imgtec.com>
In-Reply-To: <53A404D2.3030303@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [205.168.23.154]
X-ClientProxiedBy: BY2PR07CA057.namprd07.prod.outlook.com (10.141.251.32) To
 BLUPR0601MB0946.namprd06.prod.outlook.com (25.160.35.22)
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(6049001)(428001)(51704005)(479174003)(199002)(189002)(24454002)(164054003)(83506001)(83072002)(85852003)(87976001)(36756003)(102836001)(74502001)(31966008)(105586002)(33656002)(4396001)(50466002)(74662001)(99396002)(21056001)(101416001)(2201001)(50986999)(46102001)(54356999)(92726001)(92566001)(76176999)(87266999)(85306003)(95666004)(86362001)(65816999)(77096002)(64126003)(47776003)(81342001)(23756003)(42186005)(20776003)(19580395003)(80316001)(83322001)(19580405001)(76482001)(65806001)(66066001)(106356001)(80022001)(77982001)(81542001)(64706001)(79102001)(59896001)(2101003);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR0601MB0946;H:[10.205.20.44];FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: ixiacom.com does not designate permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sdumitru@ixiacom.com; 
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 205.168.23.154
X-MS-Exchange-CrossPremises-AuthSource: BLUPR0601MB0946.namprd06.prod.outlook.com
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 06
X-MS-Exchange-CrossPremises-AVStamp-Service: 1.0
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Antispam-ScanContext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: BLUPR0601MB0946.namprd06.prod.outlook.com
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:
X-OriginatorOrg: ixiacom.com
Return-Path: <sdumitru@ixiacom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sdumitru@ixiacom.com
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



On 06/20/14 12:54, James Hogan wrote:
> On 20/06/14 08:53, Sorin Dumitru wrote:
>> Signed-off-by: Sorin Dumitru <sdumitru@ixiacom.com>
>
> A little more commit message wouldn't hurt. Did it break a particular
> program?

Yes, it was found by an internal program trying to get IP_PKTOPTIONS on 
a cavium octeon board.

Should I resubmit stating what was broken in the commit message?

Thanks,
Sorin

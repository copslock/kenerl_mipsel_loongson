Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:09:11 +0100 (CET)
Received: from mail-bn1on0099.outbound.protection.outlook.com ([157.56.110.99]:42176
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007055AbbBYQJJalW5c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:09:09 +0100
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR0701MB1115.namprd07.prod.outlook.com (25.160.145.22) with Microsoft SMTP
 Server (TLS) id 15.1.93.16; Wed, 25 Feb 2015 16:09:02 +0000
Message-ID: <54EDF39A.1080002@caviumnetworks.com>
Date:   Wed, 25 Feb 2015 08:08:58 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     <dwalker@fifo99.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: octeon disable SWIOTLB
References: <20150225144128.GB27513@fifo99.com>
In-Reply-To: <20150225144128.GB27513@fifo99.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR07CA0009.namprd07.prod.outlook.com (25.162.170.147) To
 CY1PR0701MB1115.namprd07.prod.outlook.com (25.160.145.22)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1115;
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1115595FD0C11A955D63B6E4FE170@CY1PR0701MB1115.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005004);SRVR:CY1PR0701MB1115;
X-Forefront-PRVS: 049897979A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(189002)(51704005)(199003)(24454002)(377454003)(479174004)(69596002)(97736003)(36756003)(68736005)(92566002)(64126003)(101416001)(47776003)(65806001)(87976001)(2950100001)(53416004)(77156002)(40100003)(66066001)(2351001)(19580395003)(83506001)(80316001)(46102003)(19580405001)(33656002)(23756003)(50466002)(50986999)(64706001)(65956001)(110136001)(122386002)(54356999)(65816999)(105586002)(76176999)(87266999)(62966003)(81156004)(42186005)(106356001)(59896002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1115;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1115;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2015 16:09:02.3971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1115
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 02/25/2015 06:41 AM, dwalker@fifo99.com wrote:
> Hi,
>
> Back in 2010 you made CONFIG_SWIOTLB mandatory (commit b93b2a). This prevents the Continuous
> memory allocation from being enabled. Would you be willing to accept a patch which allows
> this option to be disabled if CONFIG_EXPERT is set?

Ralf has the final say, so it really is not up to me.

That said, any patch that improves the flexibility of the kernel without 
adversely effecting reliability and correctness would be welcome.


> I suspect some users of Octeon can
> review their hardware to be sure it's save to do.
>
> Daniel
>
>

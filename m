Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 01:55:26 +0100 (CET)
Received: from mail-bn1bon0070.outbound.protection.outlook.com ([157.56.111.70]:15872
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009080AbaLTAzZEhVA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Dec 2014 01:55:25 +0100
Received: from DM2PR0701MB1118.namprd07.prod.outlook.com (25.160.246.149) by
 DM2PR0701MB716.namprd07.prod.outlook.com (10.242.126.151) with Microsoft SMTP
 Server (TLS) id 15.1.49.12; Sat, 20 Dec 2014 00:55:17 +0000
Received: from dl.caveonetworks.com (64.2.3.194) by
 DM2PR0701MB1118.namprd07.prod.outlook.com (25.160.246.149) with Microsoft
 SMTP Server (TLS) id 15.1.31.17; Sat, 20 Dec 2014 00:55:15 +0000
Message-ID: <5494C8EF.8010500@caviumnetworks.com>
Date:   Fri, 19 Dec 2014 16:55:11 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] Revert broken C0_Pagegrain[PG_IEC] support.
References: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com> <5494C639.8050808@imgtec.com>
In-Reply-To: <5494C639.8050808@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA0034.namprd07.prod.outlook.com (10.255.223.147) To
 DM2PR0701MB1118.namprd07.prod.outlook.com (25.160.246.149)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1118;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004);SRVR:DM2PR0701MB1118;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(377454003)(51704005)(189002)(24454002)(479174004)(46102003)(80316001)(83506001)(53416004)(92566001)(110136001)(33656002)(50986999)(54356999)(4396001)(40100003)(101416001)(65816999)(42186005)(87266999)(36756003)(76176999)(66066001)(21056001)(81156004)(50466002)(65806001)(23746002)(97736003)(19580405001)(99396003)(106356001)(19580395003)(107046002)(69596002)(87976001)(120916001)(62966003)(122386002)(68736005)(47776003)(2950100001)(77156002)(31966008)(105586002)(64706001)(65956001)(20776003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1118;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1118;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB716;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2014 00:55:15.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB716
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44856
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

On 12/19/2014 04:43 PM, Leonid Yegoshin wrote:
> On 12/19/2014 04:33 PM, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The two patches reverted here break eXecute-Inhibit (XI) memory
>> protection support.  Before the patches we get SIGSEGV when attempting
>> to execute in non-executable memory, after the patches we loop forever
>> in handle_tlbl.
>>
>> It is probably possible to make C0_Pagegrain[PG_IEC] work, but I think
>> the most prudent thing is to revert these patches, and then only reapply
>> something that works after it has been well tested.
>>
>> David Daney (2):
>>    Revert "MIPS: Use dedicated exception handler if CPU supports RI/XI
>>      exceptions"
>>    Revert "MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions"
>>
>>   arch/mips/include/asm/mipsregs.h | 1 -
>>   arch/mips/kernel/cpu-probe.c     | 9 ---------
>>   arch/mips/kernel/traps.c         | 7 -------
>>   arch/mips/mm/tlbex.c             | 4 ++--
>>   4 files changed, 2 insertions(+), 19 deletions(-)
>>
> Well, it may be have sense just to fix tlb_init() instead.

I have more confidence in going back to a working configuration.  My 
simple tests on OCTEON tell me that it is working again.

Somebody adding working support for C0_Pagegrain[PG_IEC] would want to 
do much more testing across many different CPUs to be able to assert 
that it was tested and working.

I would be happy to test any patches adding this support on a variety of 
different OCTEON CPU cores, but I don't have access to anything MIPS/img 
may have that supports this feature.

David Daney.

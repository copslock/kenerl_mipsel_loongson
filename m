Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 16:46:18 +0100 (CET)
Received: from mail-bn1on0071.outbound.protection.outlook.com ([157.56.110.71]:60623
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006887AbbCMPqPhkwxK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Mar 2015 16:46:15 +0100
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR0701MB1725.namprd07.prod.outlook.com (25.163.21.14) with Microsoft SMTP
 Server (TLS) id 15.1.112.19; Fri, 13 Mar 2015 15:46:07 +0000
Message-ID: <5503063B.5000104@caviumnetworks.com>
Date:   Fri, 13 Mar 2015 08:46:03 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: mm: tlbex: Replace cpu_has_mips_r2_exec_hazard
 with cpu_has_mips_r2_r6
References: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com> <1426238288-15560-1-git-send-email-markos.chandras@imgtec.com> <20150313144443.GA12977@linux-mips.org>
In-Reply-To: <20150313144443.GA12977@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN2PR07CA008.namprd07.prod.outlook.com (10.255.174.25) To
 CY1PR0701MB1725.namprd07.prod.outlook.com (25.163.21.14)
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1725;
X-Forefront-Antispam-Report: BMV:1;SFV:NSPM;SFS:(10009020)(6009001)(51704005)(377454003)(479174004)(24454002)(23756003)(87976001)(50466002)(83506001)(99136001)(65956001)(66066001)(65806001)(19580405001)(19580395003)(80316001)(47776003)(54356999)(50986999)(76176999)(87266999)(65816999)(110136001)(64126003)(92566002)(77156002)(62966003)(575784001)(40100003)(42186005)(122386002)(53416004)(2950100001)(33656002)(46102003)(36756003)(4580500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1725;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1725025FF6E4B0731A8C94629A070@CY1PR0701MB1725.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5002009)(5005006);SRVR:CY1PR0701MB1725;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1725;
X-Forefront-PRVS: 05143A8241
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2015 15:46:07.1661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1725
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46365
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

On 03/13/2015 07:44 AM, Ralf Baechle wrote:
> On Fri, Mar 13, 2015 at 09:18:08AM +0000, Markos Chandras wrote:
>
>> Commit 77f3ee59ee7cf ("MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
>> for the EHB instruction") replaced cpu_has_mips_r2 with
>> cpu_has_mips_r2_exec_hazard to indicate whether the ISA has the EHB
>> instruction. However, the meaning of the cpu_has_mips_r2_exec_hazard
>> is different. It was meant to be used as an indication on whether the
>> running processor needs to run the EHB instruction instead of checking
>> whether the EHB is available on the ISA. This broke processors that do
>> not define cpu_has_mips_r2_exec_hazard. We fix this by replacing the
>> said macro with cpu_has_mips_r2_r6 which covers R2 and R6 processors.
>>
>> Fixes: 77f3ee59ee7cf ("MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard for the EHB instruction")
>> Cc: David Daney <david.daney@cavium.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>
> Either of this David's revert or this patch applied will leave
> cpu_has_mips_r2_exec_hazard unused which at a glance doesn't seem to
> be right and defeats David's old patches 9e290a19 / 41f0e4d0 from working.
>
> cpu_has_mips_r2_exec_hazard was made unused by 625c0a21 which I think
> should be reverted and cpu_has_mips_r2_exec_hazard be defined to be something
> like
>
> #define cpu_has_mips_r2_exec_hazard					\
> ({									\
> 	int __res;							\
> 									\
> 	switch (current_cpu_type()) {					\
> 	case CPU_M14KC:							\
> 	case CPU74K:							\
> 	case CPU_CAVIUM_OCTEON:						\
> 	case CPU_CAVIUM_OCTEON_PLUS:					\
>          case CPU_CAVIUM_OCTEON2:					\
> 	case CPU_CAVIUM_OCTEON3:					\

The four octeon models are already covered in 
arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h

> 		__res = 0;						\
> 		break;							\
> 									\
> 	default:							\
> 		__res = 1;						\
> 	}								\
> 									\
> 	__res;								\
> })
>
> ?
>

Something like that is needed somewhere

I would suggest having the default definition contain some 
generalizations about where it should return true, and 
arch/mips/include/asm/mach-*/cpu-feature-overrides.h isolate the 
specific models for each sub-architecture.

David Daney

>    Ralf
>

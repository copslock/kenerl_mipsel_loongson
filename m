Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 18:30:55 +0100 (CET)
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]:3716
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011278AbbALRaxdS8El (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Jan 2015 18:30:53 +0100
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1105.namprd07.prod.outlook.com (25.160.114.143) with Microsoft
 SMTP Server (TLS) id 15.1.53.17; Mon, 12 Jan 2015 17:30:44 +0000
Message-ID: <54B404C1.7020409@caviumnetworks.com>
Date:   Mon, 12 Jan 2015 09:30:41 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Abhishek Paliwal <abhishek.paliwal@aricent.com>
CC:     <kexin.hao@windriver.com>, <bo.liu@windriver.com>,
        <Chandrakala.Chavva@caviumnetworks.com>, <rakesh.garg@aricent.com>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>,
        <kvm@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/9] MIPS OCTEON Enable use of FPU
References: <1421046385-2535-1-git-send-email-abhishek.paliwal@aricent.com> <1421046385-2535-3-git-send-email-abhishek.paliwal@aricent.com>
In-Reply-To: <1421046385-2535-3-git-send-email-abhishek.paliwal@aricent.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BN1PR07CA0043.namprd07.prod.outlook.com (10.255.193.18) To
 BN3PR0701MB1105.namprd07.prod.outlook.com (25.160.114.143)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-DmarcAction-Test: None
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(3005003);SRVR:BN3PR0701MB1105;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004);SRVR:BN3PR0701MB1105;
X-Forefront-PRVS: 0454444834
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(38564003)(377454003)(479174004)(189002)(199003)(51704005)(47776003)(110136001)(40100003)(15975445007)(68736005)(64126003)(19580405001)(19580395003)(80316001)(105586002)(122386002)(46102003)(65956001)(66066001)(62966003)(92566002)(65806001)(77156002)(23756003)(97736003)(87976001)(64706001)(81156004)(69596002)(101416001)(42186005)(53416004)(2950100001)(36756003)(65816999)(76176999)(50986999)(50466002)(33656002)(83506001)(54356999)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1105;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1105;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2015 17:30:44.0517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1105
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45090
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

On 01/11/2015 11:06 PM, Abhishek Paliwal wrote:
> commit  a36d8225bceba4b7be47ade34d175945f85cffbc upstream

Why are you spamming us with this?  We don't need to know what you are 
cherry-picking.


>
> Some versions of the assembler will not assemble CFC1 for OCTEON, so override the ISA for these.
>
> Add r4k_fpu.o to handle low level FPU initialization.
>
> Modify octeon_switch.S to save the FPU registers. And include r4k_switch.S to pick up more FPU support.
>
> Get rid of "#define cpu_has_fpu 0"
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> Cc: linux-mips@linux-mips.org
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: kvm@vger.kernel.org
> Patchwork: https://patchwork.linux-mips.org/patch/7006/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Abhishek Paliwal <abhishek.paliwal@aricent.com>
> ---
>   .../asm/mach-cavium-octeon/cpu-feature-overrides.h |  1 -
>   arch/mips/kernel/Makefile                          |  2 +-
>   arch/mips/kernel/branch.c                          |  6 +-
>   arch/mips/kernel/octeon_switch.S                   | 85 ++++++++++++++++------
>   arch/mips/kernel/r4k_switch.S                      |  3 +
>   arch/mips/math-emu/cp1emu.c                        | 12 ++-
>   6 files changed, 80 insertions(+), 29 deletions(-)
>
[...]
>
> "DISCLAIMER: This message is proprietary to Aricent and is intended solely for the use of the individual to whom it is addressed. It may contain privileged or confidential information and should not be circulated or used for any purpose other than for what it is intended. If you have received this message in error, please notify the originator immediately. If you are not the intended recipient, you are notified that you are strictly prohibited from using, copying, altering, or disclosing the contents of this message. Aricent accepts no responsibility for loss or damage arising from the use of the information transmitted by this email including damage from virus."

I wrote the patch, what gives you the right to say that it is "... 
proprietary to Aricent ..."?   Nothing.  We really must insist that you 
quit making this type of misrepresentation.

David Daney

>

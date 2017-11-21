Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Nov 2017 21:53:43 +0100 (CET)
Received: from mail-by2nam01on0071.outbound.protection.outlook.com ([104.47.34.71]:2368
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991033AbdKUUxfp5jGK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Nov 2017 21:53:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L+Zt7+rj/meZWTEYy/Lw2KQFKPIdGWUeo6+MCLgkvTA=;
 b=HwcL9b+aUgH9W27pIumEPa9zQusjJLtCo9hu9MT8znAycHXzEa6HghpAuY1JmqfGwkKDR7GFadH4NDehZVyrQO/9eZ4F44bi/t8ftZvBRKK1HY23vRvNlmacwHRDljGq5p5U6q2UEA2gQ6qtGmufseJvlWkyysKanWeC/1zZfNU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN6PR07MB3489.namprd07.prod.outlook.com (10.161.153.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.239.5; Tue, 21 Nov 2017 20:53:19 +0000
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        James Hogan <james.hogan@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
Date:   Tue, 21 Nov 2017 12:53:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0041.namprd07.prod.outlook.com (10.168.109.27) To
 BN6PR07MB3489.namprd07.prod.outlook.com (10.161.153.28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6712583f-75a0-4b5a-fdf4-08d53121e6f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:BN6PR07MB3489;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3489;3:4WlQRmIkVpmH4asMtNWZMfDdFGdwPXKovG9Dfh5OMt0lLU3liHMTF4aSE6zMmaRhrIz6YtztAB/+Dq+SwjT7FHRh4Ito4oR+CzV+mCQDp6lJ9ssTPj0s7GINQdK3FsCx1v5VB74o0gmlwFjUoc7CZ2gSOtK9ATyS8kfGBxNBaI5/BnWf4klcU1HJsfBCPR5unaHOfMWMyR0vy2Q/BRl2mFFab1YpS9ezzMwfY1MWmeG2ZeSL9svyrw9zVTnXwRb8;25:JM/LJhnHxWRsf/jmqOkx3aPfHNIgSloj5phbMRiyEEAY3bmxy19cl9OwHEjjkL1+0/aRVaQjnd53GIBPUxGPMwdd60gw7lRhAYrwfIGhxVILqaLi/uQ5uLp5HdJHFaJROiJwi3l9wyNVnCANqWSw0xJBIG68NbyqKTpZOfJyI4CbchBjPqtE1BKBFpEw0oD+6pIF7wvm0fvUoEc1hkkaEfTG3pQmiPLZwB7fsMSMHnnrWfREoCZYGqeCJos3un2Pt/h0JdJYCNu1A4nmJq5LpC1VyWgPJ1WTZ4rfWCaEuMI13dIjOe/lRGcsX+u9cUdnzgsBHiBBLw3tWGkcsj6DAQ==;31:v5dBuyQFXu0l9WnyE7poVqAZ+tm4bjemEsxWBjX6lA/KYrOuMU2OJlDX1RTXQAoMm5PUYg0WGVdBRux5ZxZPn8zKVZD4dUoyE+yX8WyNMXNra1kEYCJRSWnmFUjPMygsVUFrWYSiHTZ+e3opoqTzBk+cD+CakiCQ3COqwWBETaDNYCNC0q/yca56lsyx+Chhlks2oj2f849DKr0BCqOKtf0ACaYkHysLdqxMYpmuUHo=
X-MS-TrafficTypeDiagnostic: BN6PR07MB3489:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3489;20:rsYFhiL/JOsLhj/N8MnkNIT8jXEIoi+CDthmKwkj2H4hiBiva6p1tulTmwFG7XIBARqFSirp0f/Dc03vrbw6d1bn0YmZpq5/5q1nKJb0h/BiU5gBQ/IjJic270nz7dmlY9mRbJdjfk/BKG41Xhin0csxZXzPRMVWy4XTR81hPo5xmwMjZCDxr2y2CGYkgB+qJFyeTdbtQHO08GGEHEyq5H+I+7RWcAOrH8c6/sQFi7TRXFC/jQEU92q4jm2dskgIjY2gHHVi6hoTO9ofSp8FFHrhnJNZnF9Pv+33dAbIjxgrnceuJUsWF8Dq66/NpRWuon/ZNgedecut1c/oS06Bl2MXt2B1ZAJqEYn8Ied8iAeaYqueyOfyTFACxYQErtr7KqdDR465SRh59HBn3DZJArmXzACFzYcfh0Lj6wCGxkLpHEW9KdSoHysNhKb+szNAUc3FZMz5yXRo1zJyWWf6F9dGOWl9GWeVE+e4QWwlyKS656t2VC/x0jC7TI5vKhyxSSxHdaIK2ybFXCe2xy2BQJPq5L7kMeOPoIGehBYH8/gdLoummi/ViJy1YijIWtvhkMlNT1G2Ox0uck70hCADa2x2+U0H53QoavEEiCnuMT0=;4:XgcXDvKBe/SPiHHvktBK8UhMepzsN60NB/Edg8NAFD95Zu3xb400Kx9m0cwk6IIfL0bNwG5eLtknie0L4ISfAZETA4aWagW9ci4k5tn85wBLMwosPpgfmk6TfMc6oHWqoED9zVEPLO3dbUYzJ9Sds5gJaJm2nZyvxJGjWLqVmV2onN91LAcWNyqHGrggPHQsAZHERUvBBlkCc0PXfDH27qfbD/ZgwE0zFwUQZNZkV568jzgWuNjq4BTg4fNhhydvbstoHpH9peGH4fbK6X1UZg==
X-Microsoft-Antispam-PRVS: <BN6PR07MB34898FBB4798E370AB2EEC1997230@BN6PR07MB3489.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(3002001)(93006095)(100000703101)(100105400095)(10201501046)(3231022)(6041248)(20161123558100)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR07MB3489;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR07MB3489;
X-Forefront-PRVS: 049897979A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(24454002)(189002)(101416001)(83506002)(7736002)(67846002)(2906002)(81156014)(97736004)(305945005)(8676002)(81166006)(189998001)(64126003)(230700001)(105586002)(16526018)(33646002)(53416004)(106356001)(23676004)(52146003)(3846002)(6116002)(229853002)(7416002)(69596002)(6486002)(65956001)(6506006)(66066001)(65806001)(68736007)(6512007)(47776003)(8936002)(36756003)(4326008)(31686004)(5660300001)(65826007)(42882006)(6246003)(2950100002)(50466002)(53936002)(31696002)(316002)(76176999)(54356999)(58126008)(25786009)(478600001)(72206003)(54906003)(53546010)(50986999)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3489;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDg5OzIzOlAveFlicUlXeFk5ZXh6QjIvR3k4OU9SNnAw?=
 =?utf-8?B?ZVpCMG52Y2FwWHhXQjE0WnRBRUxYZGdhbUVwZFRkMWNqNlA5L0p0S2g3Wkpi?=
 =?utf-8?B?NnNmdXppRFFqekE3RURFaER1SE9kYlprSUx3RXZEQ3RDNFBoVjludHI5NEJN?=
 =?utf-8?B?bVpJZnlhd284L29CM1JzRXdMN1NFVENLQ0VyK1dtblZBQVp6eFZEQkVjeFI4?=
 =?utf-8?B?ZkVSbkdWbkRVeHB5Nm5NcHlyRTJ6RmgyTG5qVXJ1M3lJY1ZybDRreUxlYStk?=
 =?utf-8?B?ZGs0aXV3Qllaa0QzY2JYeTF0SWM2dm80cVRHUUhlL0wrOUd4Sy81dzlxL1J3?=
 =?utf-8?B?dlBKRnVNSHAwaFNCbXNuMHpCWHh2dUhrZEx3ZjRXdUNpd0t5SW1Fdmw1Mmcr?=
 =?utf-8?B?LzYzMEUxcjlFbUM2VUU4ZXhEanBxTDdlYVlrN2tFU3E4eWJKdXEycE5tbDA3?=
 =?utf-8?B?RXIvbit3QkNQUDl5S1lnTy90ZG5HTFNpNmhFVlhCMGNrZURpS3FOYnEyeGFi?=
 =?utf-8?B?UzR1YW9zR3h6R0V6M3BXOGFpU1RVMDdIZDNCUzZHc2NzRld4dlQvamQ0SVRF?=
 =?utf-8?B?d211TjZadFRSWUxDdlltTnlVYWlOZFloVmFuVVlZQ1VoWUdDMk05U2Y0bTdk?=
 =?utf-8?B?VVBhVHdkMWpTRnFwK0wrcmRpdnVDM0piL0RjVENXQnlpOVYrWnFiWmcvVG9U?=
 =?utf-8?B?QVRZY2t4dFZ5OWt3d3BjY1EyVHRDeFFjSGxsdFZqK2dPMmdKZGhZMjVXb2dD?=
 =?utf-8?B?UjlyS280a2FkOGoxcTQ1MWpMdGtCQnh1Zm1ocjlxaC9IMk1lbnVWcmlQRmJr?=
 =?utf-8?B?ZEF3M3RqVm9GRHRmZ1dWOTBrY0hGaDY3cmFzYTNESHhzeFJpVUI4RDhMdGlV?=
 =?utf-8?B?T2I1YUpNMUI1MUJsYXdVSnJzUTRJRCsydDZ5R2NkVXBIQVhIRXhPeEZZa3ZQ?=
 =?utf-8?B?QmR4alFTSXVXNEd3ZFFjbDVvL1RseXNrSHBTT1dhbS9DdTBPbFVPWnZ3M2tG?=
 =?utf-8?B?QmllSG1KMjdNbTdtZDM0M2ZOQm9EOUFrcjZwaFRFdXMrVDBQT2svbUF5Lzlu?=
 =?utf-8?B?TUhLQlE0bXk1OERNeUpGMWp4SnRvRUNteUdqenFKSFZMYUUvUWFNSDFQVVZZ?=
 =?utf-8?B?RVNmRHpRbUNvZkxGdHJpUWlDWDR4RFdYVTB5RWtBSXJQb2VjMEl1Q0lzZFI1?=
 =?utf-8?B?YWgyblpTSlQ4Q3Zoam5ZUmxldlFRdnFwMHZ0eE01Q1orR0lIdU1XMTh2aTVv?=
 =?utf-8?B?SXFWTzMyM2xoaStab1paUVdqZ2NramhsRFBLTjdscy9XUGJYcVg5ZkpoTzZs?=
 =?utf-8?B?eFQycGlmdWptb1JZZ09TbjBpZ3M2RXdNd25oVlJBTE9qa1hYeEtDRmtFdk1H?=
 =?utf-8?B?bnNlL1BLRU91bW0wVkJjYWVsNWJTd3lGeUdlWFpqK3ZWR3J1dGUvRG1yZ2ZH?=
 =?utf-8?B?azRVRVBubkpDL1gybHdYRERsM2VMT2JoM1RieUZjc2E0L2FhbTZZanBhNXRL?=
 =?utf-8?B?a2FpQzk5ZkI2cEw0NnpmMEpBSjZmcXRic1BBYkhUR0tFeU1VaWN2Skg2ZmR6?=
 =?utf-8?B?TGFFQlFNUlg1Y3VTNXJKTU1MZDUxRmNGN3lSVzFtZUhZZ2tFQ1Bib2pQWjgy?=
 =?utf-8?B?aEFBWEhDQUJQRmpuZ0RUcitxbmZVR3FDQTlYNHFGcFF4cEpSRVRJWVA3Z0tr?=
 =?utf-8?B?WkI1cDI0b2VMSEdoSDR1SzUzR2twdmpCbHVtZ0pVVXBybVVtT0xXeFNGUFd3?=
 =?utf-8?B?MXFsSmUxeHBXSFh6dVltTXM5Z1FTcjMveUs5S0xjc2Nibk9ER3BlQjUzRjcr?=
 =?utf-8?B?WmUxOUVQaVFzVld6VXhxcHVpU3JZNC9wYUpxRVNPZldaaWZ0YkFWTEF5dUhF?=
 =?utf-8?B?Z0JMcDJvekp4YlNobVk3Q1BhQ1JYdS9YR2pYNHh2eEkyQmhWeGxvTXZ5Yk5X?=
 =?utf-8?B?SFhjLzZLVFhRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3489;6:o87x2PbrTX/r2u30sEVHpyJEtWWrClUTNL0AJ8rqFGzESPJynJ3LdFMoYuiNA/ygFXVAvFCtftiivuYk3Ndi9L2GRi82V0Nrgo1hniksxHofO2cv5z+sy4PbKrBwGqYGqhgYPjnBS98wexjHa1GCNlk1MQNgr5/p8DRLc0i20WbEb+wB5RKL3pJ0U4At/NQpqE3dM60SakFbUsvvw/Yiga1r6ed4NogTrR12KbUJN50guhehr4yETROPk4x0gxXeFaF1KmoZjlIrIsSkqZ/meTFYPjY751hjWXugc3Hj94iWj1+EQ7LZQtNOCAi+Z3sXPGQt36Qm6WbyZRKWYgE7Nc9RHWnW8T3P1R8I+8fnaPE=;5:8Foweb8kXz2E8AMSXkIXZx0Q3+fWq8GRgONNNio17KgTQTYkZfzo7bWeDUK3KjqMxkXW78Qc+oGV4MdeczlJprhqmurR9GWX9claXCOShMeqUjz851G7rWXR6I+TDxbJB6TwB2FE8rRXwyFLhA8SUK+iG4vemmfv7QxHz0eRIHA=;24:QOU87Gu1rJ3KyDj871Xz2EHEBd4DXpCo7EcqHlPWNFTACJvVXnx0xqE0DFVG2DvKcnJM9XzshURtVp01Y2BEZmlLuGi/ARKAUEsOwS/PsDY=;7:6STMbrwtpXxDZRexzNFOhyhTJp8d/t9vKp+iZR0PehbEiAvSY3fAHg5m4DVq2wvUryIEIGpjSdJ0n4d/uqfcWWMwmTzlqOLVesTFtVZdg3a2k/UMK+Id7C/Fh3+qg36LC/Pbb9ieoeqkXSKuQ79X9dcf3SnAzsqNQn/1EvXY59kvMJnDDjkauNQGRtszgQ143ggb0BXjl8mGLFxdlFfAMWVqq8VS8ln3yoQppD8t0XeQtbSQ0Vkrqg6yqRnea6KI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2017 20:53:19.7656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6712583f-75a0-4b5a-fdf4-08d53121e6f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3489
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61034
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

On 11/21/2017 05:56 AM, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
> 
> Add a new kernel parameter to override the default behavior related
> to the decision whether to set up stack as non-executable in function
> mips_elf_read_implies_exec().
> 
> The new parameter is used to control non executable stack and heap,
> regardless of PT_GNU_STACK entry. This does apply to both stack and
> heap, despite the name.
> 
> Allowed values:
> 
> nonxstack=on	Force non-exec stack & heap
> nonxstack=off	Force executable stack & heap
> 
> If this parameter is omitted, kernel behavior remains the same as it
> was before this patch is applied.

Do other architectures have a similar hack?

If arm{,64} and x86 don't need this, what would make MIPS so special 
that we have to carry this around?


> 
> This functionality is convenient during debugging and is especially
> useful for Android development where non-exec stack is required.

Why not just set the PT_GNU_STACK flags correctly in the first place?

> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 11 +++++++
>   arch/mips/kernel/elf.c                          | 39 +++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b74e133..99464ee 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2614,6 +2614,17 @@
>   			noexec32=off: disable non-executable mappings
>   				read implies executable mappings
>   
> +	nonxstack	[MIPS]
> +			Force setting up stack and heap as non-executable or
> +			executable regardless of PT_GNU_STACK entry. Both
> +			stack and heap are affected, despite the name. Valid
> +			arguments: on, off.
> +			nonxstack=on:	Force non-executable stack and heap
> +			nonxstack=off:	Force executable stack and heap
> +			If ommited, stack and heap will or will not be set
> +			up as non-executable depending on PT_GNU_STACK
> +			entry and possibly other factors.
> +
>   	nofpu		[MIPS,SH] Disable hardware FPU at boot time.
>   
>   	nofxsr		[BUGS=X86-32] Disables x86 floating point extended
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index 731325a..28ef7f3 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -326,8 +326,47 @@ void mips_set_personality_nan(struct arch_elf_state *state)
>   	}
>   }
>   
> +static int nonxstack = EXSTACK_DEFAULT;
> +
> +/*
> + * kernel parameter: nonxstack=on|off
> + *
> + *   Force setting up stack and heap as non-executable or
> + *   executable regardless of PT_GNU_STACK entry. Both
> + *   stack and heap are affected, despite the name. Valid
> + *   arguments: on, off.
> + *
> + *     nonxstack=on:   Force non-executable stack and heap
> + *     nonxstack=off:  Force executable stack and heap
> + *
> + *   If ommited, stack and heap will or will not be set
> + *   up as non-executable depending on PT_GNU_STACK
> + *   entry and possibly other factors.
> + */
> +static int __init nonxstack_setup(char *str)
> +{
> +	if (!strcmp(str, "on"))
> +		nonxstack = EXSTACK_DISABLE_X;
> +	else if (!strcmp(str, "off"))
> +		nonxstack = EXSTACK_ENABLE_X;
> +	else
> +		pr_err("Malformed nonxstack format! nonxstack=on|off\n");
> +
> +	return 1;
> +}
> +__setup("nonxstack=", nonxstack_setup);
> +
>   int mips_elf_read_implies_exec(void *elf_ex, int exstack)
>   {
> +	switch (nonxstack) {
> +	case EXSTACK_DISABLE_X:
> +		return 0;
> +	case EXSTACK_ENABLE_X:
> +		return 1;
> +	default:
> +		break;
> +	}
> +
>   	if (exstack != EXSTACK_DISABLE_X) {
>   		/* The binary doesn't request a non-executable stack */
>   		return 1;
> 

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 19:13:33 +0200 (CEST)
Received: from mail-by2nam05on0721.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::721]:23456
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992747AbeG0RN2gJPej (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 19:13:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNxI7VTnzmNBLUW/l5jRFwJkuU1lJiAhwC8K6Tb+Aj8=;
 b=UgRjYB/paKNBd174fc1CuDr4ZBAGEaAgZyOJhUoxM/sNHzqIHTwhXDGz+9T/Ui98/SQS3kumqgOdlSrEQZqPcjxZk0lZP5kteqJCJVIMhCQss9M7V5gyQIHdbT0JdR8Xi1yEL4CMuFu2N2X9ksEjkgv7Leckl02HgGvBgiLrUis=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 27 Jul 2018 17:12:39 +0000
Date:   Fri, 27 Jul 2018 10:12:38 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Marley <michael@michaelmarley.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for
 PCIe erratum"
Message-ID: <20180727171238.ybtoxddx2xulspu5@pburton-laptop>
References: <20180727111339.17895-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727111339.17895-1-zajec5@gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::17) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d64f6e2-3577-4685-0093-08d5f3e4286d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:58IKYJhP9MCeiMq4WHcE8uaSRROvjsq4/oEnt4vaSHWeGbWe/AP4nGVFdhp6Bm+HvgPjd2ssgR5XCIqH3EGXiINqhFEKWQs+ypi6QOy6EHXDA85q8rx2ZFqhtGK58pVFd51ivVc0atYpiVescmeuQEpg/pGChlXVXwaLEN3Rlgb03Gku7yNPC/XaJ3LtXBJtZrcQAEZR+t+DRQz2XZtY/CXdWzpvfeBagrf0yGkKV5P9i/c7Z+/mhsS/rGYtsaTy;25:2BOirKU79M7pM4O/yEfa08gN1SDLSSW8wfgApp2mURoAiVzNxnXXHbpJ0S5KO2B9WOK1p5MI+C7by/dgWq9fY5xTmBBsjpGmAzc8HbaLVKz0H531c+5ft8U3jdmwxBRl0+D9GzrhA54NXoJrBBtSdOIL4a3t0bX8AZAMXTDhlnUa9Ce/3/uGHb1AUwJ4EI3ZdTCFPvxZyNB58SwgTYUS5wg8f/HAKnAlCEYrJf3KM7J9AIlKN6eqbaZjoPGXd6GktSL+dN7gVG4DET1jEW+KkNlF5965Ao+Oyk9TkFUUwC51VYEmJ3reZQO3iPtvdmTr4kXrr0DIvCfDRxSdWbjkXw==;31:yE/jFOY+Dl9IFGOqLtvgWzRVROKtupYkwSHttPvFR3AI7xt6N89yzsD/pJJb3xKg7EN0sX+qHm6ddWiDDFBmpq3laljgG2NFO3utHzQepMa846AbgVYu4xb6T0psNYAbAHHQ72526SFoyZGHb3Ql38HpaogOlYApE/B/z9EfiG4OBMpIPd0aqLo8tUq6am12x6KsU0QhKM9CpJM4zE+yKYaMYPRGXvvpm3Z7AC03pkc=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:J1zUYeZ1zardWfEMhSjgO53fC76SRgfDuVeywkJVOWfaz7VdOqDvbnkCeu8tRPWWzOnKQPhsSay1BpZ+pICElw53e8mvPPI4KpBMiInJPvHvJBDNmvjx4gYZOa6mqK0VkTdHAMBqSDIclRsUcUDGN12TmoxPsPPB6+dCzE5y1BS3WB+MGGL73d8YmrE/WdWGkPkp6FJRlSZbR8JTz2V2btCFDkNQTE3mlQNLf+Oi5X07i6Xsgd2UzZOoY+NmN9jI;4:deVqne7XC9siBbBOksqXJuzLK2Nfk1VwyGhJSJwANETnDXisRyOsWJ5MDihhQF86ohWqNtb2cexVUcrcIE9dEudP8gGzzTsKRS8mCgHFNFvEfh1AEP1/xfAQAi2nGk76tEuyKGxTGWf5Z1EsV0E3UyKiAAikdGI6spQUGVm5oBSbfWjE6JLzRNh8qCrZDBjk/3tTGb+pzYj7/hxH6FV37yak/235ec2e1HwUrgoKwtV5bItRbXqKWwLbvCAP2aMffP77GTles4e6965FXGqkcYqOHwOcLefi+JF2nEhLCIEjq7TGjgK8pII1VqBSC4UC
X-Microsoft-Antispam-PRVS: <BYAPR08MB493438F080EF01CAFE741B1CC12A0@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(366004)(396003)(376002)(39840400004)(136003)(199004)(189003)(39060400002)(58126008)(2486003)(52146003)(33716001)(52116002)(23676004)(186003)(8936002)(6496006)(53936002)(6246003)(229853002)(50466002)(76176011)(16526019)(6306002)(26005)(25786009)(42882007)(9686003)(4326008)(33896004)(81166006)(81156014)(8676002)(386003)(6116002)(1076002)(3846002)(54906003)(110136005)(5660300001)(2870700001)(47776003)(68736007)(66066001)(76506005)(2906002)(6486002)(16799955002)(106356001)(7736002)(305945005)(97736004)(316002)(105586002)(956004)(966005)(11346002)(486006)(478600001)(44832011)(347745004)(476003)(446003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjA4TUI0OTM0OzIzOmJSSVVLZ21XQ2JjcGloaFYzUmlBWWxaeVRl?=
 =?utf-8?B?WlZQai9RRDNBNk9IYklHenBtSzM0bW50c0VzakVCVHdab3RqejJDczRYVk8v?=
 =?utf-8?B?dlpzNTRzcTkvMFdUcmFjN3E3c20vek96Q2prY0kxQnNTTzJxbWg3bUlyOGpH?=
 =?utf-8?B?SStaZlF1cVlqU0ZtSytjcGhBRjQ5Z1YwZnFqc3YzUzlER2pETlk1RktORzhn?=
 =?utf-8?B?WjVpOWIwNmg1UGo4NndjakV3NW1TMG80SGh1RE1PZThWRkxlejZoS0EwMDli?=
 =?utf-8?B?VG5STWFkSDU1VXpvWForMUcxVzkzNUhCOEtFNkp0ZUhEbnJDKytuWWcyeVFK?=
 =?utf-8?B?VGlCYXptWmNhZGhucVdVcEc1ZExUcWVMTXZDcjVvdk5wWUsvcndCRThJODFO?=
 =?utf-8?B?RHhndzBzcEF1WGhuS1JsUVVkREV1Q3FKSGRpTFNNWDBMd0RGeHBVcDZsWHl1?=
 =?utf-8?B?dkpPamhURGp2aUZtSS9GcE8wdGVWOXoydXorUFBQeTRUblh4RkN3V1V5LzQz?=
 =?utf-8?B?V21nL3A5bzZnVm5YZUtTTzd0UnBCRkFoRHpsRUVuT2ZoWmFCenoxaFV0c2NC?=
 =?utf-8?B?RlpkUS9NQWtvQTc3azRaZW1naWFHclNsM2F4ZzQ0ejJ3ckNZV1B5dWIwV0Vj?=
 =?utf-8?B?T0JOMnpuWmJqTm9XYm9KK2x5M25ycEFQOHRiVjg0SlJpZlkxTmM0bTcxY1No?=
 =?utf-8?B?TXNBM3JMTjNuUUFEclFqbVRPdUR2SVUybVlVZ2ZReGRtcys5TUpveTZTdElS?=
 =?utf-8?B?c3FoRWN0Q280UFZpN2Erbk1wMU1DaFJ2ZDREYzE1WWdyUjJXL3RHQlR1OFhw?=
 =?utf-8?B?RkNZR1U3TjF5Q2R0RmVlQkIxVWRmQXBHWDdsSTZXQVRtWFhjLysvanppK3dT?=
 =?utf-8?B?OUx4Y3R1L0o5ZytSQm5RSVZpVGVCUHIzU1V4dWV5S2dBdE85NkozNVMxMzRF?=
 =?utf-8?B?OEFWVkR2ZzRpamMwT1FTRmUyYWJ5S0lGOER2cDFPdFcyV2d1TTFRaCtoOU9q?=
 =?utf-8?B?VVpEanZhejFaUHd2YXRpbCtFbEN3NGJzSU9yalpvU2J5T2NDRVAyR1ErY0xi?=
 =?utf-8?B?TDJlV0JUMEZIcEphcFBLbFBGMlVyZEtaKzA2RWdSVUcrTDZWS2lvTWFhKzdQ?=
 =?utf-8?B?ejB2U0tQL3l0eDIvV2dwSTlqSXFxMGJCMHo4T2pBU0xTTmxHaGhFS0VjVGtW?=
 =?utf-8?B?aU9tT1IwbW5aRFJUaU9NWDFwdDRnZVp2dW8vQy95TDVqVmlLL3QvQkNTeDZH?=
 =?utf-8?B?QW8yOFkwSlZGVS95d1BXU3hHcllWZkVNY21JZWNOK1V2YnJNVGZBdVZLNDZw?=
 =?utf-8?B?eVlaZHQ0MmZTVGN2U25MbXQrZWpWVUp6L3J0MUl2VnpXSEhTTWN1bG1RdVA0?=
 =?utf-8?B?NEI2NnJkcFh3bDMxY2k3ODdiRXEzZjY3SmpwU2FudExvN2RFZVpObDhWTmFJ?=
 =?utf-8?B?MHBvbUdEOEVwWTlENFBRaUlPd2VGOWhMMG1sQnU0REFkdWo2UjJOS3BncWNs?=
 =?utf-8?B?eFptY2U4SDREZ2FZZVM3MmlxMGF5M2xxRnpNTnYzTVZxczRSbkNPL1FOL3lO?=
 =?utf-8?B?c1RacVAvbk01UHcxQ0o0c1k0TSswZ3VPcEhrdWk0NzNyVzhmbW9zVURBaUZL?=
 =?utf-8?B?Vm1wSmxtaGh6UEpJQk54YzJ5YjlUakYvV0pEam90NFNTMENLbkdXRE9ENnVJ?=
 =?utf-8?B?dFJzcjlpdmFWTUEwT21wenJDTnYrSEFvWjlyUHdVeGlibDNRMXg5Tk1mb1kx?=
 =?utf-8?B?QzlVNmVzUlZ1RVgyNTBVZFNqNnByNytCZXRHOVFWdEFFL1lPOGMzZFMwMyt1?=
 =?utf-8?B?QlJIeTRHUjZGblp1VDNnOEZuQmFKTms0cmg2Y2pPTGp0Zi9qR04yWm5PaEh4?=
 =?utf-8?B?U2duWENhclR5a3VUVlNNWHp1SDBvR29FL2Y5SldETjF0VExVMzZ3QVNTVU1p?=
 =?utf-8?B?bGpkRVJlVEdoSHJYeHJXZEtQUlNBVlpncGpNSFRERVlRR2dpY3JGTW9BamFr?=
 =?utf-8?Q?7OfVCu?=
X-Microsoft-Antispam-Message-Info: n7Q9JNZAkRcdJPbMEo4SQpq2B0bYpYDDWf6HeGXBjLnc8/CP7YDfVg5QFSRmzFUp2o/vRX2e5X/VGkKCLLhNrF2fiROhu+EF+5XK550AJFcpEyzAlNo467GSh3uNSr3bSu7q9L+6/DI0M73dZENZEVtxKqR7QiyudlNYgGKS4dRb79C4EzLf4VFdFzGT5MkCxDPdPuMCMI4AowO3ARNebRliNOUJoRPCdhBW3XUhqZ1mxWyQHHj9LFB12YF8yezSMHZa4QDNjz7Fj9ygWQgyprrW5e6hBcKbM/SyT/6b64+wu5cXAMzX441rj0VcSTXAouRog9/rKcKsLl2XmOcW1OXY2/3YdMe98BT7GuPRwUo=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:lzIEFGkWPYPs+0XUl9gO+X02AJcDa03eZpxx9YvFiP+GZrhMx6dzPAP/nXZ2mLU+Pe2H+nmfjJ9+ETPxvrrS9FFTl7H10Dqen9ClSGrIH+G7HP/68HITGj5uox7LyXWM8LidJYpdJcu0jAeYFKBxgo4WmbRdCL3xlzYaaToQCdWV0ohII3nGlKNWK/rYyXTZ4Vd8OOL6Hb/QTnNtcH2Iv3W3VSyqznF7Sd2HL14cKBPLOIhXcB50P/5/GeGZBJD9woqAUYVKEv2V1lZbc3culm34X7+LEAqEIz8MrxZIiZiho7THiSWChr+vqn2X3PHFBbFaWouOF02zfCADB+TwwLxqC+t8CNhwgsmNckOydEwtmB9uhMrL7nfMEijPLWs/OPI2EoPNNpOpEczlScvKmGSz/i4q9KLT+9229jbMMlD3//vxvBUf+ILzRCuTW6oAFQvMVM2buHxsMSE/nptwmA==;5:91ME8FX+M6NzQaPqmUfK0f5T8O9SgDJWXuM0EB0F6s5yyC//UxyUXOiLCNzqfuR/RQXsVOk8ksuYMPgsg8+vQV3PN5Z0J/vlQXayRVZSgFBppcprt7LEjRbdfCwZSfPVHiKjV8LC8vferioB+luM6lpltNI1rUVgSTJTBRQLTpc=;7:YmXMXVV4kZQWu/x94Z1RNq2jHStVS7ZuLI8RLSBf3XsAvLgFit3pLSbE+vyjyBHCyTEzG96LctkAx/g2C/dwI5aSMJ8Vxzgf9bR9y9Qd7AX3KwoCEsu1OjpLXXDCQJslebuEC0B0JbzOJEzdqaOeJuLgXVEJ+Wk5zXm4UFMVurID2i6hxfKOalFUw9Quw5MPjQYnemAIMjBW8qdVyH1EA73AoyA/frfF4Y/3Ega1RedIpxrGUVs/ws04z4vbJ1Ws
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 17:12:39.8478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d64f6e2-3577-4685-0093-08d5f3e4286d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Rafał,

On Fri, Jul 27, 2018 at 01:13:39PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This reverts commit 2a027b47dba6b77ab8c8e47b589ae9bbc5ac6175.
> 
> Enabling ExternalSync caused a regression for BCM4718A1 (used e.g. in
> Netgear E3000 and ASUS RT-N16): it simply hangs during PCIe
> initialization. It's likely that BCM4717A1 is also affected.
> 
> I didn't notice that earlier as the only BCM47XX devices with PCIe I
> own are:
> 1) BCM4706 with 2 x 14e4:4331
> 2) BCM4706 with 14e4:4360 and 14e4:4331
> it appears that BCM4706 is unaffected.
> 
> While BCM5300X-ES300-RDS.pdf seems to document that erratum and its
> workarounds (according to quotes provided by Tokunori) it seems not even
> Broadcom follows them.
> 
> According to the provided info Broadcom should define CONF7_ES in their
> SDK's mipsinc.h and implement workaround in the si_mips_init(). Checking
> both didn't reveal such code. It *could* mean Broadcom also had some
> problems with the given workaround.
> 
> Reported-by: Michael Marley <michael@michaelmarley.com>
> Cc: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: stable@vger.kernel.org
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> This has been reported by Michael as OpenWrt bug at:
> https://bugs.openwrt.org/index.php?do=details&task_id=1688
> ---
>  arch/mips/bcm47xx/setup.c        | 6 ------
>  arch/mips/include/asm/mipsregs.h | 3 ---
>  2 files changed, 9 deletions(-)

Thanks - I've applied this to mips-fixes, and will send to Linus before
v4.18 final so this regression shouldn't appear in a stable kernel.

Tokunori - if this breaks your system then we'll need to look at
applying the workaround more selectively.

Paul

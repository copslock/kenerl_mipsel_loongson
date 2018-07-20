Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 19:18:17 +0200 (CEST)
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:51667
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993488AbeGTRSNy6xsZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 19:18:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lghu9flveENtkmWtM8nRZk0HDyYjD8X2q02s5b57geY=;
 b=rRGkte8bP176x+5i8e6x54eXEPfDlrDQrtCOfFXiMKVxa07bkOHDpckkXSJ28/8QwK9+Vv2qs6CpV6KR+Scu708iCvcpGWiRX5K8A/fyfKywQB4C4zzrp2ndX4yZnanBp+cdTcR8UG+2mAyghJtu05UQxtfDP8xqgmEGSt/h3GY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 17:18:03 +0000
Date:   Fri, 20 Jul 2018 10:18:00 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Felix Fietkau <nbd@nbd.name>, Alban Bedel <albeu@free.fr>
Subject: Re: [PATCH V2 04/25] MIPS: ath79: fix register address in
 ath79_ddr_wb_flush()
Message-ID: <20180720171759.rxccyu44l736zl2x@pburton-laptop>
References: <20180720115842.8406-1-john@phrozen.org>
 <20180720115842.8406-5-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720115842.8406-5-john@phrozen.org>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:3:101::23) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac70d611-f837-4cf9-8a17-08d5ee64c04b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600067)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:lkWVMyZTX3BoxbarKc0+x1Qah/2LgLdwX36qMAEPRoZZDnL7bPaNBjeNfSPWK+jGPN8oh5ulgc8W4k8z3yRAL0dYE3aezYTU6wPTRGogYcj9iVYtSVMeu1rzmE6+B+Uru0XL3KSJM1vIGf5D9M0ILoPeVUoWECdotFtF+9WD96BRYKOavAQe1WI+geb8XHpOgiMPTKYrm89Y9Vc1wkEoxxcUlhyrX7w7pLwu9kJ9f1EuFq15XsAFZn8JdlJe25n2;25:7yA8J+rTcGCMtKKe82bG6SjmdK26rU+jTjdz9BwrAo3rF8ukaMXDZcbm2ZOs8tCMg7HnReIPltrv74PtCNGn/TQ94yHukQ3Hx27ybnLgvKFnyMSa8M1r5W6EdlDZXeg459Fo+iv4OlGD51YIPIXWeglF4lMitUQucPEJlnB9co64+SrostKbkZZICMaseFuSXaaBd8JvBFZ0JW2AhNlPWOlt//BJWCYgwyMrkeNNZX9xQS8GwJ5sbpm5w99ox4PXGoxQas+RgU1IltfEYNCYFoB787f3BwuZEoB5sJx17dz9oyn2Rc99VSi3ckXZe7sfJSyOJ8/UsxWu2VG8ZKSkeg==;31:CB8MFqWtWtXjTTLkohzHW4Q4/+NSo4qb+lAEMMPKySw27po8qFXTIGkWrUOy9mZjP60DxFscZqdxt9dP6xlgcfCZrXeLYIYk25O9+906k6/dS7UnxRhIW1vDsxcs/IwwY5qJjOJ8ECE7LqDP9JzcrKSri2l99bvT9LK2Gr2rTVRKNF0AJpz1XJyiYPKlF2eaofTGC1rNnFBCiGfD7/6oeM8lEwVfkObKBO9K4qVx7vg=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:xU9+8HLRBUd/uz+ZudzRaIp4JhkF58meFy4aZGPvmSYi8GNtCYhgcSbnFNAVbDgfgx7hIaGQQvKgujttR42I6PwO6cGjaNRJTdkigXP5dDZdV8m/p27ycyoklFAoHzcRcrQE2C/wCSXBNarx1SV0m2vBavTZ8dM2O0L+/kUPGs9gezVAc1I0CGV2khwoUYnYgHy/C+mop3Fnvw390YCu0LgVMkjpjusa9BWZm6CEFDQnA9fJgMAylFotcPBaM1kS;4:wfy1LbXLs/SArf5+8DKTTKQRpZ5pMVt45jRpPBAq3J7LbHsurOL5BD9IXWP8TfHySMtW2UTZUB87B21igQ0RNu1RZ+oJVB3fWKTJFyiKxz34Nx1NNlr5upcI/LX6EFVvPuSCR0kbc0xV+3a3Xf5xGERDizRKkuhkyTAoxitqyrPn+I3vKGn5qT1TqiXd5UZso4zk0sWFD5ZiQlkBA4ysqZcnCEkcv/Suowi/kQ57iNzEGlqlljMa9Qgl4QPXaEY5nK5712mv8TKksK18sMbz0A==
X-Microsoft-Antispam-PRVS: <BN7PR08MB49325221C358235C4FB5B3FFC1510@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(346002)(376002)(39840400004)(396003)(366004)(199004)(189003)(386003)(6496006)(16526019)(26005)(76176011)(186003)(33896004)(42882007)(6486002)(229853002)(9686003)(15760500003)(47776003)(956004)(476003)(486006)(66066001)(52116002)(106356001)(44832011)(446003)(76506005)(16586007)(58126008)(54906003)(316002)(105586002)(81156014)(8676002)(81166006)(3846002)(6116002)(11346002)(305945005)(478600001)(1076002)(8936002)(23726003)(7736002)(97736004)(5660300001)(6916009)(2906002)(68736007)(53936002)(6246003)(33716001)(50466002)(25786009)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:wHfo9S+lh32G/gx3ukIZJw9avVE4t2MKOdpwbqBlc?=
 =?us-ascii?Q?HTstHjdNHfnAmnn2K9A3gU1xNwQQLQtEAxbXMssfvQ48ijGL4US3j3XvGHsB?=
 =?us-ascii?Q?51dxH3zNXDJVWHWcDA9MM1kAsjoPabp47JWHigGVvgFn0DC9juaLuKov6nbs?=
 =?us-ascii?Q?8I/HdLtXwIyS1sTGclRQRJTPA19hwkXhii0LJ7v4zfCQiz0ZQys17vFkm+4v?=
 =?us-ascii?Q?PS3mtRMpF01K68y3ZLRvtwo+8Sz4luw1ZGL53ZdAtDoKLrzf3bhA54H7b8aQ?=
 =?us-ascii?Q?uDnyIdvXvpKmyDSZpxTl6f5R8l+yInBkR8GPrw37w5zlKtGooYcqtEY4CIej?=
 =?us-ascii?Q?YK3+w0Xrme0+kCS74Ihzz6h8dOb2JL7I6ro/Ahit7ZhKL26GzVTolB4uv8fT?=
 =?us-ascii?Q?TTtJTWnCi0f+WWm6JoXXcGd/UVT8pPn2g3ddwhzmJWe+NVv4+QbwnMNuOV8K?=
 =?us-ascii?Q?e6bVKL2C+FbaGp4+RpyZRH0yc+6SLHPmf9PvAgqtmvbDRMt3PnYtYM6Il4xg?=
 =?us-ascii?Q?ZGhW9Ae11gMn73kBT86RtVlDDEhCOvJ4+CAuYVYxAaSO50Adc95hNyTWbHra?=
 =?us-ascii?Q?fk5msZ4ZOg1gO1GcLpoP9FcJzZAaoTvxkDpzr1HA82NYGvW8MATA9sc7p2/b?=
 =?us-ascii?Q?uaaW/53CgMcW80FDOWh2Nq8UzF7AVGOv951jVQBGOgaLGBv4NRXB1YaSEhxl?=
 =?us-ascii?Q?y9waplahQgXxnB9ss5lde7Gyo2wZn7kI7s00Lezxbf1iUuiAGLw1W2tGSZtM?=
 =?us-ascii?Q?MvMRowPCt+o8PKxfWKLQexa1NAexijk4hyG3vJG4C4re0aUQLLuSDpyk5Rrd?=
 =?us-ascii?Q?NeXQQ5JFgdyAIbrJn/0YvgiKlwmCvNeffr1qL6p9kUNrPHbf0rOTY5/4X3Ps?=
 =?us-ascii?Q?LzovI8Zpm453iBPEZgiYUfO1UG6Mwn6eXFO1PIC5NJW5rCDIVawk1mTrxYk6?=
 =?us-ascii?Q?NEd+OJOfY4VFuD6KAzOaXzw8iyjQ2o8wYLQz2uSfxr80xg88740AOFGxWrLS?=
 =?us-ascii?Q?zFflYWwCDnUsZng2Qgg/y0uoaqBC6kNk9pDY23xTTuO5FUAJPlFVL6MfPlIE?=
 =?us-ascii?Q?uQadcGQ3LMNEIqjCBgw1j1kDwZcSxvlplfUgQMzLXMakE/gjmoZwAs5E1KoS?=
 =?us-ascii?Q?Llh7mNIkXQgVmIWfgiu2+BSIhKHFrQ6t+F7PU1JQg7bTz/O5uDs24iSvdXLy?=
 =?us-ascii?Q?XyEvyR9+bbR2sMOLMj5N7SWUpOI1hQHFDQu0CkLhSc0Aw0rWLe29+W1u+i1b?=
 =?us-ascii?Q?a11Pjw+yVLZVMKRmXDbBfYd+URbnwucUWGBr06ic/u1FuWRgqKy7WQwBoj8J?=
 =?us-ascii?Q?/YisInA0C80m50K5xxX5tk=3D?=
X-Microsoft-Antispam-Message-Info: Gon9vdNFckbe+t756nDO5D1HP/INRbDnhW09xVVysFrqMULXEqFaR/K65xjJ5NlllM36VlbKB4djl9lDHnCVYWrPVdBiCVTDK8cP163F+u5eCx9YIi5iKtDtzTnEud0DU3Aro07p/X/CMPM5dau8R78W+lv0TPfIfW+5jzlzLBx0C2RvZKwstZ4c+jMnOtD5Mi5fGKCdCszr6faoW8XsupigIyi4eg6EwZztmOk4KDBngRoaZJW3YT6TMynqo2NGBGlPJCh09VVrFmzt4vBKqPnTKJetF2dizOXAK3I/nVE1E7jfZvanNs8PDg87Kli5vvzE2V7bWqvVErVew2P0rsOXJhT9JL+fA48cEJjP2v8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:xnj8uQ9eFuwGF6Y5h/v64Lk1OtIqnOGZWZjzD7lbHxHrqIENbbJwoqyoUe4acZhpIcB76Fqja3IZKPuiQsBX5yhS0WH0d27rTxpCCLi0jmxRXMQDgXua9jTXGNJ0EtEucqHvxxHElXl/0uljjFYHDtAnnvl6KjZ4+F6FKc9yDckkm1vy8qbqiybD4ho8qWn5+I27DBSMd32wY+SHwHTzTBTOIwFwjD3k835qlLb2k+NTHBC/AvKm6DmUw0uqQhJVVmHeGMgrcB+B0ShtfVwA0wFnDcsKyjY7Gw8M1V8vfXJFhYXuJv8UXKCZOn/4DQrodaUYAPIXG6wv0nP3nUTivdj+Src7WRqU7taaFAD7NscokGfvO3EO7fjl0jF+bOWCfIR0Iq8UA81LmhD3kZgNSwA5n1AqPLyX+SCDU0NMDWh+cPr6BG7cP+glzId3+r26IHKP+UunIT6olutJon6UEg==;5:dQofxqhC053lqxpapsIbB2kTLRsqGW4AB8pqCTEzEgszMZMYhh0grFP1N7gV/cafMaCwkh5zW1cytnM6S9XtmbF2pWrNj+mKSrHPrO1bHpIom2I51Qg9dmbyFkpa42GooAtFzhQS7qJIZskd5I+dF77bJqurkpbXyaGQLZ6e91g=;7:ynThkoaUntikfPAWYWBvUz1EevUXhaDcFYPesh3Oewh6+V70R73VhL5VZLdAePpma9dQb/HWWOBjReqm5HcHVGamo92MxV9EdywcbFOGBmXgnDlXOgUI8Z4sELzjc34xuujCxGUagGYrpQbmyuomTNW1TeBzMTefNLmlUgGi7bJIJdOgOIkelc6CsIfomkjNwcbk697yOpsDUZItqph9yi4Ix+34ShPj+xTW2Nh7mGcIp1TO1V3ZXra4syst+XOT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:18:03.0957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac70d611-f837-4cf9-8a17-08d5ee64c04b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64994
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

Hi John / Felix,

On Fri, Jul 20, 2018 at 01:58:21PM +0200, John Crispin wrote:
> diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
> index fad32543a968..cd6055f9e7a0 100644
> --- a/arch/mips/ath79/common.c
> +++ b/arch/mips/ath79/common.c
> @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(ath79_ddr_ctrl_init);
>  
>  void ath79_ddr_wb_flush(u32 reg)
>  {
> -	void __iomem *flush_reg = ath79_ddr_wb_flush_base + reg;
> +	void __iomem *flush_reg = ath79_ddr_wb_flush_base + (reg * 4);
>  
>  	/* Flush the DDR write buffer. */
>  	__raw_writel(0x1, flush_reg);

Thanks - I've applied this one to mips-fixes & marked for backport as
far as 4.2.

Paul

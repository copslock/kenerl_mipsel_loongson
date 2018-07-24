Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 02:35:06 +0200 (CEST)
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:56971
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993961AbeGXAfB5VFBG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 02:35:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VCP4kixTmHQCGkttfd/LyNQKguPy1Dpz17yxcdfMcg=;
 b=XKY+2+TaDO/S3oYl8nlKD6U28zMBZCysd+Bf9WN1D74l9IuGym3G1khg36u3eqGa3U1PdrbY9pW+uZrZHPobPFC8/JMzyih/QvYt+Nt76i0aOxXQ8TgOdVUWIXSIkINB0kfROq5RzyGlY/xjUI/QEnij32m9IVyEnzSF5kg4moY=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 00:34:52 +0000
Date:   Mon, 23 Jul 2018 17:34:43 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 3/4] net: lantiq: Add Lantiq / Intel vrx200 Ethernet
 driver
Message-ID: <20180724003443.y2fcakalxmwwkqab@pburton-laptop>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-4-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721191358.13952-4-hauke@hauke-m.de>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0724aabb-d373-4d79-8ad9-08d5f0fd4523
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:J+zzcjMt2Hr/SEpxx0butkHWydVK2+fIaYFgxuzFy2T2P8VzyBryuZ5ZEhL2aMCc6sXgv4f6M5njIPFoD+QZ0fwZsy0bdjzXolltCqRngbwteZ5cmJ4jSd0dEE/v3833Xhd/lkvoiwX8EQMWirBcyAmW99q9+CGQCbQCf7XRss03aenDh0HD97eFiLAZY1tgzpYQvG6gxTQMtpLrGBVWga91XN1G8N5c7yNJDibGCGc8cEgY0U4CPZ/uLK8wrjgG;25:LUQw9MB4K4NHjVZ8DVCgwoiuecFl3yaR4mTB1KVTUqT1l4XHpi/F1gNxAKHwIKVNqTWC8Wr1z0iMGc62kDQupKZNl8Y4IljMJUWhoJYWQE4pMTkcrOPSL3ldc+CIDcnH+vM9Uvt2yYLIOySZ2YHCm9Rytg+WH2SLPt0Bfge2TPDwkMJHJc9ch70is/2NhJRBLdmBNxrnmPyeTVnlaIFXoEl/Hm/BJ30uvbX4x/lzFwe9T10Kt5eqqpKB7dGIz7sYGzTdcN3D/AObInFBwi/PDEuKbzmpkOe68xQ7pu2LJHm1ypxvwUb+HXR/Cb8eBy5n6V9qqQ6c7bTqAU3c3pig4g==;31:rKfJsAO0CVywCSEb292WUuthJahmsRag7pT3aqtY0YSeu7hahml/j2YDvxFMSd0N8GA0lOlKLCaNXiSAVpS8woyfqyLht8wOsJS3vXZWzkZGDhqqsoxskxm01al4Dxjq3Xj3fGl0RQHHA2mKbYGM0bZrz60ZCvMiVPB1Pn7HNCIbtA/5vDQf8brbpY6Q/7seSy0pxy48s9PKgjfaIATBl2qLk+XEPvDygsV/pCDfdSU=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:ukbkVUup6DohQpimK07ANBATSUv+4Ng/PTYlgP//nHzxr15PTWz8WoLj1jzgDZglp9swYzETh7++/lK/k7PjC/3lOGK7cJAclXYJt5XklDXumjnYRsB7dpQPWZ/bvzHxK//n//PJ/ukgrQILdbq1swq5MPeBfoKxNoejqIVD2ChCBFQ6poaBo9Xbaa6EiZ4yA/DC+aRAlVBLSulXo2gXfBXUGJqTtaKCZLujGHF8deEKGo3OcS0kC14eog6EwMDJ;4:qJ2r+iMRX1UTDYgjiZ2QMahvexSWzhojxTUBZQ1ZlNTjudoDXS0lFld5d4fL9wcDO0S/xp6pTHW5iebJ6Ko/BvGFhHVjqXRs4/YpZnWF3zsVqZ+jVUYGoLej3O5C/94xkYV9mWwqhhqmKdPMkrCsQkda86zAHa5788FylSj1P61K+L8TicvNuUfFCLhOahOyWqq5lEpGO5+xl0yacn/KCahQ6KIONMxoKBAzhRbQvXc3IIzh4QlBJw2LX53xlbhKdKizF4P7C3d1awuwpXZf6Q==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49332D1500616C7D358EC781C1550@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(366004)(376002)(346002)(136003)(39840400004)(199004)(189003)(42882007)(575784001)(476003)(33716001)(2906002)(26005)(68736007)(97736004)(39060400002)(305945005)(446003)(486006)(16586007)(58126008)(186003)(956004)(11346002)(1076002)(3846002)(5660300001)(23726003)(6116002)(44832011)(316002)(478600001)(16526019)(76176011)(25786009)(106356001)(6496006)(53936002)(105586002)(66066001)(7416002)(9686003)(47776003)(52116002)(4326008)(229853002)(8936002)(6246003)(7736002)(76506005)(6666003)(386003)(81166006)(33896004)(8676002)(6916009)(81156014)(6486002)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:wzo/GOt0i+4UtYfyAG6dOUQwwAYJt/c21xARTIT48?=
 =?us-ascii?Q?eKFn4q9nmpSzO6RYQz9D/qxBuxW5t/aGpprqwPCLx5zpSJMrz4qdEIg/K8Tz?=
 =?us-ascii?Q?PL7f16g5PfdD11VQYV1WbFhI9e2XgIB/4db0fH3Z16lHW0fd519ZdsLjc7vg?=
 =?us-ascii?Q?QCwk8zKcXpxQi2/Yd4uaJqOYlEdEcLZLKRuW2QalwxmVdJ9zBUkVOgkjDY5a?=
 =?us-ascii?Q?foVQPrYQAoF9OFetNUZiS3qv7ULeyM6JL6nVlwYUoZpCJ4UziJu8FIgMPVR2?=
 =?us-ascii?Q?KehvSAub86XTo0HpNbHWiyYqaNAzfV5+x4/LY/mgCnm5LBODstvF5CDKwdNq?=
 =?us-ascii?Q?0xpSUyobCD191coNgTXBSFFlVUUhw0M5hG+hcUH/xalf2BUrvCXwqP+eCMaP?=
 =?us-ascii?Q?fckf33xitBSSoU59jppbBqUX/eF8TqPTmPMjIYRBVlg1Q0H6Td+kxaU9MjNg?=
 =?us-ascii?Q?Ur6tRDBQtxPA0skGRRmBt+tmfQ8wg+25LvZnWbhLMqkovtihp9R0rqAxTURP?=
 =?us-ascii?Q?TF3vTEjzgChPQ4aaUA4BRmrw9iEXoqohq4yY+b4ELnQ3XWy9Jefd9DFwIYCh?=
 =?us-ascii?Q?rd7AzBsRrFAVCbGDHpznDwMsqsr5pwBuiNld1s28UkjLM/OyDRaMrl2w+TQg?=
 =?us-ascii?Q?UsZ8N5mRLpqQs7xbMNZ8ZPMc1SIaqxXZqfZewU7xz/Dazf74PvAtZynsEOHc?=
 =?us-ascii?Q?+8G7FbuB3GUW0NCGWcby57Douode32MqO56Y1zu7quNcUIaB1W93vbhPdEhj?=
 =?us-ascii?Q?+dzGjRNq7XIBYdrs0rFGY7h8BwhaKikaF5iDLPtEpbSCbziNn78FrDW8LnSB?=
 =?us-ascii?Q?XAS72B6sr955cxj7WNkIOLgF5YELciV092R97zSbuMLtrZ9i/xJkkcuXQleu?=
 =?us-ascii?Q?h8qwZ8JEwyPI74ancKBEsUC7T7vQ5SEXA36aod4ShXW5zqdL3TQf9jpivD0g?=
 =?us-ascii?Q?c+EWRpVWymlPeGp0Xb+4ZiOZTwZsrmA/gwHfUwXDCl4G5FWcJMRrGu31J2tu?=
 =?us-ascii?Q?nVvTdokf6ki7IsK5Gu12CDUvuUd10EyUnX1v6SLbedVBKT9/U/KEzmalyIYs?=
 =?us-ascii?Q?Ubu/+Ke5yGAN00BFG3eCyTbS4pCgPERZht98hVQ+/QYqQ8V29jrGZHQ+QIkk?=
 =?us-ascii?Q?8CdjzrpW/3Sl7cz3NWk3k+2OZfiQuuHEGUBzwqye2kvPbqIla8CMq5tWZ5Qd?=
 =?us-ascii?Q?aq0O6YrRwN6s+38HkFHZ6c+RyXJqtFQslLgkcAOjRO2qn7Rx7wg0OAmKlQQG?=
 =?us-ascii?Q?wN+ytsjWv1mMv6gv+AgtJLLSZ+/ENEnGvz+E5O19iqtGGhzoj4/trxxKyioy?=
 =?us-ascii?Q?HEuabDkkfiGk60fdsO2uT5VQaA98A3zJMZxPWzRtdayu8Ou39804wWR4UV9Y?=
 =?us-ascii?Q?qhBEg=3D=3D?=
X-Microsoft-Antispam-Message-Info: BJ8RUOSJFi4cvFdZO9JxkMOs2TW3ycJtbyFBQT0wKvc98im6xgFBoMfmpMb0ilrVOspsLl9QpV96PSrn/aciqvenJNKh5KRTSFWxHPLMEkM76nh9Tsw40m5lvGhS933P2AHcE8KUpLsK3M61rlCYxpfJElWQc+rv7XJBtd/dpXRWxb9TY+0ztoumX1oocg5fI5lD7ab2ZrjT6vXZEMG90fCjHnqaSyfswYwrB0kcXj7mYxIynaH+zQfiOpWy7K3dRkR/xLnenwngHhWKaFKxos/lHY/UidFV/RSVa3VUfAnhUeLK9T4WlLVqUl969ZBThZ7vwhUtlPvT39/K9bLXZmPcknsaQA8dsWtd4oCdW4I=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:zuVPDziEQ6JlclCfZIU2dtXM4QYDlKkc88wzJd5hMJjJF6B1X7irtLgBBTh/zhntEEKVwl7B0IAWgCoKByqyizB+jSda9QAaZ2wUzspBmeSywCCjluLKdCo67gm5XnF6siRmJsMFb5isN1PKXNXLISkS4IwKoCFr68Otr8CVzhjcuojRxt8kfF6fvUyLToN+/cNYqF48Y3HM1s5eC3M5MG9+0oq9MSWl4T00lkutql3Ve5fbG5KbG3TrgvjkB7BoMZqG2PqyYekzBMfNNmpqBUBWlXmIu2nLi2BZ4V7xf+e+U2Ft/LdVqdzvidAPdds9AycmZcs+cnlGrFY/nvjbnve+JLt9oxK/QsWY8rVeFF3ZM6dUW4zLDw8K+7G7HSi4FQoj4Z+k2m1MbiS1DaKDhEBZ8JmW/ZiA6JIK+Pk1HgSfOP3yqiE2ahfAB6Ywuuwh1f2meIQeTEkG7y6o2FyNdw==;5:MgLpcVTLxMRxPlr1dAghl+vNZR2cuLjdNQFsvUTRpyQiwLR0BK2DYS+iS378kPbv2VfahW1ifkoq1abzdmoilD7zwr6EXwUW5LJy+nPC3ZxaE5k7z7Gpgbu9uRKZMS5OvRTSVtEoxbQsrU/lrR0UQ4N0Rut0ie5c8m0bFrB8atY=;7:bOA0MRzosEqAhOXMsKYc6uzPjHHV+6QHuppgyh5JtgVBFaz7c3E0adJegZfnMk6JRoZB2wFMaGVAmZkAiW41KYhRYpbQfum2MjDb3EBdH7GHNy15Z1j8MHHfkSaWlIVEUb/c2h7syrxOsC2Arf4i3wa2q7FBQCjOQPfv+1cKYBACKD2RRnCwhcgBjxtP52RHVtsTkDHPlt9/HQAbt1p9+ntm9rdLixmHoKJTnjZxTmB4xTXNKGl3Wr0FwCoBPKZq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 00:34:52.0032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0724aabb-d373-4d79-8ad9-08d5f0fd4523
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65065
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

Hi Hauke,

On Sat, Jul 21, 2018 at 09:13:57PM +0200, Hauke Mehrtens wrote:
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index e0af39b33e28..c704312ef7d5 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -536,7 +536,7 @@ void __init ltq_soc_init(void)
>  		clkdev_add_pmu(NULL, "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
>  
>  		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
> -		clkdev_add_pmu("1e108000.eth", NULL, 0, 0,
> +		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0,
>  				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
>  				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
>  				PMU_PPE_QSB | PMU_PPE_TOP);

Is this intentional?

Why is it needed? Was the old address wrong? Does it change anything
functionally?

If it is needed it seems like a separate change - unless there's some
reason it's tied to adding this driver?

Should this really apply only to the lantiq,vr9 case or also to the
similar lantiq,grx390 & lantiq,ar10 paths?

Whatever the answers to these questions it would be good to include them
in the commit message.

Thanks,
    Paul

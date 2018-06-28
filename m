Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 20:52:11 +0200 (CEST)
Received: from mail-eopbgr700125.outbound.protection.outlook.com ([40.107.70.125]:45293
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993849AbeF1SwBycz46 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 20:52:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BME5NbDaLPaDxg694olwPromSrDwkpxDvr3FFlyiUes=;
 b=B2swH4GCIVktXJPe7KqooMosAm8969EABgbiW2MwHxouERRsjUROeb3nEls8E7Bg/G94g2uGK5yg8/zkkLMFjAa+jXVtdlXZogJGTKK+xEIrFKApCY0LKRDlnhwIiamTk+HBNEnwyokZ3KOQvuYbIJIDV37QgI32mTlwCQhx5Jo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Thu, 28 Jun 2018 18:51:51 +0000
Date:   Thu, 28 Jun 2018 11:51:49 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Felix Fietkau <nbd@nbd.name>, Alban Bedel <albeu@free.fr>
Subject: Re: [PATCH 04/25] MIPS: ath79: fix register address in
 ath79_ddr_wb_flush()
Message-ID: <20180628185149.gcmdyiiwxzk7vzox@pburton-laptop>
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-5-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171549.4618-5-john@phrozen.org>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:3:c0::23) To SN6PR08MB4941.namprd08.prod.outlook.com
 (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e362ec4-9fa1-483d-1148-08d5dd2835f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:kQI2rom+dGotHu3VuX7PCVity6aqZV+vCSISGBpfIh5zgB/TuDMElJiUbTECOZMgBwRfN/m5YiroTxq+0BNifh/ji3HAvx3BWWqcV0ffEzBC49XewVA9HGJDBtnlk20PxO9mp5iEZyeUwb//Jn6iX55IW/eTR+XRpRBE2GOIWwpgtpbOQV+4Bv0KJpXRVo9TT7hU5PTEbxgr7yEOBW1gfZ3Lbi0++LgWY7xP662fPfj8nMxcGrACbVyUWywa4KiW;25:xmQbGOUSpq1ZngARQdmMPpdNC7a3e6O2t4w8nE7E/xaQsWkDlY2iaP91wsq/i2M+Xb9JTfa1fp8bHO0uGBBjJS/RYxyxNDwyFldYYhY3zxiMYM0olzICOk4weL1srWAU7A8DB8sowSJDVwJxvDP3FDTJFSA9t0C9X+8xNtmz3YHzEodWPgRLKCFWrjdo84X/lpYvKSSMvmfg50aEkFoifqf3uidS0dvA4738DKHEpUay4eRwMFotLGJL3EUi+oOGKpG1jlh7h6++5zteW9OcHjyziTTLbXIdzVR3ku0hefRzHuygob08mlPQpdGCt+5yhKr0/ZeZFvPI2HBvpdtmTg==;31:2nhZMJ+3YlQj6+nKu+F9ND8dgIlc8thqKK3Qi9LBpIvgktJJ266DyoY9nu+dGsrQ6wmdKNDJpnw895r3UtWBvgnYGXggF7EHsGIJhskZrJTiBBZkTX+4WDLhuDwCbUpTV0VWaeQPpVNZOqG4w6Y8OzH+2pJHKdotoTdAw9MJ9RHtPUKNDyUK1JVFlj1e7++Y2PWjw4JTuaBDT59+CwDN7PYhyT1jMTf5skbkoxhEHK0=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:62AutV4DwLq+fbK1H3Dai3BiHh8Ev8lSUWcEgWYiPej+TSLLRBParvhZhne2/kGT3ObBJhof+Pb1uvIYq/RNtIoh3sy0kCvLyTGPlbw/5OUakYLezbpHFhLVOilmlFvNclFkus4KzuMmJ75md3GeIpwa/fBXp/fV90b270jQFWjbcQv/fMyYgz6ylwS8U7WL1/KZQfMGoPw2r9JZ5opZid8XLy2RxtmpYKK1wHNdYOLMBEW9Zxd5SbUW10kTLJKz;4:E4N1gTA6fCGKpIQLSeFauoPkDS/kgXiXgoKXFgI1/V174K0aIy8IMPt8vUO6UY0cGuQ3Mc289Tdzz7A1n8OGLGc8q7XiEC36mYwRHPSn4QaJnmawA2GIBZfF6caEeSEq17X/K+CDX1lkCM18AmrMEnoXwI402Afa5w24SmDpaT1ZTuCvLyaKddmH2USnAbzWQdd367Hma5nAZK88rM4CSztEsU156CJx01GgHyY37PqFdavnRfm7A/OBSQfzhKf4+fyru1+JIH38O02XOaPjuY+7AECfcUT9hjoVDzICdrwWeATdWwQuVzNQbMIffmri
X-Microsoft-Antispam-PRVS: <SN6PR08MB4941444A6CFCF8569F36E583C14F0@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(191636701735510);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(346002)(366004)(376002)(396003)(39840400004)(199004)(189003)(478600001)(386003)(8936002)(68736007)(52116002)(76176011)(33716001)(53936002)(6246003)(305945005)(5660300001)(6496006)(33896004)(14444005)(66066001)(7736002)(186003)(16526019)(97736004)(8676002)(47776003)(106356001)(1076002)(6486002)(42882007)(81166006)(81156014)(9686003)(26005)(316002)(50466002)(229853002)(476003)(486006)(25786009)(6916009)(4326008)(11346002)(23726003)(956004)(54906003)(58126008)(446003)(44832011)(76506005)(575784001)(16586007)(15760500003)(105586002)(2906002)(6116002)(3846002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:lJWIvYr48nMCbaLQhNDQPLQQtVJAVJxUEXFiBWNV6?=
 =?us-ascii?Q?mNLlkeqBUCmmSJyXgIKnguBeE0Llbj/V0DneMR9OsJbZzIWhUyIZNcOI7ZcX?=
 =?us-ascii?Q?Yvh52S49sH+pAikRPHe4ZE6xBg5oR5AQl7O3ddA6Q17ee+fdO3X19TU8lAxN?=
 =?us-ascii?Q?D+V/rY9TPo7JKL/Yb27dBHNJOxzt546WppHITV+9vVTXwJkiQApx8FNr4UOu?=
 =?us-ascii?Q?iN6L6b7Ag3LPy2YCisVH0RvkKtZKyUN2iFg6EXfh/EidoB0NNobukPgTLRJ9?=
 =?us-ascii?Q?c9jvpHu1GQw0Kst4aQr4Lr4ZuIvADWLIVZbv9HkueqkNs7n7xLoeITe0IUkb?=
 =?us-ascii?Q?SUa089B5OctU72UcX1Jb4j/8gpEoNfRVxQYERG7k1zyBufScfvPnftrIIfJl?=
 =?us-ascii?Q?Bf8h8PwCZ7WcbnE03Xz/1QBPj+E8AKaP24HY6hm4wg2WZ3EI3r7um9omIDJg?=
 =?us-ascii?Q?0HLQdWLSTzHGIzxxRpAHDmrfhHcAzzcso9AroGxhjTmXerMNpvbXuZi/aUPH?=
 =?us-ascii?Q?hQiqyjtp3i6AngJRcmOlRk5OUGeKRrB7JMFpYQAUv7fAWHoMtOzvKY/2CRGx?=
 =?us-ascii?Q?JAbTJ0YM8x7eYqkcGEhwDWystFHdcHNvBhx61Gw2GnMz11ju4X+RdXUYoHw9?=
 =?us-ascii?Q?AW4lMp0RfpTod4IjrAwLO9JDTeL4cuBlMHCMygYjLBkZVqbaWNvV0Nyb1TcY?=
 =?us-ascii?Q?mEhD7VH6BO0FMz/5qybagbGTJ0b0xZ76KBgyXZtOdnWVWG9G4w2TRA5UJiqv?=
 =?us-ascii?Q?LzQWCvd97Gltwdtu0f7l0PjRJLPSf1XfIkX6doxW12MXhBHUejOvGnlCWWdU?=
 =?us-ascii?Q?GQ5Q1i9ZUAEU9oN3Vd9LJljVdDP6l+psvCxrC1cVCt3HX0BM7sBWl+d3KYBN?=
 =?us-ascii?Q?+ePSq6z6oo3xdA34/OfiMJ2vzdau8efrdK9UrjdHjN0iHUz1fCNfpuUJ6iYt?=
 =?us-ascii?Q?DtV35LNKMWf4rCm89m2oPeLSAezIfIQkmgfNbDziY/PXU8DW8Ee4Y9OKp69Q?=
 =?us-ascii?Q?yAOCg7Ao7eaxzlhin5VqgSRKfm3T1Xu4N7CpT813A04GiWyN+7pLIh3Ak52m?=
 =?us-ascii?Q?Cj2EUj/vS0v1EGT8fm341NDpa4KPtRUi+32oM/6ZD7n0xXPoA8/VyvFFEZuP?=
 =?us-ascii?Q?Bru3VuWvXTP03fujaMfuChomGhAr+3bLg+thNa5r+nbL/U3z2whWwh0rn+BU?=
 =?us-ascii?Q?FROE4YJFIErV8NzTb/0Qy64aeRpOlpMb1DMufNRU6P6u3qGFe+meAzQUJ9MW?=
 =?us-ascii?Q?HVHEpbYdlfpNWpOJciRgKWAC1EtAILRD6c/MKaExZ5F3K80zrtQWr+ql8OWU?=
 =?us-ascii?Q?hADimkPOv2VmRkjHdU2em0/Yuxihnufx+w9wUZBUkgd8JUTRXas2T9gCy3iY?=
 =?us-ascii?Q?bjr1UN29+MODvShojgpYz8ovxY=3D?=
X-Microsoft-Antispam-Message-Info: FqLZ9QS7ndn2/lk8jCXrouDVq5wwkZ8onBuK5DrtdG8OwlBzrsUmmH54+xJzRWCnNC5nhuXkAQip9LqhwcjRjDjpxfZLA5XrBka2q9ODiAHQd9z5wvshh2qEPcqHfpOeP92mZfLhqgnUYAE+sP0UwS2xiLlQ50dpEHrYlYr0vFFplmnXkmKZfl/uXSp7MtS0m7hmgeOo10e9Wo20prP2Jd/3/lHTmeYEQT2KmO8o0EfsQQsHKwczAs9WxjC0Jx61YvfNzxxfFMuV9YArQrOoQev+xakbAlKBh9v53gny/5T/wLjNmiNatOoryIVUBpypSYjaHXS0iVquxiUXvdO1K5IiMTLKAoHTyaFpp1yNpBw=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:KE23pdqoDYBDY/dWroqog8zwarelS6qwmZhtZ5ze66ar7QV1W2lsalrRKlvIJZSFinyGVTaCkJTk0doA0hNtP+MuGwdjIAxRz+W9vfNh8JiRkYIVPWevnGpW/7ObeKwL7I5JsIiayqSq6UuIJoVuda4PDEVcG9VKZYKi5ftVx6OopIx5ErSTu7IP9sMhiwx3judVFbKN52LBj0yVEXQwjOUF/2Mk9AErQ9grPrheG/vz7sq6hsf7h++JsgKt0cTZcWfMHmojbs5W1ze2T7hfAju4Z+QTy1D9PYqT4KTZU3oYzGa0Kmwld4RKef8QZsEthfMsLT12G+CI9O/C9x27d5fIhitGrv+s6ZlGqeeU/FRzg62L5Ks6LaEYfsYrnVZO+hvTi5bahWErZj5DMM4pQduT9IgZavtrKkwj4NOR5qGUWQsrWI0atSbyCClLEiFwKnFfgjWlVIJqNCANHSIHNg==;5:4He3gb/+Lskoh2uEr5EtXwPZxR4UXv7ATa+fDvQF0m1paG1PXgKCLZiWwx+jrg6GBwYScACynTEtEYE1Rnhf/XlT87Qe73fxQ4l+5ZB6hZa05T4UtFNeMeALWntuCF1c0zSHo9qss5fYqkXqw/A45myydW746YujYTkGaipIXR0=;24:3cJ7Xs4c/WjnYGyoiYtpbkNNpKTMlD+jlHm6T/iFuq91yKrp/OHbqNK1QwiDnHJ9H4IBu38TGKSqLZmvW+WXQSZ1k+lYXmewfrWkdrD82FE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;7:b2cPqxAC63s6MAHok3Lw5EmyxPXxxIei2LcsUDv1nsi5dpA+oJdE6QlDSAKiVgZL7YVCcq2bbhKxPRUI4BN88VMzeoHtruD37eAvk/wXuL+UzN8sdNa/pHiUAysyU3Kf2hoRsi3s3dQbPlvSvbO8OIw+QEQTDIISLFktzJQhDgn6KM6QdNr1rmjtWgzgkoQCltLqk2407c/O90wek2Q3nR29zQ7t3YPdmMQ3666AKmw/Ax4lL3gmRPTA/c7lQZVo
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 18:51:51.4727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e362ec4-9fa1-483d-1148-08d5dd2835f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64490
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

Hi John,

On Mon, Jun 25, 2018 at 07:15:28PM +0200, John Crispin wrote:
> From: Felix Fietkau <nbd@nbd.name>
> 
> ath79_ddr_wb_flush_base has the type void __iomem *, so register offsets
> need to be a multiple of 4.
> 
> Cc: Alban Bedel <albeu@free.fr>
> Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  arch/mips/ath79/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This one looks like a pretty clear regression so would be good to go in
mips-fixes, but could use your SoB like many others in the series.

Thanks,
    Paul

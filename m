Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 17:57:50 +0200 (CEST)
Received: from mail-by2nam01on0119.outbound.protection.outlook.com ([104.47.34.119]:16928
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993081AbeGKP5nChRUf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 17:57:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c69PcsyWfsNftEVroTpn3xf5frCmtr/sSQLSOyFgmM8=;
 b=bqYKC1/oGkOBs4XxSRin1l3t9rqOfU8C8o3JYyZvLnY7T940yzYn/3dXdKChml1xQgtkC1/vPwpqujYA/MTr1gRL+c0rcLIgbjjNU59FgYESfuFX/rJ5qVyBqdq1FrQUsvgCPediSiTwU7UzxVf/t1QwEof9GL2Fzun9DhSrISs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Wed, 11 Jul 2018 15:57:31 +0000
Date:   Wed, 11 Jul 2018 08:57:29 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH RFC] MIPS: Make UTS_MACHINE reflect
 big-endian/little-endian
Message-ID: <20180711155729.kwv73y5bw3mlkbq7@pburton-laptop>
References: <1531297697-7952-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531297697-7952-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR1101CA0003.namprd11.prod.outlook.com
 (2603:10b6:910:15::13) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf02d066-b1eb-47c2-89bb-08d5e74702e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:gumpd34y22IxN0uF0iyvwm7BoaX1qAgAOv8UwM9gBKK89jZkZOLKo+QwTOmPIkrckL4+OE35ilL1agAK9mK5KpY67ebR3MeeIf2KsjhWphKc59bcyvdIwZDMNd23sW0LRTHqqAOV9plCfTQfR/Wa2EpKJXvWHqc6PdXtDtgzNqh6q0l+RsbFPA/DC7Wvjy9ZTlNrBu0pbGHcg8MaibmfKScwsa19VhFm0+UP/fj+u7Ya9yzvKT+Cmsrt0bHJ9NNf;25:IQe/Vaz3pX76BbGzofHrGxlkGIH2zIqdsFGSUA4oKvYcdWIFqa30wz9r43FGHbWb5VynfWuBT5U7lC85WlKFuseO07hQYQ7m7pIeay4BZgNmBQF4LedXrmKovuT0JgshsplPuXQ+I/iyfb4ORGi4NM8Vy5dJ+UbwfDRH++Vq8oWslrk4kSYcjZgbNOPDjDlWBfA0N+yvmpIdvGp5lnKIJZll94Nb97hNOTt2lqmShffB06CSKVNy/EqBn3vhpsb3u6vIj9d104pVY8s4yBPf7iKBZ2mwz7gUn2GN+AnHm0n8J6cOhO0vEhi7riexm1HmgZY6C8KSDotD9YgFi8094g==;31:guiqWGafTI7N2Irs2T6O8moEKZwakZj2Zg0JXu8j074TIOs9MY9tbIxyoyW071PA235RWnpFDjqAVPFghpg9HpwWz5O/tacFXKiZPELQqGu7oPzf0vCgPfem5F2g1k1UL81BD7z3TlPlLofH3+2OOWIh8FMgO/rXqdipAARlWz24I0UxfLH7Biwd1nMjU1gnOPxZwGIw0hE89GcrFAfZr/Dw/aVXo2OpOFW5IYIv1w4=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:YPCU+vluH8ETepSoAcgGtUUeOJl3Zm+Q7HZzQIrD5PCDQp8IpJMf/1Eqz9e/D9QZyOAFLIXkJDe/v02WxSeyjDZo5OCVKuMgLR7uj6DZXQZznQe80w3zgMmziOYSbu8Ju8/jbw7nfxMu9gmJa0/88ajbJCyc+kMsIBOZADqVM/sVUefjhNjAfKK4AtPPYQvoRxHD7k+5Ln6ZRF6yRMha5kue9KreC1YUWT+7rn5Kc6TpHCifl+PFfxMW2wLQyYz9;4:qOzZe4FDQ8ObSd+n3dErVsYme5GqT5pONUnPIj1bvwLJE1CxBqcqUK9p20p1Oojv+mTOWqj8FNA8g+sO47FWbxP5BvC4P2oeKfuv5nocbx6dPBogeX3NxGnq+N3USwqOAuuJC7rblS4XDK8agxbtriDE4HegLav3WlC51xVPSCrXqouSCpsgCUXvfp7VNpdXFaMcQvT4/wlOEEbKUlJEylnatTgOPBg6UB9dftCw9bwDV7FxxUpnO/aTYKli6Q8LtgahJ7kb2zsbai0dhCjqf8bLrtB/QOI8ZAWFC4LEGKujPhn09g1T3x9pSzXG9qeD
X-Microsoft-Antispam-PRVS: <DM6PR08MB49389439F28F17F209C0BAEDC15A0@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(136003)(346002)(396003)(366004)(39850400004)(199004)(189003)(16586007)(6486002)(26005)(6116002)(58126008)(54906003)(386003)(23726003)(7736002)(186003)(11346002)(478600001)(105586002)(25786009)(106356001)(76506005)(3846002)(8936002)(16526019)(33896004)(81156014)(76176011)(1076002)(52116002)(6496006)(8676002)(446003)(81166006)(476003)(42882007)(68736007)(486006)(956004)(316002)(2906002)(44832011)(305945005)(50466002)(97736004)(6916009)(33716001)(66066001)(5660300001)(53936002)(47776003)(229853002)(6246003)(9686003)(39060400002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:0JD0FE1MCS2dvqMcU7F/7LQWcCnLdGfSpEeVLsn3O?=
 =?us-ascii?Q?pshk5a+IKRIAM+5fKgVcVV1FLrDg7e9HNQCDz+jFlK2R5lSgGKMiMRz7vVd+?=
 =?us-ascii?Q?We/KsqmSL8xxTvR+uUx+8bjpAe7xiwoQsQrqXMAaE4pQZVvk1L3HuXe64ukW?=
 =?us-ascii?Q?mLK2QX6pzJGx5pAutkfGKP9i5bs8EPvJ4p0li524TtksmJCmmzh6PN0COm20?=
 =?us-ascii?Q?czj1K+cFuAEgfDEdPAjDScRI9p2QM+uQTaXkkylexs7il6bjhYbEfrllFiK/?=
 =?us-ascii?Q?58/BE8xvvGmtkrb9yPNn/yp+mMdfyXbwJwxGAp1xaCcPwfnd6LyZLKr7M8HE?=
 =?us-ascii?Q?UJ3dOCjTi17koiQOKVm3ZNKkcxkjDvfl7/FVP3y8LLGnFEWDauxE/xPNS4+y?=
 =?us-ascii?Q?cGDpuWDW1sUb162hQAMamrmliH7bgpJowmlJTr2yLuuxtXz3dKxEJERNj4TW?=
 =?us-ascii?Q?RpVwlhA0At1AcJir/UaBX46J+hzvB7aaW9tKG4s78nu0kAfHH2F3GgsJ2X5G?=
 =?us-ascii?Q?gWGHrPFteR2EHiDgyZUMOC/4IQi3A4jlU2+9HHsHTpR4HW5FTK8qscDkPPaE?=
 =?us-ascii?Q?EuqKswgBbL7b/BEX5LGFpXuRczMcKJbklimy0VRd05pgxzV24Eut4cHJfEfk?=
 =?us-ascii?Q?NCn+05kddFbkKRDuthGbzpZgxGjmVb3smKSPNuRUtFyuf+XBKwsiqqBDIZeg?=
 =?us-ascii?Q?xwv0FqXcBoZMaTsEP5daPWu7JhjgHepFng37dcdmHRAlrsrMibXtbgM6sAVd?=
 =?us-ascii?Q?7GgF4Jk+fl2nPbh/a1Gu4U3mQ51A9yUY/JjWNUJ9gTYNVTP/Djhqna5oZS4v?=
 =?us-ascii?Q?QSNgxXwmBwAo6LmZ4S3d1d3R7OmT/7RXAnx4DU/g68VBtA29DPluxAFpe02Q?=
 =?us-ascii?Q?6MPkzuezdts3nPUWp3eyUUnsO5CUXlYbVKfBSRMGO1W84KZaaP7/uoxYPGd0?=
 =?us-ascii?Q?4dzbIgUp4SvvDmvOWN++lgO0plDePDtcEwaFjTcSlF023UdOmMGFgLaWGR5k?=
 =?us-ascii?Q?M5BPSyEWaJSECzFgAhMdTHrtUwY5olZYB5r1wyyBPVxsGyRHhKYMRSFP9Bfy?=
 =?us-ascii?Q?z3yFksp35WYZpMSFdCZCkqF1pmh8wvhNTcqGaER2dD9HOv7Eiv9y7jzeaxgY?=
 =?us-ascii?Q?ILRtdtc6QAEJO5JB5FND4Cy6lUZAe33Tra5Kucpz/YdLmav8b2OlRO839h6q?=
 =?us-ascii?Q?1WxmdmbluwJZQY9XSZUmVBzCeUPFy8UysycWruFvjIMekxqZYFUOddFrFd3d?=
 =?us-ascii?Q?lef4cVueZwuqCS9fyPyt0E4fzCnekLu9v5/+c6kkGGBLwvFWHQpOCds9Sfgu?=
 =?us-ascii?Q?IaJcD8rJMRwuZfliALWKDw=3D?=
X-Microsoft-Antispam-Message-Info: btzfulE0WDsrrVaewbYtI17QSZmOBoQdzS2fXergfdOQ9HWqp57Zg1Qa068d3AVpBpYLAbOh6oHqbCRASR7ZNszfFznXldHCxK+pqshY1UutAc0A3WUrI6B7ntiFdT4A7I8WUeOJleomJWjHXdZ7x15+VGeINjOPgMYeLkuO2o7z3k1P1Sy5OvQ1S5LIBwJJ5vacij+QFg/PVvhtlzvBmS2MClkiy2wPvRiJ/YUGi15R6HfrKX1CKaYyK7/sBvj/pcRWHIgYx9sp0g0v/e0WusRoCgmM9ZPQIQIZa8bAcJ4ofbSZln/sjDliEJWmMGGJ+DH6rd5h+FgNXle8ldo76nzdGMMkkiGL99RVQflcfAU=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:MnB/PS7se9pwVMd9oPUD1FPPhIkMjHPrWmmgIJNJQk46vwVC016bPscRLri3eILdDIKSq31OMJRIyBmsOyd1d+nP16GOvrYJlCSHoYlI9DMwq72pWOizqXHxtpO6Xxzi2f1YRiyWMnjueXfLRRONWYP/KpzitErnWWGthlBYvIx5uzvsPsIGfCM1na0ZfVmYad4coMqfuBXYsikqPcaV5vpYEo7LAsqrwAWoGj7nU3tD9mJjhzVQ1WSlkLQwDc7+hQIEHgmABX0PHRVtYPm+h35utSQYRums5saTGsKejAafgToBLD5mSJDbqL10VGZHKfZwankVnWyFKsew9oG+t0e+hWH8n3IlXvcqsjV28XXVlADUFeU0VjEWBWaq8PwKVHXCaWT29kl9iisREQmc0CXcE6CT7gW20VG5VXnedyUHjILGiQv4UDV5pzKg2P7Ei8fulz7LtZt+Tyj5h5/9Lg==;5:sCGmQchKCjq4JKVnQVrGHG31jFZQ9sNPOBkqBarac4Y3zyUeMdgzkzZE5RGl1XRoKsmm8yS+GwktsW2mgyZnrOHUXzLH24tn6I0Om93ZAw86mOfO9unIQ+hC67ydf2hh+ybxJefOUihhdj6FaCvvcQ8iVjrBlmbSF2OvvccHHiM=;24:ZIdyODsTykRbkItyZd8ft8eZ0CZsnp+dGBwpQ2fSq3lo5PuuNg7RqIoymlmJREsgDDYWwlEJlwP6yjj45Ud7NHbzbUOpsUc4VNa02o5tzUY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;7:n//ysyQD1T8K6us+6bcB2sZ9HD9J/wDNXEJcEAlfWas2MxKtCDmb42X18lJlZAzs6MsLAouMbYViJChN0lGPIybwKNRG+16oCAMzT9siNRNXfP0z2fy0cDRVTRFxvaG23eJSpXqSDxY47D7r1KohY6+fL2aRRDPHQLDj+54/XBSOJm25HZXzj2wulYFOkEy51JL46Tu5j7vaXw7M+iWhdaGYj1VA2BMm67Pw6TLFDAc1Pkmt0x5z3fcdmMDF9rui
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 15:57:31.9097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf02d066-b1eb-47c2-89bb-08d5e74702e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64798
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

Hi Huacai,

On Wed, Jul 11, 2018 at 04:28:17PM +0800, Huacai Chen wrote:
> It seems like some application use "uname" command's output to do
> something different between big-endian and little-endian, so we make
> UTS_MACHINE reflect both 32bit/64bit and big-endian/little-endian.

Since UTS_MACHINE is exposed to userland (which is of course the point
of your patch) I'm not comfortable changing it. If some piece of code
checks whether uname -m gives "mips" then we'd break it by suddenly
giving "mipsel". This is too risky.

Which applications are you talking about that look for endianness in
uname output? Since Linux on MIPS doesn't expose endianness information
in this way these applications will always have been broken on MIPS
systems, and it would make more sense to fix the applications than to
change the kernel & probably break others.

Thanks,
    Paul

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index e2122cc..a21c3a1 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -38,11 +38,11 @@ endif
>  
>  ifdef CONFIG_32BIT
>  tool-archpref		= $(32bit-tool-archpref)
> -UTS_MACHINE		:= mips
> +UTS_MACHINE		:= $(32bit-tool-archpref)
>  endif
>  ifdef CONFIG_64BIT
>  tool-archpref		= $(64bit-tool-archpref)
> -UTS_MACHINE		:= mips64
> +UTS_MACHINE		:= $(64bit-tool-archpref)
>  endif

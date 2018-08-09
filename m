Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 19:51:55 +0200 (CEST)
Received: from mail-eopbgr690123.outbound.protection.outlook.com ([40.107.69.123]:59850
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994752AbeHIRvv5bslm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 19:51:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTx4PKh4zPSF9tSxxUR7HVn1EIXohhPFTIe0AGAKKBU=;
 b=WWjqA05PbGDUUP4zo4Gunfn2+4S4cCu1dP4/W5bdwyaO2azM/WRjx5RwkMKXpP8oVuwOV5NwEfOpNaqdUbvRAidO4unFxhSFsGkXrWeuzVIUK+yrWAzIMkaEjQlrMV+Sxqd2qpY6CadfgQZSTbNPTLK2pvNQO5xehx3UOW64ZIE=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 9 Aug 2018 17:51:39 +0000
Date:   Thu, 9 Aug 2018 10:51:35 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     James Hogan <jhogan@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 2/4] um: Add generated/ to MODE_INCLUDE
Message-ID: <20180809175135.dqblkxyoxr6uhu4d@pburton-laptop>
References: <cover.a2e1d7681cb1ff2808945fc00db5f29c2f011783.1526074770.git-series.jhogan@kernel.org>
 <d820cbb19a333cdfc4a24d0c6b2c3f09def1f3e5.1526074770.git-series.jhogan@kernel.org>
 <20180514092633.GA2419@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514092633.GA2419@jamesdev>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:301:4a::29) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956e67fb-419a-450c-179f-08d5fe20c246
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:VeDN5XGZBOFuo+w63ybss5W239RDnFhviBXzHuKPF4/3ZOyGyu4Lj/on30SqI19Cm1TphXgVVgilgkmY14KtmrGa3VOQinxCAI8BZQKnV2lRc5CvspwlA+TDg1fsmYEYgycidlxD8Y5/gi3A0GYwEYVEkK85bXnOYFOAGPPytefpB2kGeFm+cRKNTIaTJ5sBLtoJlWEq8jWkO3p6v0rumWI9ToltmfgU1nSuFpCwhYpxiEOOwx6mCCoSdfyTuZsV;25:wPwJEFSoDQCnLhlmdMyD0n/wgb9zQ31KcFja8uiY4Ov3inevtL5wzm3DN32yE1GaMDw7OmTxeCHpS26ySl+mnsL7siZx026d3rLO9xkjAkkWhW78J59w3zh0EC75A3dAdrGhBJQyimgDa4OaiYOeVb7xKSxaVvrYOfOWzA2qdcEA0UMP+6Ama5IHvRRtcqtzbsyL7cW258a9/ABEuZwJQ+9FsI7EoCoW96duvoUHZzEAcuOpB4N/Ys3eicFUqZRLfmA3pi259LswDUiMaVLBvU7wkwaJ+rhOgLdLY0Y/aHgOGxyOMULDzZXTVd2Oq+GwPiGCnFVyc3cxxRCmwEBaeA==;31:QxhomIdlhY3u8Nt/9RjjzSEO5D54KjXsyT7oBtUqtRJAb9h9aJIUwRg23CiZr1NlTcaCPrfju2sMTlKlUSRDBAIkDYxyQwB+oJCyvCpJasCb69nhw6JGVCv6BPL7qE9thrm544lAp/iYu+ZQa3w16n13uchNJr+2pIBcrhUgmQQHaYPU9t6WyHGshUA7NQaUKg7ylkjMZE1uxED4t3rgUUW2bFR84sNRq/01PKaOmXY=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:7fN49W1kV35FtNX7VD1ewZyXpUibphpb2YT2TI8P/kZvhLI+tLz6KT8NIBt717LZ7U3YMHUOl2xX0iFUo0O31gwybU1lk8CA6NubWqQaRCcxeB7gJG0gBj6fbd8EXnK+eGwRgX4WTij2bj7LRiEEzBn16nIzMPg5wxKqSibcQ2OpNtjmR0briohrCGWJ+n3s2R8kDhgHdeAwmpr69d5PR0mpH+LQJqmidsSdkIdlKuHaX9xsP3DpXB9PWNTcSpAM;4:ZdOtGzcYY/kJ0eWpRS3l7nX1TDI1IJLKnOCg9CFUa/xpD+L2+6bhgDTZIeWmzsqLUeQaeFiOtCwQbCH+2o5l14XQkESvWXoO4mmH2Abayr5YZNNa6MQtfj87kRj7T5BnY6XSEVidPm71gy2pxeURsMQ4KTNtdqg6zYI3Pw5ZjFDaVtqKXQ/iJ/L75D+BJD61djA5DjvXi9IP8MFu9yNgKPj75CB2Hh1h6KVaqY4XPUJUoO5KO3b1tUV88DhDGcPEtVl6qhYbldjv04XuCwYZrZpjl3V/hMsH22VI36hzSAL3xaMkAaqFQHX0+ONnUU+4U0AxDq2wGpoJRG7MU/BXzgyefEdrvMJj9Z3exX8br4o=
X-Microsoft-Antispam-PRVS: <BYAPR08MB49333EF9D30DAEF58EDAE037C1250@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(366004)(346002)(376002)(136003)(39850400004)(189003)(199004)(26005)(106356001)(76506005)(105586002)(16526019)(6496006)(76176011)(6486002)(52116002)(53936002)(478600001)(11346002)(8936002)(16586007)(956004)(9686003)(316002)(446003)(58126008)(42882007)(23726003)(1076002)(44832011)(186003)(68736007)(476003)(66066001)(54906003)(229853002)(486006)(110136005)(50466002)(6666003)(2906002)(6116002)(3846002)(5660300001)(5024004)(25786009)(4326008)(386003)(305945005)(7736002)(7416002)(33716001)(81166006)(97736004)(575784001)(33896004)(39060400002)(81156014)(6246003)(8676002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:mT8d3Wj2UVUL+7MeuwcgJXv1Z+sE5nQG47j+UWfNf?=
 =?us-ascii?Q?vrkJeNb6tZJiAIinFTtnqui5/dhfZOcILy31aJfjXAcUAhaesyXBJjh0r2k0?=
 =?us-ascii?Q?CTH410Ykqzx+VAQFc2U6yhn8KAckC7vRkzW0W/O4eyYO52CED+4dR2wChW9Z?=
 =?us-ascii?Q?G8tEoqbYTnYZSGuTgVB8MYit5AEEes0guyoQjRyicez3vX57E7bLZezFNtEh?=
 =?us-ascii?Q?5myn0V+PEm/LlS1A4Xu/9PAG1ZC59ktVGCXZ+Ivk0aHeNFQx4WRaRLcw5pe1?=
 =?us-ascii?Q?WoO17qA6eFXgXcKJ0789POf+EzGm8ruVcZ3rPf0f09KYw/bhp0JEoLHZsC2M?=
 =?us-ascii?Q?4WRkVobJMrA2JX030SIBmlx4oawBZVVSQ+nChxBKRwgqw1IYCw6V6xiAUawt?=
 =?us-ascii?Q?9fYATMxWUB/un9mAlinx/DVU76d7iGWWJbEX0WDZ6CTb0332hJE/j/s3iYXd?=
 =?us-ascii?Q?sosChaxHN1XoU3uJutq1Gwsct7zqjzsG34ryaHAkVxWnmBaGfyql8oc7DjM5?=
 =?us-ascii?Q?Qn6CoNLiA4RzgNWlwh5mfplj4JMpSsFEpT+zMm6UwaIkTzicCo4WfyDSwScd?=
 =?us-ascii?Q?Fe2QRmQdyzXFvV2fIf7uEWtiT8o8jCTwe/XeTlDYBhnc6r8sdy7XJtJs1T6m?=
 =?us-ascii?Q?b8WtMYSWKEs6G17boWAtIzQ11lAwg5mdZeDe4ITZ0i3qxkH8ZmAzzCdc0fQQ?=
 =?us-ascii?Q?ev08r1C4wcSxXR9zKAXQrMjE92c9fVgvlrzIJiurKY5CWr9ei/xPZQbxjDt0?=
 =?us-ascii?Q?khifUHZ2311cmtMulf2PPeZa/Y48gWdZFLPuLGgRyJyM/gGS7qSVdCW9iIQc?=
 =?us-ascii?Q?UY567N25STPHevqBV1lcl9a+QaFdZhQ7lwaDmIfRTYtX2vC1vPEUyhfFtqK5?=
 =?us-ascii?Q?DbOw3Ve7YJUxzHNakdeeFgt9o3sTCNtHESzvkfRu/5AbwF7WZ1RJfm+4a0aY?=
 =?us-ascii?Q?ZZPUnzea5zt0EQlWoMF4b53e7uSBwvXeOLw9tlSxaX1j3/JkRsXc9SPDs522?=
 =?us-ascii?Q?y9j45dzRTl/ERCpp1v2Ugpxhmw80NYYWKWENzE6BlCI92N1qv9w6ut0conrF?=
 =?us-ascii?Q?CQrFIiK4HNhMIVgdORLTdo3NqL1gm+tnTbqiFPKfG31q5tsGUoUP+2oJoEN0?=
 =?us-ascii?Q?U8reE6P+MEUG2HbgRtk6EO6xgPbh8wa0hAn7uZyMr25hdsH1nI7UNgR/sU7p?=
 =?us-ascii?Q?dxBJ/hVSeeVFgXRUIniqZK1ZB/abTziBkCqsW9rHuqTiFb25EKg5oPAt1SUR?=
 =?us-ascii?Q?B5+VjPvnHcRQKxHXi1hM6MQc1xbmNh1X0n8BhK7cTUU4oqa6qHoDxbeb90Zb?=
 =?us-ascii?Q?8ubBYR4j5Y7Jh1Vhter25Cys/af2JLsmi36SKA6pCQVEIUjeuM7Hwt5VWjfL?=
 =?us-ascii?Q?rEl35OL4xeoZyC5oQwjZ2fj13rbsbPO+6HgP/kJwKkIF26f?=
X-Microsoft-Antispam-Message-Info: tPrAkRyxgDeu6GIC9OKM1Hg/N+pVWC8dEtX0kxZC5E/RezPHXGpI+JbSuVhTHoftH2eBWUvNBxRlyZ4BkbCXiGIEa89q7URdSlFc35f5vGlVaPcRqYM6A8bSC7h+TX5DYcG+bSE/MBi5NvhJqn+AzjPRDsw/rDH4rXqvaIjaW0zEBXIx33R4Wdtm6Qf24FaAiyTCJYPLFsLJmzbdyv/IKx/ZrOAhVO7qEF2JXW1zAi/p+4Z73+GL893bIbi+InIGbZ0/vXp5HLRoSMoa2rBsYyrdBTqMCbXJkLxDsIEwgT29kY8/awU+zVyLIGcxgl+QBVNS2tWcgXffw2KOF+LXWNCvxS6TRX/czqjyr10Wm5s=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:kmECdTtueovkDDQE3Dc20Ik2ltepbeI2gtfIbeHWkncHxuA3uwJ+Xe9CTF7dO3OcmvhpLVF0uaAk0tDZhHZ70+bBgTdxLR3lzm71OTuiWIY+3k7PwjZCquJFy5CS5LYTJPecpGDPL7o8gM/VT1LCDW3L7I1Wfdexfv+3AN0JBjFymMl6w7onb6cW8suygwi44L9mJPX287H4lS3eJWuXZ5kqvECPhU9XLVserKx222ysBx8817jRFj+I4gy4p5m9fZVMyYXD8KGoioDkGFynlwgmGsUoHd5ouYPt4fKUqRHf5yKoyzMHDQx8+/V1Vt0SFg8UXrNT8R1ihbokWY4yrouSjqSXIqhHQ0LZmTdt2OBz+HKglXvdtZaM+Pjd1NEnpUYSxPMszOyVqi/+KfCne80Ir16vDSWDulIq6/jWeFQ60QufU/5wLGfjEM5cqrcs9gvAdYfdRNfisT0I1RJ3zA==;5:ZH30cTpp+2LcI4qChlwB5l9RTei82AHmfOe02xfsCvEBUv5LpsJLJw0myNiclY2a841T8eSPa+oVaJTHRm0nbGJFKIRkkEXLR8XRlh6IgJRgVJG9d5thzPSGfCOZF/siDUY3vWK+9LzuF1JXSPUUuzAVQpdmfFlf0VhyzwBY0YI=;7:WW/NbapiJKc1MitCp44qKzJYT6bZvJOFjy8VcWqpjQg3PtPhTAtPUeikjEfskZ4CJ1garviQbRfz85UOy37NAtQWEC4sRvw2mVsJPqcp12JJEqUMMiGG9nrEv+Kr66545Z9YCv4n/1SSKMGZoX7ZsYxdDhqmd2NxYPbN/+ZNZSrZsuQVSEM2WvyKghJtb6lM4w6KPp3VEeiH7pZdDkmIj4490qiFrdRIMEx2kbPtZt966GuaI4UEBgcEwIta9NNn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 17:51:39.3124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956e67fb-419a-450c-179f-08d5fe20c246
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65503
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

Hi James / Fengguang,

On Mon, May 14, 2018 at 10:26:34AM +0100, James Hogan wrote:
> Hmm, I thought I'd fixed this, but again the kbuild test robot
> complains:
> 
> On Sat, May 12, 2018 at 09:47:40AM +0800, kbuild test robot wrote:
> > bisected to: aea47daf8a396e512e0cfe11d9c05798749db172  compiler.h: Allow arch-specific overrides
> > commit date: 2 days ago
> > config: um-x86_64_defconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         git checkout aea47daf8a396e512e0cfe11d9c05798749db172
> >         # save the attached .config to linux build tree
> >         make ARCH=um SUBARCH=x86_64
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from arch/um/include/shared/init.h:44:0,
> >                     from arch/um/kernel/config.c:8:
> > >> include/linux/compiler_types.h:58:10: fatal error: asm/compiler.h: No such file or directory
> >     #include <asm/compiler.h>
> >              ^~~~~~~~~~~~~~~~
> >    compilation terminated.
> > 
> > vim +58 include/linux/compiler_types.h
> > 
> >     56	
> >     57	/* Allow architectures to override some definitions where necessary */
> >   > 58	#include <asm/compiler.h>
> >     59	
> 
> Can anybody else reproduce that or have ideas why its still happening? I
> don't seem to be able to.
> 
> Its from my mips-next-test branch here (that isn't in linux-next):
> git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git

I think I figured it out at last - it's because the generated includes
will be in $(objtree) but your patch looked for them in $(srctree).
Fixed in the v6 I just submitted.

Presumably the kbuild test robot is building with O=somewhere, but it
doesn't indicate that in the email which means the command it reports
will reproduce the bug simply doesn't.

I realise this is probably rare in the grand scheme of things, but maybe
it'd be worth mentioning O= in the emails Fengguang?

Thanks,
    Paul

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2017 01:41:16 +0200 (CEST)
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:18432
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994944AbdHRXksj24ZS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Aug 2017 01:40:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+BugoTTd5Y3T1XxuL6R4VvK47SdklwH6uXgRiEI4CuA=;
 b=Qndf8qnX9b3IJmSDWUIo5tZ47Va2rHf3xFCERXRFY8bRet86jRLLVsDrwUw/b1070EPvC9qXh4o/2BPySt3UtMvhCNEnGm6ybWoXTOKu6UvzAFG+XHEtBPOl5O73g6ZENL2kayGGMVvTJvKKWGG49atEl2RcNkmej+volu/VB3c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1362.18; Fri, 18 Aug 2017 23:40:38 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/3] MIPS,bpf: Improvements for MIPS eBPF JIT
Date:   Fri, 18 Aug 2017 16:40:30 -0700
Message-Id: <20170818234033.5990-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0082.namprd07.prod.outlook.com (10.163.126.50)
 To CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc472d58-045a-4664-3f71-08d4e6928859
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:UhtzLXe3xUOMVR7e5WzTFlmTXh7iC705WAr9Ji07hion2VTahNsdxo8RUhIu6SI+YopXzR5/tT6Vz/82xZJ7RUU/ybG9v+dhExFD6cn9f4lnbj5aYNqSdwgg3aM+M/Np+242gkLmF9tytgFUau40zNPOqq7cmNm3X+3dWCDB5VQNnpbjh3ZzYlRqyj1beGAWhhHWt7UHjjaG1h8wvCg9vQ/7E2XYoSMqmEayosR2p2H0EXVNM/48xNsXdh+h9s+K;25:KwLNB9/3N+qD2kKHKFX0hoDOMUaTaEmSL7jwmS3BWcjsmIKGpklHKkSmhmO7kruU+mMMn8AxZ61a0hPO/e8McX/fN0pRH3ZKUIVBaKLXo7ViuIshflq2CsQWMq5tTp0JlFOkgWJ693pXFKRIPreWY+3EHh3grM6F6sVRt1wc1rYU8Exrr3U8NlcyfqigaGsFPOfgTjEogIA4WC/0sFoyvA4mC3CVowNJFdhM+ZFJdHGw6m5+kVDbgJ2mSQZR60pY19uuNHPditsl8lBR3EDWAbHVrgOD6+ayA6nBzQ+M5crKXQzub3/gumLyYswKgH8fSKjhTb/CYU/TAWVh/E1d2g==;31:qQOxiUMN4bc3Ladj87OpHOzWgvvKCyFAVNS8TbTeVBLsk6EpEdFJyRjhsLlGEZN5VSyqdHgAjk67KyYRfQdX3CzyIrCiUOwSkXbBIR3jI9sFXsPNLQzTNAgqI1qFyV5EfroKst4RTjp7ikjw7ZEyjteMrR5p7gZvuM6/gHv/+4tL3IRcDFK6WhdeeWSRQaBzX3cCC6mR1mcT3Ib8mHpB/nOevsTjdwd0RVvHhc5YnQo=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:SeCGAIvbWq5TfFsREd1dvyIri3rqs/5wS1kpVCY2YKefvp2SCx0QgNgc5AcBqcF3iW+/JfxbKGO/xvhKBvcEDcmLZRevBGljVhq15/W2SUGGrEW7xJv6stdNfmjX8VfoN9Xc0sAoH6ZiJCf5m+2/Byvj1XZJE4SaPtd4IGvf4X3vkUkEnOT1Jz5HMcK7RmCLSNrID9MErVfNtr12QRAOpweHxCc65MyhLZj0k8SgooKCe088GkKo6rHQ4r28DjuCWLPL+Y3Nkyb4L/bl3wYm6oLT/tgb6+Ll9TwDRVKDOrZmp7JkGVVHz7f5Va4v0f7XVLc/pnQVIYjToBZQuewhwXtr+M0+mg6HivEQ5IeMazQyeQCYu06whn4kdmAHRtQ2o+7NANigtIcI0CNhRyGjU7xqJ8NBpuNuzRT4WlCzxkYHswrvu6dRsrOaB2NUd5gwzB3Pbp4gvQhPiYvKWp7zGIXKTJFlvfut1XqIUaOTGs23VlzGJxTmaUmOj7Sb3AJN;4:WcmWqaGfqQKn5y9U5qbvTVeuUPWK9rCoYV3JbLsOEuiwWRFQ5kAMonuBSkk/LoVG2iRJuXreRVuWuRjxWqtQfJSJqvQtpgIIpQOCw504RPgIFUpGNgN060sfbISfyQe5+3ndins0RF+3izE1TtSlikbsNrcU42NqtYDoekksuE158YgdElF4Hg3QivFj62YCQS/pBD7JLjrDbbGclR8D/XBHOCX0Yw4nfKSLPtCGoewRQ41Slw9a2wfdDty0QdnS
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494FE978089F3BABB0F7D9497800@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6041248)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 040359335D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(7370300001)(6009001)(199003)(189002)(69596002)(50986999)(68736007)(6666003)(47776003)(66066001)(81166006)(101416001)(81156014)(50226002)(8676002)(305945005)(105586002)(106356001)(36756003)(33646002)(53936002)(1076002)(6116002)(7736002)(53416004)(3846002)(2906002)(107886003)(6512007)(42186005)(189998001)(6506006)(6486002)(48376002)(4326008)(50466002)(5660300001)(72206003)(97736004)(7350300001)(86362001)(478600001)(25786009)(5003940100001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3494;23:WPJzhivuzLdBG45m7AQoLJE/dOeZymvQVcODKrA9n?=
 =?us-ascii?Q?egSSj8usZ2NedgAdcM9Fnxb1cA0KWwbnCRIgvMhi0Bda6GKRrgWBt1i3BDgJ?=
 =?us-ascii?Q?yp/gwvFYN5vFT3pvwRoHnO6Y95tDRgffrc+elWQhh8DN+FI8rfbCmWka+8Xz?=
 =?us-ascii?Q?EllEfQcOSzuklMXMf2nChiKLwlPtz4wO91wBuqNvNPmc7C5aXiPblGHS+j3o?=
 =?us-ascii?Q?Qy0cWF38/ay+xnw1sGQn2t6nA6Y3uw/kFm8+gywwPOUyIVlENn1XAYW3KFDg?=
 =?us-ascii?Q?Q5GBQBLfuABCcemER+PR+v2kyH5Jesihxu7McLvFc3GNI/6dOB1eQR0h007c?=
 =?us-ascii?Q?R1fyOo4LjsC1neqAqMFIAAUZ/F3pLIzoYEOvFBGir619SGL9ZcEAd8ne0AUH?=
 =?us-ascii?Q?0kd7WzO1Omo5+FGGjJ7td45y/vZhCj79QfO14e2pIInDwAxhxZ4XwkG7FKMn?=
 =?us-ascii?Q?rSXBWuwFm+vxeUFYp0B85DwpakCh56pbkzz8tLqskOfGFGardq8msz45ZLc5?=
 =?us-ascii?Q?5/HyIsDxTbOI3ipmQXRA7kppdsV5B/ZFrriOdoAelQ2PCj0nlqAgiXVGAKP+?=
 =?us-ascii?Q?YMLZsjCknOm2Z4cx5SBCAB6arNNn2qQAXw2We1MUw4qtDqxHwctBdtuwbTCz?=
 =?us-ascii?Q?g+mCcG8EQA3FfwgvnuOBh/h61Gr38EypBKWSLFfrH40QNbGeqn1lrcQGcj0h?=
 =?us-ascii?Q?KQIMMshOsfQvPRQXiVC6RfM+g4taUfegelBFmdWiXYGiqfZDFb7S8wtj2Oyo?=
 =?us-ascii?Q?1e3a0z8A+QGTS2v+PZNb3a91KOiCs8C6ohH1BfjdnrDYb+bLX8p/d06lXuck?=
 =?us-ascii?Q?2hDlPL41tinx0KkVfsbXJNHL6vhg/2IXvBnVa8ICfUM+8PccL/KYuTNQoFBj?=
 =?us-ascii?Q?J7+Ti+0kIaW7+/CW5URlH2CM3NzNX4ZLGwXJOIkUyFSWx7ZlPj+JWEHwGVzG?=
 =?us-ascii?Q?iQlR2SIOySYj6oJzOufu5ke9JZhgk7OfH7P/rE2N9q7URtIHAS40LEyxAMfs?=
 =?us-ascii?Q?WozoPi+r9jNepfljCrROv2g9JgMOjhWLSgdgk7qO84JHMfAkKjbkyC9JBv/b?=
 =?us-ascii?Q?JJKyL6cYc9kLLRUhyoh46B55ftNZwrfMRsxAikGYob9FdimfJMVwdUlfGJNP?=
 =?us-ascii?Q?K+CgKB7ABg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:TP5djYeT4QjzgFVwkINnVGs9pBW8JvImhOb1v2sr69nRXZo+nqK661kcdDcQtpbPSPFX3SYqxNbXKWZ8BAF/oOXVxtrTqSA0YuVVFKlEob7TW8J3Lg3PM2octKfugwEnQ3LbbXL0lbuIBNBNORRhIr6YI0PchmTR92eOlX9GWwVaXTqW2MDv4F7rbdXB3TaBlkZQ5MyzattmW0RCeD32q+vStGJGjhoMsy2ttRx+QlGMCuEV57ga/JAJMzVyVTvWZCaxK34utXho9t4ugNtzvVPzVInW+QCM6Pc7oORfZ87cWO4QGA1MXBhdNrwp4sFom3mhe+oRLyJOUA+ISEUBIA==;5:kDfuHK92CZmeh6SpfJ7P+42F3qNvsFaIYBbOl255YgvI1+Nn1xcPMOAZUp1KWyD4g1p9hEi2u1Ac0oKtrL1nxdjd5asQPz+QAeewHt098/vAIS2wFUlPrX06hcBdHyW1z8A7Bny0/5zNWIUtMDF+Gg==;24:oiJK3t1kBEVugKPazpJo6awjFTpbUsL+ob60KA/HKm2QtKLXtWbxERtyWcCjDlcufWojrsUeuhHwDsyvvDawHDqgfRP+7PbYtekBjA50TJM=;7:hY3hTVUoYKrWpEQ+3GDN/bexJyHBPunubbsLPTTLWjnL398/Z6fRWr0rSmwJDYtvOs673HNTelt7vYY292qCIhTy/NDUIOzEt158fEtkhlmLXu0Qicw73g49ECH7dhTL4AtvZDYQGBiFxC2yQFKZTfc9eLLiACJ2q3fYH09fxv+SogQMLh6PU1m3X4GpytkBYBUkM5NvqyLq0HoxFP5TnDFtyLqAuvLNFpnmGz4aM+A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2017 23:40:38.6591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Here are several improvements and bug fixes for the MIPS eBPF JIT.

The main change is the addition of support for JLT, JLE, JSLT and JSLE
ops, that were recently added.

Also fix WARN output when used with preemptable kernel, and a small
cleanup/optimization in the use of BPF_OP(insn->code).

I suggest that the whole thing go via the BPF/net-next path as there
are dependencies on code that is not yet merged to Linus' tree.

Still pending are changes to reduce stack usage when the verifier can
determine the maximum stack size.

David Daney (3):
  MIPS,bpf: Fix using smp_processor_id() in preemptible splat.
  MIPS,bpf: Implement JLT, JLE, JSLT and JSLE ops in the eBPF JIT.
  MIPS,bpf: Cache value of BPF_OP(insn->code) in eBPF JIT.

 arch/mips/net/ebpf_jit.c | 162 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 103 insertions(+), 59 deletions(-)

-- 
2.9.5

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 22:15:47 +0200 (CEST)
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:64781
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993937AbeHAUPnv8BHh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2018 22:15:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTRlCjyj0kWjgf6nkZZWcrw9EtdcqoakXJD083mn+pU=;
 b=iGutALbqtbJkhp+johL93tp84fZLV5TMZJxrXn19yrUKc/1JaFFmU1EJgdBdtscfDZOvo7y3Wm3ka5ok2Li2MN6duPCTGZpgThG3GAi6VjUum5hCeq6SWTgUAtGGj/7V+HUpZ9x6HBbQLQmcMRgolHVNqAZMw6IbRn2UiZAQiFY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Wed, 1 Aug 2018 20:15:32 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/2] MIPS: Remove unused sys_32_mmap2
Date:   Wed,  1 Aug 2018 13:15:17 -0700
Message-Id: <20180801201518.27246-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2201CA0075.namprd22.prod.outlook.com
 (2603:10b6:301:5e::28) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b9dd359-c6b1-4063-65ed-08d5f7eb891b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:cFNXV/cExjsBV34igrRCzzfSf/Jg00BkMUaLPJgNeqNjDT0D0J8JHRzBeFYk2DfAuRbK9LcH+YsER42vZ8LXrQ5GtVHTjPzMr6O+HMqhLYyjhP3n1Ql4Ksavf66Ete4d1tO7sICuIIUz3L1DLmrxfwEf05Fl6tX9vDkpZ7WKtz3+DqdeVlFDswS6Vptb9DmPE7nKrLkUHUYClgjm4rWSa8Y2MmCObKubQ5l2iTWXadg7Jx/IsH/yXdBElNeYwd0q;25:5H8f8lgXlwyeeDRa564kfoq09oo1yqqWZQnD8Qyv+FwjDkrSqb0xPL4dZ7W3fOH493GoieElaZ5NKWRqu+YsMalR3CWjKBp7OwUzv89mGK7DP6+yvZs03gzAAft0vE7/iRpD8f/0KqFN+HvkQJljRYl/uiGTvUKhBV3YZOhLtuP8AQP1C4t9n48+7R9bKtwnFUMUdiBd+LE8++U/zh0jAVKgHP0KaOEMCx5r52eHZvcbqFaJ93abSpTH6bNahhbzL4nHzxYc1l5p3PkOGiHV2aluV/Y2jBoqEMEu1hTx31/9MbyKNVMoV+neUPzEKw0+S4KOgKFu+dKzkXwJ5fRcWg==;31:HzBk2nMzNJRcphnEU0LxUTOt1im6nb71TpqhoInQwqgLf0nZIC9csBNFqlI/1oSKWyHbTs/+5PB4J067EDSVpRCAlxEF2vB65/FFypktxlwU1gSHNDR68LxoqMwc+8UNUSn/maa/fg2l51QhHahOCj987jzQyOcZEASBqJVjJWs5RDcn90sHqqqozYn75mAQPX/T5/c7r8bcLLTpAPL5IE2SuAWSZYvOKX/WUGmIV00=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:DdWTG1s1bg5oiatqKFzozKKzWltO9QsEXft+J8AUvpE3nHjwOIXPA2eGelYD3aTaQMB1vke1idpeZFnMrelTtvYOy7ZngyFPYW/tJmzvQHHgQHvIpU+xAA0TBc6drNwuG8QWWTPPrfBYB1pnLPOQHh9JAHMd6stBUvV7KCrxigY+N8BppTfdQ03pdNiYat9eG1cx6l2+e960KNc+ovSPNBJk+T9FGwbab3pq8ehr96XA5JJpRM82B+BlKYMV/baJ;4:NSYcjhB3wqnzCxzAy5FAZIuZmfP5ONFsJ4Xz9QrlMUa8cOMlkW97VzLCpbUESJ4REGHQU56zUuNBI8EdiKVuVXCTSiY/fvqWD5kH32aaGnKAQeHtdJz23SGUEhykSKL7fys0Ey3zx9G0nrLpMdfa6ko3BpQLylm6qiCTbI39p823DaXvzrgObkUydnWDjHVoyDI3XAa6fWUJS3wSJqGpkxG8RBx+EGuC24ELtdnFus9/+NI/K6bvA30VCGSIos+Q/lxYuhcJEQRgREA86ln8VQ==
X-Microsoft-Antispam-PRVS: <DM6PR08MB493982EB64D12259A95BA170C12D0@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39840400004)(136003)(189003)(199004)(2361001)(44832011)(66066001)(6486002)(6116002)(47776003)(3846002)(6916009)(1076002)(2616005)(386003)(42882007)(956004)(2906002)(476003)(6666003)(486006)(4326008)(68736007)(316002)(6506007)(2351001)(97736004)(6512007)(69596002)(7736002)(106356001)(5660300001)(53936002)(16586007)(81166006)(81156014)(105586002)(8936002)(36756003)(26005)(25786009)(50226002)(186003)(8676002)(16526019)(52116002)(54906003)(53416004)(305945005)(478600001)(50466002)(51416003)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:AwVO+StKBX4tS2CrAs9yQKG09wQhziA6Efcd5l1DD?=
 =?us-ascii?Q?D7MUrCWfwuIz63xB/SI7h0vkoKGdvjhaQYkoug6kiwKGyYWPfUqKm0Exxxqh?=
 =?us-ascii?Q?Q2zgfBF1DZDnEX//uYBBHc8aopdw2GyaKMsG6yuKlg8+7N0zp+coHjK7LI0v?=
 =?us-ascii?Q?gJGKrZZu4oKa4Lc1NBhvhxo5tSpV/YrO12bF7HJZZTVNVN22D8i6AtX6rjAy?=
 =?us-ascii?Q?BdEoq8mPx6ehU+zVwZRUtHX8Xrral6v5cIeIlsrzRkwoX49GkeybRhNloETJ?=
 =?us-ascii?Q?S9FnQncvbxHGr7akIg1RCJCLaMspimQkqSaod7Wt1KEQ8cxMFJhxb9A+1FuU?=
 =?us-ascii?Q?73LVWZ/ejJSRl/StiV2kDziPV4zeKb15beQPvPL8QWp0hN5xz7+zc2Eg8TMR?=
 =?us-ascii?Q?6+hhiHUXxm0jY4XWH4aHhCs2Zk9ZVrHqXOdqyoh6ImB5LNYeE97XE7rN2qn1?=
 =?us-ascii?Q?wHcM1dcmJJMXU61+eAgMqN9e0CovWozCqarj3lp+vmYFTsqfPDM61bNxnuap?=
 =?us-ascii?Q?xgI3ZSN8SyL4+WlkrkVIsyi2r3vze++fHIwuQwT0FwQosnfhzWDbVQxA+i0e?=
 =?us-ascii?Q?lDOtLp2fJbfCGcJyh9OYc0GRVgS94MS+BrocBtu/knjn7/IG/xNsqvyYqylZ?=
 =?us-ascii?Q?cwrhRa5+YsBn67QKuOF0jhSUH+kqkIIy8iGLncxtoSIWwafOro2Qui3ysJIr?=
 =?us-ascii?Q?j6bpD7OG/BnZgbGvKCwUOMWCSRbTS+NrKBSYnxJRpKiGUPwQwgXwIOzNWIsJ?=
 =?us-ascii?Q?ZkG+iHSlcoutXmPBYAApHGJ1yJ5LYRN5Bg/NGlfoL0WrDneQWHA0Gz+ZYWpE?=
 =?us-ascii?Q?45lU1suliFZ8CbuyybisWBmDcpDzsRAeULm6Vc6YFz4KUcAekjEg7Iq2FsSP?=
 =?us-ascii?Q?mvmaMsFIZhTA8VOfl+cPj0TIz1KeJ+4+9QXfjIfJRWYdzJWoDzRB2OFOIans?=
 =?us-ascii?Q?8ni/bp/hh6vuL2wGaCQ/Ts8F/bI5MnX5mpf3SUfcAE17pON7NfMoQUIWSryF?=
 =?us-ascii?Q?zxiFoK5dGfMHPnjutBS2ZPD1jZPTd8p9OYjOnH4IazDXI1/Xf2XupWvSi/jm?=
 =?us-ascii?Q?+s0Za+DANo/oTHApO7hY7SPmbFvWvEP91aD1vVIwde+mq//2HwCbdfufZheL?=
 =?us-ascii?Q?Bhmj8LINfYhO8/neT10vN18pM//YpjZ2CgFKw/6FT6Uakwe01coJ3V9RHR1O?=
 =?us-ascii?Q?arnpFpH4ein3DMDjC03YBQvXkvMSNc9Wfr4PnUtYsHAHh/vgQVYVoOYklPGr?=
 =?us-ascii?Q?1/znIbhlRKve8C+eJw=3D?=
X-Microsoft-Antispam-Message-Info: oXxdzovYv/CCvLHefmgO9IZO9SqOXByBVBGBE0svVx88KNVJpeiCUPUx70TfTHqHRBicKqCkCg2F80mshiFPpNJQyTeFH+nj9zlYI7p2uIXc/Lg5FR/qa9N8+O+PJDwNMbwavLcXzt9U8eGFZSBIe/weWCSIKVsjQ1M2bZgchRvUs1uByaBd+wbz7wi8vE+K9jDsNDJJE6uNa6CYfbHmA0LR6vf+5XQ2XyNIGGGnxAphsP0Sd7JS31OGnksTYLa/p2tYaVNGIqZjcOdirZf9NIkxjAY4EFTt77hdUye3qlnHa/bLeYP8WdheoErya8ik7byxWPgUG8TFNUj5GWQoUPIX44QAVg6BGuGdc/NO6yU=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:QD3YtHBJs8beckK8oKZeIVDjrKQ1EO/IO13ZJpxSsuStAAchAcZcupyEqixEM4qckH9ZL0FfT8AhRYLLItxxfpBz5E1Lb+7n63zks52xY6KDT20DzXvPkX+6zf6FHGZ7ibDOuTBOysgEwCIwKU5DXhADfjur3BFQlR40mAQAKhL1XtCeHdfki8kuqvb8rQ2lZtJeO24icXH14Z/WWhm7IXnnRmXDY43paFVqrdIZGJk0wPv7HZB7XRLtpl1x0mOvNITE+YHp81a55Zi6lwdHjlSzhRIGPjJjTBjMc6I26Yo22818FP5YN59DeHOAkwUh3xZxYJtbaDBVmDO+AfIFVuRhxEotdY2C3ha1B26JUfQewVy4Pr8io+E7WjHE4kkJfwqkbvoGSsztKOOJ17f8G3smxlbdSx3YKLIR2LngqNtUA8+GrGJ/zYPfnmkZW6Z4DoyWFOBZa93rQjA5dA9XJg==;5:iAQokncri0JRb/89nCqAnuyJXu2H2/vYkga+pKSRKHcnY5Dho7lk+knmaEVR/SVHSr/7S7XgkYWBGIf2cglg7Puae4pKValwojKkn7ndTIjkuD/snJZE9jCumKb+mKWls9n4g1EpgCRfu2+BfOdrH0Gan0H+NqPJqRrm24Ax+Io=;7:cnWTHoq4qzPmiB+JkhVKK6ydrKZY5qw9RPJhTrwy1/ZiWsiy4z13C55rng0kOq/xd8+C6X6MxrDQe/Z4iE97ta75rBVAD7bKOyEp7JrWqR3tlQcbXdAgbi6RTff5RiYjOVM69bd49AvydzdabP5KFkRZHE1Ac7Gtt3f4OV6r7bq3Bcjv4DPWQXS1hEQGGFbEBdWDsyskww5VF7uKHKsBrBSaY6ZTiQoebczlPTJCY3QQne0KK9dQKHwvseo8Ya0G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 20:15:32.8810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9dd359-c6b1-4063-65ed-08d5f7eb891b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65349
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

The sys_32_mmap2 function has been unused since we started using syscall
wrappers in commit dbda6ac08976 ("MIPS: CVE-2009-0029: Enable syscall
wrappers."), and is indeed identical to the sys_mips_mmap2 function that
replaced it in sys32_call_table.

Remove the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/linux32.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 318f1c05c5b3..d41855927996 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -61,16 +61,6 @@
 #define merge_64(r1, r2) ((((r2) & 0xffffffffUL) << 32) + ((r1) & 0xffffffffUL))
 #endif
 
-SYSCALL_DEFINE6(32_mmap2, unsigned long, addr, unsigned long, len,
-	unsigned long, prot, unsigned long, flags, unsigned long, fd,
-	unsigned long, pgoff)
-{
-	if (pgoff & (~PAGE_MASK >> 12))
-		return -EINVAL;
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
-			       pgoff >> (PAGE_SHIFT-12));
-}
-
 #define RLIM_INFINITY32 0x7fffffff
 #define RESOURCE32(x) ((x > RLIM_INFINITY32) ? RLIM_INFINITY32 : x)
 
-- 
2.18.0

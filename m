Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 14:32:34 +0200 (CEST)
Received: from mail-eopbgr20105.outbound.protection.outlook.com ([40.107.2.105]:43776
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGXMc0oYWEB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 14:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsHUSHWYiaU6XC6naKwWp4FuJTLI69GIol6X8L00qLE=;
 b=Iz51PNOkzbQ0tl6BPMXSS0RJNE/ooA95eogh5NMmu14OM1jcTqa5xvJtO1gf31MsDrMgkCWPDANEqvYuHKBFeqNFdVubYh/dmUL67BWgGDIfZWlHYDDnxi0NijjrY8s7UFAmRLmfMANoSX5saFUS9aLjx8Q4mXFSBzAjvglB2jM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.20) by
 AM0PR07MB3969.eurprd07.prod.outlook.com (2603:10a6:208:46::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.4; Tue, 24 Jul 2018 12:32:17 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@linux-mips.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH 1/2] MIPS: Introduce HAS_RAPIDIO Kconfig option
Date:   Tue, 24 Jul 2018 14:31:59 +0200
Message-Id: <20180724123200.6588-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: LO2P265CA0160.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::28) To AM0PR07MB3969.eurprd07.prod.outlook.com
 (2603:10a6:208:46::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ef8187a-c6c1-4250-d102-08d5f1617edc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:AM0PR07MB3969;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR07MB3969;3:wHJk1qNjntOoRmhDBc4xj6u/F6AGR9gfy1SFPwNLXKUtm0X8bzo+OsN4JSDN+z5egWpHucT05kdIJrHo/hGtyCOJxRsDEKQVlQgLxPbYhc7u5/CD7Y+lrWWujOedGcPUVamwat3SDDK3AASbZz49piMegMG2/KQ+BibMPJtZtGq9w0Bau89Wvg4p0nh/AqoObGft6Ws4CPZlnnz74N2M1x0U0PIalGrXCO0SDh4lhd4pGQDF7rhafyHBo52U5AIj;25:ZFGBNBD+Ro5idVu6xN4G14cr2vWb6ZHcgMRwMjcrP76jN/wgCGgM9W47us9+5sBhDPItMke3C0X1wJLJisNLZJ25Q+trTkUxJJyukm+s7MBNEYfBXIdt6jodnNToAS+rlE4OHPwpNaFTg1oz0ZBZbORg7odAkXCqGdKfkFDvoIAjHedtrJQrDSanwu0fLtezxIPYKx0d5rIMvRyE1iPxNfuLwiJOqrVJTFmIx3W5agdm2SxW2QuyqupBQ3Uu3qgD0U7NOLE3S0ZW1+dNCaQT4vtWmEHQO/AeuI6NX2CQ0iDCVoPzAj+6bAbc2Tc4+xJds14y/D1tURJRZ8gy21GXmw==;31:jO5AWYTrR7LhxFxLu4sAMpwLA/U/jfdGXuPRyggstv0JB2THFmfVZBhgcTT7ignRPNzN5eMehtc0KjPRboIUI++mrrVPk6GytVpBeitogW/UKZa7hDhJoRC3UokO/SVaZOdgG0+zlQNRn6N3lXTalohwR+H4YCOrGOb+sEk0TOyrIoGue4pK2jVabtHKWAfUcn1W/ujZ1x0NLR100ELH+oh3c1MXmY3Gljyf8HF1hvM=
X-MS-TrafficTypeDiagnostic: AM0PR07MB3969:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR07MB3969;20:q7Ddpah5TT7fmchtQzkiQwmGGErgbHLJELMScsBV9Wx64VH09zKr3u4r0AipwgMfoN0mvOoaDDCMiPHcdUGPKsw4e0tiIKQ7DDEdPlu8WHX5ukDxzbQ8554df69n3Wc6YNXptCrJ5eOaCWCCQix/NoZW7y7nNpWaN+txhv6mrXNAHH0UYYtQ58ZbHOSW3x2kNpUu3PmVY5e1ggSWmR+NPqcSrAe7uYqX69UIG3sJjelCfWfnIntmpWtLQ04imGbjBWTXLhvM3BUeGW/V2aKC79DRFf1f5E1Sw60+TDXa2JORmat8IY5z8HGuWTrGHie36ApzX/VIjw1wDrva7474kOIoNTiJ+Y7/XqZkxHtZuC7MP/Yon7je70eQ7o+5vEs9CpzKLoNfpi8lbeM57GO5AYAR7XzXtYlk7CYWAWMMjj72s6o9q0pmwCUeOch8chZIGq9/LuxmBZQf9tBI/CQdNXmV+cl2m5ThwA2oRVkf01j5I0+wiwD+RemWEURa/jbBrCeSrnREkajwbwm+0+goo244t8QSkmy2cjc7NQ0YqyDRuiOFcDliblman0cllcUILILZmCk7fPX0ozAWXh1y9XFKyrtkUcmA0KmwoL1w1zg=
X-Microsoft-Antispam-PRVS: <AM0PR07MB3969F01105D88AFE7F2DA42088550@AM0PR07MB3969.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333)(195916259791689);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(806099)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR07MB3969;BCL:0;PCL:0;RULEID:;SRVR:AM0PR07MB3969;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR07MB3969;4:wan2h1j5KZQQqd0sTTksGZm49XIemapc5CHf3wH/Mr6+FmGA0AyOMpzv25tNZ0UsTSM0halMfWwWPSC25/a/hpXVPtwhoGhuEOQHwBGKckDLrDgp58Tg+rxgqJUElawq/x1CiAvleH6EafkPC/r8hTSbg+rEXXMin0oc+QQTDUdy8IRdQqDVm8xwbrUhnNo/kkowgeXTpKPX1y1yvg3NFtaurWC8To69OpzlNaxzYymAA+XJvMXZJdm1sPxznFwVcG6MHvHgN6C0qMk5YtCPr3D4Af318N1crj84mGgbxBPyLlNUM/dAVTJwvEgeWypQsf/4FdMvihWnKAySJr5fOQ3u8ixXIL5LX3mIJqZVxkRAM3a+NwOysxelTS1rDiyJ
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(36756003)(486006)(476003)(2616005)(956004)(106356001)(51416003)(52116002)(105586002)(25786009)(186003)(1076002)(16526019)(48376002)(6116002)(7736002)(68736007)(3846002)(2361001)(44832011)(50226002)(50466002)(305945005)(86362001)(5660300001)(26005)(81166006)(2906002)(81156014)(6916009)(97736004)(6486002)(8676002)(6506007)(386003)(16586007)(54906003)(8936002)(316002)(478600001)(39060400002)(6512007)(6666003)(4326008)(47776003)(66066001)(2351001)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB3969;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR07MB3969;23:Fw6l3W7Lv3befcp0INXT6vPxkhJviXgXoC236219o?=
 =?us-ascii?Q?A1n/zOjqMBJsMCYlDYwWqmDA4lMjqRsHx+s54deyygM+UmSTZ6CTzp9cKVL3?=
 =?us-ascii?Q?vUIUGKtTPkF83UJ0rH1mVoRgcxZ/falc42wJEBtVaBZ4ralDxnRfW8oZYXw/?=
 =?us-ascii?Q?vXDXyO/VXsuxZkKWWtKI4rd1/SCMe2hiVfLDzKzXgISl/hLpEklHTUS1REN3?=
 =?us-ascii?Q?HNZqyZ/xWcpuZRu4kbaqtpeNFjhmchM68Gx8Xh2o/wO5hmOvUGMd4prYkaaA?=
 =?us-ascii?Q?yxaxqhPWUxpT56UKhfRhuPuu0h5C1sbe0WKv+EP5MPGsySvoTuTzjFqVK1AM?=
 =?us-ascii?Q?P8r7jsCJPqGiyhgvphEV3lkbk3E8BmeTq7qMnF+XUryHq9JRN3p0pPInDxtz?=
 =?us-ascii?Q?EeqUoURJeBk47cqydV+RNup1QVT2MdN4ioWd7987vl2uZ+bzqe7ZlNcwmKDB?=
 =?us-ascii?Q?WhbUPc5c2cSlOStxBNSgt8p5XEkfh3oHrSuRTtQq+0KZgt0Md9flZMVR2A1d?=
 =?us-ascii?Q?E23v9jFsyWIjxGA9AtXXN3TvuHxpxE0cMAExEJxAYUz/Vo/Aa1ZXmsKSpu9C?=
 =?us-ascii?Q?IK8MhuBQ3PGa58+QGQhxhcWZwK0Q8yswnEyugkeQGL0Z5yMEKZqFM4wc628g?=
 =?us-ascii?Q?PnfMhVBcZxz0SAcpxk2snQTHkLjEgcfTceEXh0zHV/HGBB1zJzd0m7LlP9Q3?=
 =?us-ascii?Q?PXLfMKm9QdLXhrJ0s+9rLZZ5p6nrjqi97sxwQp0VyeM1TH1+tsXmSIm9ueLG?=
 =?us-ascii?Q?9we22TDXZ2bcHzd+Qtlb3cuELj23ZYEGnbRnBtT6JemaXYcz9/jSptEHV01L?=
 =?us-ascii?Q?WJnRSM1NMmu/hDib05BHs59H2ZLQzfTaZuXU167tu5K5DGBuvAJgEDz5Qnd4?=
 =?us-ascii?Q?cmjE1HPMZXaz22dN/nIwwE42iUQZGzo8Drj5pL3oKzw01ZT6Oeb0jgpAAXgL?=
 =?us-ascii?Q?Qz33z3bR9oFdsQ0kv15fzfdFl9Q6F5HSxrvlMVH8NiCgUK8BzYk3VHOp6QKM?=
 =?us-ascii?Q?4JYrglzcR26U6cG3voAFmlQW4r/hDACdm3cTQ9QfVSnYi5aTv5XnCIVduS8X?=
 =?us-ascii?Q?9ZTyfxTu0MQ+azOlTwXI8C7LvUUhnIEZ/ZlYd7zYLB14QYOZ45DzyjoJZFM9?=
 =?us-ascii?Q?EMpD18aTILeocmHY9ZoNjxRjp0nABC+RBrWc/5zMJmk4qPo1LJ8MRj9Gp5C6?=
 =?us-ascii?Q?zmANqTQjqTpzunE4Y1oZUlQ3oBaGA8BguK7REKWwbOkP6B1fY2+rF2D1Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: tIghLRBpOwbMDfCJeNZip1SkSocs+6hSFQ8BwxpEqun2cSJed8w8l0LdYMKAETQ3enlc02aTyu2FTb0HlxT4w7EwYfFhiCzQA6bMECYXPsD1zI4WEsUfbZ3B9BMyw3FkMV0k0ezQC5oGyBNXUsoLDScWK3v4jan+Eny8uWDbdTsdVUCn/HbFKhNyEHyf7TswsvSDUwPavidpYy6UxY4DDKpkmA3H+01UfzNcebLrzupD/MUhwZUDlH2yZK4mFosSVZYpP4n5n2/xXf7ket6Rsb2Bv7G4RFovDtuOaMj4a7uzlv+L1OIirTaS6wMyOHWCtMDEVZot+dchYcGLBZkA+FYZ/FFMBG8KKMh6Y5pVAZpfWnQjseH6hSrAeyUHdu33swCDSe5Ffr8DqRGYHVtA9A==
X-Microsoft-Exchange-Diagnostics: 1;AM0PR07MB3969;6:+3Y9YNUNzCqXrEoPL/Ci/ioRlZZAJOeWPW3GxSqkvmqLMB+3ddyxs/6Qo4zGmmWCIxKSKRZvTKSvWChjJXK4c5KPzuJq1IBXV6in6XlS5/pf42cf5Z8yflTjolExDm1QSwQVzhcA4WTEZcBDrzdWaG4aIRSFyhLLeeut1MyohZjPDzc2dKc6arG3sszYwqStqeeueutp0ohoHbgH0+au0Ay6TZli7WN2d9gT4MQGrWJTxaswpDVnDFmYi9aPqRp0qiEqehlR2oaVkB9Hm/G3IiB76vW7ok93lQSriW95biBfAlITLdPZrvbJmwHp2kb+nEqCuAKGTPXtJHnOnoV7YuKJukfIIqSgA7me5z48IMmHwN0BM+P3t9+aEh5QZ60dK0QPT4ABeo4towkIjzZ5qoic5QLKdR/Wf83Lz2KUKocJCPq/YUqPo1qSiO9kclBgIN1Helmckokc0pB5nFoZGA==;5:Fd9mBd6nZ30ufXNBQcJ6xG6xb0HkVsL7sbVy3sfo1YRGWRxZxp1KA8uU66j5R7n1dHFs93Jcy/5a0Jr7HmUva8JV3stTm0YqbxQteWh0GVWevnBJWsP3amCL2AlI8beHHfhUT9LFrl1FMgpTU+EHu3q0KeOtlL6Vt3jo0chyPqU=;7:mVjKEUnR6YmKbc9C7XZAp7BSt8ptSR3rmaLHGrcccHSGKqgGiV8mFmm50BWbRHWPQPzNN66RfQ8AmkQ71EsOzq939GBtqE9eaR2ZkT4mkT1LRuyM/bAZRY5BhXlL8S+hUI5jSN0DWMn2x+PmuzRxygkU0GgQ8FuoSVZzqRFVnXGSS3chPuBa0WSo8QkYtMetrhYaFnWi7qOxTIJwKsSFx/ZljkoictwGmo0+z/ogLKzBpPIxDI76ynwqbgX5WKRK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 12:32:17.8170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef8187a-c6c1-4250-d102-08d5f1617edc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB3969
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

Introduce the same option as PPC and ARM already have because
RAPIDIO can function in the absence of PCI.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a6ce5087b729..b7fa44ddf452 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3104,10 +3104,13 @@ config ZONE_DMA32
 
 source "drivers/pcmcia/Kconfig"
 
+config HAS_RAPIDIO
+	bool
+	default n
+
 config RAPIDIO
 	tristate "RapidIO support"
-	depends on PCI
-	default n
+	depends on HAS_RAPIDIO || PCI
 	help
 	  If you say Y here, the kernel will include drivers and
 	  infrastructure code to support RapidIO interconnect devices.
-- 
2.18.0

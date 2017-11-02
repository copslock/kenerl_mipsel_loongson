Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 01:38:58 +0100 (CET)
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com ([104.47.36.76]:2752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993298AbdKBAgzQHE4m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 01:36:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LGD9GdPpf2VjSZ7bV8DMndj+Yb5/aG/sJF2AwnuoBtY=;
 b=MX3t3lR7uMiXMi/rIPEAtA80rpuIgsq6sQFscCsRSOWOD/MY40YJzCmTSxdwDfE7nB7Ry+XJLssjU0rWUdZYdGXeZwmc+PYa735lgmmduouCE72Lu3VcKp6Q8kCoajVXKMKdjlSYAZR/Yw56fHK/6jtuJI+BYQfMumI/DZNNDq0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 00:36:53 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 7/7] MAINTAINERS: Add entry for drivers/net/ethernet/cavium/octeon/octeon3-*
Date:   Wed,  1 Nov 2017 17:36:06 -0700
Message-Id: <20171102003606.19913-8-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171102003606.19913-1-david.daney@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0072.namprd07.prod.outlook.com (10.174.192.40) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8de63e8b-e37b-422b-6ef9-08d52189d0cc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:3GrD32WGDYUWJtJU6CLiFn7KrepxyyplTh0f1QmvQAPmm6SrJk8u4v0ccWqL5UUHNbasBGbjSDxnqfAFM7ilvcwKU5SJObowzS78MaPXc8pXDRK1rthgdGStxVSmvYABRt/XWMYiyKf/+Iscc4MKveS3Ob5ENQ6oTDJt1S2I5ToGvVXCYu47xSQXALLX4HcvVtgQmDO6KvSHgIpgyJoKHIUnwKBl+edW/QUibzCZ2vSkxPQzDyvNj5vjoua49gmz;25:rpxlioVoXfXCTFNKVbFDowuQg6eKBKqwBhiF7dZtCEygLF24oP12gPivjIgR65VP5BnjWB2VlcijjIg7ERD3baSFuIUksPNZndRKai8G79egjBBXn6KnTdAzjSD7S9bWHABaFCtHOuv/ppceSoGPtVuEfAVcq0LipmoSjAmvNbt77Rwiz68K4lYLspKGkIuSK99p1bCE3dur2Sh6u6eyMM0rLK0qrg5qCVcXgA9epF8zl3kCDvw2SGG/JmyLI3FB0SC82EuKS7QRqXTCWjRLplGyuqq6PIIDWM1IN4HpqsjaYMg4iWxGq5ShhJerYUBlYrZYq66CVBGQn9h/TypWng==;31:X7+Mh8jdn8MFWWeVPB5gXLv97oYAWqmjameYOPV1WvTeTaNx/Tac9lhbdMg0L0UmS+gLviu0jo0clMvhPKx+YX5Rad/N1eV6yWrOy47AxJ5u9UmijHh3N/6W84dyNCF4HGBGwL/ylNkX9tMefK55IdNkrNsXpCIhAFg0aJ/74L7zyh1mSdZHhPdTI+WaEh4qLKvseym11FDz+egInNuPnEHjQXD4OiDwmyf7ArDoip4=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:NT6zgJjb4hTuzn1o4C/hLLHTY+5hLCl0wGdBsUa/leAO83w3QZutc6GhGSpKR/9G/fJgiuOX1GoDjwFa5RtEmPhni0Ruyv7/SF1p/zd86Y2EMX3lm0BWPE48vtdTSWIoXIBIUqh87VD7duCIRP1MEcmSFErlZO7IkLwa7tP2LDtA0wFBhGOr67nlhiRFSXSoNRV5SVYGSwwWaexzxoUxO9LOqpN7GbLfV9qygr6MxxnVKxILsXqe93xUvpe05k16nMkjvgRHi/ba4MO2tKpxQMzomwYid/LpIm1FeIAiNvkbkMeoXLNUvHwdef4IJS/mTnFgFuAGDR4DLl9G5RDg2It9NOjfxnOPTS69z1x6TZX4ism3s2VJ55TYKrnovjJKR9SP4Kz21W5b9cu6EijPjvywvksU5VqYc7wREB3raoBaud00sOMRUEp7tbhhlyFrhPfhGIA0z9NYznwDkfaHbJRcDcJKtHArHdpgGt1bnyjm2LIrX54ITA7KAQISpU1/;4:PdFQR1lOP5m6NO+8F1AyoZp+EHYNXYhz/zdQgRCMFkUXIlR90gSJ6GE5wBOHyp1qaiN3WqoSrjyjbkE7uPOtNzkyzvO9TGArBqWjRltWE/o6YDpVSA8/Ybl9IL/gBblZBW6CrdWBWQFc6L8ny23QjdVqz0bl/hNUnHZpzF3mh+IPNOhIL/R/8ADCpS/RNsXay/EE6nFKurUfYDhdLNlo26a08CFe6BJxvDUEGStRWJ+gARDeCBJazQY68/jCsvcItKM6Kfbxvvb0HjB/c4pycba1PIfg18jJA8MFLG+vhLpeOhtXGXoVABDUEEqC8sf8
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496BE23EA5C469BCD1C986A975C0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(3231020)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(25786009)(72206003)(16526018)(50226002)(53416004)(7736002)(105586002)(305945005)(101416001)(48376002)(478600001)(50986999)(6506006)(966005)(76176999)(50466002)(33646002)(47776003)(53386004)(5003940100001)(106356001)(107886003)(68736007)(2906002)(4326008)(6666003)(6486002)(2950100002)(6512007)(316002)(110136005)(97736004)(16586007)(54906003)(5660300001)(53936002)(189998001)(3846002)(36756003)(6116002)(8936002)(66066001)(6306002)(1076002)(8676002)(81166006)(81156014)(86362001)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:O0/hrQcALjN9oBTQPuRrpxkAWJGwUXDjgzxMVgK3t?=
 =?us-ascii?Q?qwO4J5Bkz7Fv7XXm/8AEmdSGQUnYNXBS7o2pcKWdDsPnz4BXJo1vKclu6vWR?=
 =?us-ascii?Q?HnvleTfgjb//5NIhJeyNmDG/pOjUVTd2d03dJI8VnqFOF69xta/jdzTvDvKu?=
 =?us-ascii?Q?HKfI2u9ecf/K4zr7nr6UrnUE60iHUNQoYKQ+qe7X16FMt80nI6AsGGrK0o/v?=
 =?us-ascii?Q?IkwcMnLjFBOri8mU7QochfH23fZyrjCOMpL8K8HgorIZ4TWC45RWRtNIguoo?=
 =?us-ascii?Q?cycWMUZ6MD49v8zKkcfnnwGtdjs1ESt4xeqwaP45xH4TQNJo//jKlWVBK6M2?=
 =?us-ascii?Q?yyW8m6G9/4KYF6FNUDzZSBYkZ547hvrvfD7ngWMGOLhwhgAmfg/PymQ9476y?=
 =?us-ascii?Q?nZ254cL9jkfeR62sA0XlYrWMvuIdT08x4H5dKkXv/12RgIoqe9II5jbRrSjk?=
 =?us-ascii?Q?ChNOhZKH8gfwGzU7+ojObwQADdA05jZ+dHOaiLQ5zNpCRj5GBQVy8S63LsOP?=
 =?us-ascii?Q?wBlcxgba41EXWAl5i4Ybqtn2N2ecprji5nVrUIfRwykm2u9LO42b6aq30O2V?=
 =?us-ascii?Q?1cjC+OUecN0qypjsXETZxw8FcY2PCi1CA2usQQAuecPQy0vKZdSaOl43kpNK?=
 =?us-ascii?Q?jpqWsEw4bKbvKNTLSKY4eoum4mhM38+muq+2PNtL3YGutuHdV+8HEjnLsRvR?=
 =?us-ascii?Q?Xw8gLz4rHnG7Pu1if2h0ned4sLbQBTCB4jYCJkHWpAJKqkD9F284MDL5+xqS?=
 =?us-ascii?Q?114QBCZJ85sI4920QOk/gQaJXDR3Ob8SzutU7VoAkScxzqQmvBm/Nlix6TPm?=
 =?us-ascii?Q?1HP3bT2Ov24iftmskB/FA3KqkvAIRFx23U+z1Fn89uwfVv0kGFSS82wxlCy8?=
 =?us-ascii?Q?UHYlDJ/e3LleQW7xkJCYvzBy0mgztPfLZf9/uOnfQLDdNf9lcQn5Ylaq+23X?=
 =?us-ascii?Q?Kg+BHRWjEbLjrGstKf6b5p7a6Hm9To8khA/oUjplbdlD3iK0PJjojL/FKJr3?=
 =?us-ascii?Q?V/mNapwaIKttkO8F8cBph7T73N6Mdav//404Jr2XM91qZI15rkjV0o96EYyi?=
 =?us-ascii?Q?cFB9w6eZDYryokK4n0xxbOmRbC7wRLxcEio3a4+1lVKu562TW3FHuERiVmCJ?=
 =?us-ascii?Q?9U35VDDSFjCAOtXzBTvs6qZ++/aIj62CmVuKmCb81Xb2zLnWzo3rFyR+8AyY?=
 =?us-ascii?Q?nOiF0Ep54Ej33yW8nbx6eKnWN01ElwV//YMv2teqEbj5jOd/yEXWNHx3PhkY?=
 =?us-ascii?Q?+F4zHfpCQcwILbme3Y=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:04IGiHalyN9eMqE5kUfvVEl40R2k+Vp6WIUKEVGEiMAymlRvAisyowdP9VrRO9+9k7c+Ge3ofiy27F52ICWMC2kUEo7cKibCsQ6UMCSWT2mZG0ZR+ycdf6j47Q0gTj+Gp3cy+9c7NgZxLcuyuYSHjGznUZpHcm+O0IJ2mCtN3YxTwCPn2xHa2sfAwSdq0KF1sBAcbUfwDazuqLxqkmfErddEnmPN2ZOJz8/kzCfNcTJDXXEX0FpF9WBuSdyjb4s1ID1qQX9poYCHCyhwwR3Y19s9a/Il+JibHvmqZ69vSVyx9KQ3ZJNMdEEUiz5Yx6cGRVsZ+oyITzPPjkDx+34EboWbsRlUFWiZYNstXhn/yu4=;5:nmfoX931IrxNGNsmV5RQl1qW4K0qukzXFHs2gFPOaWduTShUIz55z3IGfxWzYiXmkunepvitLnirQkUKkA620+nIt4YgVu2TKxoPGdn9FUMYtemhDB5ysziInosedmj9fuYh0MdZFIVaeaehz2DNhKjQtbtW5EC7JcSgzfltdBg=;24:LDOx0E8N43WCBtOERcLL6gWUzZl+SY5F0MCgiM0RW55hlDfxpve31mULmvzZtLw/+SxQU44xvY0O5i+JY0SCdyhIl9pxmAdZ3FF9XAteQyo=;7:XtssaTdBIdXlRXH1zr/Tmpyar0N3K7AiOvRwndDpwm7MjYAllZYpNxbsGsOuzr3Aurd1V/a74ynYUsYycn6saq9FJCMgRtT9K/i+fm5B56d6X3RsZEoLwgpSxDPD4zXkmQP66HdgiBnKKuCNj16oYAev//CgFD8qRLxiOo+FKlBdaZlO+OyRsBd1R7FXciepSkaB4/JrcCzuLLnUQkaq2sBpCbr5VJFT4wS+7r4WaryCm+tsiAp3sy7QC6tuKgdp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 00:36:53.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de63e8b-e37b-422b-6ef9-08d52189d0cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60651
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a24f56e0451..142af33adc35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3212,6 +3212,12 @@ W:	http://www.cavium.com
 S:	Supported
 F:	drivers/mmc/host/cavium*
 
+CAVIUM OCTEON-III NETWORK DRIVER
+M:	David Daney <david.daney@cavium.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/cavium/octeon/octeon3-*
+
 CAVIUM OCTEON-TX CRYPTO DRIVER
 M:	George Cherian <george.cherian@cavium.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.13.6

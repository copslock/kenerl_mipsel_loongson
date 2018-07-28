Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jul 2018 03:24:34 +0200 (CEST)
Received: from mail-eopbgr700124.outbound.protection.outlook.com ([40.107.70.124]:62912
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993024AbeG1BXvhtVeS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jul 2018 03:23:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZTgtudz8qOzjV8DsPVHgHr1nV61P2nSWJgT5Cqav1A=;
 b=p8Q6f0BNdTnk1CKo960vESpbLc9bTutr3y7N2KbAQrT5dmieeFMzMhV+732gk36KTWA/Lcnuelpc+H8e2tOO8HYIryUcDGUaeeyV0+zrePOFdLC5kJzQN9N9wbpcEsJho5AmCoW3JiP+7uh/qhZtnXRqoHq0H+ADAHhWlPfC7Fs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Sat, 28 Jul 2018 01:23:43 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/4] MIPS: generic: Select MIPS_AUTO_PFN_OFFSET
Date:   Fri, 27 Jul 2018 18:23:21 -0700
Message-Id: <20180728012321.29654-5-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728012321.29654-1-paul.burton@mips.com>
References: <20180728012321.29654-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0042.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::28) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c630feb4-9a9a-432b-183a-08d5f428c298
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:vaZoRREKVckeMHMKTkYEO8AfqFJyRCnL7g1bAyW9YhjBPrONd0yg9xXdqFDCYRzsimk8nJzV79rfKOE3vXwpr80aqWQq63aVIcgxahhxSSDwRrzZ3V9ZL2oYUGtR4M6r7Ly0vx+xmh7lnGcl8r5lUFq6mwzPTgfNa5BRvVQOSw8C6nBgB3rx92pta9bANO3gO5KGJRiiajS6ft3pcEBn66uq3wUHq+2qntk6E1uP49RZmcuAINmOkLOzJWC+/sdj;25:G5tUv8EQyjZM+ttPfMYpGVqp26M+DGySQiVIwAAPKhI12XOUNpodQVZf6EMYSAhugNqmle4P+MdQ40DHwyP+Dde4/1UROj91ee3W+kxebh1baKrrBW79x5UUmBxzBJRoYu38uYUMNBcU+iZlG6IoDG5rwXkiBuKBQLF0FLDo0tJCnlHaSCy2ER5wEXBf/mxV4YJMW6kbRPKtgl/Td1M2vTVebh4zkWXsVuz8FAQUsqYj2iWzyLQA7GGvFMrQwblxNGiRiVCLJEOsMeabJKKSvClTAtAdMn35MiEmMx0uUsbmdFfHe7exEfSE+J1KmQAX2j2vCyYBipHZTh9/7lwqxg==;31:OioVvPreXb/TMs9VEw2RzFuXLSjbOXycppudGrplHByMA3D8lff6mhN7wc1GgPdGNlJ/89zzQnIlwXLH52Vt//bSi1ZM4G3M/yhNmxWmnbdRdSW3gHi3B9pbZBe23uSNCMr3ZmhdI820ZCS62+q2XsEOGod4qd0VR4VQp/K9RwmvQBxAmvZwiVKt8+a7ocheZYjO4DhPqcLTWGg2vim0WLQRI3B34xrwQEZ1vX/xaPQ=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:G3aywWmCRqaDcvbFV/sPOQkwVf58W6bpZx12DsV45ycViKFIZAyPs54+/AOA4iGDBnJX10v/JhHYdsIcYBNxDXEErKELRt3ClNPjOj5dcpepkQ1sPw40dXy9+CRUJHIyjCqJ9wcT/jrcb/2/TQSVtBRSKZCDiWG2jAf7y3oWps1RMVtxtTrhUaEu6iTdYutDv0UoJtMHL6aJwQUF48iOlU76g93ekpw32T/a60y2I6ONGsWmrx/hRfVNhUz+SOKa;4:o1xwRF5uT7xVyLscQxGkEMs6Ku2Htk4p6OY+xNwoYIE55EV+PlqxT6RCxh+erBEx4u9Hx47TcixYENsoQTb7KGm7WgUvafvVV+xeNcYU78OIgl8u3oSlxaWFbOg847E/TaBTM1L7/BWnaXBBLXlJdqaed6T771FEEhqf7s6OOMnYpJ5wcc3w0GvY5+J9OIM4dGRVyYQUN9G0Aryk0LXdNyvPXBraqVRMbCsGuHXviyU56uItEbPxITKacGBw8pv8ubWTTjEXAQdrl4CKPPrsuvhAnr7Gjll1/DYsAPzGZszx/QfSP0truENhxjUYNX/e
X-Microsoft-Antispam-PRVS: <SN6PR08MB49427DE3A17DC7C6CFF5FA95C1290@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(51416003)(575784001)(48376002)(50466002)(47776003)(52116002)(956004)(76176011)(446003)(42882007)(486006)(6486002)(6512007)(11346002)(476003)(66066001)(53416004)(44832011)(2361001)(105586002)(106356001)(2351001)(97736004)(2616005)(69596002)(36756003)(6916009)(16586007)(81156014)(8676002)(81166006)(478600001)(3846002)(1076002)(316002)(6116002)(6666003)(68736007)(5660300001)(8936002)(25786009)(305945005)(4326008)(7736002)(26005)(53936002)(50226002)(16526019)(2906002)(386003)(54906003)(6506007)(186003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:DIYW6gPxpnZf7vfn/CGVdnmwHA2IpdJLmt891Rz6w?=
 =?us-ascii?Q?PRbLlwCQt3guedDqLaKEajLBjDcAnOb+m+AHl3VXR4P4wFDj6S5efBTqPS1L?=
 =?us-ascii?Q?rgCa3ESsPJDGsQnJ/vcTAzT4aovnnDORisFVvWFL0nyOHW/RwX/J2/x1RyXy?=
 =?us-ascii?Q?Dz38G423lonJO1BHYqHzRwg7Xe+8Vuov+R8JzJFjtvzlJrm6Y0nBIF0Xf80h?=
 =?us-ascii?Q?04cOQUPMxquWejpz7g3eU0tZCZxGUqcW1e9QSGbhJ/6UrWzpv87ugdaM3eLa?=
 =?us-ascii?Q?vOz61B8OnX2fNgq6lRFTDdGktwneNsijLNCk3n9UQONlMMj9pi4OJI3kvVol?=
 =?us-ascii?Q?CqKb/kaWxrrhZvv3ASfBq5eAU6dQCDdAdsBJ4v0vBV82N26DMZPDgREqP6mR?=
 =?us-ascii?Q?rl9BsEYhe5MD0OKcDA6+TDhkXaCbR+Rb3vbKbhClAVrNxplzYeyHQc4xkJnV?=
 =?us-ascii?Q?9FsI3/EBXU2u0ZdLhCTeIE/dqBTgleYx61koWm8q1rg3ToX4fcBKfqKhzMOV?=
 =?us-ascii?Q?t/fSqgWOKQFE7Cj94Eb9qCEaQCOu1cvm4q7ICGGbx7wR1iYZx61EUkRGy4bD?=
 =?us-ascii?Q?CCzJTmUBHUSxWt+FsIDh71o+ZK07Vr+PrfUVFbvW27+PRCP57oI08beXnCRY?=
 =?us-ascii?Q?j91wBvHRHDcZ1oYMefhXRwh/2DH/hcQ9ct8QNTp5d7IPZ1Utm7+wSNwKG4OG?=
 =?us-ascii?Q?S9W/We19+rBgEMbJptS0ygGTlU6SJInycLJ/fZI78v0xs7538bTwIyczHDXK?=
 =?us-ascii?Q?UC/syWN7v7MtilPCbrYSdAk+jkjjPQBYH5V0ujFoJHmkyjVDN5whuJnbkuav?=
 =?us-ascii?Q?z3x3opreq3Fba+1QE96rRyQdSstiWtAtJFpqh2W9xfkizzS+NBmgNZnmIo+h?=
 =?us-ascii?Q?kreGVSp0JOjRyNXuF8UNMLZVx8MplhK0f1pu25OohNA/p/RqLWHvOeLGHOSR?=
 =?us-ascii?Q?erlzcEQPseI2iYzjg6p0LWuR+YWkTjmwIpbhynQoWnY7L7HAOsFSQKnStHAH?=
 =?us-ascii?Q?rN9rB30deFsjbwEASy3psu6sC+0pZRs3NFW67baASWehMZs7Huo2OX/AyAFe?=
 =?us-ascii?Q?Jl6H8kmjOC1UKBq9cUBohYXuNB5ucd/1g+cRk21DPojNB27RN25kKXSxF8S3?=
 =?us-ascii?Q?IxL3MJon3xz5kHfURzqSCwVSKu8pBRTSmviKx6WC9HQ11Q+4dU3XulxALkAW?=
 =?us-ascii?Q?9ZNsnhs1cC0jOj0QYhFpuTd2A/su5KCBSKRvKkbGC4EuVBadcslNZWrGu/Vd?=
 =?us-ascii?Q?DGp/brYEfHP7nBEidLd+pGUtah8atmRjsPGiDxHNoL1pYK3jgU1w38th6wer?=
 =?us-ascii?Q?mlFFvnqhO4m7nQ65OiuQYY9LOV1jyBLj4Y8QEagOTMirP0jdcQ4B9jD2Y2MO?=
 =?us-ascii?Q?UDvRw=3D=3D?=
X-Microsoft-Antispam-Message-Info: B8AQroum5uMrSNd92HXRRESFw/e+99jX51CsHdW5edIQgC7DIHD42Yd80X/HY8WpKnCL3IJQPVeUhJzYdRHS+qSOrk0uP8OlCZUOIjnOPKbUnGrWT1vJhUO4G0teHIYcw83LcbjBSuCjP4tTz7+am0ouG0TJPcENLGnXMJHeDRTDvhZxfWpRpUWWmuhDEM9XpJBiZcjZXhslkaMC2T0j4mkogcKjrkvCbn0TH/qKKWCu41lYr4YDrjDihMp7g0MtaTXGTngMYy0I6MFgklIRP/NNmgBXJODPEj6FW772ogE9ist8dRIjrbUaK9EkySudweCKjxTlQawXkWdW7XTZ0ODrXdyDj8BEaaJLz8FXagE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:Raxb0r43Ane7jkc6Ez3UE3VfqE3TVpeMQI+7KuItg6KpW0a1oR6EwuYiOqKwFTMWS0c0RL4oVF2W1MLFEghFG/SYvVQX6SpErN5hED2lAWomg1jD9LNxNSK6xfOtZd5EUWqfYH+Rq2Ze03astSvFYdAPna8Dq9uHgmmrII8cc3sL5uSyExIa84O/82csJrbKmFWekn8JfXrgpbsBs9tMrxuahD0nOXsqioPD3f4jo+Civ1B2k/Uen+05ADzUwvP+Ge0B/uapI++lxBcKy144TTgtfQlleJ1ChsMtj4qQKzD0Cnqcl2NvDsiONOmEspQQtPw2yryt/ByrQdZcVDaG/reNHg240YRyi14wByIr23Gjzxc33UmeiFyxTeXBLeYcTuQpFWrclIZn7KJ/kpy84qn5JKVpLCanrq4QHxL7fYsYBRC9nweJRRZgccI3JDnuqyFpHt9kM80KBrLcGPu1Aw==;5:FQt7mAb0UMZrskIKuIIjdu+jNrQROFnzIuX7RQL7wtbCeXvUD1Etou8fwr12Qnfq18t7Z7varXqvhxo/IkBXsumO+EG0iOuuaonRY13eQH/Nin6FbQ70NqYJwU9TZBYLKSDpMni0hkFzMoX6qej727ppW789VOLJMOUPuQxcx3Q=;7:JBHbG984qV06Jzld3uPCD6ih6Vg6xqdpFeGYlpjIrD8bOMwioIuo4oupWchyNSF/ezAXi9haUkpdQNFQVQ62Je6zbSD6NY25Nipdjj/Qu6VRHPxbE+dpqkZYyMEMJ+64/1w3rqsX2Y2OpJeouuiWy/MIhLpasiVQUMMv/OTQiKTM3Pf+TI7c0nsVs8dY5nlX50Jr48xoSNxayuAZdlTsEu2d9xj/f/i+qdSZRhuis6KaLk2JDr6dSwXGsKg0/Uck
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 01:23:43.9659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c630feb4-9a9a-432b-183a-08d5f428c298
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65221
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

Enable CONFIG_MIPS_AUTO_PFN_OFFSET for the generic platform, allowing
it to avoid wasted book-keeping for pages with addresses lower than the
physical base address of memory.

This has a minimal impact on kernel text size, with 64r6el_defconfig
gaining 0.1% in size as reported by bloat-o-meter:

  add/remove: 4/1 grow/shrink: 345/13 up/down: 9017/-392 (8625)
  Function                                     old     new   delta
  pcpu_setup_first_chunk                      1444    1780    +336
  pcpu_alloc_first_chunk                       864    1136    +272
  start_kernel                                1064    1288    +224
  initcall_blacklist                           224     372    +148
  try_fill_recv                               2088    2184     +96
  ...
  Total: Before=8457273, After=8465898, chg +0.10%

The gain for systems with large offsets to physical memory & the ability
to continue using generic kernels on such systems seems well worth this
small cost.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Suggested-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fbf7f678e856..c95eb5ad0d96 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -98,6 +98,7 @@ config MIPS_GENERIC
 	select HW_HAS_PCI
 	select IRQ_MIPS_CPU
 	select LIBFDT
+	select MIPS_AUTO_PFN_OFFSET
 	select MIPS_CPU_SCACHE
 	select MIPS_GIC
 	select MIPS_L1_CACHE_SHIFT_7
-- 
2.18.0

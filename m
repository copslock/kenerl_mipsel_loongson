Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 22:15:59 +0200 (CEST)
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:64781
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993945AbeHAUPoZ8vvh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2018 22:15:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC1ZvocwYxfyBAoibqdDDZz+HttPSGN824PTsFMwMd8=;
 b=EXS8hax9KQfl42we/bVIJ93Ulb/vvi8oWd1qKh8CSlXgcHjKxPJPGjGragZqOxXUdTBqFKoaEMmqgckYOBqx2PX/avtzStxrKpwmgZMmRYthSXqz679wRtJgknW/ffAxINspb61iLdylVNTP6OzQznblra4YKw8WgtZvFT37Cag=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Wed, 1 Aug 2018 20:15:33 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/2] MIPS: Delete unused code in linux32.c
Date:   Wed,  1 Aug 2018 13:15:18 -0700
Message-Id: <20180801201518.27246-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801201518.27246-1-paul.burton@mips.com>
References: <20180801201518.27246-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2201CA0075.namprd22.prod.outlook.com
 (2603:10b6:301:5e::28) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08c4edad-6c61-46c9-d3bc-08d5f7eb8985
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:diHowT2nCU0BchtVwPW1D4v6VmTvFopOWMXs+gge6Njn9PrHD0XDEhWAkbueQTm1Ux7F4bSDACPXc+r1njd8xn1tegFNbsWT3OZsrvYDUxnPKXZe4RWew/MOM0TXRneZjblaiuT4P/aojbetYZDQsDadsdPhSiAGtBCH8j/Bc3Iw9o4RzSeZINOSq8VNVZOkIZBzhAKOPXxsBtMUrECA5Kfn2bzI6Fr+2BVCQMTcKyGbItbs3KlBl9rV2Dh91ckL;25:AXBF77n4jEAVULcF0ABofPfkmadee25iKABsylTEB6WyvJrnJBBiKXqOkDSaP1Aq6qbzoDeTyqpJjAKB+9+PiHD6APY/gvsX9IHjyJYOl977w8I8JpXvK3zPwRRIbhPUgaVgDnFeVC0eSuU5bV6mLJbuKP/WRwRw/bPrs7cyRwYfpnRQZ90wQGSmupSmGYaMZyLG1BYYlIENmm4stwyg5TaFhE1e9j2XJcpEe8OlzXJPuBOHh3Ar8J9Vr3xCGCwacXSzIC8K8+FK3GMh5hlrktzQqbkfZ6vl+6fq4F6J50uxK08OFLahpYByoqYrUcPEnxtlaPnCEzESpomcTe4iwQ==;31:+ul5jPDbmoYtjzF9Bj2o5YZTAXiVZ4v58EFgn4LrQ8sG5hUWXwUcqhCWiZ/7OXx4f0xb7CXpVgQmCMPk8augAJVNKEKz9xSHplkJMIBqZwIfrRnIzFq0GR2/zzmtS0zEE2VWAFVBraNY2Sr3/SOEH1wz/wNMmoBgrU/frnSI+/gCYkpfxtpDWo48WF8MCPOiFn4EG5//AfO8Auh+F2PZgxTg4A9gLkUWewpbqpap3Do=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:yPEo0tzWmgvXqvakOHDp3qVVv0+Df7vmw77VZxfvy+nN8Cq0rGlMHKzPjlswWYReI2hyW2pQm1Kh4EV9OF7Dt2daaJsAav5GHhXNhmcc3bUxt6BSf6j4dzJN8HMTdF0ywzP+k9Zxd9mMycdaxzKtKmqieAuR2G2GpH50/CnwTjLwIgXn9JkgVRopDJYTVj2VqMRan9pLEhZU0nth579IXbQgde4Cv6A/zE9L/9QCBN0KSqmCb/ORz6ERpbtRSmDo;4:5pqDdNnV5qNj27oVqcph2hRZJF1Cg4MslJRDlPy+ENiN555RfC5mlr7i6CAKsh9cDmWTv7eTFf2jxy6z7ebgSkAm4RGOdPJKPA5qpWTWrkj54s8LO1mzo7ZQ+Vwv99iaeDCfPnCvlehMcO6nlOsd7P+zdT2jxPwHS0LavF3PxdYgygHKvVYmMeSCOvC2OA3heV7U7YchXcclmC4ZuAHRLBtS2K8an28WAkf9/Sg8U5lC71iP9PcK2C8dbwdKCfZCR6nPbiYbqBxYvWdrUlaUCQ==
X-Microsoft-Antispam-PRVS: <DM6PR08MB493980251D9E8F41C153F4A9C12D0@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39840400004)(136003)(189003)(199004)(2361001)(44832011)(66066001)(6486002)(6116002)(47776003)(3846002)(6916009)(1076002)(2616005)(386003)(42882007)(956004)(11346002)(2906002)(476003)(446003)(6666003)(486006)(4326008)(68736007)(316002)(6506007)(2351001)(97736004)(6512007)(69596002)(7736002)(106356001)(5660300001)(53936002)(16586007)(81166006)(81156014)(105586002)(8936002)(36756003)(26005)(25786009)(50226002)(186003)(8676002)(16526019)(76176011)(14444005)(52116002)(54906003)(53416004)(305945005)(478600001)(50466002)(51416003)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:9mzGHR1Fc5M56LqU/Wy5NYQKQRQrYcJ+cPVIallcr?=
 =?us-ascii?Q?bb6rGKB5rH882GpUoBsi2cCATFww9/sOzcZNmA3ACThwqLi8PzYQMRi/L821?=
 =?us-ascii?Q?3V0d2mWGG+TTyAK33llUg5szl+zq+DX+9zHRhpzRXfYuxut6Q4JdfQkpBvhX?=
 =?us-ascii?Q?ZxHT1vX+ztqMBikPLf0EUHinuVdXDtaamllz9rt+Q18Sh0YaNNpexgkES+6j?=
 =?us-ascii?Q?YLez9T5AhOmyG3i8MDJNcUUMqKuWV9UIiPX8p2xizLt+mEv+tKeC3o8yMZ1M?=
 =?us-ascii?Q?ry5b1KGgXzJSb7D5x/WEgWEOCYrdxjwt3Eh82cNEs19DnhRKsRcyxB/8KpOR?=
 =?us-ascii?Q?F8OEtgzZd+5PHgS6hvDA//QTqm7BAyYMFCISAYWO1MMQi3ScPOoFi/Y1zjOm?=
 =?us-ascii?Q?bZV8jT8Ec+hY3QKKAc3J5N+1PUTr2ufiEeM/dDn4+Kb3klIjw+2p8m7zldJw?=
 =?us-ascii?Q?MPK4ne71YIyA0RVMk996QPi7CrXPpwP2Ij9GIPlQpnVc0YSber7qOQIxB+6N?=
 =?us-ascii?Q?0KSljtcRONGYrpZ6wj8tOR0p32JPAKAFhtpLoYJHfwlwaIzWQMGboDtPxJLt?=
 =?us-ascii?Q?4pBucyV5vO/l2t5KKTEr8BL0TOKP7aOGMgqo70Y6faJRJF3Onspz7SGFmWqu?=
 =?us-ascii?Q?pkAevHQMuT/4E/0YL852H8HNK25HbcYqF94n29tNtIwXpLeR45U1VT1mJF/w?=
 =?us-ascii?Q?EDyIKGKsdPFruUSEPokZ9inaj0vbaJcSgExp1WyUZ9d1oH+TP3M89T7tvOi3?=
 =?us-ascii?Q?QH/xE8iAWDQvYlnly7n6sCtoLuEDFotyYFG0iYAQy0hRQIMKzUmW6R/NjYmt?=
 =?us-ascii?Q?TS7v5FUpzTCPwX+TyDpQBZoFDCG+8+7urQz9IZP2TjIgv68iLieKtaAU1vC8?=
 =?us-ascii?Q?8Mv9ZFeVc+kPS5ppfSS5LTcNsEgQuQIQk82zepM3rUUR7dnPgbOrUgvu0N8q?=
 =?us-ascii?Q?MbgER61EfXwjRPNOvSIZM9gatdXxoi269+4pbKwyX2fHy3DkS79vH1jAzno5?=
 =?us-ascii?Q?spmDvsrXq0LDxo5qq6vvbXH45YqmGUfpp5BT1tyyb1VWD5Imp5Yg9IQ9PXPv?=
 =?us-ascii?Q?lIkLh5e84AZaTJJwiPMS+FlWTphd/prhOyZGdq1E4DPLEcJu7Jqq2txTwc2r?=
 =?us-ascii?Q?V5vfJwIA2pKKDXJ3TMv/21RgSPzKkRbyJ7EZkU9OLUqtWxX/JAoGy0xO6kZh?=
 =?us-ascii?Q?GdUXowezQi+WvBR6xYMrEOD6TZDJQW5N5wuMd5sZz7MUDftv7kpicokGRioz?=
 =?us-ascii?Q?vPtO57DeeEVaHrFXYLV0rnRME5YIkd2+BNTU3Ft2SdBlpS15NhY9/p8wtxbK?=
 =?us-ascii?Q?MwQt7ayfh/B7rqFyXdArC2f6qCUSdLZTEdtLqfucXY8?=
X-Microsoft-Antispam-Message-Info: H8jhr2QrP4+iP/+BuKw/KzC53ylKxvsJ4avld/+/so+Bjx6i2VrliojsbXlH1EbAffQkIyaSJ7qjn8zmruhWKbEKcp9wGk9Ilqx+N6z9LHVRs5nl5oqIG3HGUPlr4qx6P9Nll0Z0u/CiqhP2pD2oU3kYUSeiBaxobSHGSiA2oUhHJWd6BvcBl+Pxjg2peOVslSlDihB7i9PS1uU6oFfFLl6MUK3Uo/pDAq4WRlR7sz5EVE4DWu95/T2ke52MoaY2lGBnbWPIJDXdHMdqBQWtuErrDMkz9KcroEiuEnfOSzVWz46guNzk67KY3BqqXckXjI/sIuGERWXLvofaaa5u70m1ALOWkJ80MrbSNqCvf38=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:CCASJS3SrVruIoKrU1DyY0j6jIywPxPj1xprDjNQHITce5plAc8c9aQ1ZtSjvObiHGAE2RVR1P57tcompr4wAo9MlXdB/B6V+2+dH48ikoeauxKYRAu0IPWtifaK2LHYYluGcUes4KuqJcIeE726gKWjtzAK9bc+jiPyJeOm+laQacBQ1tdHTLIfQDYxliXC5X+WrQRl7B7DSR0iyjb8D3MpKnQOxXv5oDkOWxxHWfzgU7XQva5ncRBlpz1r5cqNki1bcrSXOm0jDJ+LmbuOUaLGLusOgZ5C8WEl10UZ58ZIgbPdPqqlIlLvOg8uJ9+/PQkcGRZ6Xml7MEIfqLFh+A3vVxRRfHWp1QwMzYCzVqHGMIQWo5s/Rva5AZa56DdSsL5sdUVvjM6XluvLrw8sY8/SmrsitJmQ8Kbz+KjBoHTkRVDED/BJT1662o7oZk0zG6021Pe098SSRZxOZM+SSw==;5:A25BU4ki0OfUG25PkXeZww6lcdjXW8gvApfOaT2s2NmTrMEkEiHEtlYvnQvQsdQT2TM7Ufmz7o1475r6FEm09d8AD0Rpubj3O4Oa8awBIukojDwMmOQbsEWn7N7LWOkqYZUUHZzgA+uAEoaQdJ63RQsiE0NEiG39BwVdUOFJ+V4=;7:KgTxZJhAsBfeEu/V7ZbpwGYAwbDdNEMkKuLvxEd+jB8iFEIO087cgunKzCG2xh2yJxUcgJB/UEOjSyHiXO02zQkDa3ITA63cwd4/11KBxxkOB6dLa56acpCPB0hlDbQ8cc/z6lu7YX7kCgRs2KPm7CwsGefo5gkUNM4OELrC3Dj6rjNqeNbPMBSjPt0FCXHIfe38vZo3Lj8ux5q3ycw23k7zB6KVS4INKVMNdk3XZ4Q1rsZrTG62FF4zt4RePp4J
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 20:15:33.5794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c4edad-6c61-46c9-d3bc-08d5f7eb8985
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65350
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

The A() & AA() macros have been unused since commit 05e4396651ca
("[MIPS] Use SYSVIPC_COMPAT to fix various problems on N32"), which
switched to the more standard compat_ptr().

RLIM_INFINITY32, RESOURCE32() & struct rlimit32 have been present but
unused since the beginning of the git era.

Remove the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/linux32.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index d41855927996..6b61be486303 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -43,17 +43,6 @@
 #include <asm/mmu_context.h>
 #include <asm/mman.h>
 
-/* Use this to get at 32-bit user passed pointers. */
-/* A() macro should be used for places where you e.g.
-   have some internal variable u32 and just want to get
-   rid of a compiler warning. AA() has to be used in
-   places where you want to convert a function argument
-   to 32bit pointer or when you e.g. access pt_regs
-   structure and want to consider 32bit registers only.
- */
-#define A(__x) ((unsigned long)(__x))
-#define AA(__x) ((unsigned long)((int)__x))
-
 #ifdef __MIPSEB__
 #define merge_64(r1, r2) ((((r1) & 0xffffffffUL) << 32) + ((r2) & 0xffffffffUL))
 #endif
@@ -61,14 +50,6 @@
 #define merge_64(r1, r2) ((((r2) & 0xffffffffUL) << 32) + ((r1) & 0xffffffffUL))
 #endif
 
-#define RLIM_INFINITY32 0x7fffffff
-#define RESOURCE32(x) ((x > RLIM_INFINITY32) ? RLIM_INFINITY32 : x)
-
-struct rlimit32 {
-	int	rlim_cur;
-	int	rlim_max;
-};
-
 SYSCALL_DEFINE4(32_truncate64, const char __user *, path,
 	unsigned long, __dummy, unsigned long, a2, unsigned long, a3)
 {
-- 
2.18.0

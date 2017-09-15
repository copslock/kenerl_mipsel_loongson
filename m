Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:35:52 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992186AbdIOReDTauOM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ykL3sqciUDSTYg72xcLu+TG+KLtWHvhoaDOFnt0f0WU=;
 b=me5iP0KQKT4MlqpJB5QZ9/EesTKyUOWqVUSNU8QsZ6O9xZaYOBH6egnUZAaFHVWZoWv1brQk4kI9JmEJ26Ai22hYpUq1a/8kaDmBY9pGCz7YVm0E94n8u5p81mIj7oPfTqLkxlB+1NtrqK4uRsJEEzew4J1Rl69jxXzGpjPpb3Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:54 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 05/11] MIPS: Octeon: Update registers for new platforms.
Date:   Fri, 15 Sep 2017 12:30:07 -0500
Message-Id: <1505496613-27879-6-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:5173::41) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a5b1a34-f7d4-4414-9444-08d4fc5ff058
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:WHkWhdvFxEGCIwbGkEU0/FQzlYXQSiHGbl6wjoKiPauQLqewII5B53UqH+RHbMvZQB3678+KRGjxMV7NZD4F8I2ltUQEuddrxlWADqJ+uDLhAwcXqCh1WbfJRKF3Yv1IFAwrJikOUjJCNUSG+4pLrlp/ydKufCBZhUDdXrHpo67x+1FryHfDoGqXqZRICtwKQfO8e2fN89+gfhj7depuod0n3niazWyJe8dAhP6qHw6toZdu+2waJxlhtypghPDK;25:+aGThmnsWzgSZMG8QurasRSKUQl03QamgWbV5KN+qtcEwoe54RHOGR093ra7M+lbzdL3RSMaWYgGn1Ka8WGkDjU7/4uxjZ2sL1l7CUw6EAL8gWBuax5CwAb9/Pn0M7I4vpr0ycNGDCKk0h69Ul678M+GZ+Q4twJhmm8MQDy9GqPIvmMrjCJavdzC4XlRbwYZjn+K3LrO+W/RAfkwAVfvtlwqz4VUDYgE3AZkfMBoPOheQxh7Uq69XkM2+1cRcZXSoc83b62S7l7MJWG7taj5NFpGE60WMrQjs9G57B58pOJC2AvARbXPp9NKA0zUP0ouuMNsrqONFAZhJRiD5ekU4A==;31:IudgplnyCdswEBsbgLiBq3bAc5rm4Ww3HYLblp281Xghd/wU/b4BJR6SJGHzJ11ZEedxGjV6vqwr8XeA5j1iuLcZbJZt60XKDKAPywx4wSSZFxrkfWPJ0JZoHQgf1b1B2fMoVu8ZBOoTlERp4ym/KNiR0oG893MHdWHHytVcGJaUYcSXV74eAESMoSjiKgpYJG+vr1kD9x8YItOZef0BTQ6bOO48cGKBGxJnunKRFVA=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:JcTdXWRyWFvUvUVaq/ooywmNeotgd7ju4zWp2Yfxq6uZnTHD3hh3sM5irmuhhhxuebBzStsypdXlK4uGrBrAwvfnFTe7dnKRHEMIhw8cXI7+Dw4sovaV4fq3A1wZMvBBXke+Mbf4TGDda07Fg86whCUbz38tJwshUvtg+rmI6YqmlqHNdRDn3l++az/mnf+g6PHR23tqcfZcMryg9OkVPdy+mK9DdZjeyIjvwrj5NwivquwnGkRzYNzhhq9p0o43es1y6uP9iB/eINh8PYPtkazmN66SPbN6R8AiYkdGC6LI7M1U9Tjhdl2/xIkFe0ExdHNz+MBvbt8dSqIuCjxo2oVlpf6oTPmCQYtwwl/90Kdxuwfa+8L2xTNIiApZFmK9mIsbcPDD7N4eh0de5ryxuqiarj8OJCRRTqsNZFmwS6LgmEjqmkChAERZvSR9/sl9/V1QePilGPACN+b8a2kYBqjiXSCAKt2GqInK6jnDFXnKb/qx8SbaMYxlctBmNisW;4:rlX8HrrGAgUxOesnxwuN/2ZM4m+clIKrPehYvVQ04z7ICGkj+9ruK1rdfTpYN2b6TSG4DPRs6+lSFZB7bhRCl8y5eOWDqfkLQv3r4ZqqAOryU1gyPS+5PrJb8Qh0YFtjhDtmb3NXpgrZQzOmW0l8VWexR34Q8ecg8/T56jPhgfPmUu6G4vOGlr9JNNLyRYDQd74I0mmszNs+MZDTwr2SFR25gDqBBpCOtEqt22TK0+HJbxIeMox+LA+2Z+cAwoLH
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB38007191883E38BA12AAAC71806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(575784001)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:EKnyFlp1HbVfGyFMvSbYE3SuJfkXcGrf3VhiYAJ?=
 =?us-ascii?Q?aKM5ZhrOM+D9TuCMvaTsqsDOOKBwXt8SsfJQ4HGTDz6pmaFZx7OuG2bWbXfD?=
 =?us-ascii?Q?qGiNQ+wwA2QlrZjizun7vcNuz+2K4aeAN5X/6DBtFd435uFBAUTq4Vc8t9Qh?=
 =?us-ascii?Q?jDtoLBGAqMDG/O7hJ5iTYkJsQtdMzwHAwMIERm69mDz5T5H7QhqSr6GJAvvs?=
 =?us-ascii?Q?YXVNF7hQ83CEGl+O7GbGG8uJ2gS/GoWW6GqV6H4+qyBH+DfpZleJoFwvW+yf?=
 =?us-ascii?Q?dfa/hMWMjQpSjokjExLIjEKJYyYC8NBK6IdQ56Llc4Ksx7IPuXsOrVCMnzMW?=
 =?us-ascii?Q?SLusmxMyhiO7ar7oHbscfD08Io2kggPUfufELxTgXv1eBanLDvG/ar8jPrtW?=
 =?us-ascii?Q?Esy7bOaEHkO1MaoSP+DQlYRBtKVzA72NhvsM6ay47HeGZdmgBKVBDgEV8Wad?=
 =?us-ascii?Q?YMyuXC6guj/rS9yC1b0R1LRhDniB/4Ys1sjU55acCWTOhswkvk1MAexw45sp?=
 =?us-ascii?Q?PFx4bt5culfCMepvoQWG+RzYgzqoqMYRCsUMsAuar5AoSai5UF5OPUkr6RHJ?=
 =?us-ascii?Q?7G3OZ+QZXXg1Tg5EWjolSfL3WCB9+/m2lTvF2lbyDgpTgEYvX6PYGOeESzrz?=
 =?us-ascii?Q?qUoIPCaSNmLuMGnKkvKfvlpsA+nzHhnHgyq7H9DRNinj3wbDqfSPCWbS2W17?=
 =?us-ascii?Q?i8RChv9pq9gPuGIFQUU5gOtavUWQxxLYYGDw4erJc4iaf7IdqRijqvm8HvT/?=
 =?us-ascii?Q?1EcTiuuk8lbGfu3C9Wa7h1BwdHwur7X9sTomwPStfPvgoMPPtc6Ed3RAUOEI?=
 =?us-ascii?Q?QH8FgZ3CTGLhx5M81XidY2C1v+H2mBPTlQxIwUjqd5vmitcuxeuYpTTgllTO?=
 =?us-ascii?Q?Tozfk1/pf26DGTJS68ST0PkD73dDB/MnS4cmspEFWPQhAU3OXDtuKLfJMLRI?=
 =?us-ascii?Q?HbJ0/ERJtr24pgt/Uzm94BJRehpS99nnwI9orJbLB73oV446xZnrF6CcX3Mq?=
 =?us-ascii?Q?fKsavVitlfHYc5EtbIpusKK/i6ieH0JHyMhQUZU6gqVjn3c9lYc8QfYE3RsG?=
 =?us-ascii?Q?DfIQQgokExg/LTpv8Z5KYCB+vT8Rkp7PKqjbxTmcsdvyuP7UHRGRS5Grpgwl?=
 =?us-ascii?Q?Whw0uewWPGiIx+VtMOSm1XiXzHuK9p6lUSxMwZBI9TX2bHOwCf5CadhSHGEb?=
 =?us-ascii?Q?M0o++70hbPCBrxymm6uSH12EF70h0apbH+RL6yWDZ8tB1k89hFan8Mz8MhA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:ecGnAS6hq/PGxv2FUyFU958Yp+iFWRaqMoCmyliYffcWA+KNvwPxCEt6Jya6hPX0eiAWo1M3HRD0CmRqoXELlIt/TkBtyTT3g8GOI5eqA0ZQxxKPRN3r5KgZDeoMjG0mZewiVQhXt6GCcAVzCzQErKbqA86+C4WypCfSda1f+KxIrB25FC9d1nWHvoesbkZTU9Y4lHJliv7WzhlEiCzsCtaoGfF6FQmltAf2tOyWAEdBntwvNKA3rTMd+bi/6j0bi0ej+1OxJDTD9uAdkGQdtsOrudAvfLj6oD72t2GG4St1QpaqID/DD2VpBR9dJzvzAFbnMQTDiQjoqE7VdZczrg==;5:n7GHJSCCiMyB4p+hEj/8lxeiLbNe8ViOsAtwaTk0Z6r168R9utv3mHdo9/qqLiINiJb6s0W+evUGGD8/IgouqmytLtufRMH5hVadTOLb5yZytkOT7QIdIQxuyCKeKV47TnNQXVKMxk6Puu5rUMhN7g==;24:JemMHT5mWr+rjbyzHm0Ugu/TXL0KaL8CLZvj7Pf0hWl/TtK6NaxiPgBpCNqPnzqpzV7xXWaPKGm0ZFbeFtXubj9YNJsYhTh6rYM0CYiPeDE=;7:eQQ0/Yk73ccZ4z8PsOohhGBmt/dnNrzhSP6+mC6KwfNMdemPv92hCIUYxo5Qzb25/TxbNfJ92ZKsFofbdSrj30zEjyW1pRBcXHNIu9LA2QmTD9SdBvfIPwoyYYL7NIz5rryTGTgQu/YQiyZ6prF19cMIm4EaoyzpceWWFibOhF/ZzKOtDkD6R3MN9WglDaIif5VBGR9Bg2r7EcZLs/tqxeu3fLDSkov20BHTEYLY4Z0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:54.4262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Register locations below were wrong for many platforms.

   CVMX_CIU_FUSE
   CVMX_CIU_MBOX_CLRX
   CVMX_CIU_MBOX_SETX
   CVMX_CIU_WDOGX

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 132 +++++++++++++--------------
 1 file changed, 63 insertions(+), 69 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 0dd0e40..24749ea 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -43,7 +43,28 @@
 #define CVMX_CIU_EN2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x000107000000A400ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CC00ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AC00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_FUSE (CVMX_ADD_IO_SEG(0x0001070000000728ull))
+#define CVMX_CIU_FUSE CVMX_CIU_FUSE_FUNC()
+static inline uint64_t CVMX_CIU_FUSE_FUNC(void)
+{
+	switch(cvmx_get_octeon_family()) {
+		case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+			return CVMX_ADD_IO_SEG(0x0001070000000728ull);
+		default:
+			return CVMX_ADD_IO_SEG(0x00010100000001A0ull);
+	}
+}
 #define CVMX_CIU_GSTOP (CVMX_ADD_IO_SEG(0x0001070000000710ull))
 #define CVMX_CIU_INT33_SUM0 (CVMX_ADD_IO_SEG(0x0001070000000110ull))
 #define CVMX_CIU_INTX_EN0(offset) (CVMX_ADD_IO_SEG(0x0001070000000200ull) + ((offset) & 63) * 16)
@@ -64,56 +85,32 @@
 #define CVMX_CIU_INT_SUM1 (CVMX_ADD_IO_SEG(0x0001070000000108ull))
 static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070100100600ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
+	switch(cvmx_get_octeon_family()) {
+		case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+			return CVMX_ADD_IO_SEG(0x0001070100100600ull) + (offset) * 8;
+		default:
+			return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
+ 	}
 }
 
 static inline uint64_t CVMX_CIU_MBOX_SETX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	if (cvmx_get_octeon_family() == (OCTEON_CN68XX & OCTEON_FAMILY_MASK))
 		return CVMX_ADD_IO_SEG(0x0001070100100400ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
+	else
+		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
 }
 
 #define CVMX_CIU_NMI (CVMX_ADD_IO_SEG(0x0001070000000718ull))
@@ -174,29 +171,26 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 #define CVMX_CIU_TIM_MULTI_CAST (CVMX_ADD_IO_SEG(0x000107000000C200ull))
 static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
+	switch(cvmx_get_octeon_family()) {
+		case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+		case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
+			return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
+		case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+			return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
+		default:
+			return CVMX_ADD_IO_SEG(0x0001010000020000ull) + (offset) * 8;
+
+ 	}
 }
 
 union cvmx_ciu_bist {
-- 
2.1.4

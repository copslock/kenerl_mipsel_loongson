Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:43:25 +0100 (CET)
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com ([104.47.38.70]:18650
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992724AbdKNEjLjbPq3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iyT6E8MwSWy3o+OpAkGNKbDj7dEqlohqSEZv0wzPtJg=;
 b=E+FV7uULwC1usQYhjh3Tb2OZ9Z9q1yHMXzjPXl53qs9PPU9cY+/EQFyg2DZQjGoxUmO4tdnX3eFzbd5ef3ZUsXeIWJwfoKZ/CGkEO8cNO+uBg7asu0YMxOTyH2FTQSZF/VlS3RVh4RwkiDQpFbXOvxtrhf6w8XUvgx5k91x9COo=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:53 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v3 02/11] MIPS: Remove unused variable 'lastpfn'
Date:   Mon, 13 Nov 2017 22:30:18 -0600
Message-Id: <1510633827-23548-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::14) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ad40f81-fbbc-4190-bfdd-08d52b199c5f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:jdie3Sp2Z/n2kuIcXYLb4VaRSgIkfVME7Z1+Qo1IL8sYIC8tWhqPJA1TaX1IRRiZ5zJS5ZkNMK8aYakDPLXCMcqQR3VcLsRM/13Zb1NXIRhflVaBM4FNEbzIk9Oddj4fwT/DqMAgWRiKis0/hNAafWjJT0IofyYZjwgkvSfzVDYdwve398trdwOf/BKqb83o/RWFf4TUnrS2PtvglctKDJlpQm9IgjA1CqIsWwb9kYS2OV1YnTJ36o8zHMRvV3Rt;25:i7Aa0jSZXRE7lU+5UGo11JUMZSdsvb1qYbFVo7+GrCO4uZdsK7mThTOHPSPgPUNn14OCR5uBR4hsgzkDhtwG8cp7yFgNXQeOGqpjwcf1V5061U7eiM3YHzCN2fTftqyMlkasEhJdfOkAONvclaEd3lH6yIOjD6zUwygbxO1umYhZ8OgaWxvvEzuMh0zKVdo7NO2pRlBLDbopCegRTFz0fJq4RmMlMhJtbbFiRtD54+E4ESfRzfyFb/Sq1q0MEqQAYonzjGzKCk5RCIbQ6JB4EI7N3Qav1brtfdrVBLTsuIBEatAYG4HAgFWTZu/V0W+5R/RclwZlDo3LTN8MTUnqjQ==;31:2zUi3058jRKJO/PaP/vjLuKUWbfWxD9569OqWbF340GgZ3KKRRVvljCidz+YyjGF1tg2n84EjaDFra/fEmBFsi+23vNdrA+qFKoOQP/linzo4udtbJa40ExyKABpf+LzDvTADD0uD69im4apprl3m4Yc3XQ66u7ZFxCVQ/+y1cnfkIC4de2+/bG8kxMXD+HXOqHaimm97vLvigdWziAqkuA6WFkQ7CRPvspTJw42F4o=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:fNkRrpjvD+yOrkV1U63+g8HEl2yLBhHc6rw/jn3LgKEtwBqkFl+uxybzwMOaqc+qIz8OXw5n94aFczfnks0a5cWfosjmPkGrTbLC+OZxbyt31aPlgAuI3rEn4SsiP6VfNSS1Bg7SkEkDzxestGL735GGchsl7Oam3MaGga8v9xjlVu5Srn9LiowgZZOu8zq8xN5Av5aF3wopZfNYlVBfgF9Bg7o7fYKug5wE4CfjW3zWLwUvT8H4wpgtPm/FZ0RcmQmc+JubGvZpHPZTKN/6Qv6RSd6EPrFP1ihBx8ipfFiqpLQ+BovMQ9yiXFQ8l8Q+XEWaWNreNZgHB4/SCk8d5GEgDNRaOsL6jEr1MLic5/EiUtxc21TpqVAaBEHd7EQKRUcLf9Amviz5FaJ7tgxYW+Wc5+g09LIjSugyJhjVkqXfivfUcZoXEKPAQCYZjX45NG+dioWthpHY/VlsEqNCgrr0nA5x/qTfJko1/Ap5eMvPYQQON8pmLo4Z3onFYm3r;4:8Npoe4m5ry4IJb/fdYNcoEt4DbFusWLCqEbhcT+mBpCL0aKX8Kw/v2vZYBEM4rGUS0XV6vvuL6ipREsIrLf9JusubiMNNC9VD9kD0tmUGYfLkiRXtqDl6e5/njA57C9pIsfVjL77Ya7gOpky5gAVbH/Rj0SXYqFiCPRVIjSj1Jyv316D8rEAM/0LHYqdRXXXgkaSuZZWfDVt1mfuGnFQbA8IUgKc1I5pMSGKd+k1vP8Pfm5+9x6tSZMrhA0z7w25obgdpElzRyc4VGxuQYMjog==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3806FA806F26DBBAA17925E280280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:orE/h1MPVf/7ZszcxNjjQMFiNT5JfqVLZVkFzmo?=
 =?us-ascii?Q?VHIidaPwpy8TWVWQwrJkyqOOq0Zd30DOFDtFHaVy3LJxBSiodU6XIYNMdILg?=
 =?us-ascii?Q?SkvasChLVfXQKqOJxmzNy5sgYHX7w12WNrebz5NIdHFSY2BRM02EZ6K0Bnj7?=
 =?us-ascii?Q?YF99oOp5YrDqgDqYI8MxvsKSRjefs1jhMmQLofFThxZ7J0d8EuOpg8gKxJEi?=
 =?us-ascii?Q?UwgbCnYv/HkQYxgKaDtQsHj7qYv0yC9riBrkwFLVUVqVZhPF/yDUjC+x+NO/?=
 =?us-ascii?Q?aKtl6R1WGZhbygRDyYf6hrB+Ma+J2rtuU6007ZY0XzNKRB92Q1mD2X7zoUZn?=
 =?us-ascii?Q?w0Ks8mkjWTQo87znjlDgXaEUZdpa5kzTG3CgYikhAeWc6cbY598PSLt9WrnQ?=
 =?us-ascii?Q?ymAHTWmW+23UlH8ePAtg3hmb+ezXmsB0Xzu7qYaQKarH97hP9diJQwMhiXbA?=
 =?us-ascii?Q?xb3/dZo7Mf2Vn9UMzs0w0KgGF6mQ8PhgQ3hiAyeJbMBvr20Kuo9vn2oRlLnN?=
 =?us-ascii?Q?gtfQA4/7VNiUb4MnfrkRNMWfwgfoQDDj4rYZWYw7+8wVnG5mfGB/ev7YYa0H?=
 =?us-ascii?Q?vTrdTzsIXP6cJuu3Gsny/RkiCptrbkdC8MbzW/L8XKEHDeIPRMzSyybvJcO/?=
 =?us-ascii?Q?yYxGihHHx4O6nFVyarEGZVLkr6gbsvoNMUCSPHzyan8TlRYyYLU1zOGzUgSV?=
 =?us-ascii?Q?XA05W2/X1N0KYn32BcKLjb8CvRP+lBgFp9y+WCMDAZTBM5IJaMoJdZy4KA67?=
 =?us-ascii?Q?jNmA1gDlBcKyqVvB77/CVZGj1JhGKv++57VgcvX2ISlQqlHPQxB9yyl5SJci?=
 =?us-ascii?Q?U6k67UhsK6nveMXNEzlqWWNZICwZx3SR/RVbmtaL08MwHD07ptObdxRPe3zT?=
 =?us-ascii?Q?gHtm8Wkls1JVFz98NsjKn05J7M/jeBnVqQRxKed/NjbYQ0GIEKmvp4iP6KkH?=
 =?us-ascii?Q?2iMVMlEV1rfB4ivuVklLmMwq0o2E1G7ZX6BZsS6dHFDBAAVQUNCif3InV2VC?=
 =?us-ascii?Q?YfT9rYwtgk0/1D8n6Tgz7QmVf8GKJd4zHFJxR/q7+YXwsUaULOINqV0DmnFV?=
 =?us-ascii?Q?1HqgoyPChEtWbR2k4SIm7Ruk+os/gknPUk+2pjZoynSu+ox2lnqaJI7U8cQ3?=
 =?us-ascii?Q?S6p/6DnA1XGHiTuRBpwJhh17bSI8wbMf4xMZcdc+04t/aIYd9Tn/ktxuvPeJ?=
 =?us-ascii?Q?UHWaeCNMsRBoQlu8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:L93VJAVtyUeq0yqrCB+TMZaF47zBnLjSxI6oeTiLMnGkeyeB6h0sDlcbNazPWQBqzS7EnmpFdRkNtVgv2SNPsaFSHT2veErCKEsUa/bvHlz4OpM5lWJ25cFttWIu7q2yTCxNwJEFWiXOgTGC/LF+g0fMp9RvWmALoxGWEIXTTwTrQ7ZeHUf/4chE8fx0j0yU0YqyqiSxVdMtszYWjOyqbiO7/SteR9FiiJDIcH7btetJERVEQyt/v4vPOIUsvXLvSkKDVsO+smcLLORSeLjSuG3o97NuHuHmCUd5b5ifC0mHiGoSViJ1vLm0pa9q9tNciYjswp1iqKInQNWsI4M8nmZ4EbTgZIc5FwEWmQ9qkdw=;5:lOU3CAWpn51psNBnfbB6Thr30vQkCt5yNqEbaut+Pnd0dq7ydmViFAWePVGZ5TUi1VwQioeZgE2H0S46m3v39PZTq2CS/rqvmMDrhgFg2VPqfPqCUZ0I8OGn3gPuZitRg3oF2PKK1eQ6dQX9mCsSI39ovVtJAQOPi8Bs9GFfE1U=;24:9GHTNL6uYs/74vPwGBgFNugYwJcRoEzkRmYcAL9JNlR1EJjxtZV1GFSqshOQFgU4PYhCyQ+qrUtCz0qqz8ins954ZLd8jFwXCHBbsnQUUiA=;7:6ykojG9iZ/Fpw25W7TW1IHc0TuPSl6nt070AhAR6/QELpY2wjI2RGjAzo2VV04+qshW1NpJ7pv+gJg3HooFsMU/SAd351iBlbBRZoIs4P+Cg7IIeH+kQLL+aQGNWzeQ/qhTegMh8Ag5VSFH2MaCj2fcBzRVESYA0C7536qgGmsAopF30fb8Df6Xk1MYH+jxIop2/qRdakvfUBEGXF+rMKtb2eSoTSqB2jfsQdwB+dFGl33vdSirmNlEj4x3G/EJ3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:53.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad40f81-fbbc-4190-bfdd-08d52b199c5f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60903
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

'lastpfn' is never used for anything. Remove it.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com
---
 arch/mips/mm/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 5f6ea7d..84b7b59 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -402,7 +402,6 @@ int page_is_ram(unsigned long pagenr)
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long lastpfn __maybe_unused;
 
 	pagetable_init();
 
@@ -416,17 +415,14 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
-	lastpfn = max_low_pfn;
 #ifdef CONFIG_HIGHMEM
 	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
-	lastpfn = highend_pfn;
 
 	if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
 		printk(KERN_WARNING "This processor doesn't support highmem."
 		       " %ldk highmem ignored\n",
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
-		lastpfn = max_low_pfn;
 	}
 #endif
 
-- 
2.1.4

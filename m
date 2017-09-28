Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:39:38 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992334AbdI1RjHEtkuF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Eo1Gj+kXYpnQoQ6YzznLYBCc47aFjUNqw+I/oObZVns=;
 b=U+vlt46HOybYTqYBqmG7eS2Y1xblkmeZrvJGHA01YqRy+9swrBas5k67VCLvT/GQRhSDL2dJXM/vT84V/HH1hHtnxsaeqCIQ283ASTikVq8tUWEzuCR5MmvkZsIdv4WeEKufPYBeZ353TlIWHc1rIVT9wp090h4Z7iWcL7vor1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:38:57 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 02/12] MIPS: Remove unused variable 'lastpfn'
Date:   Thu, 28 Sep 2017 12:34:03 -0500
Message-Id: <1506620053-2557-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db3532a1-3661-4fa7-ea15-08d50697cc54
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:mPWM1YsW8A5n1AegIAdpLcSiozchl8bFGWQvW84to67J+1XQe6E5jW0lIbKAEn4b8n7tlFh1NbMjFq91CHMRI7WZ27hShsBQqYk+MuSxY3gfTsKHy6KuhTOwhjBCDQsutMicIW2e1B6sVeCZH6n5B2MqsfHiDubZ6ORjtwlsLUqOtgcS/qgxhc34d0FKyWNXPXSeHnAo68IWZsIFYxW0QwIejTPJXFwZ2YViskkfwze+/mEXvQDXlXPjhkE7ijDy;25:X8JiyfniAm6mdyxCoJyD2Mrq43k6BKyZY/TmIRysfCn5SfrNFo0MDGyvjvVoR3rCZh3Xs7YRDBWWbQ1QGlTbrvTv01cXbio83KCHjLv0T6sktidEarU22nvfrR+CvcU5//8cljtEjv4/OiB8IGuAnPRprC1vm70rf1yyNsTl9m2nMX+9bgDEZkNXF3REZSm8O//ryqMLglp8BWk3TLY7K2NUFdtpEJDZpUJQPahyyYqRjU1d5hi0M1vyQJVUk8R5tyP3Bsf09k1UaI0tgAjfkuQA6/FdppFVJ1JFUu2kOPBHbT070W8jwDzrBbRXuZzrRGDqpePgc8moJsnPfo29jw==;31:Q6QcFf78RkesMZu3kvtTQ7ByrPIefcMBYWaZmw6K4VC6IY7EynuLFHgGVM2HpMOYZjvlf6CFhspIVeFzhwUIgR5x3VDUE7O4YKEcKhrFWbZNG4HsKJl+2pEs6ndwagFUTUaY+4V6OVpFdkZ/xPEgU5g2x2d+rejND4hVTTLdKv6r73cC1uFHpfKQBKGbv11BrvDFjAsHDQXoBqGEmD6PrblgQbXoy2UOtm7ca08rom4=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:xRlyhsvWIL5DjzdAXkcPQ0OiCyz1C01zhy7KeNoLBQ3FN0q7/7veOmK83QY9K3wyJYCBpexkewqjqStfwtaLLBDy8o5m3EmKg5utYt+fn/oSDVFMO1ORXbC8V+ytQhg12JE5FDQv82ecA91Q5saPDi5YPyLFCrfw8NxbIrzaPnBw2ufTEN0EpU8azdR4hLpL2fB4YvkXJMcAn41cK+JLe+YBencayY6caMo+aJ1w2cUT+/MmEuEMmNf5DW0FbD9e9hYGJYA+4ahJrJObECa/88nYhGjpQSrhllLlciwGYbkLtDOavdJP0xved5/U6uFrra9Bjmni7OJD3Mr04MaCAUBzgjIcwgkzsfEAiSd9c3z7GuyVfNG9pJzo0j36BhTmS84l2v973qpAIf45WpbY6Ht6ww2JB8UYfo5FN1EMzIi2MX1PH79GfEI5mng1E9h/6CQUME6mt0Az+jls0Ij8J5OuaJtnNenrZ20pcjF5K9XkoWCq0vMFGUsW1eTRJ3KQ;4:OOly/DcCsd+jYQQSFxoE0Zybw6vvyG4AsS6Y1moPD49dd0exiXwMB2CG5C86ivdN2LZHbBmKsfFIwJ9JA+ps6s02QNbSlR+P1iY74DTpIKn5J2Jtfuo9orFGuavVdk4ZjM+Kn9voayI/lExPhSaHgPVcw+DtuFZIMVymTtEsIsqY+agtIFqdKbDLEcFBtcfWuaJeWEqL3rmiI4/QalIerLguybOQEzhU1inHXahoSSkAxvpplMCjnecRLsWwKraa
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807BC0B88B7D87CC00CA95680790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:q/7bMhx24jWruDJ/383bju4viwfEfUWkoV5JFmI?=
 =?us-ascii?Q?JzscYocfIKoWtS/2Os1HrAoXvT76lZNUgnSlvPAJbSymW4ttFjobnXnIWUbJ?=
 =?us-ascii?Q?QG4ZSht8xEoMd9MODdpfljDiCRU797nLKRAY1h2Q0E+w2LlqbHMwtKtILNzM?=
 =?us-ascii?Q?cZnQed5Qso+R1G0kx8P9QpOY4IYIOm1UOyX36bwb/kmaU5k11iCDoHqjQi9Z?=
 =?us-ascii?Q?q6iD86ddN4RcGqDAnVcaZsSabZ1v/9UhX/aB0g8gG/Du2O/PtFILbyZg38JX?=
 =?us-ascii?Q?F4b6R3+eHBE4wXa10JPS2PrwB2aHmuCuEHhdiTesPP/hX9UPYIxRiTz/cmF/?=
 =?us-ascii?Q?K8r8y9kZOA2vGp0Y/5zTyqwFE9uHvCkpNvV7UtlZmmuQ6UUW/m49KScsW+z5?=
 =?us-ascii?Q?q3oftxe6TqVJ/5+Om9856ptFBVhdTc3fPZf57RJ9YOE5lElWG0/ZMSAGs1i4?=
 =?us-ascii?Q?x8uO9moKkYsQ/VZM0s0Kf7/ZVGydWBGa4qvYXolraAx68vy28NLgBPm8Io6G?=
 =?us-ascii?Q?m1osvWfRNV7rVNee0S6EQgFLZPKO3ClCkWceFB4OT086H0QzqRoYu3FFjXWL?=
 =?us-ascii?Q?2rzEz4MUjI97NzoMYzA3xKiL5gmgouN7BnEYbyXBUzkUaYuKlfl87s0Bv1u5?=
 =?us-ascii?Q?3A+SLj4jx2Y3lVLHer4lABdufb9y9Hm7Tweb2n006naoFN4ui9ur1o1+OCas?=
 =?us-ascii?Q?29m3AIdPvGezeXjrg//JDzaM2Eby2D3BAB3olVlVbV7pf5++wduft1mZEFL/?=
 =?us-ascii?Q?HUJSkaOJ2SkngSFzipu07L7wTtuxzXcbYQn/and4mRXMPXx9SHHuaGiITIvP?=
 =?us-ascii?Q?kL+rWmOZ7LGsX4uUXl8ZXok85bRPM+INdxlDnoOwuB+4SQ3/gfTgrv5ujXiW?=
 =?us-ascii?Q?iNlI1i1u543LS7T5+DDQKCr7RTrYSf5hUaU0C31kwuzl0QK/e47IF14dTjxP?=
 =?us-ascii?Q?F/a/i37N/eOuJt95KBUZOtoNUOY5NFdfOJ6wGNauoLaI1/tSx9t0EMuFB8t6?=
 =?us-ascii?Q?sOzwOaowDxEHIN4424Spefp4kfc1YppSZhFV8yDBiabwIMQRv/jO5yQqBbO2?=
 =?us-ascii?Q?tjlBcCSV1HauvHKTHeO+pR9vi9NpnURYPFinNWBZz00lPSWFKqbkFHAy0sMK?=
 =?us-ascii?Q?Ew1jyo+EF4pIWSoWJ6bdfkyf3/k7R2RdXWeXjMI/6REO1JGnUkaUiMgzfgye?=
 =?us-ascii?Q?M40D0/wJ9Ej5d43Q=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:M8P/ggmuqUoB92LOL8lZewdGg6qSr53ZdzAAkbZ0E5vzfy7lgomt2QBYOG2PQMdrsFvwGHqKE6KcZmCGfeqZzXD0ZXm+zYujaHsx2dwnuXan4hdkvOWR1xguvKLVyRTXp/Xg3Gkt3F72s5k6vgMiS6liP6D0pb08BD3GtKISJ1oNYSry6QglbvPCoBBdXX85O8bc52RiAE7/yXKIqsmBeY/NpC6sqTmjaPBz1spZt8S1BTe9692vxRYQAum8FLSE1OG398PtFL8ac/TIKxJU01cOMj1y3Plw0GFYgbC211nyRC6XKiUHqEQ7dwPTNt/t0sYZMQAc1puCokzuYfxP8Q==;5:otPS2AS7md8aqOdhYml6OdJGN33QfYfoKJEH07r250AFQXcsRuu25Gu0/ldMvCIQZjyEmRFk3M21SlNJR6AkqpiGtikP//upygEE4j3kaOeoXAy4QkKDMnP1rx9FglTjPYWaOt+vB5l5J/GrdJSlCQ==;24:fJbUQR/q3Ru2sl+bqUAajOFh47ehkvgqzZ9OHjrOkDU7Y7njm390+g5Bm9NmzB+TurWTrUIpRpqAEBrqflGJt6Z97rTLK3t40YNFzm+h/zE=;7:ck8C3vtT0oILbv0VeXeDFJWvAWOx1wqOVU+iMf/eGwB0JwuHp67EMs9fSj2RSIRdRXjmClV2N2yE5DRuxLFRRFauspe6HL95m5ibfWBcS0yBYtfrUJLmDFw1LMZLZC4eLMFQqSkQMNAYmSn/MJQWtQJTdk/k3QUCw7AOrxGQxRjMjJJCxnb/CEBjG2STfhRc0XR8srg4zqP98uTpx33F6bPVVqfBxKWkq21V02gneDM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:38:57.7926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60186
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

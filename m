Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 10:06:35 +0200 (CEST)
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:40096
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990505AbeGRIGbelqg3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jul 2018 10:06:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcLFni6S2fBLTjeZwLCprPnNREPTxRIFvTHIiCw+FYs=;
 b=croEc97JJN5ShOo1kqNxpXpJCTzz6r784oURwiz1VICs1OVKasD13ev3lLFJbHJ5NKqTl6Q57KNiZ6qnL2AUrPwCujrQy68bLake3Yukb6leFU4ZjL6IDTN/GuyTNqQebMLmOfZbdN0tO07dP/VbO/RYW21Be6PMEPQwbSRsPgs=
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.20) by
 VI1PR0701MB1887.eurprd07.prod.outlook.com (2603:10a6:800:39::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.14; Wed, 18 Jul
 2018 08:06:22 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@linux-mips.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH] mips: Align prom_putchar() signatures with header
Date:   Wed, 18 Jul 2018 10:05:56 +0200
Message-Id: <20180718080556.5067-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: HE1PR05CA0387.eurprd05.prod.outlook.com
 (2603:10a6:7:94::46) To VI1PR0701MB1887.eurprd07.prod.outlook.com
 (2603:10a6:800:39::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e23916-f527-40bf-5f6b-08d5ec855a30
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600064)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:VI1PR0701MB1887;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;3:mEwDk6HvWPJSgpp3LuIMMole1Lv5p94enX8+dcd6oAzA1ZZwoC5mR5qnBhK9GbaxNg5v3lppCHgIx7wjjVH4mDOpE0kXOAPoi0s+i53DT+rRN0xGN0wrz08vRsksucziSVzY0RVlQLCvTjiEU9oKupwJ0vVJ1tIwL1fIs6LbRk5snarfxUi9ArNwrn95O5AiLyE7ijcxLNyAgr9EVF7/y9kLPYGcHzwtE4T06Y+mPSDaWkJPCzqN7xFVuV7g11mh;25:dzCYXJ9BVdJbLuSfhSpWlKh10B28v9XC6+LX/F0WJZ0NELUkl3ChdJbN4KvYnvZ6tG+X9riFn29+LMVMTw887zPqUtqJMAf1lkwNxwa2eYATMhrN4wglbNFDnmg48wUf+9sInBUHv/af1NrM8JMLJ0iM3ZzRCy+E8rOJdCH+gu6E/km51h+js/aa3xNEkJbXj+BMxFUp+7SdQZvGO2LS/B/EzdQg/BJEMQ8IkMy9uIQctV1X48zGaDfa8jy2JSrT0leTDVT1CisEwI0NdBHZ4diPvggbXlEFqD53o/CEK2/cV5wCsAZ95DSS6oEj6Ypcb4tt4HEkI0q1+2k7nYkzNA==;31:oLUw8rKMkU04LtCAXPE/zDH5fcW3v0AtGOqUwMVFKim2s04MA7AKTGu9KO9nX1DehtXBqOVHmZw4ct/HXnWDC6KGXeLEkYizmLYlWH+LKlyvkxcYjURNsszri+VssqAIw/1JAMsxpG4eXv6stLDX5Pdsbnvi9AECT0QuHmPeOp9y2iZjNtJA+xFBvtu3Vbg0Xnz0F7tppTLwwnbm/RlAEgYHhu3CiOoxodwcMH2YM3g=
X-MS-TrafficTypeDiagnostic: VI1PR0701MB1887:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;20:0OxBed7IK22pkb9yUUnX4DzYbgvNk4NiasflreS4DcVCa7TjgTB9OzqjyPymsbwK6iZS5y0mdor1M5NgIgNiFjGtjjX3CvXcI/L9sUENPi64fo7ah5tEAK1ZEzv8pn6R0oOAjeCS/xEetpggYXQqnvcjLh52z4ndGt2t94HL44/e7bKs7zdhrQeTImydNH1/YG7Vdd5a6aUOqP0Fy73j9gSANAeIASdyzP3iX4K9goRoaJKxDlWFHsRBjP9L/w6/8JqgWGTkYt7gyQmPZMqDNG+aFoGz5lhXmSxVQr6gTB/XbdKexc+1/OQiiCflbkiTT/3OluBiZPL3c9QE6tBDy9ibqW8Nq76UYxAfgPQZESwf9MO6/0iUizQNxjeBZ5XKWueHkWBEpsMDf6OnKzFe+JQCCjtd/UyFE/VPNhlycadu/CcqqC2VkObtDvtXO1bfYhMaJzK1PKRxYCjTZEaW/a08CVihH9pOajVVaXvs98SpWdHrSQjlYgt9VNSEYfBqJDC8nHR8zJk5HAC4yzb3UpYGQeVNNbBWop35k0WscnVmeyrQVYdSA9Hv/P4bJS3jCAeYoIQCfMmGQRi3PrVvY2bcR04HNokWGv9Aqw8xxm0=
X-Microsoft-Antispam-PRVS: <VI1PR0701MB1887403E8C08B0FE3FE88DA188530@VI1PR0701MB1887.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333)(195916259791689);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0701MB1887;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0701MB1887;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;4:QnCwL5Sez4uy+ZbWkWsmbNHzsOzpGh5bP8+2Qm1J5aodAHKajlVqaT5og5XXPC+JvrGvTf22K5rL5n/vXwUmp7sg/deWrrslwwLm0fp03pZ681XR4KBqaQRmJcnTw8qvQBl0tdqRQJZHkSqVV1GoBr//m+Wwam2sFhpZjz06y1rYrUMossc5fZdBANZaruGCJre+zUqDRpDe3kJ83/w/Y8gCruNmkwpyWV3oA/wH5yXR9GeD+9QAS6PMP6AtZNu7gLZwVT/Nbo8WsuYaZvJ4preq3BRkymTX5ptOWvhyBanTuAOLBaz4LP3Atf5LLmPUzmvbEh/MesiIrNIwnNIIIkF5hPdgNoOjCVV12t6X6+hHPTmSGTFlsOFecIOB0rea
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(346002)(136003)(199004)(189003)(39060400002)(2351001)(6512007)(4326008)(97736004)(6916009)(6666003)(5660300001)(6486002)(2906002)(53936002)(1076002)(2361001)(47776003)(66066001)(386003)(956004)(2616005)(486006)(50466002)(48376002)(105586002)(52116002)(476003)(3846002)(186003)(26005)(51416003)(25786009)(6506007)(106356001)(44832011)(16526019)(1857600001)(316002)(575784001)(86362001)(8676002)(7736002)(16586007)(81166006)(6116002)(68736007)(54906003)(305945005)(50226002)(81156014)(8936002)(36756003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB1887;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0701MB1887;23:2FHzYDgkXrWv8XYn24vmzJ7lIQtYtExX5GMoGz8?=
 =?us-ascii?Q?vOxckw4lENPxPYaXujpb5neLSontLB6mHNyaq4icjR3kPoz1SOIaY+PUvPZ9?=
 =?us-ascii?Q?FPN68tbCGDLueaMWLVbA9yEGT3RclFJPhb/vRbmOUsfnq1CoWJQhF1sq2y/J?=
 =?us-ascii?Q?cEAz4H2lqoFLPf5kOJGPHgAn6VLnMvmSjC16olZax16QsAUvjFjiH6RbMlMI?=
 =?us-ascii?Q?du6a29icWw4MGjicOJZ85Hc4Cqu52MnBYOHx/yO8x/WYAMrW91Csw5FpD/5y?=
 =?us-ascii?Q?/g/hAlW0VrexllwY859VhJwPCHGT27BkaUWIqZYTjNpk8v3D53X1t94vxtto?=
 =?us-ascii?Q?NtMYGEHS2OwGGtn97AS4HKj/Y6i/L4d53h7fL/CDOgNZ8R9M7l45g1YACs0K?=
 =?us-ascii?Q?F/raZxyFrmkBTytnx3VbCpYmx8JZAJZyiJInpOujupx2S08fF6yRfNw0Bk7g?=
 =?us-ascii?Q?zvo7okL/Y2Zy1xlQmFpHkOd5SBAZiMPMGga5uHk1HKhA8GN0wLpal/7A9/hv?=
 =?us-ascii?Q?KHrqilwlsJTeKXCYeaGZnSFB2aWD2DZNWT000+hTlV/pAp7iQQaSLSl1gohu?=
 =?us-ascii?Q?X6C4APNBj88n7siKnl8J4NgMJAxGUumnV60QBG7oKcksjaJQceAaACRZZiwG?=
 =?us-ascii?Q?jCAR6diXTocrZPFEkMyCTyT2oBOLwOoEJWELZa1pMghdYnxIblkknbJFjoMk?=
 =?us-ascii?Q?KqQSoqLwOc34hTYXusttU+Kj/aHhOdNyil7PMH1axuPS7HiTWpLzCP4emdO8?=
 =?us-ascii?Q?5VaPNNYysuK+ZBAhqIUzN4Vm5+DCMizcvx2U6aehrF7wfmF3RYpx1aczGkVQ?=
 =?us-ascii?Q?HUcoxMHWfyV3jTH2fRgKpnGh7mwcA8VDTFqx1DLSTT7+VjYkbrW+C3okrQOQ?=
 =?us-ascii?Q?5xk6N47ec34v8DYD/b84ZP8BtpackrbqqR2YCQu/v6LLaP2/X9/9u/BqbmZr?=
 =?us-ascii?Q?MRjDCuGPArYvjWrbfRkqCQlFSBV7JYIukRLB7lRTRApfLjtWvhUFVJ82JRzJ?=
 =?us-ascii?Q?pCTPR/6Bo+wGUrZ+6+H0YEKmrmZDDtQzNixsZ3gjACT1OdQYcOlHnuDBRau3?=
 =?us-ascii?Q?/ifAvNd0EL7Kv0t1IYTcS0w4KpfsZ5GwZZaJSMGnX6zMhnYt/CiPjdtiVFVn?=
 =?us-ascii?Q?UlhP+MSr+lsycqYIWwARSawGT4piauikWI5MSKHDxiuPHnjJY3B6RNfmvZvv?=
 =?us-ascii?Q?AcJBt6WjnQn3xkZbmZgU83q2hhIuLpHjPrCeB/jCssGI0bY2ZIdgcOB4ypxC?=
 =?us-ascii?Q?v30CdiulydK7cO5HXQaEhaHEAqIvGmdCtpk/6uhyauTIkY1JYh1sLtd5Fkg/?=
 =?us-ascii?Q?gdg=3D=3D?=
X-Microsoft-Antispam-Message-Info: s+shlQhA6ljdXWRaGW6mUU7i6cvcxqNCxwz/q4KFaN6hqoE7LP4kHwnXhJg9ajhuAyh3IG2n3BGFfcq6DjEDE7f6R0P9UjUN1YZQdCXVwdFSOhwVlw/wI/HUvxAll9dRbO5JcEX+anWvQ4doYh2TflXKNsW+Rhgc55O5ZcE6xYCVOJsDO+nYwNS59NyenZOVYorL71gLEB2cfbAb0ASi3oRm2a9FMzfTnCvovYnz/I1HIREaQyvvLB1GzBGqj6dIaqGt2P3q3jg5hbMhiIdr7KyoVPa5qzWRxqfv3J1pB1LTE53WQX5QqCKQMNNejwJRyviwNgi2AAKxThscSR1c9lCZrhUKtUhAZbRM/pp4/QWKxQJz1uHQAr9JpEXX/dTtssbZ0+4rgir76Whn4wwtgg==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1887;6:ta307WSlCbVjCAb07HmwyWDDsuqXE1edoGy45w7slLH4pX8y8Jl2NQmRdjnDvTJu8V8K/flhQiEKW8oS1MJ5+ymedYIfBmtFuPhQdbLTP32toHWXCZ12m7D9Eee30/HDx2giZitb6tgtB3P8WIU/abEXUjxZTatGJ6CCvxrvuadvwoZOTEVHZeTyiZxKsgp9EDCHVxKmvUZvDU8M+hYKaC5FM7KwtmGvh2JoynzL8iO67Ay6YN9GNKdFAZ77/Lv7vAnS8Jjd2inbVvb2imUv7dVxKTtTPs9DTCbGUOmYohrwTIMLXkPXN7lLpCIgP9Isz72Y8m+5/Jxs/vMJvm4sAFQjH5eEiV6kxATiIpU5fP/epcUgrtPpmfoFBI5XguEe2Le/AAky+OfwT6klZti0aoQPtMc9IBTjcDOvNtdS8emgBx80kJ7deuMIIpl3cZHtBFDAnmfLirGD4gz0vZlxog==;5:eFR0HJXYuf3q4wT+OkxEcaDhGJWUEn6AkoThPDtzIzftQzDcjK5osBbge+o7eiUZ4pswzvr9G5+PIMFJuXLv5O2rkfjtfvqbXWgPv8hLkj8tCqJqEipAMLzpRq/8rY4utwxZ/Ey+SAYtqSVoDrV3dGkMQEZWtCK+XYEZ7sT4oLA=;7:CPyHQwiaoKwwTmkCiwaXEcufNIZFw+ACoZV3Yk8nrHI+K+s5U7Pgo1oIMUIF3INOA22xfdqbwL6Lp/2FwS6y1R1MP7/hbgPPA/QpKO42Rkpq5TJ7mmldjSdXO0YmUjVra9HagtCZrgqaLXGCH8tMFihrQ9a0c4hmNdSN10VZFFq/OmYOWW/mr/qjpG12HLQs96uKj3XQNrqdlgYvQqAxRSOpWW1/M/5fjWlg3CauUlFYy5aD8/oxjOkazOPlTbdS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 08:06:22.2436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e23916-f527-40bf-5f6b-08d5ec855a30
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB1887
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64915
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

Fix a bunch of similar build failures:

 arch/mips/ath25/early_printk.c:29:6: error: conflicting types for 'prom_putchar'
    void prom_putchar(unsigned char ch)
         ^~~~~~~~~~~~
   In file included from arch/mips/ath25/early_printk.c:12:0:
   arch/mips/include/asm/setup.h:8:13: note: previous declaration of 'prom_putchar' was here
    extern void prom_putchar(char);
                ^~~~~~~~~~~~

Fixes: 112045c520 ("mips: unify prom_putchar() declarations")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Paul Burton <paul.burton@mips.com>
---
 arch/mips/alchemy/board-gpr.c          | 2 +-
 arch/mips/alchemy/board-mtx1.c         | 2 +-
 arch/mips/alchemy/board-xxs1500.c      | 2 +-
 arch/mips/alchemy/devboards/platform.c | 2 +-
 arch/mips/ath25/early_printk.c         | 2 +-
 arch/mips/ath79/early_printk.c         | 2 +-
 arch/mips/ralink/early_printk.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index bc0b15f2270a..ddff9a02513d 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -61,7 +61,7 @@ void __init prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-void prom_putchar(unsigned char c)
+void prom_putchar(char c)
 {
 	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
 }
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index d542daf917d9..d625e6f99ae7 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -59,7 +59,7 @@ void __init prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-void prom_putchar(unsigned char c)
+void prom_putchar(char c)
 {
 	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
 }
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
index f11e763b890d..5f05b8714385 100644
--- a/arch/mips/alchemy/board-xxs1500.c
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -56,7 +56,7 @@ void __init prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-void prom_putchar(unsigned char c)
+void prom_putchar(char c)
 {
 	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
 }
diff --git a/arch/mips/alchemy/devboards/platform.c b/arch/mips/alchemy/devboards/platform.c
index 95e49b72de01..8d4b65c3268a 100644
--- a/arch/mips/alchemy/devboards/platform.c
+++ b/arch/mips/alchemy/devboards/platform.c
@@ -37,7 +37,7 @@ void __init prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
-void prom_putchar(unsigned char c)
+void prom_putchar(char c)
 {
 	if (alchemy_get_cputype() == ALCHEMY_CPU_AU1300)
 		alchemy_uart_putchar(AU1300_UART2_PHYS_ADDR, c);
diff --git a/arch/mips/ath25/early_printk.c b/arch/mips/ath25/early_printk.c
index 355d948ead18..8f4080ba6b4f 100644
--- a/arch/mips/ath25/early_printk.c
+++ b/arch/mips/ath25/early_printk.c
@@ -26,7 +26,7 @@ static inline unsigned char prom_uart_rr(void __iomem *base, unsigned reg)
 	return __raw_readl(base + 4 * reg);
 }
 
-void prom_putchar(unsigned char ch)
+void prom_putchar(char ch)
 {
 	static void __iomem *base;
 
diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
index 5ec0686e40de..2b5b0e2e084b 100644
--- a/arch/mips/ath79/early_printk.c
+++ b/arch/mips/ath79/early_printk.c
@@ -93,7 +93,7 @@ static void prom_putchar_init(void)
 	}
 }
 
-void prom_putchar(unsigned char ch)
+void prom_putchar(char ch)
 {
 	if (!_prom_putchar)
 		prom_putchar_init();
diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
index 4d5e145db669..0fbb41df4032 100644
--- a/arch/mips/ralink/early_printk.c
+++ b/arch/mips/ralink/early_printk.c
@@ -69,7 +69,7 @@ static void find_uart_base(void)
 	}
 }
 
-void prom_putchar(unsigned char ch)
+void prom_putchar(char ch)
 {
 	if (!init_complete) {
 		find_uart_base();
-- 
2.18.0

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 16:01:15 +0100 (CET)
Received: from mail-ve1eur01on0128.outbound.protection.outlook.com ([104.47.1.128]:3584
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993890AbdAZPBH4KY77 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Jan 2017 16:01:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HV9fY9qkAlHMFwT8U0xahm9VKYAt3dwoOzSYu1KAkIU=;
 b=oIfbp4G9xFUrxaqKfvDx/zxYWn6Q7K0Qgu3msbxWqqQIwMHb1q1u/YWMz+NVDxtJy4m4sXc4h4L1Qkk2YNQXw7ek3nf5Tu4NluGuGQ9jWt+xVAzAUrAGLjmIUDlHCRm5vYaQ7ClBxyoickJTGvDV1NeJPgqHrpzhVHEdwOcLy6E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.9) by
 DB5PR07MB1319.eurprd07.prod.outlook.com (10.164.42.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.874.6; Thu, 26 Jan 2017 15:01:00 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Robert Schiele <rschiele@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2] mips: vdso: Explicitly use -fno-asynchronous-unwind-tables
Date:   Thu, 26 Jan 2017 16:00:05 +0100
Message-ID: <20170126150005.2621-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <alpine.DEB.2.00.1701261445520.13564@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1701261445520.13564@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.9]
X-ClientProxiedBy: AM4PR01CA0010.eurprd01.prod.exchangelabs.com
 (10.164.74.148) To DB5PR07MB1319.eurprd07.prod.outlook.com (10.164.42.13)
X-MS-Office365-Filtering-Correlation-Id: 92cfe6b9-0038-48e4-5ac0-08d445fc24af
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DB5PR07MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;3:wzVNL6h8Wjgd25HJG7M20iD3262yGp3Ijz59eGl/u5159udBaVHbny/hzllRfD337Cb/bHNWdpja8/3YyIgx2XWuO5gG1+dEIZH0lVRx1sU8F0NQWOAv75GHccUHA4e5/pqAteKw9Z+FoMXZS6mbd5adCLDuHqNSd/xYBqsu0Yg9NuH07z0rb8v4/x0Ez1QqXg3su8d28Eba4T6XHfgZQBetmFmm+wOa+AfkndPqzp+GauBpfWLpww3HXxf0iYDdO78yE68GLr4je4Bm21m0fw==;25:n5CWFSkYzS4t8ae2aYfTU3cmSuIyu2JzkIpJAJ0ZPjeyF2CIiWK9loXu886fBopm5RR8b4+24AIL4Ppeo0TPawz89syb3QZyfirGX76JJCcWOqB+1Z4Z+Z8wEJ26RQI+EjhNMCFi2pAV2SL2zIgrzWiKuPz9a9mFZejhV4jbzYHGTCYr59OVskWxEYZu1VgCma7H7LZuGw9833xoplleAFZRt7oMCaoN1sXESEe4oCEqdQUxUI7oDxv1Jy8j5jfYoSg3U2Jlzr6slKRyMkX184S4A9GsAG138bueb5FbKyVbErYkj0somok6SeGidtCD4fAQIWIv0FHwuziq6i9yXPw5L9jWp10u5TdzjZKulxjQb1UAE80W+n6ASAFXHXsvswtTjDKypK5k7v/sCDieK/HMvBzknm01NW0/hpGCvUavpcRWjNwWvnceDzp6457Z2LVHtQ1zCeQBwUX8XpXssw==
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;31:NVveLOBbQzWdE7bXsRfXLq+pDQCCXX6QcLVSNg7r0uugRzsZi+kojNMufJsJSNv3+QYCRPic6/fBDrnIqzzT1mMsUQiwmPrC8ZDDTKLUrQxxadGq7oLDYJSC+CvwLwFAW7rZXfSQTfMy+KtZpQW6S3QULHc6oDbiIP8JJLEdTmJKfWmviVSr8drGGGwqd8z/JzQ+KtDuJFui3FZh8hNybQjdj9NYVEfwhspCrzPy088h1tsF7XjlJ98zU6q3iJBC;20:oV5trRzOtmISQDg8cK+4FQ4OGEsvbLK6hW/lJV6krJOrAPblCxXmT7LkF/ZGZgLHBuAyyIs6p09AUir8jcdGRstDUQ0/KLqAWfhdZdO8pNI+ooaUUhOE22qNyOdnhxCxWxD88jW+92br1ptEcVnY/hYRlfgUp8qN2dC49/7rg1NvlyoBe1vidzVSRZFretL3VBJMVkbTlfTAhQx6vVJTguw6WVTcidUO6F6xoWmNXE6lNVnllBtJmsm7vwubG6aaPay7F8Tt5MRwgE7hvexNrCSZTdym0EnXY3+f8yDcZKybMPgAMhSLxi+QxJsauuQNkA/U3zUemmvPVogrs9DQ+lQOBK9WdCXjfyxYUZvIIa6NEtVYy84W4kROI0J7c6xrJZl4T9++QxfmkkcXtufJdZAUfTiqV92eOPh/jfWcyA6jvLDdCu1ty0z5sOkFvzo7oZqSOXcGBQtywil0X2jgSu8ShdDtgVUA3zetHa9lAso9WXtkYAU7AH4NQMOMTy8IRbR4jNkboaUdvoYPJGh4Ni4lrkWiNTCrzn3y1ioAf+x1SO0EcsNxJYPqzCJ7+d1B59brdJwwjp1u5o/nKb+zyI2Qw2+kdTxINEirx3di2eM=
X-Microsoft-Antispam-PRVS: <DB5PR07MB1319473A6A55DDF2564C672F88770@DB5PR07MB1319.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026)(6041248)(20161123564025)(20161123555025)(20161123562025)(20161123560025)(6072148);SRVR:DB5PR07MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;4:+/y46f1ERWocJRG0ta4lVSCVIaDYk3nrJJw2LLjYDTQW24g+/ZLKaTIlmpTONerEcjgIUZCz8EsQVyFoLX1SttEmXtLGmMHFMCTqEKGMpPtIi7RyD36vsjnr/F7X5SCTZMJhHKxtgClY9JIFYyf/QRb5pH2VbU1YWCCT2cr+81+EamZNiO6d3YqyexWHP6BFVjyZ5tsSVXPb76vb/Qk/1id177ziqLPU2aOezV46msUUu7GtuQPmbHeQxzsF7QGNZE/wPIVIFhldzECF/QUPhDwNYQ6eiDQB5kMAbvPEbDzzACZyb0hJC1gWjKKvxpSreIq3eS6rphj/xe6qGEnK142BWDe4uBynEPzzzut73MMbPDn827fIC66ZnmNhOW/ja+NMZP/KTg8+2H5hwKuasjeYDDBEkn8nGoGIiU/+JEm9l5lw/YcQt26zD7vveIuKjk0it1iCa6hJTruk67CvfVS7VGiBQSZrh2tzO1fdmLeVW07UNRV/aY1j6QIS6EAVYOCdo0E/pQ0Up2MCxGRkg34IvES0wMqXUF6V3WRaCplqi9h7SYGowvQ+x6P8T+DSfEU4/anpqLwQRp4oX3NZgNdUhpbkDbfskc69D8lmgmTA37n8loxgXI/VlA/mO9GaL9pJIAD25jXtwlXCzNbFqw==
X-Forefront-PRVS: 019919A9E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(39450400003)(39840400002)(39860400002)(39850400002)(39410400002)(199003)(189002)(2906002)(4326007)(6506006)(53936002)(189998001)(3846002)(6116002)(50226002)(110136003)(38730400001)(8676002)(305945005)(7736002)(97736004)(1076002)(68736007)(109986004)(5003940100001)(81166006)(81156014)(39060400001)(92566002)(36756003)(50466002)(230783001)(42186005)(1671002)(86362001)(54906002)(48376002)(33646002)(5660300001)(105586002)(50986999)(101416001)(2950100002)(6512007)(106356001)(47776003)(76176999)(66066001)(25786008)(6486002)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1319;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1319;23:1Vca7hwvp+ehwMGweNfnMuDHnIVSyts9r8xh0NPYb?=
 =?us-ascii?Q?sAgINnceIK3e51XMzxL1IDQJ+IB4rE4ybqQTPW+kYI8OPa+cXu6qusA0gAIJ?=
 =?us-ascii?Q?Wn5xtCd8FKw5Z2fJELXhgUDmCELO1TZB43UpDCH9m6F4zhOxUoffHj/XJzQd?=
 =?us-ascii?Q?uBBQ5AO29lwxV4vTUzY7Hpg00x2jakUod9s55jjl2mfae9tkPb9ig16AqQfR?=
 =?us-ascii?Q?warVVylVmIvWhYgUkeQPgKLfQ4YJeBZrSCftrvis/ltHzjmsWnMgYmRm/Oaz?=
 =?us-ascii?Q?er4+OZqYxoG5J+/nGc5N0WKLNcG5XZp0Vz6lnqqxnvDFd/XmFwP2QKf7m4O3?=
 =?us-ascii?Q?1DItT9oArJABNtE+CZ7qoWpD27UEagcP8EaafCXN6eEjNW/U8vv8/LW0Kxds?=
 =?us-ascii?Q?OPttpcbOLdN5kP0GugfnNC8VEOO1dMheu5yuQzlMtEDdsknAzZHBMhZAuP6j?=
 =?us-ascii?Q?MxOJPfjSDD+KvRqoZ2wf63rYHUeC5t2MV2YQa7ASrLHjZ1y4puGyEwwvfjry?=
 =?us-ascii?Q?dPk3VLct6SkeuJpXtIVPImA+C3jY+8AdmtZTgj+BMNYyKiIrUga44HQv5TYA?=
 =?us-ascii?Q?TI/LxfKMyLexCtqLn5YnbnwzHIcDLyFgpzYauAgCrRGhQryo4uA9bB5itKYF?=
 =?us-ascii?Q?TQek9jukEbxJ83tudBPeC/W22+cgJTlXAYaiLzih8RfVwZhDfhH2COIsP6Ee?=
 =?us-ascii?Q?IGMz0VtbgTP4rMqU27Rp1L061GcwZW/Cb20KmouP6+hTbLfcDGkvl3j3HRU5?=
 =?us-ascii?Q?71DJFddP+xhNbUzeNvJ8kiIj7Wf9A86c6MCjQSnp7A9RtvPzlxnLQVQ/+ghX?=
 =?us-ascii?Q?0VIJUVgjUSrcTHezN2ETWJ8GO8Dk3wJ/UQiF+F4LJfrDPvHyr5qV2FI9poR/?=
 =?us-ascii?Q?hhqbI4b9iigmXGZX0zvb2XSkxlIRv5pmbW4cWMllSDNOZ7eeezuEAlS895lK?=
 =?us-ascii?Q?4EbXctswOcyXM01f/PGBXQlmZpBAzoNl6jm3ES6rAvS/zev6qslBYfbhmEq6?=
 =?us-ascii?Q?X38XxWVnQQpKaZU/l/P0iyOWZjl6XAtHmgaByTSU1pY1+Mr/EbXvlDuYfGtn?=
 =?us-ascii?Q?SWK409N8YdfKF4DhO0D4sJWhJ/NqPD0K/m+AvWow3ZpOC84um5/f4QNAQQDE?=
 =?us-ascii?Q?JfGVppT4IoIci52Yr8el8C6VhNoIzQA2gqk5LPkIYNBd+Y2LGqn0Ass3EjRt?=
 =?us-ascii?Q?xZLiMjuBibn4eHJd3/ueWxD3uxVbvnSbdeHDnuS0lY2uuE+dOfi2qPTb/YGz?=
 =?us-ascii?Q?Gmy1heKbocdRZlU+yCKX8p8mwmLxrcjfOQQJl9b5sjipfT7V3eAB7oiVsIjH?=
 =?us-ascii?Q?wmuCzQZtwhL6TNEC4MQI+k=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;6:hyuJOFJOxovEqRqBRsLWQRzXMnB5pk9XHw6iJQVpwDYVwlarwkzlPC7b/mcR1gkbG2Ori4hWAUCWxM6OnYclaXCDnTQILVYqtRJMG3Odb/bt3vJOA3JkI2FI6EROME7aVNnUpQfe6aLCnv8iSkSkUDbROUBP4dxDvkpgfIJKE37uT2QGTo7X5wvvRN7eYl5pOu1zu8mKng1PHgWbNUYiLTtnpgfnY2kyBdDirA8ScnKGHmMJesbxvasgmSMmLBs5ogOFfRuyXTppgnY6hLXOo07h/MGdALIMj+SqLOJw1qLoUImAIwgEN4BagIzh944wPKw/0j7zV7xngPrVtc9yU5ev4n2eQiu60S7NGiR7YjI0NMzq08urIcQTWwdYbsRRwTMQ8QbeIRUfw2MbE7fZASw+TRoMdK2fE7NCMlLniv7Al8naAQ+1Orls8mQQ3DOvTm8invYRVF3J5lQLUD6EqA==;5:QAAoZS/SvolnXpMn0Ajkhl+zL5JJn5nO5IVlfR3B/Z/GEXst7uKI5poZ32hymbnIUClzXhepqp6cX3/rsaJRiigN4NsxVweIClvnWPlAbc0KVKgr/b2qb+o5WXZ2Y7dsAPTxLJS0JG7+X5uMc0/FYg==;24:P8BZT0gpzuCP3DhnNfrVx7Z0J0qx/510KDGsMqbqA5S/ocZaoggTBS7NBUcmuDtA8RErYvt8QOJwHCRIgDjkWAb5wvMhfZoaacgYPqFUzYc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;7:WLCR6glqwQEkPSqEvrY1PbYgefzRFPuQAzh9HL1uIZ7nwm+mhPa2BzW7nFpqqcsy0mvnsyoScHHL6VViniemHivu7SCja3hu2J4duIK9bBR+mLUg0cG7CUBiaRz58m1TIYQ+KMM0uM8fuGRe0S5oXX/MyZWJhCfZ28ecSyb1Gczl2cm0yztI765IridyD5h5mMffpxYgrrx03faApc/SMi60Wi5ga1rcz9ErLKYVXyRapKwJcb7U5pe6SyqBWg0vpFXP4VcxJxb7I5Qm3np0LqH5eAgNFAZbPyzFXi95/JiTifZQ05jahKTPHNUfx8tencYhldbY//tCAYIxBEBydIdxxrA/mpjrLU5EXMUevOlK1jGVNtix6ulCkcwCJD45DYt4IUrySSozeAEIswekFTIRHyBRMJvb0Z9W0rNrgAgezU72Ak5STcKzOw6uSgpJxi0pgbdNI0l/zxKfST/oTg==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2017 15:01:00.8993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1319
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56517
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

From: Robert Schiele <rschiele@gmail.com>

Not every toolchain has -fno-asynchronous-unwind-tables per default on MIPS.
This patch specifies the necessary option explicitly for VDSO library build.

This prevents the following build failure:
GENVDSO arch/mips/vdso/vdso-image.c
arch/mips/vdso/genvdso: 'arch/mips/vdso/vdso.so.dbg' contains relocation sections
.../arch/mips/vdso/Makefile:84: recipe for target 'arch/mips/vdso/vdso-image.c' failed

Signed-off-by: Robert Schiele <rschiele@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index c3dc12a8b7d9..c08077e43e73 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -11,6 +11,7 @@ cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
 	-DDISABLE_BRANCH_PROFILING \
+	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	-D__ASSEMBLY__ -Wa,-gdwarf-2
-- 
2.11.0

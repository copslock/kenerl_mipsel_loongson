Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2018 08:47:28 +0200 (CEST)
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:59066
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991025AbeCYGrJUtVYM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Mar 2018 08:47:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4LgLo64D/s3Ze6P8IeufCMUJWCfFbxpDxzyy9rS+CXo=;
 b=Giop3PBr/vYOGeipSBmtuY3WnC6X/CIzS3ixofvjdsAFxgcuLA47CtaQRY+gIpwEpPhzAI8ktRGywnXBD3L0fhuezDhzgA9WHYYt8lsTxy1HuCsgqqADSmPApifqzEL91Z7/giie1k7RvugrhNWH+cTbSng4hAJiNo9fFg6tVf8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.609.10; Sun, 25
 Mar 2018 06:46:56 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v6 2/7] MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
Date:   Sun, 25 Mar 2018 01:28:24 -0500
Message-Id: <1521959309-29335-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
References: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: SN1PR0701CA0055.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::23) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa5c4fab-db2e-4e13-562c-08d5921c338f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:Ks2JiLshVUTfOmENLndpzmmLtXo8pZ7hL3RukZbLAxNhKfX9IzNJNXqQhmbMVJkKK80mmAFzlfTwS3s4QQKakajleIETceCRI7MwKkkB1MBOJ3eqqmyEXmhEGbVUokqBbFvkk2/Z8RnYgqMpZEqG8pnn9o+ukK4qv/Ffk0wP3R8WtYRVBf752a3bKREJGeuy+U3xXzR9C8S/Q3D/P9iCtdzxpM/W+HqhJHahn3BCnJA2E3r1He7U3a63qbWKsAfD;25:vRriGxRQ+gtabJN5+eoh+e8Z1viT8Rtsp9tGP9V2Fnd/dlbpuH6vxmberLieXY0qidGDiCWLKFPEMFIvWMNQeuEPoO89s5tMB7KpqGoWZeoeYWpVSQo4HinMItd80lVwVAuDYuXcz/Rb9bkBUArwLqlQKnXxXac59kD7g1YpGJq6e4EehS4AID9ftUACT526MFwDqsznQSAgkpWPR3P78L/NN1FW5ruPWLH55CPS2ni6H0bETv0KU0n+M0LdrYiqDh/wmfgsmhKo7fn7j+KPl4jrC0A88DyRz2jmNVT13c4rWBiLlrsCBCeSTcGR02ZZ99aN9J+nKoxJ4jSWdH8y4w==;31:moeZr7ZxzyteYtNe1MdvdQYcXzd2c9l03MUNo+E7ME8RsDDPMVm6mcQG2ZNeCHwQPuir77gxWc3VyuSKP7rgWTUx4/z4Drz8ibLk2BLoetTJzPK5QYs6YHaGF6sKr+JxGYm9MtEjL7U4l+58Qxcz5XKuRhwnmggNX82M+lnqcOcoi1HCG5bokNMYPRDChgNFxtec6dC9Yyr9skGbgh6yckSfu0tLGLvMAJcyAM/J5lM=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:jAI/qL0hV3AcEkRuinD0O8FMVncpwCheU1xdsZ0tm/+NN6HVBNjfrEnax8lxcudUSq/X+0E0wRCG/qez04jgF+A/l8GZUijGbiiQ/812ubCfTPAtriPK0ltqYkC/3BV6UoWez09sES8tbZqKZzn5XtZCaELET0sUEmrOC3d3odK/3bZEDjpAMRWTdpV1YzlIXftYuxRdkuD/H5ZUHzpIQN4JmyPsW8kgJijayC5Ys/oJCPlSzfNhDlkan+EAKz0O54tguZqAb+ibBhFHuqKRTfTPlVXzOHL+mOC6bXd5N6WPJcRL7qPEONp6LXFWcZ1PJ51Vewh4Cc8rwAzPZNcAHmwNelkLhBEfBVX6Dcssf0qfjqTcKAqs7ejrEXnQMfmwrKD4fxClZLgrRH40fLYOUXIyWJ37ke74mnpyrAQDcx8tOWAoRscf/uSTtZq/MGArzXzRDz+tHGOkaKPHZM2MocMTO4uZs00+ELOn49/Sx8J1Svi+a8xqzQx42F7Z/Z3b;4:MNj1ST/MNhs3iQ31bifxBpTsMYuDMCk/5Zo6SWyF91cm5B7gf0q8xp4XEFe6AIsauQmbLp0czvT2mXPJyavT6kuMp0XXnmm6AW1Wvv+yaRFlxhQKex79/kjv7T4PE3C+EJ8Iq3S/rDCaELHcfbge6Wai+7HRdxGpp6QWWpdxxo4uVMy+UdVf8TNJkb8rIwWxnE1nGljrwA+RogKrwPj+i9g0LpLIl+h6uImesI13+JQw75CdfmMhUb6w5KXFidCv6g82NO0pT6olug6jVST61g==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3610B70C61664F081D5DEE4C80AE0@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39850400004)(39380400002)(199004)(189003)(97736004)(51416003)(4326008)(8936002)(52116002)(48376002)(478600001)(5660300001)(6512007)(105586002)(76176011)(8676002)(81156014)(81166006)(25786009)(11346002)(53416004)(6486002)(6666003)(2351001)(6916009)(6506007)(2616005)(68736007)(575784001)(386003)(86362001)(2361001)(956004)(47776003)(446003)(69596002)(6116002)(106356001)(50466002)(305945005)(7736002)(3846002)(72206003)(36756003)(26005)(107886003)(50226002)(66066001)(316002)(16586007)(2906002)(53936002)(16526019)(186003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:OOQ8DWLWzYjrclG0ZTIResqqFYJAI9rf4UFo2SOO2?=
 =?us-ascii?Q?mcxmFbAfUm0kAGn1+feB6SW7xZWRQf3QRKibu/B8zoYkslu22FycxagfW/Uw?=
 =?us-ascii?Q?wO5dmAhj4/7CKwY8FAHl9q5tVwuCjaxOurowKORSYyMtEP2eGNQgpoTdbBXR?=
 =?us-ascii?Q?d3nbczBR37mjXs9pJBoWn2T6ZT+5ZoK0bQkrol6MDbzUGwo5jlyu4+d6m0Vc?=
 =?us-ascii?Q?k5m2J4OJtBqCoYOs6T3oPTCD6GRoQD51SDjdx/88S6jQQhjMSr1XHsgIzWGx?=
 =?us-ascii?Q?fQQ9MgSbbOLiAF69MjN+xW2tgAwi6EDCuYrAR8/gaCtBjmLV/Zg4zYbFxITr?=
 =?us-ascii?Q?uzHqhPizzQykSeuGhC/3C1dIR4txOKIL7lUvfga70XALl0C6Xhpy8aMLQSnu?=
 =?us-ascii?Q?MfA3+8ExrMRpUpo6PnO+UTA6Q4BqKwbhLDbVkH4Gu0cMfcktQO/g9QSDUq2d?=
 =?us-ascii?Q?xxbGQcxDRnb9Szw559U8LkvFnw5X+mcAnh6vL9vcO2g+ezQiyYvDgnVsPeq9?=
 =?us-ascii?Q?wLmUHbF4ktaYmHczl+XFTQcUwqFzBblFyd2QJVb8WR6V26TkM5ifyRnlxbml?=
 =?us-ascii?Q?TO3mhF0GBEJJVlJPurwKQATKhDos5oEpIupoAQ2nesdnIo/SmNrav+YYVOtW?=
 =?us-ascii?Q?b1CrFruOG12FvThr02jWaAH9S4l4YjRMTvIMJN1ynThsSvNzPVaNweXXmyAA?=
 =?us-ascii?Q?oCGwJnTFKtkOxhSB9wXL+dHRooNbMqXsxOcwQeVK54dBYe5FzenMhDpmnjuG?=
 =?us-ascii?Q?BoI5RvyLkPYvTkVB/h9iASit2M/gS3BP+YDsh95nHINuC1QtWcMnR1UU04Bu?=
 =?us-ascii?Q?cprs7i4pLz0E4ohzleLYrJhVxiHSFpsLbktmknUJHJNZHOn5OjsoFeIiSSFf?=
 =?us-ascii?Q?UeHNU8Ardr3nBnQ9Hcxpnforny7QLPGhV8hT0OP2YuinD/DuQ/56cGkk/t53?=
 =?us-ascii?Q?nf5QjDgUN9bnRBv+tnA9VTg2/UC4YjzeG5Wv5Szolk+BwG+Z18uVGKPjkv1z?=
 =?us-ascii?Q?DMu/XKIzpq+cVWGVeJJ5Z8Qpiz4myjvEcMoFA5d+y6S26aCu6USQMpIAU0dh?=
 =?us-ascii?Q?UfZYaXj3b0CM1rfGwyFXoqs1GM+ll9jTUq7k9Hukt13P8yeEPPeavl+wydfq?=
 =?us-ascii?Q?wT6YtQ1aGGwtqLgE892flPPPfSjDAPPCQTCu3qqJaw6AQKH1eKB6NVXJfHEf?=
 =?us-ascii?Q?xV/2phqWCQ+eXkg6si2KNIlWTFKBX3OOXHlzOerXpTXtk3TtyZtrpjWJkySl?=
 =?us-ascii?Q?kl8bmHP41SYm+KIvc5SX5eexaMkwWnL+xwpAmgsMJHNf0hZqfOzbppXtLhSv?=
 =?us-ascii?Q?tJ4ihbGLFL0r5/+3NrVohk=3D?=
X-Microsoft-Antispam-Message-Info: Ndr4OtGqjth7PeB825YsFWQvU6luwEhD4kIUt9yaT6yU8VyVbFRW+VKFMWtdc2THha1nDVdDQPdLecmLFqel3NSJNUA10+4V5oc3hPan5tVWUfmxFervWmRY358sDnxnjkZuPwnII8YTYT6OGMHyUjt4DC4+W0JpPiNG/zRoGqyA9C/ZxwgF4bvhX0Pf/VHn
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:Aq7upij85X0UdezU2Ma41YB7nnGWVuTIRqLLIE/R5vk4m65zZ67R33Y9ON0C1YJ0yAYwIiYi5FYF+AeARL1kZBBpZZtWvwm6bkHhm+UMz5EpQshAjKzmXGDa1Hac4xpATgVgZ5OyDAaLIHqE+OApt/SoxQZVFCzi7vnDJy/swP7maNiF9ipepDpLqL2N9EhWrR5tbD80VHQqHq8Ok4tA3xfKxdnZAQwZiXoovMEubTggAx9NGZOdwfPJctDzC+MX2FUIUF2bfjH1IuDiJa7/fr1G90RJEVns+Qe0/yJXdZsZajAP54SBxyijyZh5NcVGj+wSTJNu34vtBAWhUFIGpB8dhAAHNRJFEh14E5zyPV0j2J1vnWlxiPrm38XcrbNGEhCZyK6b3GdeAFp/Lb5TicBvPEyp5SaoinKXpC48V+NhMmRdu2enK9GnhOmC4Keak7H9r0dOQ13zf4vxjVd5sw==;5:GiMSqrbY9kfngfXKoDO7jC4omQegbGjcPqe9H793ZiXCh5eB60Qu0UMxGZFVunKAULeR+tdSyDbeq1Rv/zPkuPGzaaIns7VKVjFiAmwvZwU9W0mCWgIvMK0mp64HYbem+0U64XmNEz7jQT4e+/vBmP7GNv8ND0d4cPtprxxj7Og=;24:BmhNt/AtMusIYi8EdXZRWNe0ZloEKenPH74Hyqt00vT+NUAkdPisK/pJ33dvbcPRgbEnFVIBSB56Dk8+nIETx5QgMVSP7tpwkrq9QvbP8m8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;7:mXJKBMg96pcLSVeBm0T/N8i7dZNUDvFiQc4E2lpJBqe/23RH6hmPZbrxC4UG8Z3OcbhkD6nPQ2pVjFu6bo3oyHv1RWGkfutcFm1DCEAG/DzKq4VInqB3BBfjhBjvCIrC0P8S0TA5TQi+FARtSIUDW2Ovnnl60J4MeSvjJjllfr1tiShQighSOS+G2hAnsv1tAnAxyHryR81PQ72MHQMSyJy1Lao18k0WiqYYY8fpp3rtR4nhdk2TzSyoBYetrm8B
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 06:46:56.1242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5c4fab-db2e-4e13-562c-08d5921c338f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63217
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

Values for CVMX_CIU_FUSE register was incorrect for some platforms.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index af9164b..f955607 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -43,7 +43,31 @@
 #define CVMX_CIU_EN2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x000107000000A400ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CC00ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AC00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_FUSE (CVMX_ADD_IO_SEG(0x0001070000000728ull))
+#define CVMX_CIU_FUSE CVMX_CIU_FUSE_FUNC()
+static inline uint64_t CVMX_CIU_FUSE_FUNC(void)
+{
+	switch(cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
+	case OCTEON_CN30XX:
+	case OCTEON_CN31XX:
+	case OCTEON_CN38XX:
+	case OCTEON_CN50XX:
+	case OCTEON_CN52XX:
+	case OCTEON_CN56XX:
+	case OCTEON_CN58XX:
+	case OCTEON_CN61XX:
+	case OCTEON_CN63XX:
+	case OCTEON_CN66XX:
+	case OCTEON_CN68XX:
+	case OCTEON_CN70XX:
+	case OCTEON_CNF71XX:
+	default:
+		return CVMX_ADD_IO_SEG(0x0001070000000728ull);
+	case OCTEON_CN73XX:
+	case OCTEON_CN78XX:
+	case OCTEON_CNF75XX:
+		return CVMX_ADD_IO_SEG(0x00010100000001A0ull);
+	}
+}
 #define CVMX_CIU_GSTOP (CVMX_ADD_IO_SEG(0x0001070000000710ull))
 #define CVMX_CIU_INT33_SUM0 (CVMX_ADD_IO_SEG(0x0001070000000110ull))
 #define CVMX_CIU_INTX_EN0(offset) (CVMX_ADD_IO_SEG(0x0001070000000200ull) + ((offset) & 63) * 16)
-- 
2.1.4

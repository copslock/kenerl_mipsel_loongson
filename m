Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2018 17:52:33 +0200 (CEST)
Received: from mail-eopbgr80115.outbound.protection.outlook.com ([40.107.8.115]:49230
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990397AbeGMPw0gHAkg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2018 17:52:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao5M8Xa01MZdKtNtZ+0zorIFQFPG+i4ybpvZVVbGUhw=;
 b=qExRlmeG978D/AwQ02KEdKytyhUN4/ptIfFvjqFGmN/AizRyMWYViNYknexTFg2FUnqwkX5LZhXaPbvU/3eYTqivsU0++L5uo0aQInHBrD/q7cCsfOdYpAZ9lta/3ecCwD9ImBnrC/UBghnVONq+fHsq3C29JIfY3SyTq08gs7Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.20) by
 DB6PR0701MB1878.eurprd07.prod.outlook.com (2603:10a6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.13; Fri, 13 Jul 2018 15:52:13 +0000
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
Subject: [PATCH] mips: unify prom_putchar() declarations
Date:   Fri, 13 Jul 2018 17:51:56 +0200
Message-Id: <20180713155156.2747-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: HE1PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:7:16::48) To DB6PR0701MB1878.eurprd07.prod.outlook.com
 (2603:10a6:4:9::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4681906-9d45-4d1a-123e-08d5e8d89a37
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:DB6PR0701MB1878;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB1878;3:Dc2k+HikqPx9g6en51M9JtHYbAZG4eieo2f7kA11I/ZvIQ8SUWkl4KjrzLLwV1wPcl0VGwNMwxFBdx4tnR6yWIqtiHOEnbqL4WOUEOKPMmGEM3WcT5SIH70YyDyJ8d0SPiJLFTDgaKOOygTx4i0XRWbr1utRs87rdvljfUiJFIhEXlZ/rJHolllpX/5nUDKqgCtV1b2gBMAqXILyOeLUe10yluKWXPP8vMLIFCLk8Zumztp4amKNsctmiavUWPTfd4Yz/H59+Shbd8ASVTnx+qm7ZkgF8uybIzA8xqzrW8k=;25:akCTysgQMsZfLtven7Km38dDMH7glAocyoGDTs9fuz98fRmmuTqVO16a5+AbNzuknKq+Ta0ffdcVcn5BBX9/QJdcEnk+LkOD0fBQQ/BSckdNHbwBM6q4zn4X/dgjNdGG4D3NwUE852mA1OxQGN/WpJ0LYNoa1neSdYAuFECcdamBpfMr4a/VgVd/JtKUnS70RDVtdv4jMluKDF6OvUFCF3XZ+gt1Ui2KXTKphMZsKm3c/1tA33dNFf0YiX34wVRNA5d6AmKP5/ibF0jLyLAgFaZMhaWc75odap2nzGT1qKyYIKrZ7/oY0fMnMNTrTNV3ggLKejz9O+gw85ktH7h/yQ==;31:uIyioW8cXNMAnVSJ7CjwjqAiLUmHfOGJyuhKIWp2uW84q/azJ5OnnJ6lwEau0i5bffgopLEMGuavfH9KsbeysCih74MPY+w4GAbIMVHbMmD9IOlOdLIkApMeuYCO8eQNl5iNW6s6INLMtZIBAKRj0ku1xGdLANvTHZfLE0YsRejtpl9bllpWQrsC5ZGs/RXP3XrxMbWtAHrXW+Wh7bwcaDDa7EwvMjZ9e+pEtYX6m1g=
X-MS-TrafficTypeDiagnostic: DB6PR0701MB1878:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB1878;20:jsZSpjb15qS07AsyEy5hvUkz9YwJf72TT632aUvLbpCZRyiTbwqGeaFiKoerUkpbAfmGA8qS+CzZpSv4NfBn8vefq86Y0j+ccEy6IeHHrAgra3qQrOZSjkfkxjQXXWCZr28HtZnz4zpXbHKX1qzcRX6ej64xalY520MaII6g2xUs0n6Ry3ldGgupJQorDLluZPijZeT4BjkGmCvoGWQssWc8SWN6NObnkwnfnjGvMEAG/3r9AjXKShjnq1bujW5mQNoYGsPyPS9OI7DFqbTBNCdNVZy6/1ujN3Q+4hI7bXxUsg57rYeIrbkOjos7sThLeKnaRi1ju9u22Rc9Ve81LwKb3AvhNzVFZJS8uj+KeoaHOI570OJB2gbwFDkcOK78ENfjTYtMr7zY/mVblsGo7oLSMDxeaaSo46OEPPvaD1ZIqDdO2lPxHBdMwjYwCbnpv5gewnF/0kM6JggkFGbJEOKy84xz4T0p/YtiiHnGZTXNDlUoAsO6t782gJ0bzKBO6emHNTwbYQHmJfDFctVr24THZz2D0dmcygSZTAB8p2sdoeoZRP8yeZnOWyoUJNPjDjy+siAWobv49cYxzHR+cz2c1K+NlPoAQhKBVT7GKfk=
X-Microsoft-Antispam-PRVS: <DB6PR0701MB1878921C327320735975A76688580@DB6PR0701MB1878.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(11241501184)(806099)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0701MB1878;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0701MB1878;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB1878;4:tD1IJvEI3A/pZv9X+wkrRJxNlkUEHEhQQLtl/Kr8l+Ns8GiRujZMI0E+IHP7me3x+DkEZyvQZXCFM8jcc6YR4c81AXvaCVED9QLRA4q2lAq7hmgnGPsCn+RyHy45ZHVL+qG5y+H+WKOvHJXFiGuHCDj5wY9AH7buDahCTbrvOY6B14F/6TrTv8R5IXMZT7gAFCH0+Z4ZVep6Pq8ip5tYjrlvkDGrVmXtaS17tgRkCPk0RjvQBbCaBKIZCCHhOzi16TeesEszFkG8LNcdiv41QeyfY3fWMmgFcm31tpM2msaUe5hxvktf67tQayIJD2kwd5ybJmqYU1GsR/byIHJI4hJKzTwRM8bPdqzqyNc3wqI=
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(44832011)(2616005)(97736004)(50226002)(486006)(6512007)(2351001)(39060400002)(2361001)(25786009)(7736002)(2906002)(26005)(68736007)(305945005)(53936002)(52116002)(51416003)(386003)(6506007)(50466002)(48376002)(476003)(956004)(81156014)(47776003)(8676002)(81166006)(316002)(186003)(8936002)(16526019)(16586007)(54906003)(86362001)(575784001)(66066001)(36756003)(478600001)(6666003)(6916009)(105586002)(5660300001)(1857600001)(106356001)(1076002)(4326008)(6116002)(3846002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0701MB1878;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0701MB1878;23:0VLsy8b+k4PuNDGCmDQcjHSdIqmzA6fUaGscRPO?=
 =?us-ascii?Q?4yihizyD0qUw5cb8GaSHqp5D5bu4R+M2v5HaNpY9J9tl0DVuoe4z9JxTA/dy?=
 =?us-ascii?Q?KGP54NlCcgdjv4o6/FqR9Zai1D6ETL8Pz1M2GujWuk5cFEwOqmIbvvCl2ZbY?=
 =?us-ascii?Q?m9rI3TSctQRRbXIE5SAdmM6zvvGQytig8iCMxGF9AG1qrThQ0c7od5ZasT+V?=
 =?us-ascii?Q?nhrZ68bR3DF1zpbjsMfNNT+zIuz8Et9jg3PefWVgrt48Uqen2lLPCNxdeqVY?=
 =?us-ascii?Q?sWvGsVluOw8xsge7/VZ0CSl6U2v/mmiSG3KHkJAWvEKwI+LnYz4VHs5aPNYm?=
 =?us-ascii?Q?ApmpGtqR8nMm+pgKoIz0KPyFj0qzcKhcjsZKu/dSVgTxnGvjZAIyivpGtQK6?=
 =?us-ascii?Q?++HTdx1d4lMLJ8AKd4b7YDUVppQu931OpP5ezUcVP9YV/Nmxo8i2dILDvMLk?=
 =?us-ascii?Q?rWtT3nV7IS/57Sv28hI2ZQWh4XLa1/xYyKgnm2Lj/7mcZXA7A3zHURhcPaEe?=
 =?us-ascii?Q?6vLjl/TzXG0y05TXrgUliR1SD96MmBIzulTtQBU07UnGEFoZDt3Ubped5sFg?=
 =?us-ascii?Q?Bgd4a5/svuYyNAW1Gl4wXwCHRBh2XHdvGTW3BpK+rXc1p8oV85MjH+gIDPTk?=
 =?us-ascii?Q?6ue9E+XoT2SZmWSPilZzbsuBFyanjeJo4D4W85FkZzTu467lpfGu7f4cyEc4?=
 =?us-ascii?Q?F7ymAWs2ffsJOZ6mYDsE3xmwqU74e9InFYvPoEMezza5wkSdU5IiNckrm7q4?=
 =?us-ascii?Q?gJOi8wZoBlkSKppbDNzJZ+GNkqTn3PBPkSl1N/RJvhMA7olJ1uvY73ABW9kl?=
 =?us-ascii?Q?dBh1J+I1S9nYnTrQYM82AKhR5kHHZ1fBydv5cLekeyoGZn1e9e4+Vsaowzj2?=
 =?us-ascii?Q?+ZtBejYnNwH7ylapYjVABcT4fAyhIIM+YgAd+kj3nw+THMpVw5ZvT0BEVIOV?=
 =?us-ascii?Q?ZMT9JE9/aPFR6HJyJ2tiDjNk5y8/RqNgnTgFG14h9jZ3/vaG2S+4Kd4LHCVb?=
 =?us-ascii?Q?h73igFXAfO4oOGw8RTj8iuqJaBpUMC4/Jy3OLlBzbD5kyqLF4FyWv4rPgV4K?=
 =?us-ascii?Q?hon8O7FSJ47NtqPwp887dHNPwbjfHwdnRTbczSmBojE8i7B8J0ESvxCpedue?=
 =?us-ascii?Q?G/6r0v05qPkMC0D21ua68r/LHwdMexSwdj7bqJvvPCZDqtntoxW8J+gXKsV7?=
 =?us-ascii?Q?DeagEI/e+A8cVVTxwLHOGmWoYC51mUCxQwshzQ0G1RjGKUeQzNqdVGvE2bJj?=
 =?us-ascii?Q?5fBp9/r4yMRJxL1/lQkXHFvr8aTucgNrFRyUSPW9rtOQBzuJoYu0dZo9RO0f?=
 =?us-ascii?Q?12Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: //uVXLsSF5TsJZ5+Luc69ZMaJ70ZzW6lf6JPEfI49YpFZebyNHGN11MpwTc6amj8LtGBdMbuK7X5bI+c/7KlEFHAMFv2wUkv4uRY09dNngC8x5+FPX80I1ln9Y6j4hnTArED8cuPLumzjA3v20fXI2nD83qvjkAhY7lBlWM6V8VQUqUxrRBSfJYR7bY9q64ip8+W5DrhFvc+X4vlXT4DNpaeZQbV8gzijWRgUwvR6bh7Wn8qaA2lYP+fvPaAUXXLbEz9mnerqfGvnXTWpiA1MJBCYCLVudfEf0/wPkz/XE46X9HaeGk6Jvcsa2FpjcD5AQXttkxhvjlDyo80IOzxDuHIsOBQ+T60gJdA0E2UTsgn3ZdigCltZBhnoIn9HkjyJC4WAGQDi6jQd4oQUUCAIA==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0701MB1878;6:EUGFIMx8iPOB1ApNEi/oNXmAl7MSVJiUVkLEeKGvc+nQ1fWnzC1YGr5g3Rr8Z/7rBbO/2ig1vWzKG0vCXgs5hA8VVjzECT8RgFY768abySAdB8mybCUcKU8WOPCIMjZe6ptvvh5U+7Mm5o1xv/k2xyWoYHeVLzd7rvt8jHS0UWdElfvyL9ecg+wFmY4uj9l/qrx9uLA0jMC3TT+gb95CN8XUVa/uay5q5TjmWuol4Y4FAad97SEpU0X6e6w1qgqxiOYpLHag9mhK4R63r/32nIf0R8DZ6Ak7G4WKxaHgandvCJm+Umm/Wm+ldVoR+/OBYOVIOxF6pyRKHVS2Zul/mq/633875bwCOeqUxQpyShJGXlKpJHviGwhRteY+H5z+7Fdx2lNzA7mlvQ4XgiPa7vVDdHeFY3plk1OjaGMZjzOd6ygMYZ7+RXHGPBD6hSfKOpJdf36I8IjlfTzSBfjJ8A==;5:eYugCJ709ACtxZ4k/NN/4FgClcazJRdZl6PN9vR4mqZCePi+TgQyZE62gPdLitXd3ioWXoCGmkAskerkqxS5yIT3qc7XXMukUrhilItVof1DTeYkXUPE1IpHcl/zks83LiRGKqTgCcCzqd4NKAMZY9AsBvMARiM6DJ+qM51aEZ0=;7:3SJ0eaX2IMoFHeKe67zq0yRMW/y3uwaufOQ/Lfe/ikhvy63QxEc3bzwTor8mULlamwHDPL5SLhhSrton8xviuStLa+txl/dJb4Jk5D6C+TbwLlKXyt9gfspekwmGuyXk9/bOd1LSRitkC7Ns7T0D1F4aEPEckMwEkC8iqnBsEnHK6tVbGjzWlg0VdUQ0/Vd65JNaXYoOoREwT0QBMda7fNdlgUuYKRz6ThqE++HUFoq/+CwNyE8hM765gXT6g/sR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 15:52:13.0524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4681906-9d45-4d1a-123e-08d5e8d89a37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB1878
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64837
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

prom_putchar() is used centrally in early printk infrastructure therefore
at least MIPS should agree on the function return type.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/ar7/prom.c                      | 3 +--
 arch/mips/boot/compressed/uart-prom.c     | 3 +--
 arch/mips/cavium-octeon/setup.c           | 3 +--
 arch/mips/fw/arc/arc_con.c                | 1 +
 arch/mips/include/asm/setup.h             | 1 +
 arch/mips/include/asm/sgialib.h           | 1 -
 arch/mips/include/asm/txx9/generic.h      | 1 -
 arch/mips/kernel/early_printk.c           | 2 --
 arch/mips/paravirt/serial.c               | 4 +---
 arch/mips/pic32/pic32mzda/early_console.c | 4 +---
 10 files changed, 7 insertions(+), 16 deletions(-)

Tested on octeon2 only, would be nice to get some ARCH-wide build coverage.

diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index dd53987a690f..d97ba7d1a983 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -259,10 +259,9 @@ static inline void serial_out(int offset, int value)
 	writel(value, (void *)PORT(offset));
 }
 
-int prom_putchar(char c)
+void prom_putchar(char c)
 {
 	while ((serial_in(UART_LSR) & UART_LSR_TEMT) == 0)
 		;
 	serial_out(UART_TX, c);
-	return 1;
 }
diff --git a/arch/mips/boot/compressed/uart-prom.c b/arch/mips/boot/compressed/uart-prom.c
index d6f0fee0a151..a8a0a32e05d1 100644
--- a/arch/mips/boot/compressed/uart-prom.c
+++ b/arch/mips/boot/compressed/uart-prom.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-
-extern void prom_putchar(unsigned char ch);
+#include <asm/setup.h>
 
 void putc(char c)
 {
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..aebc815a2c5d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1108,7 +1108,7 @@ void __init plat_mem_setup(void)
  * Emit one character to the boot UART.	 Exported for use by the
  * watchdog timer.
  */
-int prom_putchar(char c)
+void prom_putchar(char c)
 {
 	uint64_t lsrval;
 
@@ -1119,7 +1119,6 @@ int prom_putchar(char c)
 
 	/* Write the byte */
 	cvmx_write_csr(CVMX_MIO_UARTX_THR(octeon_uart), c & 0xffull);
-	return 1;
 }
 EXPORT_SYMBOL(prom_putchar);
 
diff --git a/arch/mips/fw/arc/arc_con.c b/arch/mips/fw/arc/arc_con.c
index 769d4b9ac82e..365e3913231e 100644
--- a/arch/mips/fw/arc/arc_con.c
+++ b/arch/mips/fw/arc/arc_con.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/fs.h>
+#include <asm/setup.h>
 #include <asm/sgialib.h>
 
 static void prom_console_write(struct console *co, const char *s,
diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index d49d247d48a1..d48e70de281a 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -4,6 +4,7 @@
 
 #include <uapi/asm/setup.h>
 
+extern void prom_putchar(char);
 extern void setup_early_printk(void);
 
 #ifdef CONFIG_EARLY_PRINTK_8250
diff --git a/arch/mips/include/asm/sgialib.h b/arch/mips/include/asm/sgialib.h
index 195db5045ae5..0d9fad5915fe 100644
--- a/arch/mips/include/asm/sgialib.h
+++ b/arch/mips/include/asm/sgialib.h
@@ -31,7 +31,6 @@ extern int prom_flags;
 #define PROM_FLAG_DONT_FREE_TEMP	4
 
 /* Simple char-by-char console I/O. */
-extern void prom_putchar(char c);
 extern char prom_getchar(void);
 
 /* Get next memory descriptor after CURR, returns first descriptor
diff --git a/arch/mips/include/asm/txx9/generic.h b/arch/mips/include/asm/txx9/generic.h
index 64887d3c7ec3..9a2c47bf3c40 100644
--- a/arch/mips/include/asm/txx9/generic.h
+++ b/arch/mips/include/asm/txx9/generic.h
@@ -49,7 +49,6 @@ void txx9_spi_init(int busid, unsigned long base, int irq);
 void txx9_ethaddr_init(unsigned int id, unsigned char *ethaddr);
 void txx9_sio_init(unsigned long baseaddr, int irq,
 		   unsigned int line, unsigned int sclk, int nocts);
-void prom_putchar(char c);
 #ifdef CONFIG_EARLY_PRINTK
 extern void (*txx9_prom_putchar)(char c);
 void txx9_sio_putchar_init(unsigned long baseaddr);
diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
index 505cb77d1280..4a1647ddfbd9 100644
--- a/arch/mips/kernel/early_printk.c
+++ b/arch/mips/kernel/early_printk.c
@@ -14,8 +14,6 @@
 
 #include <asm/setup.h>
 
-extern void prom_putchar(char);
-
 static void early_console_write(struct console *con, const char *s, unsigned n)
 {
 	while (n-- && *s) {
diff --git a/arch/mips/paravirt/serial.c b/arch/mips/paravirt/serial.c
index 02b665c02272..5d39c9ed16aa 100644
--- a/arch/mips/paravirt/serial.c
+++ b/arch/mips/paravirt/serial.c
@@ -13,12 +13,10 @@
 /*
  * Emit one character to the boot console.
  */
-int prom_putchar(char c)
+void prom_putchar(char c)
 {
 	kvm_hypercall3(KVM_HC_MIPS_CONSOLE_OUTPUT, 0 /*  port 0 */,
 		(unsigned long)&c, 1 /* len == 1 */);
-
-	return 1;
 }
 
 #ifdef CONFIG_VIRTIO_CONSOLE
diff --git a/arch/mips/pic32/pic32mzda/early_console.c b/arch/mips/pic32/pic32mzda/early_console.c
index d7b783463fac..315068c5b56e 100644
--- a/arch/mips/pic32/pic32mzda/early_console.c
+++ b/arch/mips/pic32/pic32mzda/early_console.c
@@ -157,7 +157,7 @@ void __init fw_init_early_console(char port)
 	setup_early_console(port, baud);
 }
 
-int prom_putchar(char c)
+void prom_putchar(char c)
 {
 	if (console_port >= 0) {
 		while (__raw_readl(
@@ -166,6 +166,4 @@ int prom_putchar(char c)
 
 		__raw_writel(c, uart_base + U_TXR(console_port));
 	}
-
-	return 1;
 }
-- 
2.18.0

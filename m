Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 18:38:02 +0100 (CET)
Received: from mail-he1eur01on0117.outbound.protection.outlook.com ([104.47.0.117]:28255
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993889AbdAQRhykVpY0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 18:37:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kncj55T1jkFEotpclNeO5+m8XGTI5FExUWUF653Pv/g=;
 b=kEACVsjXg+AsdDCjhUmxEdbJ14hjBOPB1DydxF1A5cVuAlWPFbp5A2XWdE8B3xSnIFDLR4a4idCDLpTTCVq+AwiRcrqcCjYptRydhfp2m22Hf0dk8dYH+A+NHPJj7P/D3Ali3n4SVDSA7zv4eXYzcxEbAly/6vBXjw/EO7gAa1s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.9) by
 VI1PR07MB1325.eurprd07.prod.outlook.com (10.164.92.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.860.6; Tue, 17 Jan 2017 17:37:47 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Alexander Sverdlin <alexander.sverdlin@nsn.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] mips: rapidio: Drop dependency on PCI
Date:   Tue, 17 Jan 2017 18:37:39 +0100
Message-ID: <20170117173739.28036-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.9]
X-ClientProxiedBy: HE1PR09CA0073.eurprd09.prod.outlook.com (10.174.50.145) To
 VI1PR07MB1325.eurprd07.prod.outlook.com (10.164.92.139)
X-MS-Office365-Filtering-Correlation-Id: 6791c8f2-663c-4d92-91b2-08d43eff8d6c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:VI1PR07MB1325;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1325;3:ACqcmPDrTz9h5Xvc+05FGODFv9nBhL12jpintYt4XqBAzhw5tyT6WTLx4ocp/omS5soZWnoP6EkxMDBvc5aVqvigJad0YeZRzcoMxOBCc5qL3rdUz1FmLZr/gH/bkN2/jMWW3mOW3c6+geFe1Y0YdqJSY1rR5SCzAzmDSiqo59gNvQt5NortaA6Wmyx6a+AECvE00C/zm6GbXqu9gWkwpUcIGKSjf9I+2kOTKxAk0kI5+QgC/etH1KTB//MfiJouCtHs6J8mlbV+opJbamx6JQ==;25:2MQRvOPd1m/4peP/MHPjdGNsLUvf09eG1fdu+SinH2rErRDs6zwpDzQPkaPodLvIIaRO0Cip67ycTIVICVoCTVKMSPY1hBtdON5Pc0d0gH68ZCUK8GnOU5fJ1XRTLEdIPQN1qHuSJSzddyc0bYiW935ZRnzQKbmkRF4WH4YJABuKfa23wKahu0lDqdTa36kBGnuMl+Thx0RY3vzcVdWj0C92+gDCoujYf27B4gQmMkt/CGScbTBGL7Ih9Yrm/X2QxZcJ1DxumTkDDMfnSwHaL6U1SACH8g1F+pxujCnqAXK9Q92Z/XnN4UnqbF7XndCcI23zOl/FkralG18jBmRhAHaKECZ4Ma9BJ2XJZU5yvNutLOmw/Fn8TmbETBnReTXDfoH56jI4bqnAOrx/f3TGP7t3w/QnUQc1CM9O5X0EG21tzyg9F4SgoSjmmapWpbQ9uS36KnMEk1sL1eZ+mJ9QwQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1325;31:3c91MIBjrpsfmO5zgVUdtioNz3f3rw5tXNtDVo0iJQptSkawZDkHRLmx08jpg4N/2wiWpFYQ7ZLa+GiIDucxhB5//2iSJQ6CPOE95HnVtK+bw4iWixB436Bwnjb8f3K+UrWuQ9qZK52rlQG79wbrKSsjuBvSG+fTIV+x/AruFlhwsJAme9deWPtwutVgezX1eXN+43QP986ej3wXqcfzWSCZ5pzGHh258fAYUyPHF/tZEIWWwMqIbWCBgMcpXS0o;20:3InPfBUm8ljjnqbGgstedgxPlMBrEdB2i7TRwZqjqA9UOiFPYQb5JcphebQSUco4zFs/7oKOnqpy6Qtv9s82Vvyo1o3vYUch9zs54xdc3NNbCO4IUO5QOpbAgkhJM6enAQ5ejSlVtUbPtO54LAjqVmyhmmvKOSum51gfJANElo6wY3VKZ6uxqvJ5LDoroWLA3f3f1iAKdKkEBB5H4BoEeAIuEsPRcj8iuIULVf5SueOXj7HTJ93s/QxHsLwpm5DwCSwe0eBsE3rTjppO2bwlxpv19kg7hwt97Spxy2qYphpQ0okEdoNlM3s+L3cfQrtZqf+eab1OXgtijal35q/Y1VLvEG62xU187rNCngNuPp94buosy4nXJUnQdb0WaFiNJbB6erTEF0Mq/bWebCjUJoUo1LeGHxpHye0Khxi6GvBLLyBeBPu3ZudW7RiCmG9fTKBzOvqAZ1893mRb/IKxqNjb13PBVeMJyTiZ88aCdIFyc79ykdVvySRCW3N//gDHc5p48xYbDexhC1O533xm00Cq9IaqmtMGj1xHHN0LzDY8sbPBrLhfwOjGFHAe6/JZhDEjMuTLkCmVjYkocrngPxW9TRrQcnLamHvNJQHcGLQ=
X-Microsoft-Antispam-PRVS: <VI1PR07MB13250DF82EB22ABF82C7AF7D887C0@VI1PR07MB1325.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026)(6041248)(20161123560025)(20161123558021)(20161123555025)(20161123562025)(20161123564025)(6072148);SRVR:VI1PR07MB1325;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1325;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1325;4:IweE8drEA9pqo1fYP6U4r6UuNumoC5I4S5xoi4XVaDLyIYUgjOxyFo5ktm05jx6Rm7t+nUObgBR4K5Abga7qyFARL/5kpstlR6jUS8IwFiWmCWmd8SIdTqu8td7l4DRLm5mRzyXaFhXyGEikeO14bb5VbWeurp5JgsRciqw8tH7qln1CYYSlbew+n7maNm6tu6frQ9sGT/hqWM3c/lgXIQ3Hqx4lBi769WgyYXOQnpA5fHm917uiyQzX9r40GueJSth40gPPKDOEbuG6Fq+Mb+hQJOXrr5t2wwv8U+L41KikK1EK7Z9gavECj2WX579Q8z79yvGBwIoPUG58ACgAUUdRlof9O/pTqlu0zj1QOFPGiwXmxGLzKD8GqnUFhduPSpYr4Hx/p+vnJvQNuO2Zw+kth72q6oNfle6Rc0Rh3MfPIuvyeYgKCDEkIzKWGRdCIDEVEZOf9gleXCcEwN4O7IylGDwviwbFoAtRpaczkOLG8LcMfJD8WmZhlu/46hxlD4cr3JEEJ+QNpMHtl4JBY6KiUzZ/u81qbk+ai7YVJr4sP0tppIeLdQyvsdJHSRJWa2Wx5sFppj2yC90cq5REP8B4Kl4J4njHTiPIzosrkehgul8qgKFb4/+t/GLKNFX35UvKlW1rhDrX19NmksWVskIDbQC7M0Ew6Rv32GRt/I8=
X-Forefront-PRVS: 01901B3451
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(39860400002)(39840400002)(39450400003)(39850400002)(39410400002)(199003)(189002)(575784001)(33646002)(101416001)(48376002)(86362001)(8676002)(97736004)(81156014)(50466002)(42186005)(38730400001)(66066001)(81166006)(109986004)(36756003)(25786008)(6116002)(3846002)(105586002)(305945005)(7736002)(2906002)(6506006)(1076002)(6486002)(106356001)(54906002)(47776003)(6512007)(92566002)(4326007)(450100001)(5660300001)(1671002)(50986999)(5003940100001)(50226002)(6666003)(189998001)(110136003)(68736007)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1325;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1325;23:BFJfJ8bJ9ZzBN3r4L+yCNplqM8uln+Ta+DRUmd9Q8?=
 =?us-ascii?Q?RrVJH2qQJzBAnoLKl0UPRIMnIDkiRl3oOBmMyODkZXCei7g/cecOo6nHR9vH?=
 =?us-ascii?Q?GesvTdmqgOIfjQIeGOt1KFNDkRsT4oLo0j1m/Ymh/NG0Mm/kiiWrmmuNpKKL?=
 =?us-ascii?Q?zlYbnSP9xsuAN0ziAsnMajdb7PztUL0GSSHo+VSyObzfGK9XxhOGkcDlUBZY?=
 =?us-ascii?Q?pH6g/U1cSc0PktSYyoaER5dgYamgdhmrWUGyX6aizapgH0E8teAWG0i8cRrP?=
 =?us-ascii?Q?qAGUGn0uoJ9pL00zTorIpdVYDqnkI+JJ4ftzmaGNfWS+YPLJ0Ja/ZGUr/2My?=
 =?us-ascii?Q?t7fd983rhYzAWBV+GnrR8Hqx/Bz0fc6A051L4O80dyhvD9PCPTjCrfkoOCaN?=
 =?us-ascii?Q?Ei8NazYGIKMjIbDdORqxec0DIMSUpPStCqpbyFZ75KdhU6jwBbJbEFKNWd8q?=
 =?us-ascii?Q?p4ajuu9JMCTmPZsXDv9RBjTA1Dtzp66gZ5mYI/OaXBmvWk+dtnVTHjXZJw1w?=
 =?us-ascii?Q?kfLornKnZpgjpuiKLzugL2HsmxAA1VrJlFL9rKX26D88kBVYJGiiL/2zxIFs?=
 =?us-ascii?Q?bgOnYf1Q1/KrSOfCsfqwTGUWT9LFr4KEtNxpli0c/yTKMDveMWW9k8NufElm?=
 =?us-ascii?Q?+qPIN48TqDm9uQ4ZzYF76AKIsEOmznhkXw+hmARkJBFMvQC3hnQiy7w/24EE?=
 =?us-ascii?Q?pDHXm++MipBlWoyXDIU+2SM2dc2K/pvjwiYaec+qJOoqvtOAE0CZ33INMjXm?=
 =?us-ascii?Q?qWR4qy1JOGX+lLd/6rA14ecktc24JCmBw2Us7fizufP5aMVf84nuzKan11qT?=
 =?us-ascii?Q?BUuaDgibu2hpvaP/BJ2wTayiYL5xs57w4JXmofO0a3UVNe0BchSxEM+VWNtC?=
 =?us-ascii?Q?xCjA0ahYfnPjJaagzHyWQWEc9AUC/P+YkTOLVUVy4csp/jpqbDyjTy6uwqbz?=
 =?us-ascii?Q?BKnkCsWJ122Iu/RjJgA2wiSYHfI4Dy2n9VLgQK36MNO/nlwhArgXCYsGjCIr?=
 =?us-ascii?Q?Cu/wyEzq2O3wkSOrwQiQY6LpaBTYR/AO/0tYtA5sTytqL8Ym3DD7tCzOVFIw?=
 =?us-ascii?Q?RxuC481+BWryRL7nuNY7isQtTyN/7t1wltaAfAnfrR+WRJqGPcL94TYm7oQH?=
 =?us-ascii?Q?oXKx1Qz5IEerUL57jIbr2y3vJRKnyss49pj9NeiHUro3VJDzgsYM4aHC2l2j?=
 =?us-ascii?Q?94Wd3wN205Eo1XNdEFReMzyGtAej22YFWd7To4ddNh8TEGfKSqskIFaxtz4t?=
 =?us-ascii?Q?8C4qTXzbL1NfotY1ZPSPfg3T2kbywwAt4OkjdsB?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1325;6:QFJij6cKpqyaIyS8LcvfixV8g8zvL8OT+Ox+r4dsc79ntaHr3RBsZfIABR/QPwBkQLraui1+dqcwQLohae+XlK9WOvzOYjfYW4wrmzxNzC2/ME0Z+ihwx/UNPIcUOmbwschph22zeSA5ZspK2a7pDDjUk4wJTSthi1JK9zY2JFnwOuUjtKzTJMuFH7XrjZcBe68FJIKTyCZpCSged0vxAcjw8gZmuRNWAsNqJ8rlxfVE6apguF8/RQei+5OCjI3be0TREhJbhFU5Iy8JnLeDV/uET6dwswjyIBxuMlJIF+bP+u5LH74AHFA/3ES0jUZ1KvrajOadiK0ieit5DZU7fyAEVE9lNM2tic0nyozNzLFFLY1ysRWoDBbal3UckFCdgHvTUFeuejoGqT+AyrWWEvixNi/Flb9D6hd41JJzWJRbnb4QYpxyWchQbk0b8j7b9RIGXcLQnILwJiHcJmzTpw==;5:TACg09baHdL2gBywcpCGKtkp5Q9kdlp7X6zKvb3FSFmuf4b90/c0pEFJxiR2RPsfgc7d8lAtlK8yNSAnk//T3KD8jXuFhJIrFV2tUPjaheJIHRVMikwwgZF5iUrIzAS+Y1xWXBLAuUF66Gx7hXlHuw==;24:ipseZMNxRzc+J4ShRTXBEFbi96VdEg7xy8Fj4mZpDwYOK2BfAyHBk/rfb1p4WpT83UjChyGEoXDQXrfB6oZkzIazK/SCQj+lv+fzw3qwlfw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1325;7:HrRGMfJT2G12fnS3pMhaXZUS0AtLvFW/vaH/guRGpex6zEkL7/UhxRlcwfLpHXV76IYN6RrRcxVMeDce5SYJ24Eb5Nsmm0waGVjiQuQWlieY1PlcEoQLmSdVZ3Lr7zLPZZvsLeivKR182LJOmE9XeYNJIVr36l+wGB6yYq+xNABC2/9+hyk1oSxzn4MuEjc9XrqB6YYz3gWH7Lche0difqIAEwomeEDQ7FMsRdJ1k5KcMTroiK0AAFRomBYTr+6JLfR1oEVtplbeyKC9UXEaQxJODIPiCi2/YYBOzOVdMeyh8Ri+caNPyK8T+lsZUIYdjvNdqC9u+dAx3jnd3PW7wAiGC7U5sjwUgT/Cr8LtBe70PfN14BqJWUFUsbL7no0OFHF8tUk9RqJiWadjhiBw75dbnAgl2445x1I7oGwmPGcQ5kEWqLbWnUJxGrlKL5IHPyTsJh56DG05Y0n+aL1cbA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2017 17:37:47.2744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1325
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56365
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

From: Alexander Sverdlin <alexander.sverdlin@nsn.com>

Cavium Octeon is an example of the SoC where RAPIDIO works without PCI.
So drop the unnecessary dependency.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde43d34..a97fbd6cbe0a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3089,7 +3089,6 @@ source "drivers/pcmcia/Kconfig"
 
 config RAPIDIO
 	tristate "RapidIO support"
-	depends on PCI
 	default n
 	help
 	  If you say Y here, the kernel will include drivers and
-- 
2.11.0

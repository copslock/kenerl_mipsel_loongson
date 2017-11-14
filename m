Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:41:08 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992274AbdKNEjFJ2ky3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BswKn6P8fCeDUCHHAUvz6RrGO4MMmjEbYN1lUqPZu4A=;
 b=bGx4h4CwBHT0xHxUUjyzLlRUXGHGpuvSkoQeh59S1iUe88/bKNyFvzunAqC6mtdKNxdQJs7albFYDU+GZSLB070LvTmIYNJp1iNBfAD8K4EUtGui2Cef0TGrspgn0irbsvZ4WKqBv8CXnDyGOdisgoTiC7gYOrXdJc3cZe1+5pY=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:57 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v3 06/11] MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
Date:   Mon, 13 Nov 2017 22:30:22 -0600
Message-Id: <1510633827-23548-7-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 031f24d1-9dd1-4ce9-f297-08d52b199ed9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:l/PZFYieoe6r2k+KW6gtIlAYFEhiUdj2mprGPHkTrcd+pseqhR//qn/7tI+UPYW1lYa3PUM9gAJo2otxcakjPykM1iszRhHRjPB+BTyy/iiUXt+fle3kkyyHUk3d0XH4YfsatqGCk8A6dQ7IhLdSpGcH5q0cUluVE18t7ZVXA/WuWI46NYiXBsxUqYkNvscfu9ekY+oxc2CHjVDeUv+P5GJZFtuGP+IMeFLTYvpQaENFWu4jBjKryTMIPMq2OuZv;25:+3CwGl8TbQOAL4HcGt1RG+RWxMWDKSpyFqj7m8sIzIIysDUI0Y2nvY0e3oHyEYluQq2xUCD0I53uRFYYwy7UKxw6RpWBSZx8ak1pWYCT/HYEGFXfZzIWl7c1OM+LCfYGo5wsuTpt3FpqO1Cdb7lv7M2vilx9wYahztNlZC0+A5gkFjVpu2w1YempaVM0KtTzFPb9Brxu9fkh07OLCoax3OpPQJrK8fQZAaKW/QJn/hKWCMjxLeSNgYLque8ZGO9yDMwDC2Tq3pGkea0uVPCoYrEcghjvEyJdy5cMtDpi9w5T0WJo+znISPoJfOEDHt9UzVcfhNEgfQsAo1Ho7lRBgg==;31:SZV3C0uj1dsqt38Pp29qBwD2FXnc26Wr8lbhkSFHY0bA4Otq1Vl+aX3c8JDK1rybR9bPxlyUXVNcQLpHGQUBP1RFb3ZdpNX1WtYK0lldXnNY9nBxW8XKlCd6G1ZEKvcuaOtwWyvZsbp+PGd9VOeUW3sadhMRuE20I+qz06NGQJvIzvuefQtRpV2RMWvQTz0TfzQ74MT0B3tWFv1D1k3PrKWaV69nkXfN27GbVeGOyUU=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:FLlPORi1alBnCUQESgaLeelIhLuqtXK5bAlfIyYMCYBfsjiuTao4MkhvFCBn+MrtiG1jbVXHBkT61qmkNYzGYiCjRowMJGesduOocHejJPZIBS8u9kLSxLxkh5auzuUaebCkJvEqdFc48rc8y6wo+zhuYlc2qVKfXVTgWCa5O3r2rhlhUl6AXMI+aPnizTciHuFGUY+2XDMho+dMI5QZ6S0A+RrrAlxGDyjqRIkbn6rshRh70oDTFd+r4eMCR4/di8Zag4H2iyBJ2QRWpQshxcUIPWGFgp8V2cuOYCbwUNRsPNAZr4jwEbpv+gpnUWqVIkZXGo4HFLjZ+2fRFjztnyLiGFzFpqbaIRJlD+9SeJ2Ofbu4Lj4M8nu2042w5fSmgAgUEg+GnTPBEs3CJhQx9xeZceq5v+f7o8zoXcApoayczgS0lBIr/LvG4fpHePsb1rFJVFCePD29UZTgwZlVuw//TIs93wWh5RRkqa0Ze5PKZFyHddml17XO3W5E3mhn;4:eSM+tJ1SW5Oh4ZfqW6f6a2sK5/kkq/HrB7c3HAoXo08cA33EDsL/T6TjVcmZ/DNh2vFJozg7wld4nJ1T7JJs9qqnV921H6Ns3AP5CU2YEiGW0RQ9N736cSO7DC/2lg0Va7mYo0geErlGRrPmlYohTqpIa+Q4xknvflkJ4x925LMl1+8WyPm4OHjBG7S2x9jlfYSJb1z42ueS2uUbWc8lFK7vUK8zFNaPlzECbLu5IOoJbCpXAMeY40eaQdSm9UBKUIIax5fOnGauUa1ZYqeRbw==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB380664790D7CFBF1E5B1C9F880280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(575784001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:AfiiVOFCtx06sufBvbOwmZLT1a/TCv21OeEq8nZ?=
 =?us-ascii?Q?Wth+lQgjXeJ49ff5SNyEtJ9anDR8j2HWvY9N1UCq4RtSUtoNSxheocmhn1Es?=
 =?us-ascii?Q?pNJks0GA7giTJHfU9xOrAVE7SG0OAddEN9wP3asHMwVYctALyfGU7qrtdlgi?=
 =?us-ascii?Q?5ItPXYuGy9XAE6xx/G5UoXwbVYSKncMoiyTXadLA29/GBxgQxybaKixnQuxq?=
 =?us-ascii?Q?JAJhRbZfBrkgNET8fEFeDi3Q0V7wSwUjI+vF3TDGWv2crwL/XqPH1nokXhtc?=
 =?us-ascii?Q?aI1Q3qFMb4dzLthSrIxTQgIwOLZZkzRAon++3J+UMNIEjIgFmk7lu0Zj6ng4?=
 =?us-ascii?Q?bAAf+x9j8VNgGBJ8W6YRan5h1YUaVGMIExNyAWBEG1uHFuubREWDGGSVdZIA?=
 =?us-ascii?Q?8yeWoZapxTxztWnea0yTHLAD8G0PlccLoo5W6WXIaKxiXe9U0a4BAHT9WwIz?=
 =?us-ascii?Q?yLk2QCIID4TfoSqnd7xgfSV5FuTw9sR5wEH+BpFKrt8BcLxSFBw+sKNX2jJ0?=
 =?us-ascii?Q?IPlreCvbVJOeXk5YdMTIbE+ILB7wuCXB2GMa996ssuxP/Tm2ZO+OXkgpMLKo?=
 =?us-ascii?Q?2bvU2UO+KB4nLox8qLUdFx2PHnaINO9sfEtRkJg1kmotDQQE2PNfYuZiBUmL?=
 =?us-ascii?Q?87r4oTnf0UyvQdI6VnqOS8Y5d9wrqKzeCv16/bIFYlzhN3QQyAJZ2d+iVyQ2?=
 =?us-ascii?Q?tg7wxxVmXnFjdnT4mH4S1DCgz3IBKNmkoGdgo+VadCub9WUbWZ42WMJGNTPp?=
 =?us-ascii?Q?FbTUZqI4y3LXVRJL65wBUvdW3svc0fOFYmjP/lTWG19OhJEdu0a2rveUVJGl?=
 =?us-ascii?Q?z56azy1Ti+ERiiIDwcrW3iCk3QlD02IEpkGUpuKzyWcKWsbyAizTBkMUQy+y?=
 =?us-ascii?Q?Wjnem5mFr9XFQrX2wRrOGsFg8ibDB3amhVpsaX/0Himudadk6T8fP0Zusf29?=
 =?us-ascii?Q?7ChcL5r342FKIQeDMfG8hUK8YiPQd+bX6TWiALxQ0crt0MmY42JxRYqut88+?=
 =?us-ascii?Q?RwNP54lKLhfDBHEDuAjwmofRWk/5pBBJj5/IKW5QDX+7rU7hiWjZEMvo4hij?=
 =?us-ascii?Q?wretD7Ob88L6l7Zje6e+9BlpxUFpmAVVHSJM1YwZrlXbeMUHA6Gb2kGhKV+r?=
 =?us-ascii?Q?CR2ptzszyuQwpF4GFV6G/a3EgIW4pFHOdldsvfgvEuJ0o2wUygL6AAvtDDGt?=
 =?us-ascii?Q?vRD9nkxkiSIp9an+eWW7sXkbmW+KydnrQGm3M?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:N+qZiFim87qyt5C+soHAdy+rpiUoTOKjqR3ROYD3ty0S6mLrMpDNQrBgumN0gdwqwYMjffQJec5B8uqgfqAEj2z46vFtDNKMCNdhIEoPBYI+o/x9Uk2LrzqT8Zj8m892V4S26lXw6cVrf7bYjc2/mW8uN+mNW+1ghLKfMzKQl5AxFBUNVL7zNXUWm9ziHNsBDin726XyIJobUgTSczoc0yFpoZxxKvj4OLs6Ztg+tyP1T1FE9KYTCOMckfR7wUz5MAY4w08AYEGPECgMw/iIJ0CP9iBE6efVnpA9l1fPNHTFPrsJ3pNnwOG1VLX2TfPHShNLKpys6AGMSMBhdKASj+NeoAvKIto8+ducmw9XcIs=;5:nj1GHmtXaWep9ZMyT8lVXaatLxZfSlbqtYUzqld26PzVhLoA041nuEv5QLgjvXZrZ7EY33CXwh23bQMudMDQJJ8aUItLnBqdYNiPZcZt/truHPsk67pwQ49elWngtY7m5BriixP144UwieFVFe0ZDD8p7oBN0bgzXNFGulTfVAY=;24:xXE3HzUAf4IaDLl5FMKarotM8ezqWGw1NrIjHDHvu07x9/+uiWXBFRXTx2uPNF/6Uu4whwxn9SOME5CForwOiAat/OW2xPgyEMaJKwpgM1o=;7:zuNvN475Th1a1OEY8PaV5gcYnO6CQnPZ8tddP2y8S2s32hz3IdoEHG4IXiTRfQ+JRuTSG4PlXmszWU9oprGmOYfWprn7Q1z1VXutw/wMaKZqlCu1+rub11eRD7nLeFRxwQCebD/J6aDJf0pNf7Gc8AjDK/9ddO7QXNnvK3kAx/aEql8Rq5fxmkQHwawlPc2vdeYHWN3G7V0894wE00Tq/BWly2Dh7Iqklee8F1eGs0XTWPA/eFgWEQtU18P5OWFk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:57.6115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031f24d1-9dd1-4ce9-f297-08d52b199ed9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60897
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

Values for the CVMX_CIU_FUSE register incorrect for some platforms.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 6e61792..8947d88 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -43,7 +43,31 @@
 #define CVMX_CIU_EN2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x000107000000A400ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CC00ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AC00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_FUSE (CVMX_ADD_IO_SEG(0x0001070000000728ull))
+#define CVMX_CIU_FUSE CVMX_CIU_FUSE_FUNC()
+static inline uint64_t CVMX_CIU_FUSE_FUNC(void)
+{
+	switch (cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
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

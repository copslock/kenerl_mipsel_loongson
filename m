Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 23:46:16 +0200 (CEST)
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:55342
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994614AbeGCVovsX6x9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 23:44:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVjtCSzX/4MPUs5iAi2XUq9zMDRYPaa9C4rmKcHh084=;
 b=ScVI6fmosPEwJe+xHKNCLF5x0aPXLj6Nju6dvSrd5obfLvuBJLkZ+Grv61mxMwayhHkVxW91uxZ1xWYB9f4jmnULaxId+pISY/UYz4T6f0k3yvu7Q2W//BGLu2wvJ9aosD37yljoD+++yV8G1r1/SGkeBvnpmmgQNIMjybG/BYY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3960.namprd07.prod.outlook.com (2603:10b6:4:b2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 21:44:36 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: [PATCH v7 6/6] MIPS: Octeon: Simplify CIU register functions.
Date:   Tue,  3 Jul 2018 16:44:25 -0500
Message-Id: <1530654265-26949-7-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
References: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) To DM5PR07MB3960.namprd07.prod.outlook.com
 (2603:10b6:4:b2::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f0424e-3637-4cf1-df54-08d5e12e2c66
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3960;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;3:gXiK/7yNTUa51myimqPDPIHDApA4hlxSU0hBxA9gV7PejYLLvZEc3s2Wgl9YOGUIo6RlytlHpScu6vO633s7IpR7p9KezrjZyZ4PAurE78O5U0eXWDA7akNJkvxcVSAfdFDJABRH+TOt3yW9Rcs9Z2A3t37cG5k3t6fCe0J/lw7SN4JGBm7ORN6Ay7hRvVuHPFwjjpuo6QFwjInCH+mGm6Hge47p4HMHxgYhPU/hJ6YCIwLeUNu8ezo6s3ajX2FL;25:7BXcLKD5uZEklaWFwSCLxMzftBJvbklhk7Y8uNvjTYhUsB+EmXwHlByfZ0dJgwvSTP5UPp/TgGvnJfbeUlvMgUj1MaakhGdswY0Y1DcjYqGnrY4g4gPk1nBN3fIJhutaWSsLaoT35SxxbJBQSYFQ0LjSa4wvih2/4UJTcTe5xjk0dWJhP/UCQz6GpXIRKiHlhRkwazmpiZJHhCpfpUn4eJri8mIhJGNv3h3+z4WNwFsuApY7aYfoByxHsCm1m8MOqTEcaVgUaFS8YWBxOLCjtohL+eFsXM2h9IY0ZGwY0K/gkF8DEPrNTaIeIOXcwz3VJ3LK1DXTsVO4gwsn0PQENg==;31:8AtTCdZ5SqdcIoyRN3ZMgLKAN1pXogj05yue9Us4C1/pta3UajYhCE9OUlO5NQWkc3ga2kuZ6OGOn6+44YXgMdGhUPq1E4ibMUnUgQU98lDcvYTPz+jZ8BKC4briv9syquRn2Hx3b2RjslM7EJ9Iz28JiE+GbwiPrcNbCGpthBnllswf33B2QgfOtQe8di5k+/lzckyXyi8ET6ehcCXjLlIFFBcglcU/2GyGycO+TrY=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3960:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;20:ag4RDCEjb0OJxma8Bc25b2aP5dZEhkg0KZ6nFY2KlbeppE5xkffzE/z9H6P3+kjNU8AhGBnRbhFiFea4PW0ZNxGFl7UIEQIbrOW8Qhn+h6z8KtbSGqrVo55TIH3xeXMgq6xr/2ZxzQtHjLKySuM3wuWrtcR19bzGVJatyxV8lXypDjtx3wIbpwgVMO1laQDfZ3zmt25+8SeLIbawo1NTaOjk+h/7cN1s4A4okEPDtB5JSvUfiyanuOFcDflwSYJNcpBLM8QWk9Ey4DeRXIWo8lLaelCBkxCzNb/4MAZJDj/nPBrlPdUCGjdq7M06KP9WVNRroVxxX6Svdto6HtAmEVrzjFsKUYw6gCPQZ2F2W5zP9YycZEeu9j3X8xQWkHTCBEz/r7fIaoosSoMD3qUF1LrILqOWdGarF/Mvf75uLDTYTrIrAXznNgrvOO3/DvmCWJ5fcGY/lo88ABlpFo3OqVbLC6lM1zPy/+YotytZ8fB0EUHf0eDnHq0S+9OZ2X8V;4:0e8GUCx+pkYH7JhGt2n+ZQKxfsWTs1pcSpyEaW0nwWeHH6SYt3OFUVAbeDslqRqdEhvIKqYsFzW2BahEJ30s3csXo5gBgVbrcf8kVPiIBtUhwiSZRSC9AIhBZdJDmEYjjL/XMxEkaqHPrTUlMrKG0yMvSvNfKVzuXSkCfSNuySA1rTym7Ywfw9WZbMdpxmh0Jx+qaF3+LS+6KfyZcfHILO4lv7PArXpeIyD1md1Wfzr9WgWuU1kEbXHh27g2UZ7EtZBQI7msQd4tlSpuVAGKNg==
X-Microsoft-Antispam-PRVS: <DM5PR07MB39600D14F7CF1ED06A20B13580420@DM5PR07MB3960.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3960;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3960;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(316002)(6116002)(5660300001)(3846002)(6916009)(72206003)(97736004)(6666003)(47776003)(66066001)(6486002)(53936002)(68736007)(16586007)(107886003)(386003)(36756003)(6506007)(50466002)(2906002)(48376002)(186003)(26005)(8676002)(53416004)(486006)(2351001)(76176011)(2361001)(105586002)(106356001)(476003)(446003)(69596002)(11346002)(25786009)(50226002)(575784001)(51416003)(52116002)(956004)(4326008)(2616005)(16526019)(86362001)(478600001)(6512007)(305945005)(81166006)(8936002)(81156014)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3960;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3960;23:932I4P0zRtrby49b7D2NK/FRfKncaM8DR0m7Kmbiq?=
 =?us-ascii?Q?eM49YSi43Ywr43ZCZuqsbbgsV6Xn0N9xUOtioMVVCY0KpETR0IFf0IDCMuti?=
 =?us-ascii?Q?rXFnJWbYjRax5PvLpdSFrNsvLhGMPjo8QgU84Jgln3W+AOuabBYmEQJNHNvd?=
 =?us-ascii?Q?k11LF7dUn/xdNkhNSf7w+Q6JWH0ho+tnYFhdIk7QDPolMA0NbrxtTnR6igwx?=
 =?us-ascii?Q?zEQkS/1zKhEU0K9lrBRuyD40SiNoCj+6wbXzakJVjvxOrdz8bKslDezbgKQ8?=
 =?us-ascii?Q?C79G6Bs1DRfjrXlGcd6CLyDKFw4/EKHp8MYDcmCXHe4xc7kV58ITRqwIhzWV?=
 =?us-ascii?Q?51j2yf1DUJLWJ/64fzrBIXOhI4xVjQxDkPwiBvD1fRqkIboZVj4QYRHpWx5t?=
 =?us-ascii?Q?lylC2dScb+SsnQf2LrwECh6vMD89M5cFeCOSoNAUwUxjdpG0eHuT5NEzQUCZ?=
 =?us-ascii?Q?UAE8pPISwKrH3gQioCJOAx/BkatLn/2OgBw42P2fqU4lfcI7FarrRN2h6rFc?=
 =?us-ascii?Q?zoSSed4fbf26QRJR2B/N8uJJGPw82+dbfbBQmVQjTighW7YC+1rhh5mDiF/4?=
 =?us-ascii?Q?ON/my579R8oAbs0qVitGZ+p2K4aM7woHdxjLH4+pVQ8n7pdg9Ld8fA8Da0g4?=
 =?us-ascii?Q?rsC5si1xDVDM47Lvp1bZIRBQdD1chs/zc0pX6BiG7/ySPgqSwGoAaE3I10L8?=
 =?us-ascii?Q?qWZuBu6y1UyIzhQBdqoIlIfyi+lY8bGdEAT1QaGTNqDIlxpVNQ4ycho5Qqte?=
 =?us-ascii?Q?s6vSi1hC8DjnIHxO0Kkar3MZKwvbe341wHmlk6AlR0b8vD/CPXQPDWT0lLXM?=
 =?us-ascii?Q?N2CQ9SeQNTYd323ca703Y8BGL13lXRHU4L26x0tH87JEXBsuPms9SZI/z9j9?=
 =?us-ascii?Q?+4GZvoGa06vcfP8jKW3OIZy8ds/uuXi2+YzYAxqzPX+b2GPjKukhjP8E2h/F?=
 =?us-ascii?Q?x8LXX8uarkIdRI45Ua6qryFhGTni0UkIirazfCn89oiyQbKeDZW8qD5ECc98?=
 =?us-ascii?Q?WTA6AH7JFB0fxFjhZpGnLiUjP1emdmdCJU2zV+v/VTVX1p0F+a/Rfo8Cb5IW?=
 =?us-ascii?Q?RBAcmhDhKZYO9dp8z4yoR7T2FLp6HT8c0pxGGQzg2NwCcG3wO7hx7SR+Mbmu?=
 =?us-ascii?Q?gzquHdZ0WaYH4AZBjSnl4GgKOAK9V7D5RNiMAPaiKPAxw0v9SS6/SxKTTfuE?=
 =?us-ascii?Q?7/vbgvj0BixhQUDYOjffVb3loNA1D/BYekTqm5ler0RdHGIISZZ5L8ONCH4q?=
 =?us-ascii?Q?7fbGXSR9oR2wFiBaR+U5K5B6L/CvkXDqbLwSmx+Yqme/IPUgs9NiERugDFyS?=
 =?us-ascii?Q?HAZJGZrz+rtmfzTL26EqNU=3D?=
X-Microsoft-Antispam-Message-Info: D4OoG4Q89jlQBfk+ulenUvtCPkIY10gOXkELQMUP4/aYy5AC4AaFPIhJ4jGoI8rSuS1T4LLaK55u4WNyX2nRgWy+DtT6RbB6oH8j+0N7Ws9QjSOSuRsySjmj1GmzIHQKXBFKW25siqqfPYSwkdwvL7yzO7Y4ru9fu7yUmedpSVZyKGiQm8ozEbuV72ORxbexoH+zmIQwXJRFQG8Rhh6EKswlee/CGolujlfWiXFI7MGvmufOn22ZDFqPAozHgKBEewa/Coz4R4N85cloWLVDUoZ5bfIN0hQb5+ZrI44tlkySBpsKxLtg+KEbvK6Dq15bwcaWQQj/0j/B48zjGhBnUvb8Feuhhe9qWtIQK5gTuK8=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;6:LQk77/D1rWlzUBqjJKsYp+5/7FdNbDCvyGh6mDWe/V/HyD3hYOoY5ns6+PBWy1YKjxLzx0nKpd232JSbcdgmy2jpHVemEgcjorGgxLzrqn16uF5LVV2GjqkVWbmmfn3eQ4T4hmQhaEJzo4H+L3y2kYqDLn9UlzXnVuvCf7/K4fDEC8iB+VGKlZzVak2ryHj6Hkjuis+pKwaUuxloub+HbhTgvm/f4K3nhijlTD8YdF5wk0+neqkop76BhBq7seyJFBa7kkGi4b8D7cTcIAOS6mDlyHxCibD8UC7rzMRPNCUN5ZQplcu/nez5pYUhU7HSngC3Q6yXx5zy1nppPzWlTKaOe0bB31tPiuB5GuVo444jC0e7Wn/1VVVDWtzXSq+q31r++uVk4e6UotoXRtLn0JkrjtFM+yGwL/wrqZGQzBqgjOBOrHd3qrTaObm3w9+E88/MV8ZyzQSo7uWYX5ikJQ==;5:CGDRVl+OJ+GgQVqHfBwICiVXiz4iYEhMD1Wb8Uw9GahuCJG/aEEiT4AVnS4oQfEIVGyFkX/hv6jLPja4/y7VHXA/wgMApIl0UtaE372bUEtJMkQGUf9kQ3XtGYAoVpYwPYDIFi4TMS9P7G6LPf07DJWgx+1Ok4Z+NtzRF59w4QU=;24:VOFA9YFEvqcbTvQeh3de0HVyvQyqjE/yzgkDRaeQGJ5EOBK2GhDuIwxEYFaOquxPTJJV/XeqkMmZBsGM6f/gQZ3nzdj0Oljb0KQhN9KbgO0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;7:IQ3BZd+W3VvKm+y5vV4xVNgGtMvoWyx/uMb2nSzHmGGtnLJ6xTOo7ppJid1wmV6SlORHhL8lLjmcDxzQbkqIhs5GgJfVgAubXK/XMvzq83sK+6btSphcOXwzR6kKP0/1CD9ehlbtAIvk2k/qL5xUeJCYkYFkhqJifaj+QJxmbkvDeRRlcdzG0hWdWE+XlOkpyeFm0P0PdwCPk2gMRTqR08ZbpnLJ4eLF5dEPGO+JWnKtFGriWL9CgJuTim4EqGnn
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 21:44:36.9125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f0424e-3637-4cf1-df54-08d5e12e2c66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3960
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64596
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

Collapse and simplify switch statements in functions.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 116 +++++----------------------
 1 file changed, 22 insertions(+), 94 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 652f166..1d18be8 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -42,122 +42,50 @@
 #define CVMX_CIU_TIM_MULTI_CAST		CVMX_CIU_ADDR(0xC200, 0, 0x00, 0)
 #define CVMX_CIU_TIMX(c)		CVMX_CIU_ADDR(0x0480, c, 0x0F, 8)
 
-static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned long offset)
+static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned int coreid)
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
+	if (cvmx_get_octeon_family() == (OCTEON_CN68XX & OCTEON_FAMILY_MASK))
+		return CVMX_CIU_ADDR(0x100100600, coreid, 0x0F, 8);
+	else
+		return CVMX_CIU_ADDR(0x000000680, coreid, 0x0F, 8);
 }
 
-static inline uint64_t CVMX_CIU_MBOX_SETX(unsigned long offset)
+static inline uint64_t CVMX_CIU_MBOX_SETX(unsigned int coreid)
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
-		return CVMX_ADD_IO_SEG(0x0001070100100400ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
+	if (cvmx_get_octeon_family() == (OCTEON_CN68XX & OCTEON_FAMILY_MASK))
+		return CVMX_CIU_ADDR(0x100100400, coreid, 0x0F, 8);
+	else
+		return CVMX_CIU_ADDR(0x000000600, coreid, 0x0F, 8);
 }
 
-static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
+static inline uint64_t CVMX_CIU_PP_POKEX(unsigned int coreid)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
+		return CVMX_CIU_ADDR(0x100100200, coreid, 0x0F, 8);
 	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001010000030000ull) + (offset) * 8;
+		return CVMX_CIU_ADDR(0x000030000, coreid, 0x0F, 8) -
+			0x60000000000ull;
+	default:
+		return CVMX_CIU_ADDR(0x000000580, coreid, 0x0F, 8);
 	}
-	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 }
 
-static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
+static inline uint64_t CVMX_CIU_WDOGX(unsigned int coreid)
 {
 	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
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
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
+		return CVMX_CIU_ADDR(0x100100000, coreid, 0x0F, 8);
 	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001010000020000ull) + (offset) * 8;
+		return CVMX_CIU_ADDR(0x000020000, coreid, 0x0F, 8) -
+			0x60000000000ull;
+	default:
+		return CVMX_CIU_ADDR(0x000000500, coreid, 0x0F, 8);
 	}
-	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 }
 
 
-- 
2.1.4

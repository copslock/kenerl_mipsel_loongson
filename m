Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 01:58:05 +0100 (CET)
Received: from mail-by2nam01on0054.outbound.protection.outlook.com ([104.47.34.54]:46912
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990517AbdK2A5UMFfci (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 01:57:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AQml3LPrz+vtfgV7Kh5GQs2SfqjLa2H1W17iT+mgL38=;
 b=hl4a515+hhiLSC9Y8S4k3T1LnF9lWDT3gz1MH9xYwGX0rRzPliL61u5ndhsKhPsvrhWxJiruY86du9kGn7DSUoCEBZmcrdmumGFYtGwXXF/MadMN1eMt0s18E879IAVtqm7R+ts94a4KuMVuj3cNybFHA6/xKqGHvO9mNUc+EEM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 00:57:06 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v4 2/8] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Date:   Tue, 28 Nov 2017 16:55:34 -0800
Message-Id: <20171129005540.28829-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171129005540.28829-1-david.daney@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0096.namprd07.prod.outlook.com (10.166.107.49) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57d0a03d-aede-45c9-3b19-08d536c42000
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:8WJzBGffIgD4jK0hajsf4haXakF+gEwFUnO8hjp9bXMqkFg1DlZjEBMmPbAU/eUtXhpyDFWiL5z7RWV8LJXmWID0vVfEFA94nBQpPCY/3I5nSO27hO5m84otqSm0R7gkkDutrtxkAV3ITjjch39fwpRRWzpDYidARl5oSVjPFfG+UKqcdBy3GN1dtpzHD8v4Zo+WXGskpagBCykzgTvLxT+gQBsil+s6ynzibI3RmGiQV4TIzh0aVtjSb3BY+ABu;25:FuuXLDvZRB+O8zqsr5P/4GHbfOSZ5rP2b5m8/MuaB7KyTi6UW+obNV1vzU4ZOcmuBMBHFThlqK852YeUCRriuJtdcbyzHEA1AsLnsgz8TK1S38re6qcgRaapDys4WZ8+yhjbXzNdyqF3xBv0lpxYiRPAoPKo/jI3FR6F5u836wPtno+Y028YeipelkMN8renwCjCdq9qolseqdEfJPhSjvqIq4B2DZIwOCPdFQgCfbexHpdluUvlk+DH9S7t2Ziz8D4VH/8xZGaam/ih+sNjZxEtHGbBn7b2JNRbq2bs57wMAWVIV6H6+cIqnyR1ZNgVZTYVnTFcf/D9BjZMLhakZQ==;31:857xbTNlgtqKYHr++7PgDGZb5IdZNu5ZR2nRUPuL+y7c2builZ5zGOOFz8zHINMgY1SgwfZtmHkU7jmXmXS/gfo3vqFcj3tunc7ppvdIpFWhtUXIlMc3pI7GK1C0FcVpIbFYg7aa/vpC/a7NqtNxGBkSxUPtZZt8BG5YYeHUYVkNkoHK39WSrzD1IGVKFAAResCh0DwU23m4zCbpcBbIQY4rt8f+T3jqnmt+fLEM/2w=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:X8UKQbATDQ+MooG3EdI+xzmvs2E/a4JTMUHljKGM6e819arOirtcBV33Bs8/WlndJc/0v0CWjZS+r/6Q17427r//j9ilomz30yaUvF45qbBBbH8bC/TO6wpVpCt5EYe0797gasnsgMUpyCcj0qUyksMhXDYf/1yIO3NSwcpoRu13gHoEaBtxPioc1xkXXbFsdXi8V3LtBqsTkkvh6HZaGFroaxzdVrwXqDgMUegu5dR1V5BvSx0I5oEBYD7iboHhBCqXUa9ZdbBR4da+MnmzdasqUB8klY8T30qMe+PT3WQa8ilzvhfugr6tI6iMIg2weVyahnjIO+oLVaR2LD9l4F7dFA47d9MNQaozupmpYCvwdVBQrxVgF4GfkdpBl8nivBr8IP+PHDozaMXTMuTnGLwzCDZNtQENMvrgC36CGg17UAkmJf0g+1OWzUrNPUbMzSAvv+gps4fHlSFY7UwRK/UXEH178cx7yMlXQCM1JpQivlbriaJ0uSk+GSq9D+vZ;4:ZcUN4apoSxHXMEp8ga/lj2e61ID5bKYgIErQOBlQtsdxf536C2R+bSx9LkM3cFLSOi9IwRrMkhyCUwzegzNn99r14EO4yHiQAvqFfOCuSoCWcIhWQUWoqunhrrh/vaCoz1c6qZtsx7t12wtPE15npEDVyOPsN+FjJktLtq5JUQU6VF6Rll3cE9kLhNI/a9+4T4AsyDEy61FOX2kxRTanpYtSlMlNCvJa8D5HA2jrhFJ2FhHFs44fSNWHAcO3hBPZ2j2wb9S3dsh+r7PxVBwTXQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495A7BA7F20092920EB793B973B0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(6041248)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(39830400002)(346002)(366004)(199003)(189002)(50986999)(16586007)(8676002)(4326008)(305945005)(7736002)(76176999)(101416001)(16526018)(86362001)(575784001)(53936002)(39060400002)(107886003)(66066001)(25786009)(81166006)(81156014)(2906002)(50226002)(2950100002)(1076002)(106356001)(7416002)(8936002)(97736004)(105586002)(72206003)(5660300001)(68736007)(6666003)(33646002)(478600001)(3846002)(6116002)(47776003)(189998001)(36756003)(54906003)(110136005)(51416003)(53416004)(6506006)(316002)(6486002)(48376002)(50466002)(52116002)(6512007)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:A5A4tLRZyaAtFaExziket3m7x3tcNA+mlmBpuP5F9?=
 =?us-ascii?Q?DL4viZJx/6PFzzhr1nURWLH9rurXD0HE20L0y3uWgOhbMkfMdBOXyuYxre05?=
 =?us-ascii?Q?CjeP/2Asdw/naJkWBCZc2xEzzhbXxhx2fLwel/s27VQryjLzEvf1c7ujbUSU?=
 =?us-ascii?Q?LwwDQup40sL9VA2tUBwrYhGS05hbzURZ5+zqtNdlbY9PML8mOlThkqRW8gpv?=
 =?us-ascii?Q?hlyKHOg25Q0ENg5pRviINCfNoxWM/x8Su0YvTspwFfeb7paZGYJU7MyAxaXJ?=
 =?us-ascii?Q?glY5wPqPIahXg4xze00yYMDvE+xgp/Ox2f3ibwio0fhob/gyZnmVetLKdTIJ?=
 =?us-ascii?Q?e5NjrGp/xIetG7oZWhZtsm+C53yp9Yc+uSIxBCYmwNrHK1CkbHdDEfbnjQKs?=
 =?us-ascii?Q?tWN1wheAWrpzEmjkOjuwaP9TncXaei8JsbGRHBvxFbWvXAmX0kjDfxG/J5sZ?=
 =?us-ascii?Q?3TSnPeaT0OQ7Y25lmwkZ2yXjGCLY3FxWl8bNjVD44VWSPvFnWhB6aLOJsQb6?=
 =?us-ascii?Q?i3B5o6pswzIbOpdbAnb7tY99QYV63Z/vH6zIsFkQsLrbDqKQ63GiFhd4Ejyr?=
 =?us-ascii?Q?v/b5FeIK1HhgaSjCc82LwX1MQ12QKn54zRF50QlcXP84LObo4J0QRs7Nnf3U?=
 =?us-ascii?Q?m5hEZSz4cIfFI9+Vvv88udf8znE6dAjfMPYj2KHkeE5PIVsZKQIo+dyGhrsK?=
 =?us-ascii?Q?SP2tZ4ZZAfp84/CVLD9JB1K4NmVn4oAd6uh2pA0NJSxKQIFAxGvQnEC8RVC2?=
 =?us-ascii?Q?oycsfI/5YmzZsHgFcL0tVKVkVmYkq1UVIp7gy/KK86pKNMXP4oDFiOWpaEvN?=
 =?us-ascii?Q?7Xfiv2FP4EzlV53eapd3EUpiqkrTU2L0fR5lj0M0dHnyJ30P0ZJZElD3PHbJ?=
 =?us-ascii?Q?iE9Lh19UuqC8y3DQkx7IHQJmG5I2NRzkTuzKKRg5fuipPae7uvHsJPR5hL4G?=
 =?us-ascii?Q?3QTPv4YR8RatCtS1rwwGsQXZOjBFvjLA/Gqurg1UshSGRpwzTIasvtxJeoaY?=
 =?us-ascii?Q?Jiy35LUD5YCuO0F0g30bfBNurEbyRmrVpEjG8yH+KknCjoyUez6ABG0iIQCq?=
 =?us-ascii?Q?fJCvW9fpAtP9gvVqRbwMZnYxmZ52RKgyw9Qq5C/nOeI0ntJnamtwAqP/eJMw?=
 =?us-ascii?Q?MMqYn3Ra0nDQ/I2p0CIhe9YdN1eidDOG4EsOTJY9CLxIBBSbadELM3v+0Zwp?=
 =?us-ascii?Q?/pq2MLPMlNLIhN0EFSssrkT/T9SUWcc0r6oq4kWXUQ8SbtGG1lvyfR9UdktM?=
 =?us-ascii?Q?yKffROG8vcNR057bvterCzr9y7/KQQyA7BNDMwrDHFB9lS0h0rz80eyOl3o+?=
 =?us-ascii?Q?N28QeODMMOtoxHzGsJEgHk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:ZHChQW7nnD7KJ+lD6oIbTcXFIlsRcz1nwJ7RG93nLHlQFXHNwljMQd/aD/M9yg3MWExK/2RIFnLl2ERD069fOoQYgu7N758KU143h/5/fIYP8zN7oq15huq3S5Bji11dadK5qal1HyelfW9AV4CH6Z1Mgg0Q4lc1ITmsmguK91cxNAPcKU+IvAeYMHADAvD94fYYXtLLrSLNMbhXMggSw3MZAsrdJ0oYwNi3hSWrEBh5Jew2xRJt+eG+aF6UhFxMBePsRYVCg+Va0zIb/C9AhDdSB+sfK/7kROB56paFfifPgSbqfBC9EwnCIDCAEhts3+a3cISXUSBuD2vF+m2i7DXfd2bCWgFqg7OULuuGMeI=;5:RXdqhYRspD67j5eZSlbs5Yau4ghnTc3D17aGzQwqji8eAEmLCPHiKqgORODHLfdiS6vg9esX7ObyJyFPOd59CUnKqFFJ+tWfuYXNaO/oW8bvwEitET5wxI9k/50ERt3kd5dMME+SRn5UnDQcCMedz6zOFfP0ywPFHMXQXLMu7bY=;24:UhUXn6eaXzDISQVpPmhaJJTrNvF2QPYc6za9neAC+SKk3Mq94ys0t+qde8C1bziEflxJALfX6z4+xpVUfDLInaVlEasuuDcIT5BmATxq2oA=;7:jgvAY1pUusaDlqgZ5JK6K95qeGvehLoSBosvjTpc7PTNQthH/o2WWa0g5+qLML7g8XW7+UHbd1pBVTBk56v0Ynikao5gowbAVBsb5IXOhSdBM4Z5X2mAu0LI4C3CUCm1hwTp+fHMn0/8PAkH0DCP2k2PhBQgMD30QLRFpeTvgZysvDaUZAxtglf1O54jZ37md5tzwBbJ4O7ggjVPENAsoYNGB2buzSDuOSWFS0kimyoMEfPKv9iMj+ys4V2yM5nP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 00:57:06.4919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d0a03d-aede-45c9-3b19-08d536c42000
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

From: Carlos Munoz <cmunoz@cavium.com>

LMTDMA/LMTST operations move data between cores and I/O devices:

* LMTST operations can send an address and a variable length
  (up to 128 bytes) of data to an I/O device.
* LMTDMA operations can send an address and a variable length
  (up to 128) of data to the I/O device and then return a
  variable length (up to 128 bytes) response from the IOI device.

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c       |  6 ++++++
 arch/mips/include/asm/octeon/octeon.h | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..99e6a68bc652 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -609,6 +609,12 @@ void octeon_user_io_init(void)
 #else
 	cvmmemctl.s.cvmsegenak = 0;
 #endif
+	if (OCTEON_IS_OCTEON3()) {
+		/* Enable LMTDMA */
+		cvmmemctl.s.lmtena = 1;
+		/* Scratch line to use for LMT operation */
+		cvmmemctl.s.lmtline = 2;
+	}
 	/* R/W If set, CVMSEG is available for loads/stores in
 	 * supervisor mode. */
 	cvmmemctl.s.cvmsegenas = 0;
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6a79f4..92a17d67c1fa 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -179,7 +179,15 @@ union octeon_cvmemctl {
 		/* RO 1 = BIST fail, 0 = BIST pass */
 		__BITFIELD_FIELD(uint64_t wbfbist:1,
 		/* Reserved */
-		__BITFIELD_FIELD(uint64_t reserved:17,
+		__BITFIELD_FIELD(uint64_t reserved_52_57:6,
+		/* When set, LMTDMA/LMTST operations are permitted */
+		__BITFIELD_FIELD(uint64_t lmtena:1,
+		/* Selects the CVMSEG LM cacheline used by LMTDMA
+		 * LMTST and wide atomic store operations.
+		 */
+		__BITFIELD_FIELD(uint64_t lmtline:6,
+		/* Reserved */
+		__BITFIELD_FIELD(uint64_t reserved_41_44:4,
 		/* OCTEON II - TLB replacement policy: 0 = bitmask LRU; 1 = NLU.
 		 * This field selects between the TLB replacement policies:
 		 * bitmask LRU or NLU. Bitmask LRU maintains a mask of
@@ -275,7 +283,7 @@ union octeon_cvmemctl {
 		/* R/W Size of local memory in cache blocks, 54 (6912
 		 * bytes) is max legal value. */
 		__BITFIELD_FIELD(uint64_t lmemsz:6,
-		;)))))))))))))))))))))))))))))))))
+		;))))))))))))))))))))))))))))))))))))
 	} s;
 };
 
-- 
2.14.3

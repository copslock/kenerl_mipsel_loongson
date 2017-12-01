Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:19:41 +0100 (CET)
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:45440
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991827AbdLAXSkofGns (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Dec 2017 00:18:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QnPtUVgnbk5xAC/xH+aI2c4O7LD982h5cqkqgGONQSs=;
 b=QFTfq9/RXPovop5IvQd74fQlVfoQoS3xf7awMFYKLA+JX26oCO1Mcw6FCjtRj4R/usVPPWI7r1I1WhV0DUt95VSngbtdNJbR2TJizpHIlgcAjA0saeAxTKYsFUHIxYbycMJaVsPxHTUnESU8yOU3OnpmX583ACi3wumgo2rgTq8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Fri, 1 Dec 2017 23:18:26 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v5 net-next,mips 2/7] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Date:   Fri,  1 Dec 2017 15:18:02 -0800
Message-Id: <20171201231807.25266-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171201231807.25266-1-david.daney@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (10.174.192.32) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d15db08f-62b2-4c13-75c6-08d53911d6d7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:UPkb/aZtNpVR60MCmfEmq3IJLr1pwqwvd0pjJ13JCiNA2jKQiZP4RIiPYQNRy8liJ1AYHSxkhu6HytnL6b/evlUxc6FcLTpBuurEBcYbzA6OZRmnP4UejI7UamebgjulhuTicoB5/B12Dp/q3NMCbuSzmIbQE1IWPyp7o9wRH05AAdMrP286ufoT3xuTcvVPKDYQqZxmvV8k9KHhYlgzKqUmhDSDMCKV85zYLAL3vCxXkgt+75UvVpiHF5aTofDP;25:bj1GN1AoAsuUfqHsH0hnrpS4kyfFQvQWcH4BCGLb0BNt5Na7qqvEfexFjnXibHEQRiQHlfCTlZISjT3lDzbrx/CNxPJsCidCKyp5vB86Fjq3CYFLCjuLHSp6k2OBlllkrM1eZ3710xK5L2MF+ZFZjs+M4VZ0KTr74GPJWhOtgODkGqW4Ox7DuvWTKjN4CopEV7AiiR1KHp3TIbjNZT19RJlVb752gVOlZegAPtdi5D1JaBZfeqmjFL0/GmoME0McIehr2Fjo17J5neMrFf7i5sksdo2iAVu26yQu4MI+c1SWUmaZLyDQEzUuguAXxE0tpbnykQaCHq7JSkzO1zGzRw==;31:hoI3GclsjxdAcF3Q/B17O0UMPvOV6fJ2on6Z175QvroQ0IVr3lDPRwpIUdPXZQEWKgUsvSYBlghtm7QcNlcdCcPFWz3wHHRgFJsvyvQ+vmS2mplbX6+3FD8fNEQlrq5fUOix1I4+IxLYDpyYOnQxHu18jvbzofKBcVN9wzi7Acki9K8QGL/1a7g1SdcIoJPhOEMpmuvUlPtyeLN46uHP+/d6MS7m+8p8ZwNEduEUDGs=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:FgskJzKyZow9X+KhtE5mubfmTbcBo/Ub6bP8XDIK6GfAeMJRphJ3beTisZB120JWBI6XiDQtcC+3/dGjnk0C0sVTAWEGgDYlYT7sYQt+EtjO0VbIX6v8apu9v0zJJIxta2TLCtPVw0PYEbEQ2VKCUrdaOFcTart5Rv5nCiPJ7+pLBnUJqW5gk4fyAKFpmKip5ObdxpLRYIrJsy67pB0MHSXzwQn5vT6uT9wD/xLxXGFVr6Ew2Rh8XzMTLHu5vOzHoMXthiSeSDXkSnblDwNXklyAMtD0DFm4gK9GlpFuQzLQt7AtfSV/EjWuM6k9tkCpTrW3FssibnR6Yez7O6yq3fYBOsLqNwDAAJCrsPtbAwax3DuMoWpH5YK5M85D1kqzBUij46VNy0jTZAM6PUY3HebyXarvRAQal0ycTPRNq8N6yVjqUpbpXGDgIfhRSp3DyUzVj1rfUr+uaP/6koiv4KJdauvcyoWE5HU20nV8l3Weramze5aGHBy1UthpkY6L;4:8AXTM+xRcyN7tIhcq4p1byebrBneo5g5xmJE7ix5klLngqTLAAl8Kaqc75z1OJ5b/AOMi70oSYNcOEIq9dhhL3xL1GqmkzMGG8BlSDLf/24OgP2vdeFN8iSE6JP7VY+xIyyMsTLhSxdPuyR2/nctMwZpX5nyd1okkuPUmXRlLP68wdC84qydezYpYD3OmQOx2s+6nJG+R0srLRMz31p0v70VuvkfK7eh3jwQlRhEcjWIEP7QwvPCs5wGzeSRVNABRnaW3uwDZP08RkoEVX8+jQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB349966103DD34300EF6E9C7097390@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(199003)(47776003)(72206003)(1076002)(7416002)(50466002)(4326008)(66066001)(16526018)(48376002)(33646002)(6666003)(76176011)(97736004)(86362001)(68736007)(25786009)(39060400002)(2950100002)(101416001)(478600001)(53416004)(6506006)(106356001)(5660300001)(3846002)(105586002)(36756003)(69596002)(8676002)(6512007)(2906002)(51416003)(53936002)(81156014)(110136005)(6116002)(81166006)(8936002)(7736002)(52116002)(16586007)(316002)(107886003)(189998001)(6486002)(305945005)(50226002)(575784001)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3499;23:SZOxbDDE6ljmLD2UCwbwOrhiovMxwEixIzXIcPsta?=
 =?us-ascii?Q?jRGlX2Fw0Wc3AA2jc8M0AUaCsmFeBpVctVawHtl6JVR6mvQm2h/Rq9LqBi6Y?=
 =?us-ascii?Q?OGoLJioBx9WVyZZzc1ZkftGeK+aHsC9tCdGwdRQoynshNkLtXS30E74WGfuH?=
 =?us-ascii?Q?Kr9w0D7NVJUzllZCwDPgFNmTTzmxsS77wkqn01VRbajkPEvnoNBVXlBGXFFW?=
 =?us-ascii?Q?rgOa2bBpFluXzDuPM3flIPYb6UM4OdRw6ko5/kAYS29ifLCd2JyvKmaiyQEi?=
 =?us-ascii?Q?jXtbeaTh6Qs5xTCCz+ZCX48YLCCIf4UNNv74+gnO2oG9aH5qj96+pLy1LYx4?=
 =?us-ascii?Q?kWr2OambwRDtnGlihMWFm70dfcRWOGvBp8JEO8Mb4Euvrz1jiUeqxD6ZRm1A?=
 =?us-ascii?Q?YbpmWRbhfHfoi71hZkHvjjlwGyeg3Itx8c+B7m9XNhftC7YVL7SKWY54yZbG?=
 =?us-ascii?Q?Nn/KNMCOh+CsUm7uGEW99dSBmct0GS7eGy4I5MbPSPGGHjRGdT1PUpizgCL3?=
 =?us-ascii?Q?mAMkP250vRKKZQDbhySdZunhdQg47lhSllAx8FhFEGOvUEwt6/QpuJJrStvF?=
 =?us-ascii?Q?m20DkJFj2K/kuzNuZ3gc5zZu40dH1mNCGMwqCkLjsxKVOWuuOO1dl2mSOgNc?=
 =?us-ascii?Q?1saFx6XLigXrr3UuL1Qy+kgYSTGv2G6imSHc3dTUgkDPvYwPVDDqSInWlJsG?=
 =?us-ascii?Q?KmBojav6gtjnoMGt+iZfiv898OJ5C8WA/4UWU+WBeEckpWkJXM9Nwu33ddeq?=
 =?us-ascii?Q?WKc0VZkSY7ZDAjGpVhmmTAEjSJOSPaeh9WTu5MKH79OPuMvB0gingIhoH6TG?=
 =?us-ascii?Q?fVMs1jMYTbrv9l4DwE/ntGXikH4pe6SDyAKJ7gvfclHJecxIEFsQl6KhSFYb?=
 =?us-ascii?Q?+8sRc6bDxJkBacK4lvIb2VYtu74rO/GS3pVGGgy7eGrrfXo+DqRntzD2MRVy?=
 =?us-ascii?Q?9KA0aiaDR2w1aBM5SJd5jwwJKolG7lsu48QUhBJZOSZqv1bPGkqgm90bJP8h?=
 =?us-ascii?Q?OCmk5uXbJDdxVmDwnPImeJmn9TbrgWQOBs+9rxTyx8urvhNUDKBtJWlsrUGf?=
 =?us-ascii?Q?+J8YHbN/SEX3SB0L17A6gVMu4k3m3IPQjJn63gPin/tbcjtip+7rzqh7OIhA?=
 =?us-ascii?Q?Z/ZT4joN/KRWP1av9nW7w2779n0HvR3wvUcCSvsDAzsSwsECSffBzep439Nk?=
 =?us-ascii?Q?Pc8VhzlRg8X0nbyd2iC8/96WkabgsBW4kEYlcQUQsdkRKKs9sAVHqyMfWaZZ?=
 =?us-ascii?Q?qDsNxIyGdywsvc4kBR2c7A0pYYp5WPAu5WL2KYa1PhMJY1ZeqWdA8VBIN+b/?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:VubX/ABcDgEeyPAgC7dq7stF54W+NcbCpbzF7RNHtNBaTx85WvM0SOw5A10Dfc/g2yl+DOPEuR0WfUdYdRFXmJH3ECf/Kh/aqwOH9cDOL0ob8BFahNahpwZdrBpMlPwdssUpD90wn7QYA6QUaHvR5MBMEe726dvkKzIP8Vcds/dRiKj+KG7VDCTkXqd37PdqmUQ+GwiSfiqcSuw/NYsg2LSsqanSZwsU5SVkPoNKttu+y3xLCZxXXlT9c3oXqa/yZZuudc1hy0tdHzUxnzBcBCVumjAGPkOJvRUbYDJXmvCH6173qafgGh39eldaUMzycd01tOysJsXN3d17rIo284Ks9qne1B2vC062tSRvlQk=;5:jBBpbpqiAZVZSraqMJOG1UWjFtCO+cIcbw2F9YKuVwUsm1/MaY3Yl9RtPwlkkzZfIrkp3vjDZEhWFo/95BEhrzLVspxPw8VE0W36GfFz6s+216vKKx0DIXqqV7O7HjNsWQorspPyKwHxUeQ7cUEdABBZVzL5tBI/E4aS49lDb0s=;24:k0cDs+S3nQk4qpg290MK6lCzdBJmzHoZFZSyLk7yfTvZL35xqfANJAGhOtwdFRMUKad7Rs07gj8CSQvbWkt5icQ9SC+TLpSTRiigl7RjRvU=;7:amgVjcXKPBlV4xfx86CcllyJlaeysrPKR/ByQmqfCP4X3517+zqa6D9FeRhu/u6bFcY1nZHIzw7WIBquc7mpY3OakMr2MMr2KpeqPTgQOGkPF7gNgMrIBD6VicDpR3/1YfU/JANsaUnZ529S9t8CKZE3Etur0jx0qcgt3VWzj4Gas/qhWVLZVeZMj2J3qinE/lFAbnz7yOLw4heiQJldLH0fq9pIsVkjXPFPzlRW/lmmMjsqUC4EHf7+NJgmaVNs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 23:18:26.3214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d15db08f-62b2-4c13-75c6-08d53911d6d7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61271
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
  variable length (up to 128 bytes) response from the I/O device.

For both LMTST and LMTDMA, the data sent to the device is first stored
in the CVMSEG core local memory cache line indexed by
CVMMEMCTL[LMTLINE], the data is then atomically transmitted to the
device with a store to the CVMSEG LMTDMA trigger location.

Reviewed-by: James Hogan <jhogan@kernel.org>
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

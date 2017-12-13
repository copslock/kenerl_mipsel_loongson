Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 01:49:40 +0100 (CET)
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:30945
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993885AbdLMAtJjhJHl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Dec 2017 01:49:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QnPtUVgnbk5xAC/xH+aI2c4O7LD982h5cqkqgGONQSs=;
 b=ccu+iQeWBCntFDIgIEq0l+B4e93C1flzJu66b9iDtoMBpkna073V3+sfBxccasaA/GbfcmMH4jrGBSGdNHj73NnPeYekHbUSl51XK+YyGOJlAfqzjpfAr2Ifqrqb9LJ7cAplrGpFNqsS3JAKOJak2deFLFUThrD2+U3zOi7FkZ4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Wed, 13 Dec 2017 00:48:58 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v7 1/4] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Date:   Tue, 12 Dec 2017 16:48:45 -0800
Message-Id: <20171213004848.15086-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171213004848.15086-1-david.daney@cavium.com>
References: <20171213004848.15086-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0037.namprd07.prod.outlook.com (10.168.109.23) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0bfd288-701a-4ed3-f9d4-08d541c34f2d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:YspiOjAiRIzpSuETebPhBimWwglqrjWoQRfYDrum0EdCvm/G0eWL85+BffyxtjTuP0A6HeK3ifudDtQcDBOPPZfqrN12Ti6AFHh9uQgGirPo4w3sERFBcfkyOS0Z+6qSFruw7znwMf9k2i5Xg6RL78an0eOPcHSuvRAIHHwjdsuCljKtgwIHjeGanMXNz4UXIaoxDMS+CwK+cIF4lgg8ifXejvDrIKrhk1/SNZl1WyukvOj1QezjjiUiw2/8IxEh;25:/Dpq5sk0x68AZdh2zsk13gFSl4ORIuSwr4+Qx/mqYEXP0WBeU9zrApH1Jl70gRyVWsU31WMJX8YpDeBvpSL7OJaIbON7v+xK4gpDLVbrRDfvcN2TNkPL/7VXmrud5NGnJ25PPB5zLR7xZg2qbN0SmPEIOoc6FQmWWp2TTkhUAMMcRWlwso97m5DKrUpmfheh7eO/SdkJNgWXPR5yEQGf0veso3uOGYrxouC4aU3yn5NiaBj2/ai7eJOcx7TBZoHtKK5tSgV4KsLS97XOotofLYU4gSuPz86iQowk2PsM46WRuTakZHNamHNb2Lg9ImrzRIN0JgjJbx06sreoW5T9EQ==;31:EoxRYmxFTw3xuoXUbtdN4VBbqsN29SSyKZCpADufF+muDH6J82bvI7h9agqB3HFPfg+iJabvVaorZjkUKW44mxgedRaJxD4U1qgrAz1G3xM6mJD1bXuaYfGA00Ae7lc7k1wqPFl93h1lsdYy+q5KWS4PzHVJ57Lu70PIqMBwnDLlRkSbmnLIRjP/J3UXBkFOBZUFlw/YUOrweovPhQfJtVhlRh/mAifQHYNT9GykOW4=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:MVqvKIWfEam0n4zyMMlGEckzUNxCWy1S/ittomFTDN9gplWKFxdTFRrGDSVV76Qxs3xtXQD6WySihonr60J1VAWAbislTqYJdkhEtL523tRWMSkVJ2LCyiW39DNZjx9BjVbXOgLZctwNq4hhX8TEzGM9Vu6JzDZPHVlDqI3gC9G5Wnhs04VcE5CRiNlNvn4S4i0R2sVu6Ly/D8mqi9kua6F5JCMCuwNxmbsxwtiy1URSRySCCurkivEGjHdUzLw02hqwtN7FpLC3Z7em+P/UOX16jG+UBGk96fRKNB5jjsKrOkjGz6of7CNhVyNA8POHdAzQIztHmo1sBprR5y1PtzhrkYfpQFWhRhqwzIfPyTnkDuP9udp3bFCH2LTu8xt3XyyUwZ+c9qSZqp1N28mS+PGn3aGybXKezdX4XNc+hFdlWmgZRqt8bXzXMa/wVrmg8KldJ51egUxa0CG75x6sUbWG2LQXtrxYxT+BipIu/81a74RK1NnQ2gpxQENdkW/c;4:q27OXkFWsPgFUbPTJkmGZfjTdc6W5YoCtvf/1//FrYkuaudWyZ1MgpnyZgHBFv+RjYAy0HMvIdEXzYUh+baVRkwPBUUHEZ/JUiW505xT0jhgEVyCW16lC8udXt2GiXmUJzzl/YxgfaXXkXkfORACJP+jd9CthBTwSzV7ApSfNM5x4wfQt3cAt+daGK134ybwxjDqr2rOLF5wrJZdharOTABchbGqGT9odNDrN7yrgGTEcoC/vTrI7rmhQu0o8D2Gmqv+NRqonQ8q096+/R8IIg==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495E7D0651A73B394CC956F97350@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3002001)(3231023)(93006095)(93001095)(10201501046)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 052017CAF1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(199004)(189003)(106356001)(52116002)(105586002)(53416004)(16526018)(6512007)(16586007)(107886003)(1076002)(4326008)(53936002)(47776003)(25786009)(6506007)(386003)(54906003)(3846002)(2906002)(6486002)(316002)(66066001)(6116002)(69596002)(68736007)(81166006)(5660300001)(6666003)(72206003)(2950100002)(50226002)(36756003)(305945005)(7736002)(8936002)(6916009)(51416003)(81156014)(8676002)(97736004)(76176011)(86362001)(575784001)(48376002)(478600001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:EpvPDNxjtrX7ZRrOOJBFXBT6h+sWF8V5EV8hkpK3e?=
 =?us-ascii?Q?XNTworHX8jYwHzZ1fNQwAIXBWN2wDTQs+l8q6G6yaUCAE9z1Hj0bLN5XJ8Wa?=
 =?us-ascii?Q?JlG+gZ9CSZ0VNqJuy6q1ls9hNVB9pLPMIVWN3CzEm+FU79HO0Bxt8QimxBFb?=
 =?us-ascii?Q?unJqPWlAGLhYJL3/tQMNFFw9BX2mj6n+YE+csnks9fivEzlilq8etmSH7XQz?=
 =?us-ascii?Q?aU7Gt7x6R8RBIRJie/dL9+g4rTviBxGmEObGdf8SW2pZZes5eK257d1MuhZk?=
 =?us-ascii?Q?fgBBzWBMs3RYJumRk0MiAyNrqd72zhOwHVwYiOZ0Gx9/eq7kZ29dcuASzjox?=
 =?us-ascii?Q?JwkHvb2rftJqoR6yqrId4Ezx3sgk8wy3tiU8RsRXG2b6VyAN0tH5Bac6kXrS?=
 =?us-ascii?Q?wNubxdQheEzFpbM+Nj+OtsJ3dlVV4RfKd1yTzmcWpa+I8SteNvW1VacLxV5e?=
 =?us-ascii?Q?/B/Zp4i4tW+w3p1er60yZk4ATKltQ6Te5NpvRoc+Csbs8E5hiwofqrZcCTdm?=
 =?us-ascii?Q?Vj2PAJpHTCzoK6kXRwYWkAtjH1PpHyiCWz8tehkYP82J/HXJyceZtHigHSf+?=
 =?us-ascii?Q?JV4L0pIL2+bFRojEiwYy/wxeJqHQkgCB3YhUACWKK2WN2CAmkgNrbL5tniY8?=
 =?us-ascii?Q?WdTTFH+eHl1xfS6tWaGCf1o1VOEuGxci4JlbZKlo7BGAL4OGFy6M7AtBSjjo?=
 =?us-ascii?Q?bLb7mxzEVcIphNgIskcNvojVynRzXiu2KaVs0F6VRlYZggDE8TTP/tqZXuti?=
 =?us-ascii?Q?XkmrPbsz769X+AMauOeMkabX7DnEDo8rwTSW/1uJyAPAA7sTPDFdeRltBN53?=
 =?us-ascii?Q?VEFD8+PbouFR5MjGMqlI/Jt0NtMskqkkec2xr5PGU8ZSmYnHbFvb+Y2EtrnK?=
 =?us-ascii?Q?nk1iGAjbAlOM9dINqf+U4iocaAd0ayBYSE+TOLvik6NlL0RKU4ctClX9PISh?=
 =?us-ascii?Q?ggD8yc2HV+CbEI+ChArZiEjqnj3rwro4lwESN2/DNepXc6g3Ax7huCzhNsLV?=
 =?us-ascii?Q?pNK77zJgHKWiLtwKG+rzG0c+VNuBVQHO/R4u4LpNhevYfJeU1fMP/DHwcMYo?=
 =?us-ascii?Q?rDHKpNMbil6L0LPKV7YrpOMa4q9gHm9ELode5dyPD9t3jKWkJ75aYJxcYLF7?=
 =?us-ascii?Q?sKPvpAY8v/1BalH/cd90Vtx+wfVNZth?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:Nx+zBxFapuxYDttHO2vbjxoM8laiFIQt8FpRbUuLe02CTAONjx/atpRL7l48HIcoTmauL+YUMRaj3smhwRmaFMSRwEkbzj/h5CNlDJ+zkuSxCa5EdTLwLIdO9cJJ7IQ8z4ErbP/bXzWJAAne9wgfrKySSbnH4Mix2zsVwlsIt2CC7GQUn7W+CRV91UJ282wqEFFZ48s472JshOccmRLnUqTR4rxCGeCwuB0rmRVSbLdri+uYSJz38xju9XqNasF4OXynRA39u1BfwcxuDnOsuKoTUw43pZ29n3577g0mhXdUr3cdjaVXyFRuXqj+ErkF7Sm9Lz9PhSGshB7yICV/Nnl8JyX37TofRJ44oF3C/YY=;5:l/kX/pT3qEEIiSd9ieDvVtPq5YwT1bJeeyHI+gnXM8Z8F17z8V4ZxBvN2FlV+U4UBoQT0829KUWp3vRhgefvfhtxh2qp6wDu60Dk+pK183HfRwUPZ1a7CME4s4gYp/sDPYLZdrLR+b9KleA2ixsw6vOn69voM7IjH0VbS1LVzds=;24:lV63mmLkCnKQMuSBDZqF/BZhw3JkwTXyfaK+xlWXxA6TTSYrgGTUncwmQSqvuaGselpDu3nxe51MrSszTGup3HGY6YY8MyVpgnDDlZmxqHE=;7:GLrNp1uOrBvoIO89UtsALh4JwEOXBncslX01ilABL9FxoaakEACQ2aAfFtyosiGuwz2p9QU2TeC+yy+KSx4Kb/fZvgkwYKsTetwoCgWcyYZvsMj3w3FR9tx0ru+0XvZ9yirP2p1/Lb7ZUl0OOeYWd5iW5jMHWd5qaxVOgs4P9iLlxW7o/O0XYHQMV2r/0FINAVJnTcHhooCCFxPWx2UTzA+1tDexXJ/8ZMtq8hOfIk6LWgMjjtU6rGl5K3oB7HIv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2017 00:48:58.8134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bfd288-701a-4ed3-f9d4-08d541c34f2d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61458
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

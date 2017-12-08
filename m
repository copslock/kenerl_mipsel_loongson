Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 01:10:58 +0100 (CET)
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:35584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990436AbdLHAKA7XWCA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 01:10:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QnPtUVgnbk5xAC/xH+aI2c4O7LD982h5cqkqgGONQSs=;
 b=c9azMaZDJSxTz8RFtAVx2jn7gAo8Z8vnH42aXA6JWPulrku5RBEp9xtZeWCsZwqr0rcBwucDpX3a4jtx8mCUHHDD0rWUviS41FfdSW5JNiAIz3sI1a+jgfFWp60pkSOgvXbl3HkArNuaV8Y05zxOMUTkgTkel8KmFyw/j5QRhWY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Fri, 8 Dec 2017 00:09:50 +0000
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
Subject: [PATCH v6 net-next,mips 2/7] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Date:   Thu,  7 Dec 2017 16:09:29 -0800
Message-Id: <20171208000934.6554-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171208000934.6554-1-david.daney@cavium.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0068.namprd07.prod.outlook.com (10.174.192.36) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e41383f-26d6-4a14-06e4-08d53dd0030e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:sPooVWhF7NLb6nzFwwrxR7WBfvCAJNkUp7sxzoMnK7lAbcSjFzes5emfqVtfb9Vzjgf9sow2JY/MjsNcvCUavPTtJgLx/+mpIQOUH/SWeaXK8wbH6S6a79ByVwkTUh+xdxsuLnGELg51qCX86PTjjJHeC/Efj7HD0PqfgQ4QCHxR7eKsoao9EpEP4EVCfz9HoKlGPG+G9EXmFW9mOuxosXOd0YsrxLLQ0GkGH0dsmTiuE5t8viWc7yFxy5cobWvz;25:2nnjKaXe8ZWJxlFUDWe2QufQsCt204hShY9m120sG0/BxVxMgGUdASuubkILYFPCe+TwoKLfM5FjViDkiLpst+FKMDV44K6M+MfpQRLgYKMdwcYeeZK0l0/y3yeKVEEwgo0+nc3jy+7ETbD9+zSFLLpwBxQqClJ0VIyP9jxUOTIqUOgeGC3eultZRTTi61StFL4xEApvqJ9slFmBajOytHyGolsVPTCOkIHVBZSO9Y5YKmiXoUqG87rTvSGsoQCCwxgBRV/Kn+medgbqzm7pUonfAx2aF3JASFpFZcyoyv8Ay2bqrv5pg4XAoXilwWAl4X00UyRi2XEPQ1tqQ7KtzQ==;31:iL3Ps+EsHaknsfZ+ScjjTb4oE7ZdqFzMU74C6YHzYhhTzgeiNffrJmriDY1HFcvDLnRN2kqg+vETUwz2kz+wAFlrFD5Bbspqs4tVKU3cAuLMsBvJ+uC/V17goS18TZEmujaPJEIkEqkT9pN24ltfQTSIXXBFcnL2kj5YLX6MBOdUu61s+R5OPgAnRoScoNHx2oIj1kPxVoOpFNfFD9XW4vRW4pYX86UhhhNZHsXMl3U=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:6Hsh1BP3FGOJzb3+LI87hiJivdCLYI87upk7MTD3AEsDROp1Cm72j4tplEqKEOzAJURn5u7BeBZBMi6C8mSxXhVwG8InjGbjTHCPp5B3LslRNJlI5KSqwu6yDfnsLpSOHXt0m8RTTYKixgMQRzGIc53tnafSrIZBQvU7w5lGMcR9mO59NQP1Km3VQRcafMcIXYmLkhWID0wIwmu1Lrnx+lzbL7C7M2k2EARx/DaiOoci3fBpg16lQZE9pfKc64zfWQGU1gax+pSaDzfCv/O7xtNKn3/6FKc3jJHUscTOhfd1bNHgkczHAOya7X9XHH5iOEld/PoqY5y6LS9764IbeYhZp5/gY8jDNGR4Bk+oEpIa11B6EBTuHWaJHm9TZPfFK1tWsSWSYveuqUGJcl2IElLnEZG9XT1WCGUQ9TT5z0uaHGRW1R1SQPPdy9QzlY1eQkHcYYEildvbvoj06q5CyhLSqiF5aUzcTLy/Vf7Hn6Ya2bzKXaYLJ/i9dAjxQEXN;4:5+gTIF14pIu0TqUwRnkQc36yxHOakhFvCFfWjo/30pytRdgHM86XxP98wsbxIn7VQdsq/SU9MHloxRHbtCSn7jPkqcJUc6gIWiYKNI+rW+mOg+K8zWXfu3taeZA8xhAE8t3BspgGHUQfZhcwGXHIk+O5uGcFXSlYJHE1D/GxKyJZzS2OwX0/akAooe4gNdVoWL0QjmMh+Iajdd1ePjMylAsqbY1RYM5WfBBQuBvF0000qFkMaeVNEUP1JLDaJDXlH3JOwR6P17Z1DHRTUWzJOw==
X-Microsoft-Antispam-PRVS: <MWHPR07MB3504015F870F8849BE8BEDDD97300@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231022)(93006095)(93001095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123555025)(20161123562025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0515208626
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(199004)(189003)(575784001)(86362001)(105586002)(106356001)(81166006)(81156014)(8676002)(69596002)(6512007)(47776003)(107886003)(66066001)(48376002)(4326008)(39060400002)(7736002)(50466002)(305945005)(53416004)(53936002)(51416003)(52116002)(68736007)(36756003)(76176011)(6486002)(6506006)(8936002)(50226002)(478600001)(33646002)(72206003)(16526018)(25786009)(3846002)(6116002)(97736004)(16586007)(316002)(2906002)(7416002)(1076002)(54906003)(110136005)(6666003)(5660300001)(2950100002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3504;23:PDODtp5P6+wC3RKpNPuRYIUyJaH/bHo9s1WlY1Xwa?=
 =?us-ascii?Q?24vuP1ql385jsE4wwqP8Lsvn9qu7B+3Iy0sncGOihztBYmuXQS3sQepyFKTu?=
 =?us-ascii?Q?Lhm61J4iaAyhLRy49nEqGzkFa4SE58L5aZu0r/5Peh/DzPnCySDkcA5npwVF?=
 =?us-ascii?Q?0ZjMTf/ZTk0YyFydpwf6w11kPXDfM8afwisZoNpLrAsg+BP7vIVm10W/2k6m?=
 =?us-ascii?Q?hlmj8DbnvL6rDuOUztwgki+J+SecIOrV6rKR62mtgWuMMY4HKIfxLTWmaDaM?=
 =?us-ascii?Q?/OevDNoMzdqN5l4FOPmusIP69FY0Tn6gw5ikr21uF7k7sQ3fxevVKhty6oGj?=
 =?us-ascii?Q?2ISjtvYpW+mnPwYGCLuvObKcuQfG5deoYyazjU4us4gf0eHAgdYuajK3PeH6?=
 =?us-ascii?Q?ynIj/rYwv4BduE7sRzp70HOZPL3E62Kdef7b/A8fnW668JscmegfxjDkkX2t?=
 =?us-ascii?Q?reQhvk+VF8FPtHk6nKRDqIeQRHAiSFA4HjIqMiK3I5f7EtzIMbyS7DQN8mcj?=
 =?us-ascii?Q?4ioFsWOzMOQ4Q1dRHdfxOSUGrvdLk8RGLp4Gsmye2EnSSC1xUFyjBOiMNmso?=
 =?us-ascii?Q?C/ddIorMzJwFpm0csTF8xuZ4vl6wCewpkFi5/Gdor7Vy+6adN79EdxrN5nyG?=
 =?us-ascii?Q?iy3oQUYC3t3yyXwtxNJohm+3QAXxeDt8A0fSRMBYGBgDkuSoZJ0a67WZBCA+?=
 =?us-ascii?Q?UWE+whZYgPxMPpkiy26OIWxVHkqd7wdkGHMvL0LV9lfs9EeSsPY+mIjEcQlR?=
 =?us-ascii?Q?gbaj3XtA06RCBsFNkDIsYQNyetq0KXPElv+RQTnmCSYTWdy47vsTnX2Oen4T?=
 =?us-ascii?Q?AXRS9iYjycWedcGqO/4BpAzprtFFXfq65faPWm8wKF6CtLklI+6wcG2jgkbI?=
 =?us-ascii?Q?4FgO5XRoZqXX+lMY1oytxBmaI5mbpAfhzteixn034M2C9QjNJPab3tWGKgfl?=
 =?us-ascii?Q?MaOSOO9Gvmfy5LEcAEFDLjBIe8xE6rZNSjrsYefhO2tI9YKTHOJt/5CaC0oR?=
 =?us-ascii?Q?MswnFCsUrXKeOJsln2Fnuh0y+a/YmO0Zj/5aC8NdKIrTgNuwj8Pc0qyPj2Sh?=
 =?us-ascii?Q?YanSViJehlJcBCfSR1k3qA1UxVHdDVOgoEbwg9QP+RGHvCyhCRPYgVsWMOTG?=
 =?us-ascii?Q?OCARgrJqOsS4lvJS9GUNvscpHy5H1Vrf0lhtPfwFR/mFkHSWhOLyVs2084/4?=
 =?us-ascii?Q?htdKvMiHeFRoKKEdAlIP4grupKrU5rrAV7Q9Fpge+tbl0dIzrx8Azr3Lg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:zLKCf2nzvCIEC3peZVPoicstsNr0scJy89ZYiLAzI4eZKkiUilUYd5cJpM7cn2m/M7GuUtEtZlk8h6a9Smgv7flsr75MfOKkxo4UpDJa8AtY9NNSTsMW/WWF2hLyc83f7IfMLwkqDLe7+pTwZn+zRkBEHNpHFhG29/pXA8r757trZVJF9u/TpzpsK4S1WclU6qjtZabRwu24jzHT1UFylOFtBCL5S5ygb6tqpmgxAJQk0SdQFLE/yrgAKNgK7Vt7+bvYwP9qdzwtuWkhMdjxjNT9z1Sh6lQhh3icJzyls1whnJcHaKur9Roiu5+exab9vUnaCM7DEPDC74O6/iEhIsscNTvtfweJAoIdj4RV4ek=;5:jV4l3bItxNqSLcKYuyy/24UKlzIEQTtxmMLtwdS9x0wJ8LzgfYqNUgxp5uK2sHerf1DLqOAstHpx/dir8UrKMxRHGa0Wj6OLc1io/xtk5l/IcA8xz035FMKOyeSled4bQVJKahUeis2KuCmcRexuy87YoWHEBW2El/nIPZhCY/I=;24:Xsl7jiY9BQmHTsgAthxA3r+1RikSeh+Kuy6e6zCJniWuCyaVV0J+vn0hKRsJgnJxBVOH+9SJbXJWXOjYSL7pW61pHw0NFm5g82ZL4SqV3KE=;7:toxXLcss+SyikkAiLQ7uRa9/e0IcJD61f3IZ55zSAJB/oeSQPu+PAG0wB9yegPwY4Tq76NaJOvZzrTErTlZ9eu4T+0UsoLZ6qg53y0a49hYb/2qVQMp3SLhfkgHYq8GOvNID4K3zUjQ8DJfsHMH7lTcxyEbjrStbddFgjdyuzOaQXttsWN63uHMvJnhtNijdPEBTgCqdQIZWYL6PH4vDKHELGoGm1ys1PQp3OUNBDyHlASiYPrUvcBpmT62mKGiQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2017 00:09:50.1535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e41383f-26d6-4a14-06e4-08d53dd0030e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61344
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

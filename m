Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:52:45 +0100 (CET)
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:53732
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990485AbdKIAwC48rMQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 01:52:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H5nBmSZoi7F4q+THjhmGDsxL1SaBD1ybpCKXd/Hxa5g=;
 b=SX3H8Igch3hPHPC8TdgVtWRy3YhnV8KDqw9lAWAcqxH+knNTeIYj27yaLk3ELFoQZIlyRPVb/H8QlK2EywDng0NSHSeCx/QRalC3qiEjhqpaT2s1g7YyliwTclMEnMjRrAhLVZSp3EGB5Q2OPZg9rWbUL8gqI9Ia8SD007RRe1I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 00:51:45 +0000
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
Subject: [PATCH v2 2/8] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Date:   Wed,  8 Nov 2017 16:51:20 -0800
Message-Id: <20171109005126.21341-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109005126.21341-1-david.daney@cavium.com>
References: <20171109005126.21341-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0022.namprd07.prod.outlook.com (10.161.192.160)
 To CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b355bc3-4471-4bb8-cace-08d5270c10ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:pJ0wCHH5l+ihh3gOc9NITI2wgQEn6dcVDOQmXP68gU7LcIEGoHoYEp0sEG+redNrGL/sK2YqsUdRskMBL+RMBFbX/xyQfq/qeb0JZo2N/CZ93huLStylkPbZqBw8Wvt8/8JMGt6P2TmxeQ6gDnsVTvVV28+c9rsxcfMnmvpxpK4rd03N/vi3TSS92GVLRosgdI7EnHbJEzxuMLOFxPrlfF/M4Io9JVL6MXaLmksK5lxtzhWwn0vPaqqqJrBxX+xF;25:p5usJm82EBboboqtve3YOjAAiFhZrVDfUrFdDnEDC/oiRSrEFqe3u2oEyXBIB7ih6eComUTLCQl7+EnPhD4vGtFo89otpAfNPITfNce8DEky+RyRT1i72vctveJA80k0zB+Of8FlEMu03B1XqxiS9YU836/bZBkTYMgxXfCp3DfSd1llQKXU3a26k0pAdIGXqPMZpvl4k99CBa2993Ig7YUMLCltA6NXgzLS+3z62jHPWQWdAO3qfXQTqww1Pcv12SFExWFeS5SEfSP4kgcVOvhe2/uSSUbamH+rJtrrUKMPaJnNXS0EjjpoGWH1W2ix8KZC2yjhGJmPrZwaKgqhDA==;31:XhVgnaO83EAIoG2LoHphgz24Y5C6cBcaQ8PoIyqChIZg5IZgBz1Gd8+mxjXzRjqj/Mw5oPzYPXmdI8P5JcyLlFNtBG96zzd5tX64y4UYV3Ul7FL95NOBUrJ2oPY2XHdFDWHxjG4+3DVBnYBfpi+ikS7+ZJwuxxD1cLB/lAgGhw2Ybqj+OuhWXn6wKUIn2BPPe6lswrMMwaxSJ786A//fQkJz1EdciutAISg69rP4AYg=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:jKpNsddVmYgQZ1jqC4lw1VHg0ZZ7kpahCJAX0k8+DQ4t8SQkCFk/ofsaagxpUHxh2mm3X8/+B4+9dKZbtEpO4mIq/POk/P74JY4ROjz7ots4KJS7kWbDTLcIocC7eLczA1td/gnJMsSKwd6rqUbs4gLBRTLq93yf1emUnNQQbaihHLX3PXgX8+Be+oIWmrv2aF5jbNurVGtNPSw+w3aCitF7FNPBBlvQAhSYJgcWcVtKBZZJZNBiW38dcJm/jQAiFvg7rvGMj2XfEcjBXfHE1vQX09CuxRdwHP9dj++lISKbWQT+H6tJvSFNSfBboFux1lpUgiY2FKZZqTTwgF5X+hd8sJqDp8iDOuV75wa6Go09SK47oRT4qySbZ9Sv2uhrxa33OtTWjzUDh3Q2+xRgzA5s6ih0zk7drCx4EdltqoUSQ8dG2mu3EcUV5VlFPmfo3AS0VloGq3ID07ru9ykorLM4blBFAZVij3tiFg/ipO7GdfmzBBUu/IpPn7sdjOx2;4:H3w/p5s5Lxfmhwe5Uw4nH2OlR4u3HZw+sTqvSaPG+IzTxGcAoQwwSAORTOQxCdX7X69vX0+/tDcyaNE9VhYEAaNNHQ2guc8byKXXPqA8HElR8vj3Pi+Q0/vwteer7/LItj5krZkgVZBRkadYThLJn7wXR7dRkoZv+98T2jrjG41p9HasW6CNb2+bSnDHwUVuM4oczxufogAlZkP9B+upgBzEi4dg8ZfLqVw6QbAaaSyjCrtErI8L6hCs78GX2UXX5mYBHQ1r6sbk0w5p4QDTcw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495E5694312F5E70D829FC197570@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231021)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(53936002)(6486002)(50466002)(6506006)(110136005)(2950100002)(36756003)(33646002)(7736002)(54906003)(50986999)(106356001)(189998001)(66066001)(2906002)(25786009)(305945005)(7416002)(97736004)(76176999)(1076002)(48376002)(47776003)(105586002)(16526018)(3846002)(81156014)(6512007)(81166006)(6116002)(8936002)(5003940100001)(101416001)(8676002)(478600001)(53416004)(316002)(6666003)(50226002)(72206003)(4326008)(69596002)(5660300001)(68736007)(16586007)(39060400002)(86362001)(107886003)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:qbYZ4tFvelCoAOKFhtvp+7AF/6m2IvyJKMjvFahT/?=
 =?us-ascii?Q?IHYcLF4kbZrBFenl3CoCY2zi5dNuG3Rd/QrS9Ih4FsUGRpK6pC5nHsC9oTH8?=
 =?us-ascii?Q?Cb6uFbvIIySOOitJpK/zAe7ZcXNHw0JeToJHCb4mLCFcP8ckIBycfq4iUURb?=
 =?us-ascii?Q?XB88zKhxM76GpdjzS9uDc4V5I0dPz9FqZ8IQqjoFvfQhCCZNjWP7wvhS2OV5?=
 =?us-ascii?Q?NTQgNIR8trID1tRceuvtzJmp+4bNY8NZHEnCL9yUo+2QQq9tJ06HfPkM2xkV?=
 =?us-ascii?Q?nbJVa82hgBETX0Nr3LMyJXjZE1J6RdFhiuSHtj3bGgK/Pi1Zn8JzO9SNlBHG?=
 =?us-ascii?Q?YH3bw8LBx5zPXEouoyVIQluus7e9RnHYS2oIQl/R1WBWJ/6LOug865Y6eozE?=
 =?us-ascii?Q?XKlpXwg+0Pvfvz/csp1uUwEvHBY4WXY4r1aHFn8OVxnrVf/yudldDMQmdFKz?=
 =?us-ascii?Q?NeA7cST+0GHcERD+j2RQfM16ObVt5tE0hTqST8VziXMVjbpFmf5V1UKpJjfL?=
 =?us-ascii?Q?kSg53ajIiLXUtTfvaJxOcBNQw13H99jP+K7rHUS/EPsTUXMnEHEeghzz2gZm?=
 =?us-ascii?Q?yFc4I2nTGtBc+I2d+0KBBaPaXTpwdixfkRcOVPjKVDNpkWWhSxWHXkou3FuN?=
 =?us-ascii?Q?nvV6db31c/m8htVd5pRcXYBOzMn1bCzRlH52Vxv/3vSLeVGe1YAWsIPc66ha?=
 =?us-ascii?Q?Oj8MZLDKNt98ftX6qHceUNOE7JU3OOsEGPRtPcEsfSd9Hd90zuXkjBe3HHMk?=
 =?us-ascii?Q?4THJvO9uFNtnODZNKh8QAQWS+8wp5ven5w8L2pjdjzPeQxv0sD1XkVn8ZQwB?=
 =?us-ascii?Q?CEEdTnZqYNPR75u7O3ogo6aoXHGGD+DZGxoPfVX0rgMMIn27kjp8kzvJKoF/?=
 =?us-ascii?Q?2uwPLEsMPBZg92vocebFqnq77r1cNq1+LdpMZqBOZM9A8pO8JoLU381LR7Y0?=
 =?us-ascii?Q?SmTLzzQ5qcm+WfHlgABqNrYloFeQpaU5EP02G009SKo9Q8fgsWzV2wGK6fws?=
 =?us-ascii?Q?5nfTrkRYRN4W6/gFk27fy/0QBE8D5ESnYG7yxbVgruh5xB9ezXZPf3csxyO9?=
 =?us-ascii?Q?pMVJG+TlLfNJFs33DXUB12nmSw9LUravouaiCvWyIdyQIIx+voLMLbHxmRSR?=
 =?us-ascii?Q?FA1h86c1tWv0o7UdAG+uqDd3fb12oetgKpzLjWDkL70Ai/DtlzvgYk1IDHxW?=
 =?us-ascii?Q?GkWHZvdw/Tys4AQR7bLYMaRv1I3TL3Qbx4BrWjrZ+knurTz5Mx2Qy9GFVygP?=
 =?us-ascii?Q?Tx94scUbLTc1lHRPt/MZx+B4GHniM7nh/wKs8bm?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:iuZBZCGxiExQoB/RUJFIL9lwds/tMPfZvzYiyquf8pZe38GlvxULTaqG9kiZEu0renXhnM6zuQ2uawu0IHxF8UGQNTC2SqlmL5wL1LzGZ4JN++ps5jWfn2K6xtuQp29lVoFzZjy/w6xuBIk9KUKKdZ5W6JFgfh8UVb69FSvqQIK5BjbMWaSBfCsL6FBVU+QmofO8u+/LGPHM60B0QlxQf3EIjFHwGrKe9LD0zyVOsjNFtatF+8+Wn06FbmO1RIzzxlN1rJR6a3AcZz+VNMyAiEgwang2Fh/SKbR376xyosGN/YklQvz7PjXJwn7G3hX+aAlJQtZlv6N9y3KRkfMv+L074aMHlgIjV2F/ZpVKWjI=;5:XN/SQOhxQ879VQtmgMVjOeM3MSCmhO4qB2LTZG/8Sdo4nlK8l4cnzpkq3jZKYYJKkiV6spk0dHm22g7qSf9P04q9QNnWz5kuDiKj1DtsxCA2bolwiV4vdIijJynXFIre0pxKnKEwDkTDBtN/OCxfnj/+leKISvKy0XCdW762kM0=;24:7d0GJNafs2OldaFb6tIz92yQsU9Oh0IKocFKI2kPwnKPbqr1ha5h9TPrw6Am5X8B6O51i9Xjv0b3KN5K4Mp4UznueXjvAZCPWBFPi8t4M4g=;7:R6CS36Jf/M+NB6l3K00TqTYYa9JQHshO3E99gXNf7c5SFUYy08wcx3oHKLuqT7IBXsrHT/ORgDsLRI3jkqCoXGSsxF2MDa9Sl5MATDrw9ZbZrmVDytWQVzE24ct5jnAfIqySfkKwfIE1UMhUWPSnDsfEfUkpnD/y+4EyNntaBNoLgx//0uS8kLSiRSYkRIWubBxDVzPyEk8if60jHtHkbOE9Y8YZLKXlP0H5QK3nJljyMhe09DjAvRUaC+GkLrRf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 00:51:45.5061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b355bc3-4471-4bb8-cace-08d5270c10ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60785
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
2.13.6

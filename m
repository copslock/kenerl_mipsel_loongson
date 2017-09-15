Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:37:59 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993122AbdIOReFozyIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3oeIKH/ebwbtCO/5SGFeOWBEdpwIXhknrc1KOtrphhs=;
 b=NjADuBXjrgZHKd/66sV/pxDXB8OJYFrzPxcc6T9IIMmWl2Yo0d4EE2WLPDH91u/gqutQ0rUKlOC4hlaEm+Hk/0XUv9wFHfMUZIPmiXzD0rhyYbnFaYI6yOziONVV5t65A4353G3UancSB+dWIx4mM3j4fObYKbGtNCMBr0QZt/8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:58 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 10/11] MIPS: Octeon: Make register functions node aware.
Date:   Fri, 15 Sep 2017 12:30:12 -0500
Message-Id: <1505496613-27879-11-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:5173::41) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eec25254-ae98-4fcc-e025-08d4fc5ff269
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:T07toxnOyf6Wf2zrLc0PrhyEZdu4l0iMs9kIR+oHRcMoXPhVOmpGvqqsaiPS4dUpiCwMAI1ecfaV+5UTpYWnuDDKTSvpXxEngXxlL6+uAuQC47QYQ71QoBB9wUr+K4iNfPfRER8Y3H+GmFTO0tlxCY9gwPpIMeE0F+V2Amvn60g00xQOeDY05ObJxBDk6lVW1B0qVxY/HLKd++iavaUzo97XigwR/pGpYsyjOTJmT/k2inf4WKfD1DbMDF0+XAxM;25:bpMPD+Jb9taTCL5Fcb4OxWVObHIRk+eH6NGjHEspHSc6c+1RHF0sBbZmAUhwjHvIk8h4hAlXkS/wvS+Q+D1rOxnFughiwG4FFt7lSGRMqm0Cf/7hfNRymvcROGR1sq0pOrqtf61k1/r976Ujv6zJyfqVygTWs3dCGiX3EQu27DltccWWBOahgBB+eF1czWHTc1J+R+iRSmQnnmQ6SAGLcyJc0r/LSLPro4oKT5aMRRettqqZm/5uSjX5YEjCvtv6tbzSqZh0u+TLJOwz3o4Ul75oIP2/97OVPH2YEh9QXgDQ2Lg9/U37HiSaSHPOpsAuUsI8EkiKZahKR6r1F3Irtg==;31:0/DmW+NSe22QT1ELn3ANQwK2SBwsa6I7AzvClc+BiDiOROp8o0b79oja0fsKjbJIOTJ8q63dZ+ivXCv4VVlr1JPdv4+jKKvLnZ75RUXCXDSx4ZcexjBga50s1pw7hVXuNyXBA6qlX8RxPaSGEoVaiwLKJil/v/qNLsB33VeyFYIx4Q7qrDmOzYoMfLseQaVFrzVq2zzG9HKWyGoBbdNop5dzkgw9sdDGWRQIIrSSB10=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:kwILYeXOcN+DvpKWhc02/y49cWOa+A2Er42ffPGV1/8uCxu/vYsaFz+s8yHlmXfjKXIzU5+EaLrIQCs8DykwRylNZ+ephmzOFmq0/lsZPb42BoV2c8k42L4+QKZbTnQmzRW9BwNDNJOMAuOaDOhiXHTrFYoTe0pfWg9RdNUlCmumVKkxKVzNVztPC9YeOld7fnmmBxy56Q05UcdQ/fUQK6o8VGZQ9bq3QSRTAWr0/1egCVAFcBeqeQC+xhoYO1Su6WOxxbvgQ4nVka5NVGIMpElP2TeVZH4rz+AcA5Fc56fgicOI/IJ8Bt6X3BNyfU6V8P1xK/gAa7QKMqUdBYLudfLbQxwkuHAliUqu4yq0+iKW+MgEMZN17WYN2RKm8Xmevlg/TwvRYWePZI9fNWbLAchS5ZXYjM8PDW4ks66lAbJhZXVdiLFVycICI9swItzy0axR1LGqVUoyOlmOB237S1lot4RRNW1JJ6mz8hH8pbf/kBGia4sxI6N/lu9D4Ck9;4:89ujvefezuf+7Mwu+NMLWfX2kZgSpss+RgdE/nCUMNCUwG1HJs0PeOgbneXIFoFwBIzWFXB8a/sslxFyA0BtdGy+l0YEkuPLmAY8YVl+TZQWfycdCiTh2gR+NDhVgxKogzjN4SGPDw9BxlOvca6Tcx2WBdSHNuwUW/BIEeRA5oCNx0kcN84SAUIJzAP37Z5iXNO397S5p2ODQhK79G7TBtpRu50lv+0i9DWaTzwy+PSAsXu82onZt6FHGKrR15I4
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB380046A5C1405E8D8E843D2B806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(575784001)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:BxenJjy5yOfuQMIRMPYRxbAffoFrAUJZw6LPpwO?=
 =?us-ascii?Q?rvA0MuAsvm1TEzmedklDF4c/8vdrzYbipnJocw8BbT0Gh9C4FpJB6L1ojyDe?=
 =?us-ascii?Q?r6riHQe9pxK3r9FiJ69I9mFyMat1Z/DYG6I+idkz9ICQkYiIHp2YkOm+uS80?=
 =?us-ascii?Q?cfY50ca7ChZ+p48sOXzQj5LWQFViRRsrLp5f8ZX8O/sIFdM4f0q48+0Zy8y1?=
 =?us-ascii?Q?s47iFT9QOZzXRWt893X00x36dvdXytVUCg0pqE64m5JjTay2JARs2Nl8zfnO?=
 =?us-ascii?Q?weZ7hnZVMvuHyRnLigZiVKQucPkYlW6EWvQZUR3MmS+HPhL0nhx1TTKbJEEG?=
 =?us-ascii?Q?1AG47nph791A6JzmBNvHepV2F3HMAZ9QflLbASvxCpwiaaf5rTLBz3M/FV+L?=
 =?us-ascii?Q?eZy1cRUSz6Iui2OftPUO+pZmPGrPAuR+bVot1yR8a1ZpPnl6KAHZdvjOVl9O?=
 =?us-ascii?Q?0+DxW+vVxAyt8VI1u0uCpi3PFJhkZYRJ91vKdi1GL9KlEUG2RmyalxWeqkHf?=
 =?us-ascii?Q?q8qX3f39DjlZRPeqFE7MPttO340oIL+WwDMVL6MsMvwm2G2MlTPMOC64aY1z?=
 =?us-ascii?Q?LIqbm89rnJif/ZbXGycHJTdhoW8Os26Dc15Blbi5U6GtPgH4lSXi1d1Q/kBs?=
 =?us-ascii?Q?M+RMr/sZx7qALnKxueEL0O2zJFfWJllbG/Of6bByC2yqY/gfEkuOn65RNOIi?=
 =?us-ascii?Q?TW5cPW/n7JBvvgyx+LdDlJ0zzfDI0DloPSnaPnJdxxE0OHJY/scq9IlkZ/Df?=
 =?us-ascii?Q?OhhpleRZoXgOnrrI9dhvT7wUNBb+Q9DkwKJc9Amvjk1sKqrER4JP2EZxkNz9?=
 =?us-ascii?Q?T2z7EgRYur+julqawTbHXMbfxdAybgXEoAPIYrWLMdI2zhJlEqaEyEwqzf9h?=
 =?us-ascii?Q?9NzsGP/4JKGiQGAFyzwVMwyOESlhoFe5yHTuxMbQOHHznqIRT1xKswGv79bS?=
 =?us-ascii?Q?p74951cEPMNIjQVmuWAGZB8LsBSRRS1LdipRfjebeeFX7QUbtHWY1Pi25Ytj?=
 =?us-ascii?Q?7nzfuAmOObLzYW3JRpiKkdmYGxE0bQ/Lffo2503vVCySh0H7oYVRyuKkCg1e?=
 =?us-ascii?Q?f9jnOQDNGE1c9GrFiRsUYBxNidV9YhnrLSkIEsCx9KQH9O6L9u4Bm37hoesc?=
 =?us-ascii?Q?bN2mVjaur+d12dyNX1lakGgjX74wdDcRDdClD1HBkFV61CZUnXj/dmz7oHr6?=
 =?us-ascii?Q?RNYZlqzyQi6VdzuGVue96urZsiyoX5UnNmwDGOczY2glR5vpISVqOVUFwIA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:TCgBB+o+wEdqn+c9Forrk8EGRxr2WcHmoISuYfNdI6Si81/6j3nSn6XE+B8+Ey8hoBC4iR243LPUlkJLBWmLX7l3PxfaCGwullk0S/LQ8LwMC2duSwNTGrpBoZjl9NNSA2VXqVbhTh1DyzbQE3yzaeZthNoBSFK9tTpq6siNsdzKfVvXSr9Fh1Nde7t8HWs9wVoEAgQ4UoRHIATx45FTH+xQ2a+8hI72HmvvU0SRIW2mpuVsRu6P+Ay0N8scQWAMMloeiPgKTLUC2GhG9W19Zdo/qe90sW8xj0nNSwenUAu0kMAlUDnx9y+idbLdR5AUC1lnJUsTf90Zw3CIHNrnNA==;5:4ON2ZzEuQ/7NkmicCu/x0hZe+yjh77S5I9pbcCmzG7S0M/vc2x7ikYOF/HfWGByZBkvIexAZ2LyZgaudYl5mz0S82LfRWV5ijAiDpUqkcDpXLtxl4AQt5ZmNvbxuRhPchpDbJZx7jZujMvrwTUni1A==;24:J+0JA4EqWyDJW3U38n2oEqOxL8spjSz2BA1dVFNLHsj27ou48IcUNg9s2KlVbuuo4IcoDlwMIoWDJfILLEeFCMUK1ImE9xCYxxtAQIO3D5I=;7:PD/9xSCKH5+OCRcG3U0wHKpd5T5YXN5oQ7wF7L6MyRUq4xhpF9fCPlM9j9u63u+csZMHkLXRQfHgFtnHmspUBgaKMDjjwSSP/D3NVk9z7ly1dJLpoDVuFZPZaDmxmiI2FSNt+C8eCRuZARKdnUlyTMyK84AU4zl8GIg/30wWas6gNK5d4fRdJYV6ieYqk4ByGbPuQItFK2iAaKViX67VbDwk4+ViAm70EKmnqIZGSfk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:58.1762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60022
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

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx.h | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index d1d1935..1c0a929 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -272,6 +272,20 @@ static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
 	if (((csr_addr >> 40) & 0x7ffff) == (0x118))
 		cvmx_read64(CVMX_MIO_BOOT_BIST_STAT);
 }
+static inline void cvmx_write_csr_node(uint64_t node, uint64_t csr_addr,
+				       uint64_t val)
+{
+	uint64_t node_addr;
+	uint64_t composite_csr_addr;
+	node_addr = (node & CVMX_NODE_MASK) << CVMX_NODE_IO_SHIFT;
+
+	composite_csr_addr = (csr_addr & ~CVMX_NODE_IO_MASK) | node_addr;
+
+	cvmx_write64_uint64(composite_csr_addr, val);
+	if (((csr_addr >> 40) & 0x7ffff) == (0x118)) {
+		cvmx_read64_uint64(CVMX_MIO_BOOT_BIST_STAT | node_addr);
+	}
+}
 
 static inline void cvmx_writeq_csr(void __iomem *csr_addr, uint64_t val)
 {
@@ -295,6 +309,14 @@ static inline uint64_t cvmx_readq_csr(void __iomem *csr_addr)
 	return cvmx_read_csr((__force uint64_t) csr_addr);
 }
 
+static inline uint64_t cvmx_read_csr_node(uint64_t node, uint64_t csr_addr)
+{
+	uint64_t node_addr;
+
+	node_addr = (csr_addr & ~CVMX_NODE_IO_MASK) | (node & CVMX_NODE_MASK) << CVMX_NODE_IO_SHIFT;
+	return cvmx_read_csr(node_addr);
+}
+
 static inline void cvmx_send_single(uint64_t data)
 {
 	const uint64_t CVMX_IOBDMA_SENDSINGLE = 0xffffffffffffa200ull;
@@ -421,7 +443,7 @@ static inline uint64_t cvmx_get_cycle_global(void)
  * 2) Check if ("type".s."field" "op" "value")
  * 3) If #2 isn't true loop to #1 unless too much time has passed.
  */
-#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec)\
+#define CVMX_WAIT_FOR_FIELD64_NODE(node, address, type, field, op, value, timeout_usec) \
     (									\
 {									\
 	int result;							\
@@ -430,7 +452,7 @@ static inline uint64_t cvmx_get_cycle_global(void)
 			cvmx_sysinfo_get()->cpu_clock_hz / 1000000;	\
 		type c;							\
 		while (1) {						\
-			c.u64 = cvmx_read_csr(address);			\
+			c.u64 = cvmx_read_csr_node(node, address);	\
 			if ((c.s.field) op(value)) {			\
 				result = 0;				\
 				break;					\
@@ -446,6 +468,9 @@ static inline uint64_t cvmx_get_cycle_global(void)
 
 /***************************************************************************/
 
+#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec) \
+	CVMX_WAIT_FOR_FIELD64_NODE(0, address, type, field, op, value, timeout_usec)
+
 /* Return the number of cores available in the chip */
 static inline uint32_t cvmx_octeon_num_cores(void)
 {
-- 
2.1.4

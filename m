Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:46:25 +0200 (CEST)
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:30302
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995042AbdH2PnRGamk1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qfyB0/yI68Rfj7mBkoTcZr4BKbN4yX8ImJqQfa3x1wU=;
 b=CShYOwNc6eby+hpCHaQj099kE0stKOfyZmVJxtAVSXa3xd/xHoKsCIIJZmIs4mAoWl4Vc1BSknl55IkVYaQuRz5QrICUJUbWZl6tZJCj8vAXCFvEbZKOhQ4kW+Q9PbgCI6uuMNh21Sav2FBorBHCqXZs54/55cKsSqy7mGJN7xk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:42:57 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 4/8] MIPS: Octeon: Make CSR functions node aware.
Date:   Tue, 29 Aug 2017 10:40:34 -0500
Message-Id: <1504021238-3184-5-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a3b9a7d-51c3-40c1-4a5b-08d4eef49fcc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:6bKtJCE1X3prI5Aify2AoHx+0TkRUPLM8/C7LVUbTEbBuNKuolFP+Kx4yg97OxnIZvtXWwFpdYmj0lcXvfBJJydf5smUGK1gOQnARRANR+5BkVZsydL3I+V58MkMreBO4V7Uv07j2vuP365x3sxfIoP6T05uiiyzeteS20gGtWa/rEwls5IYm4JQeMAHrIQLJvMoMxU9j/45ey7lSBIytdgOJJso1F6zehewsQiHnmsTR8nFsbvgL3eKnHL0fYQy;25:txWDdy20I5+1MmLWNSOoB6SzMBRT5F+SucT8ZdNyHv4gvYcSUU0gDBlavPyySCiNDrjS1UuepjZ5t/GfwbGyB2DKEp61k3Gp+FncyOpToPRQCCFrC9re5tgi2NDTj1HrkAc5LFv6IVnKETCCUNjl/ZNDkYwMg1pada03HdFPLl3zyo8eSiAAzdNHYV2IbeQSlrYpfsIu02q65o3w1mt7k+/E+Q6qnU3/ZGlqLF9/YnGlgPQngYWUO1f5ELnzI21qf71/YeOp6z8+HpyMqbsLqB+JY8x50RLQCXWkZqHMFxL0ja+YAIcnRqjmxVekz6f7DJt8u5DN+lqrqnj3qVjTmA==;31:KpehuBJ7hx5/y/jrYYMw48r8rNfhpx+ZsSY3QC/SkB5ExS1iaGlYwC2Hh2XqTiyTui77I/flgLXv4X/y48RFZ/cyAgpjPMq1k7HcVAhQYGaFY/kr5xnGFRnGHcjStnPZmBc6MbKjyZJUsqihePNzfIphqWvbtYzulCFpxkjDfLHhYwzmxb+jsUxoydrRztmUSnk2wHegUNozCDoPVvYydjaeiUTqM1PqSfb5Ru2iHC4=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:cEec5lSYUMhAMQyd+MfhtD1U18aVZtSU/8NEad2nQ90mY3x/j/W97Bqmb1uHyV0nbr/mDN0JGk+LCdcMcPaLbjblfex9Ef3QaLC697JfyqBzM0iAmxVqZdAAGrJpsU0zYHBBEwnnuyy4QhYVzLZMvjlZjnnmGUSFbIJ+IY4/CirtpQ6rNXNqc9gJA5u1FLiKLgIIpMQhYxjQHRADmrspqwNC4Il8qs6iDvnqD8VuKKliycwQUXy2+2glfFmQXqZTmG4UEQEl6xPcB0lUWDs+FXkoT3TN+QhnfgV31hTHTyCcvcnqlMA7hDed8y2TLUYfzMEI8rQzArGmPi3MZim38lhM+I3WHmUtmboQQRfZVGqYdllcWn8fuA+Uc+xBXRPyeXreEa9nOutkrRn7m0pHrQs36DnyEgpc4Ap7c8Mc2VH72TzWQx4NQGW9AYsqtx4qmxgMhBY4GYa1hadc+WjfPpBGohVDpdzEHLQTx4WSwcdBJYRPAA+MNsVKwedwiANO;4:S1xO/1F0Mk+E3bU5K8t0Aw02yt0zP0BJLva3NJpwH7sCFK9W5sUmWwTvyspOoe63GW7cHs6K5fpY8mRVIAqgbDu4chmixe4Uy+oaABK7FfVw9dWBD+W34+VW1AlHVwj3AKhBBC44s5FQQKgtJ9Ho0eHJYX1++8mbX4ePfFeL+OdRtTDN/kiNjV1EfZ8IU/ZcPKSI8wjgcKH612cRy2CBFiwvqI2Kd+JjyJMJdhhkdm+TGh3S0IhWbkF3BvlnsrEn
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803D8AE628D88E1C68CFA4F809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(48376002)(6506006)(66066001)(86362001)(47776003)(53936002)(110136004)(50986999)(76176999)(5660300001)(6666003)(6486002)(2906002)(2950100002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:OIbsUjxX2BZUMKejQxXDQ+4lC368m6ISMiRthd2?=
 =?us-ascii?Q?u82l4QIqQTC6lou2wApxU2e754B6RZhRbjxLWxY8St6xMt1D8Ek7M13KNM3R?=
 =?us-ascii?Q?QvjJ4vSIvBoHCIMZQ/q03NEpn1xXcvb4VRhnK8ot4GoImu/C+28l2GdQPLwj?=
 =?us-ascii?Q?fxngxa1fx5SnhjMkAoWJmFSLmOQ7Ao86HJH0cqn+ZvboXGBldEB4WwZps3iI?=
 =?us-ascii?Q?Itnosvdry+B1oYjAK5gPwx/KXwIqSzuzE7fWczehJubcW0fLc0GlYQwUB7fp?=
 =?us-ascii?Q?JbKW4foCCzPKFZ2RdENNONAGJ26I9hxFUGyMOneWTE/l2/RpoYrSoGtHmOrE?=
 =?us-ascii?Q?iy6OGhKbnxkMJboyy59ZoyGQIA3iZFjt7X9S/zYxeVW97tXX/Eu3G5SSkaA6?=
 =?us-ascii?Q?WHJE1BKD9alFhdX7YGZsJ/O+in9jXz5HcewWFlJf2Kanj6ScwNoFnTUa2KmK?=
 =?us-ascii?Q?dx83CFV05++emvfgNWeUxl00mPiK8pSvGKZQNs3hLACPiurcxlzIFVfO66XE?=
 =?us-ascii?Q?LbFAyzFg9jtZXOCpEA3Rar2M3nczR//lG89ailBdqoqEyZeC2qnOUhi7v9mY?=
 =?us-ascii?Q?VLcDAVj3JjuSvIf4uCZkWErMHPvGkmAa3wjXIWTUcxZziKqKvM+gRZt4OTni?=
 =?us-ascii?Q?fp6ZAMJoOl9uuUzyeICVGLR5TwnR1RaVDaENx/8tUf8W+DJfHgS/eKNd5SPy?=
 =?us-ascii?Q?PYXhsIo+YZpIfT2bugJ4heow4mGCj/wQg/cysMqu9gU/9iQ36OUU4RLiumch?=
 =?us-ascii?Q?xpGpPJNqnBQH+zFxEPloNKavHFFsIO3X8vCeVIi8ycV5r7rRTigtu8lwUKvZ?=
 =?us-ascii?Q?/BxRaupj+KdPc//c3WbKSPIKxbHaWjJZAU+NqrvlQIA5U8AIfBOttR4kHaEJ?=
 =?us-ascii?Q?cTCNSWyCNv9RA4koZ2jGhnVasP8ez+0X+GEBVxqfiQfoqavlFSD4QrX5bJsJ?=
 =?us-ascii?Q?CCVtashpE+28E8D7ZVO1VBoi5/8HrRkMxlTvlr7YDrsCaB1OjNs0r87SeQfC?=
 =?us-ascii?Q?flxBDEWA/rP+lpfDTtdfuOoir0D+6VwKlRlZSPrneX48UIaoisG9WMlG0TZf?=
 =?us-ascii?Q?78RtgVQrQmEFyrk9j67kOzbc05BLHGZZ/isAQcrJG9hlZMdbQZg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:zazDhQMrG+UAioUgEfc49JyWPGmy8XjM71OCZIyAgTY5ETAUxyeI7tD5hYF7ZyTAqRJMA8h+xLY4IbXszkvoJjuUOdzp0zAYfysXymGSx+sEmbbSrlPhhaguw43EzdmtpTBkupCS8UIPiUJv5eKNANCyonk2JtILVuXroXRe1HtB5A7PrDXnVORqYmt/QHWFIKoheQE6avnQwx+y9e+q3QDBEtM3P6IXf7UksqkRS3kMZGcZ8VWIcf7MFfFm1nsXcTwiHklMjy07tx2Oy2Q4miJo/YzhiF8WGUpJ4pVhSkf8+M7gO9HlSZGJVQETnX8ZPA9IxbOhCzccHOr9JmugsQ==;5:iHsJguS2VNODwD2Fb5HKWBOerMsSUisUST+ob8A5zIzKKlYyPJoOsv9iDLD98FsTSb/YLd7AecTpVfp/xnnDemvsja0LxnykbCB9pWpGBUg00Is99MRa5R/XZQA+utkeRsafqpl+hHGDQdCIuN8bZw==;24:tyee2HP6jOYRxH61wiUCsB+zF33ljKaStIBtkfruOCyADOUol7bS8ALbi8yS0BPCfpRWr1rEE7gBzUQVRRA0yRPIPJIuIZcgWf3sc8RSVbA=;7:nVHYAnWX/LaxO4yfumM7s6nNGspN8mGrFwC9gaOAJqlh5bw8zL1ZxtlTl1fEoK578T+9vTBLTji+vAdsIxfxBKBSgKDELUReH3j2juSdv7HS/KySHjfPNPwpgTVa+IEgUGJ/IScKuUPrHsOBwkkI+kOeL0YKtLAZ9Gb/GXylFGIBpOq1aICNvWqJfKlKPW9mOWjrEbvxyO8kUA6GaNrptH4+PfmU0+O1EQ9p4Fh2WuM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:42:57.8666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59873
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

Updates CSR read/write functions to be aware of nodes present in
systems with CIU3 support.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index e638735..205ab2c 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -357,6 +357,34 @@ static inline unsigned int cvmx_get_local_core_num(void)
 	return cvmx_get_core_num() & ((1 << CVMX_NODE_NO_SHIFT) - 1);
 }
 
+#define CVMX_NODE_BITS         (2)     /* Number of bits to define a node */
+#define CVMX_MAX_NODES         (1 << CVMX_NODE_BITS)
+#define CVMX_NODE_IO_SHIFT     (36)
+#define CVMX_NODE_MEM_SHIFT    (40)
+#define CVMX_NODE_IO_MASK      ((uint64_t)CVMX_NODE_MASK << CVMX_NODE_IO_SHIFT)
+
+static inline void cvmx_write_csr_node(uint64_t node, uint64_t csr_addr,
+				       uint64_t val)
+{
+	uint64_t composite_csr_addr, node_addr;
+
+	node_addr = (node & CVMX_NODE_MASK) << CVMX_NODE_IO_SHIFT;
+	composite_csr_addr = (csr_addr & ~CVMX_NODE_IO_MASK) | node_addr;
+
+	cvmx_write64_uint64(composite_csr_addr, val);
+	if (((csr_addr >> 40) & 0x7ffff) == (0x118))
+		cvmx_read64_uint64(CVMX_MIO_BOOT_BIST_STAT | node_addr);
+}
+
+static inline uint64_t cvmx_read_csr_node(uint64_t node, uint64_t csr_addr)
+{
+	uint64_t node_addr;
+
+	node_addr = (csr_addr & ~CVMX_NODE_IO_MASK) |
+		    (node & CVMX_NODE_MASK) << CVMX_NODE_IO_SHIFT;
+	return cvmx_read_csr(node_addr);
+}
+
 /**
  * Returns the number of bits set in the provided value.
  * Simple wrapper for POP instruction.
-- 
2.1.4

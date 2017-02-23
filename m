Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2017 22:23:27 +0100 (CET)
Received: from mail-dm3nam03on0059.outbound.protection.outlook.com ([104.47.41.59]:39424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992111AbdBWVXTlppc9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2017 22:23:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UGr+DnGoQhFr++PBt3nRk6RZNRXUpkUi2vEM+YfIP7E=;
 b=WmC0XdTnO/0RDUWMUXU6LooZGLuv/YUl/WNJfDGIxF0B9dhg9HqBGIu5y8Mtt9/xaX4z20fArMInJKx5s5w39GkTq+c+gQ4yVOGSn17Kxs1yHdRphqWsuPqALOo+M8iv7XpCMTf024PF2j61gnjKfbuFT6MehwUiEBy/7gprY8Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from white.inter.net (173.22.239.243) by
 DM5PR07MB3209.namprd07.prod.outlook.com (10.172.85.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.919.13; Thu, 23 Feb 2017 21:23:07 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org,
        "Steven J. Hill" <steven.hill@cavium.com>
Subject: [PATCH] MIPS: Octeon: Enable PCIe for little endian.
Date:   Thu, 23 Feb 2017 15:22:47 -0600
Message-Id: <1487884967-916-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: MWHPR07CA0048.namprd07.prod.outlook.com (10.169.230.34) To
 DM5PR07MB3209.namprd07.prod.outlook.com (10.172.85.147)
X-MS-Office365-Filtering-Correlation-Id: cd99753f-0629-4c36-097a-08d45c322c76
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM5PR07MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;3:xO3B7/7+42RE6yP/ED7eLeseUflsj1WGA9TyOgbISvecy/LXDCyiIAF+YaPqbtI8HGzeXI80cYAegHpoQ1HqdE9yKOfbWad6Vl4BGlgX8weVXmZSl7hstFtAoSytBxrWSfMWK7IFIfGFTHKTy6aaZXw5rCfxrK4E1oBMWcuxPR8A7fGs60JTpe1Xvo2hv05uoha6iXhEvFcyDgg4kHKLGzuz2/7VFc08+gNbu7mxxV4/PxPCQKpznNKcA+xrp7q3hhajPa5oPVSnWSeHU3kZ4Q==;25:7E0cNqT9T9RRYfZuyCYQ7A2Piq2wL4jLnZ0NYkxZ7agvOQSh2RCrwe1ST2KRrKJ1daRWbyo56hv0oO0DcoOWzsUMAPc1rawvh6J5/qmCp7qb/BuU6Jzpx9gx/a+JNELG4lWbfKik1FARsvuoa7eds9J3VX43wTJ8vFBTROKwyyI0K38gHjm+xSI/0800Me3byfUIh4IFSz0Ojdcrk8vpYjYXx9md5m5M0YSuICJaTwdyQd/QU1qzCgPJsIIPGotP6nrMHWliYLLq0byvJT3ifkIeegjdN0pdfRSAD9EK1mA4XeVECEFAECprQ1UOwKDwRfFFNFeXGLM7swZSIU61hkJMA+NVPokQzN9U55TxvGJCX/ZCPKXk0U1cliLvptq2TR2ZIXJklpWR8Iudgi4o6cs3EQMxQKt6Lo7Ps8Yi8SCUZIGV5bgx8tH5up/vLyNQT96OUYhumK6ZTHLA1rDBxQ==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;31:f8wq8L4nYjmyTQ2xeCQsJPkFg+NdhJ2WFhOST40/1UzRWZ0CLTGs3hZ8urvC0ekMO98wOmPyho/jI9fRs3zJ2ytPbQQmEJ31bQSkJuvbcAO9jf31VWoQn+nj1RhoQzUpAabQ4HHFShzhPfPCnGnJRmqFD/GulqR1zuKZ77Ii2TY3qV5zO/GYRnLKPluH3AJ5+zuoEghOe+VDZ2acFAbQgBs8wPfZWlvTUTbtjBiuzGg=;20:FkzWVyFMc8beuvDDTr0aDaH3NwlvgpAg5yRbuOV6wWIU0E7WUcKCaC+PVm5L+gCR1dzbKxIsM7ToUzGbMM6eCLXFTdHCN1nbcqHBA1jRNQcSHNFRM343VJeHntKZxLnwRJQKo8Z9xB3sj+kvo9hGriqYlBECeBq0MVBPUlP5LbuVxfT1cQi/NENilKmPMi1UIU90oscr7cz5S5XFcUCyyaOOH9s2Mo/RXXswpxMFCLYWlqEZkGAyqSrtLKWRJUgFzr4LZaE66uOQLd6L0xJJNMAJI0JiQjUe+18lsmv16p929HtDRBMkEq5gxZ8Ak3WgnQlmMXlTHgOfy91k/TAukRhmq9B7oyQS3CK3aPgtfZHhP3cM4nQwV/BXR7U937rL3B1RCWITCPxAUZdY4aVeeLep3qF0Y/xREv8Yw2DoD1lTfjvLJhnEfj9oR3HD/nAn6oXvH6E7v48S23KD9erLzV7w/bqNIh/TZ7CczxubxF5awBwGroHCJmzsXijYsjUj
X-Microsoft-Antispam-PRVS: <DM5PR07MB320995C5071D548E17F075FB80530@DM5PR07MB3209.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123560025)(20161123562025)(20161123558025)(20161123564025)(20161123555025)(6072148);SRVR:DM5PR07MB3209;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;4:lA+qlIwTcJlpQek6dU2kt5toRWqQZRIplEaxwVfKfEEYPU0OO6EIBVRsaUAfnqqjxogYa6C9W2rPxRXysrX0QtVsuaAfthtUJPg7HswAaxYQ1fPPUxyxwygDmyGf+xHc7RyEx1UaB87Vvbt29F5DNGFgcgOftxwlvCQmGZOoprfejQaRu+S1SvXFojG/9fEKYkXPzr4HNLIyFJsZ+pFrMe5PN6na7GsBkO+cqleQeC8pKNTy1Hqd3/zAAoALJVRnXYMF7o6wDAamw+EJfDJ9Bz0lJs4qNj11j3pLVSi5ileW88YeIk5UEQID/k8r5YObU9bD0LuEhds9+5hG4qCb7sLFqlbyXMqEsmsVfNjdA8bUxO/Mq5shyGt5TgsBvE7FbXEcQYqJg5lPi9XL7oTE+8i3n1IeX3v0jD5Zw2iBUZhMfNCxqhyIV6f5PibFWor1Yr+kukk06WYr8EoB9ORRaC5SAT9Vag9GK5mFbq3BCZRIB1XphowdKTNl6c9RiJaNRECyHxy0mmiuk1KBvD26dAIV97G8pCip5t6wA3xRhIz28iElAo23m9cQfRnTzP5UPj80inSyeNc+G9SA0WS6NG4tzg2eyuNXtnigqLPbiUs=
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(189002)(199003)(189998001)(50226002)(81156014)(81166006)(8676002)(4326007)(110136004)(107886003)(36756003)(106356001)(6666003)(38730400002)(53936002)(2361001)(97736004)(2351001)(5660300001)(6916009)(450100001)(92566002)(25786008)(305945005)(105586002)(6506006)(54906002)(2906002)(6486002)(68736007)(50986999)(101416001)(6512007)(69596002)(50466002)(48376002)(33646002)(42186005)(86362001)(53416004)(66066001)(47776003)(7736002)(5003940100001)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3209;H:white.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3209;23:ukDfU5vEA0nFQ8ieH6EjSRqbiyZ/kkJxiLK1uQoFT?=
 =?us-ascii?Q?cZ3ySTe1xJt8TRHRntJT2WrPflpUbgRmM9DBcIhb9iJI+npSIlOWoaF04Fwt?=
 =?us-ascii?Q?9wWRe4VHKq+V/rvP/gvuPVpEa1wM+9St1zbKr+EOwgu+/1Pg3EY48Vse14s0?=
 =?us-ascii?Q?wrSUNJY4hVC3DJOF9jTREYWjY5tx2ohaKeU/oyZP/ScXPUbDqR5kum7OtTMW?=
 =?us-ascii?Q?h8hk4b+CEkGVhw09YBati4NhjPKOx0FxznZM4Zyc2WUgh9muBQe4MBHp/A8q?=
 =?us-ascii?Q?lATmhvVG+SXHxm8w98YBj6sQ9Gp6WeN5pYf4jVxJSVqBlL9StmiuDRKpwBG0?=
 =?us-ascii?Q?faO9+bos3kd5hGQtP2mabOLq7U4ANNqCzxOInihyJU7WNvhPly+vGEz/XDCJ?=
 =?us-ascii?Q?Nh/JwgFemVLwXqYlB5+XTiXIB/NIY+ijkeF6sRGWvmDbtJa5WSyfuukpgq5Y?=
 =?us-ascii?Q?+JXBJ8lEIeauEnN5+pdlB5/wBV/tvGDkyWTmNJbig1umKcHGkWH4yswv79ZP?=
 =?us-ascii?Q?sOydikfqOAf8jCs8crRKqx3O17klcJkmZimkH2vKHlNGfnBA5WM+nXdpdfSL?=
 =?us-ascii?Q?sup7arWQwieXIp2AbdRDTq758MmJjZj9+Zr8wIF65v99F4m5sirEZejiPVVd?=
 =?us-ascii?Q?FD1IbTc8ct0nLJygLAOH6FQpygnSgVbE8H6xexn07mmvPOimbdVID0Gop3py?=
 =?us-ascii?Q?yod0CN8tcj/n/WfaiJCDkJ/X8TkUF9wGk6mmNIWDvQAK3wrDFVcFMlZPUfj9?=
 =?us-ascii?Q?BcIigWlQ3HtBG9nRV0s8FmMutta0Z7NdppofdUm6tgNkpGLzixq2ZELgC2Rz?=
 =?us-ascii?Q?jUUzf6GWwuq0sYVR6h1+tclBBlgLVbs8S9Bubtz9/O9taY+bfDYjoN4V6yqa?=
 =?us-ascii?Q?oMcN0a0QFYgZCWCCBfbB07wM0irR3t1OLzE7acVMv1gtEije3VVbppN5oTd9?=
 =?us-ascii?Q?WFCoyrh384GXUwKT4CZKbRYTzVNeVBiv8r6bMJ7W9yDJpSNJ5h/Z1yJJ+Lzt?=
 =?us-ascii?Q?gAYvlQf/bSSHW1hg7PX7ZbQIZMjKiHKlGGYwnLjmm+tfN2myaIb/YVsxncZa?=
 =?us-ascii?Q?7q5xB7eidP9ckNi8GuuQRbZ94Pkz0fYZ0/fmjH3njXEj98dwiJaqh7KoDmGK?=
 =?us-ascii?Q?5DjIy8QuHHkE8tvwv1yEcwCB27i+nMjcCN9fDC/fevCVhQGNeYPbn9kbCigb?=
 =?us-ascii?Q?4MBKiUEJ9tGASs3Egpzsi7hTD5gCrqJgnhX?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;6:cMRydKNpkVCOA66/vziSvrqKNBoTBBJpwNA+p9YZk3qchmTXHsKxN2xZxyLRIDoFj1weaaiv1U9A9OpXpIYBcjRr5ghdeMX2lqP0j8W0VtOS9snx8XkCmWyvBrAxFlVu6rIdFI0ZrVPsG5roYuR+WWKJUh3oaTyszbd7qLPLTn1b1PhrSJVc/zHszvmPhBE0xREKg3+IKUMwcz6w+iuHLby7rOkqDLslajnKO5FVgEWmQc/Zz+Z65JXtll0OKyzqGG94ixSPoqjrDg8p1505Ngl3YqpbJg53/caa0axNyav4PdhJYOgQQVdEX10bPsMKM3OtBG7XgkZk0bB3Y926kg2dzdShznw5pHcSP5PSnqnnI9asPErglq2Sb4omtXyB4XCCzhyQIH2LtAjglC0pMQ==;5:h1iVur+Yby+k7OZdgv6m66tHQgtywzFA5fmRz7wa9SAX1XuEPq1iPrFt2f6FF4B/glzqrHR8nj+AfyK0F3PcVM0ZIscvUQjqzWuHH24o65Z6uUgxTeEHFUvkw3RcfW5PERSPadhYDlek3V7OLyaREw==;24:y0XdEsJqluyqCNDbjixIaCbTW7GG7g1e7IMXbXhhNBSKDSDa9VcDUrh9xBsmhMsYgkddRYSrfhIEFsCdenAtTk3CcDybquNUaX8YvofRQ8U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;7:LUCHaa1lH943pflMEcW2raabF1lWGiixJpo+Re5KdZNE/hL4hdKr+P1fq1u9OAH+UQAtnjbj1ASxdrKsePD4uASeEwBOcxhyJ51RByJNXpfGmULxTkI0D94F+Dsz/eHjnipQigwely8gOqx0gs7YYu176WTbCOnULMZJ7Kw6yu8ENAbW1ymBJvuMtoLHKI2NCwHOvCCvJZG3s5GSjJHrNBK1xDnLYaH2jEfGPq/cKBaWmqdfpYjun9aAfqB1Se70b7WYLPdoKM7ljb8ZVahhjFFSIF7Qmb3QhysroFwxFBUYmU8HFLddyw0+F9zju8YdmnhgS9VqkR2T0ZnzCrMEmg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2017 21:23:07.2637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3209
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56892
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

Enable PCIe to work seamlessly for both endians.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/pci/pcie-octeon.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 8f267bf..3c5419e 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -31,6 +31,13 @@
 static int pcie_disable;
 module_param(pcie_disable, int, S_IRUGO);
 
+/* Endian swap mode. */
+#ifdef __BIG_ENDIAN
+#define _CVMX_PCIE_ES	1
+#else
+#define _CVMX_PCIE_ES	0
+#endif
+
 static int enable_pcie_14459_war;
 static int enable_pcie_bus_num_war[2];
 
@@ -116,7 +123,7 @@ static inline uint64_t cvmx_pcie_get_io_base_address(int pcie_port)
 	pcie_addr.io.io = 1;
 	pcie_addr.io.did = 3;
 	pcie_addr.io.subdid = 2;
-	pcie_addr.io.es = 1;
+	pcie_addr.io.es = _CVMX_PCIE_ES;
 	pcie_addr.io.port = pcie_port;
 	return pcie_addr.u64;
 }
@@ -247,7 +254,7 @@ static inline uint64_t __cvmx_pcie_build_config_addr(int pcie_port, int bus,
 	pcie_addr.config.io = 1;
 	pcie_addr.config.did = 3;
 	pcie_addr.config.subdid = 1;
-	pcie_addr.config.es = 1;
+	pcie_addr.config.es = _CVMX_PCIE_ES;
 	pcie_addr.config.port = pcie_port;
 	pcie_addr.config.ty = (bus > pciercx_cfg006.s.pbnum);
 	pcie_addr.config.bus = bus;
@@ -1347,8 +1354,8 @@ static int __cvmx_pcie_rc_initialize_gen2(int pcie_port)
 	mem_access_subid.u64 = 0;
 	mem_access_subid.s.port = pcie_port; /* Port the request is sent to. */
 	mem_access_subid.s.nmerge = 0;	/* Allow merging as it works on CN6XXX. */
-	mem_access_subid.s.esr = 1;	/* Endian-swap for Reads. */
-	mem_access_subid.s.esw = 1;	/* Endian-swap for Writes. */
+	mem_access_subid.s.esr = _CVMX_PCIE_ES;	/* Endian-swap for Reads. */
+	mem_access_subid.s.esw = _CVMX_PCIE_ES;	/* Endian-swap for Writes. */
 	mem_access_subid.s.wtype = 0;	/* "No snoop" and "Relaxed ordering" are not set */
 	mem_access_subid.s.rtype = 0;	/* "No snoop" and "Relaxed ordering" are not set */
 	/* PCIe Adddress Bits <63:34>. */
@@ -1398,7 +1405,7 @@ static int __cvmx_pcie_rc_initialize_gen2(int pcie_port)
 	pemx_bar_ctl.u64 = cvmx_read_csr(CVMX_PEMX_BAR_CTL(pcie_port));
 	pemx_bar_ctl.s.bar1_siz = 3;  /* 256MB BAR1*/
 	pemx_bar_ctl.s.bar2_enb = 1;
-	pemx_bar_ctl.s.bar2_esx = 1;
+	pemx_bar_ctl.s.bar2_esx = _CVMX_PCIE_ES;
 	pemx_bar_ctl.s.bar2_cax = 0;
 	cvmx_write_csr(CVMX_PEMX_BAR_CTL(pcie_port), pemx_bar_ctl.u64);
 	sli_ctl_portx.u64 = cvmx_read_csr(CVMX_PEXP_SLI_CTL_PORTX(pcie_port));
-- 
1.9.1

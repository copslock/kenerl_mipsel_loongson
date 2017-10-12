Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 23:03:58 +0200 (CEST)
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:34528
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993035AbdJLVCr1R2Oj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 23:02:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qPNIbe76/kyrNQ87VrplO3mtfdtEx16FXHoNDdqIwa4=;
 b=CMRBovDX9Gp5zg9ayeX7LJbWOEO0eskeo3GV9zTdN6aEosA1gYhW/kvXY5CeJdlpx9yY7lrKXlUD1qho2Gc7Rowt//HjU33DioQWiqL/e1yyYNiFDqJMbSkQnpxZYPbgMYrU62hT71l/CiSLBl6Zwv85FVITwk63d0L49cOC2ZQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 12 Oct 2017 21:02:36 +0000
From:   David Daney <david.daney@cavium.com>
To:     kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 3/4] kexec-tools: mips: Use proper page_offset for OCTEON CPUs.
Date:   Thu, 12 Oct 2017 14:02:27 -0700
Message-Id: <20171012210228.7353-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20171012210228.7353-1-david.daney@cavium.com>
References: <20171012210228.7353-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com (10.162.96.22) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c4e77b2-eec1-438f-d209-08d511b491aa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:tnPzeR20fq8uPfya2YW+mQq8ob7Hj34nW+wQNLPh3b8S93XT/rQW7/ZSmQsApu7Y9+qeKnZXykTHxvLEukycX13HpJCB/zRaucrs/Hvnbr5lsGxINOhZkJiDgW9DOq856nRskdO0E06vPw09Tqs+r2WDPJzr1uzu7dVEv+iJi5f57oc+pvFMjoJpH1617Prr8K2ns3vSgFHSXbJdlp5ikePKTcFxdNTWStTJn/J0GrfZJ9YBkgIoyyOY3t80TM45;25:UJV4FFvYigfk0YXY6bFtVy5SD51kAq5omu2TMnQW4MLnQ7fhtTDOwSAClzkTFGCZblc97tCLDJvdZi5Ya/VKKQoYKsBiaZ8zmwAr/2fgEuTYwQUXWpEEBOB/ASJ8erqLPW/wYCWtHe8kDSEXitFtEQ49a79/nDZNm8vR7uwii05kO1Zl/tgsibxbChxztUm2AbQ4Vwt0rpvCJOI97MvCDUrR2f4UY104hm/PmPmGKEmd2cbqsFyjJcrV1q2JLC6PAt1XwDTa9b+e7NEIUJA66m2fpDpQ4bVlWJLFvLlEKNOsHJiWMl7TAUJuUzEknrKUcwdV8/YGVOi4FfJIzs9ICA==;31:+KnC/qXRcNrr0WZUyrGGPU18Dpko4eOI4Z7CvJD0nRNDAxqe3QxXKCzSGrzXmalAxe/QW1mzdZ6PfPn+mMMy7GGkoL1Ni/ikWsWi9lF3Udy2BX8Gwmq2qRGGY9vvzPeT2xgkzOg1pLLWoybDeTvB51ECMpzrwC6qKKHBn6Ni+JA3aGUXBs32jfqwku71xox4yOfohxvDu3XDZcn8/8Qy3NF76ZoLhFJ8tk8gXmiuhDs=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:7g20oiicZgnnDS6h9gpnAK127kgvQzcgfxuVqLek/19GCpnPF1bF7jZ2HIbMiHKZ9lH4NB00cTVDKrp9+EJAwoB8woxZ3bEZT6FukEp1L5ILZRfIew5Zxwk3uiyzeJuw2AJfApExsqkmNROJ1ZJXG3mHMrn9+AbIzsiAMzNWrTEMLFilZ//sM4hPObnws0euN9mZRdeR8gi4xyc1OkiWfGLmInMgaz20x3caNIgIqQwnVgpQVBdvwDId6PiUwhd+KjC6UpA/w9ZEC7/b3a1PndhDj9cdvBsRKnjFU/tFNBGEsGKzXag0H/hjAr93mMsoUEi0On7z4iOIMfnF3EeanogMlQdOMNvmgezWLb34sqqZyieS2RWC0xFeNsICsnmifRlXAnTmzISubDBRAt84F/tsotrZ1rFnWv3+CFsAuwUfAzmqM8vwLn9IAsx8W4b0gntPyHAS+/yzx8tnKqehfSfKCrzHyMbYNnpfDeabPQkrokb2jJs75RYtIMJUjWY/;4:uAVCyZskKVifpZGgvBBU026R3PgfT3kyxFht6YAKltI2sUtPRzPJC0BRp6VImuiccI86fF21ztiCCoPrxN/6amHzaJohGivIrXOif+QX6v0kUoNCNHaaaCHsV6SvEebBNaYmWX1P8IdAi4e81FLe+q6q78vqcAtvJRnQtRxD/tdBqxL18oF4PxL97R9syzCGzYxY+v4RVfJeg/CM/mddH+O1pXEgE5LO183U379dNQBT9P520byn6uoUPSn+EO5j
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB3503B452B21442514428E77E974B0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123564025)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(16526018)(68736007)(53416004)(76176999)(25786009)(50986999)(69596002)(47776003)(5660300001)(2950100002)(50466002)(48376002)(6666003)(66066001)(101416001)(86362001)(6512007)(478600001)(316002)(6916009)(6506006)(7736002)(8676002)(81156014)(81166006)(305945005)(2906002)(16586007)(36756003)(72206003)(6486002)(6116002)(1076002)(53936002)(107886003)(3846002)(106356001)(97736004)(4326008)(33646002)(50226002)(5003940100001)(189998001)(8936002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3503;23:25RWWgizs23vuKW121FBE3uGvGsSCyvgfb6m70K7P?=
 =?us-ascii?Q?tFbihP1FJvNN+8p9mdbIA3r4ts3PXfmBGNPWwkaGtv6RXyIC/MZ4ja4CXu7v?=
 =?us-ascii?Q?iKi5KRQHn6nAYgnFMm/MVxmZF1UUw5lz2VkCx8CTaA4M6IPhByu427QiD/VY?=
 =?us-ascii?Q?bA2BCNvbRL+Cy9nX7/sI1NzzW3d4c7bvqLdSfU+A9huEwvBZnuBnIc77aQZj?=
 =?us-ascii?Q?NNxqqIJBK1kON6LrFgg6QcahF4pskKXC9VM0T68uI0QmRAHpokkBdErkbRzM?=
 =?us-ascii?Q?dnXXyix6R7bZPcAjzPRtmCNVL3763hbSL86RSKrLz63OVANhGCZc88zHmkmh?=
 =?us-ascii?Q?qWnnR09f67SI7ZF81c1LVsmwfzZAwHy3tCRRH+l3dT+JHC+jbgO9Kxthch3D?=
 =?us-ascii?Q?o/PVr9oYIvvdBwBm24kGEjm77rB/DrK+0FZ36ihC6AaT2hZxCJVF8k+6KXuK?=
 =?us-ascii?Q?p+XJR3L+p5gQzx44k0AWIwY5t/wuosfRbUSp0f18pJyJ5Esxc5KJRJWqrXYc?=
 =?us-ascii?Q?scsk0ivcW/LEpEoXgAi4DW+m/0Xof50WC9pRED1h17RNvGWAdA4d9TkxnORP?=
 =?us-ascii?Q?fqFplelPTrc3Fej7Q7I6unuydreh5lzJKpACPaESjuAwFlsKaZjSmq0zApHw?=
 =?us-ascii?Q?7ce5YPnntx9YVAM7cV0sGUkE7SC+ZXZzBdvDsx9qwCsvjI0hghFZ20nEMau3?=
 =?us-ascii?Q?ngXD2UYSJP2InW4YDjbj/C9ue3/uR5u/ZeHQujEUZ55THAjNcXO8UulFJByH?=
 =?us-ascii?Q?2eQk2iKb/i4H1XfbODv8NBDcgUFgbtvA1ftqrE0fkcnwl+kU/lS/4RfOM6a7?=
 =?us-ascii?Q?V08p4SKcFb/pYM4nQ+S+NGW5t3lKyz3tZiB8PwhkXwu+qzaQwvfnRW2Cpjk/?=
 =?us-ascii?Q?fuV8p1R0Ew4RstR9cufq+xV99XUYLaRNB7qx/hjOLQx2DFwWxzd9PwRQgStB?=
 =?us-ascii?Q?D36ft/Cd7bM8nwro71y5gLeeNK0wSEiLkQrGwBtbrYakHkEyUs6yjmb9P7JC?=
 =?us-ascii?Q?EAE+TPFCbT7bJZkqDIUraoGWuTI39VO8Sm+SHfYO35a4ltCKhK9+UBdOFXu3?=
 =?us-ascii?Q?QvfLU6PvBzZBWhkMLSXetSyAZQf8GR5c5e7wVWJ0e5FwQs21wy1qCmHdeMfY?=
 =?us-ascii?Q?jvayMHteyUXJ1c8iCIWtNvC5114ENvPfst6oowXTJoAsDvfpoeYLQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:tQOS8TZimcgR1LRP211Jq8jwLztATQpZsoRUlpnbyiDXsGnwJzWbVAZcOnPuQpUPR746+2j/+jOIpYwkgqnDvlEJ9Usk/kEllmmoyt8+TV3QB10UAQaswkkZjSJ0ArTQcu2qTzXw5mW1DOg1TSe6T6wP+Ff5YXg6YEQn8sTNFDIe6+1mGA9PYOqtunwWTX16Q8UI9qD+qePtY7SwKtDUI8Iyr/TAeMrZ/Gzgv+7LRGxA+ZjxGORoMcA+txzRSGi0PhpDYKBCVBCWkr8EZoBrdste806TSPM28tTpnaQeUuhnFp+zCfpg/+G+MCF2hANKro4q2UMVCNQhzczZbrEL2g==;5:HslQkYopfMa2q5Sn1gtF0RXMhEBSA5wuYpP3M0ZWypjejiIQdneWEUT5G7i1DLDSbyAhlj8wbC8ijtYpjKQ2vDuhHaXXKaUVvPPzzDpzDmOu8r9oUSvawKnx9ZCrskMMtQda2Ey6krXKrUVIsZKR1Q==;24:/f3kORHSv8aTf6XERYk4UBXDd7jEX2B9iSyaXmAmki07mdz8ZZNzFVcP3syN11427FDnJYnKFEXi+pQ4QMpkBiEFJZez3UUhNjsVl82gStU=;7:nwJ6M1cdM1norDy76xagfFrQM5pjXKCVKXRqpPQVRmQCdUNHuTGO+p9LSA+5dM3XKQ1VKHOsWn0caMhK1HFCjGQH/QpaeviZNTVjYtFii61+uokt+55OHXtU7UJVxeoJnNdfDtSYXXpV4CVsCLNxBZwxHpTxRsw/2nsZSijaPaM42FdKV7bj5mLqTPeBjfpHJPSuiD+BCjaTuxAeocQw6kwO6tcpN/hfuqdeCkjqszQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 21:02:36.6907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60396
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

The OCTEON family of MIPS64 CPUs uses a PAGE_OFFSET of
0x8000000000000000ULL, which is differs from other CPUs.

Scan /proc/cpuinfo to see if the current system is "Octeon", if so,
patch the page_offset so that usable kdump core files are produced.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kexec/arch/mips/crashdump-mips.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 22fc38e..e98badf 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -315,6 +315,30 @@ static struct crash_elf_info elf_info32 = {
 	lowmem_limit : MAXMEM,
 };
 
+static int patch_elf_info(void)
+{
+	const char cpuinfo[] = "/proc/cpuinfo";
+	char line[MAX_LINE];
+	FILE *fp;
+
+	fp = fopen(cpuinfo, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+			cpuinfo, strerror(errno));
+		return -1;
+	}
+	while (fgets(line, sizeof(line), fp) != 0) {
+		if (strncmp(line, "cpu model", 9) == 0) {
+			/* OCTEON uses a different page_offset. */
+			if (strstr(line, "Octeon"))
+				elf_info64.page_offset = 0x8000000000000000ULL;
+			break;
+		}
+	}
+	fclose(fp);
+	return 0;
+}
+
 /* Loads additional segments in case of a panic kernel is being loaded.
  * One segment for backup region, another segment for storing elf headers
  * for crash memory image.
@@ -331,6 +355,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	struct crash_elf_info *elf_info = &elf_info32;
 	unsigned long start_offset = 0x80000000UL;
 
+	if (patch_elf_info())
+		return -1;
+
 	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
 		elf_info = &elf_info64;
 		crash_create = crash_create_elf64_headers;
-- 
2.9.5

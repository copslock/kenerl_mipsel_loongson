Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 23:03:37 +0200 (CEST)
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:34528
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992274AbdJLVCrBZzMj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 23:02:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ie3wi9+sh8DGeqsmmOcXMeALs5Dhi09nUSsmUh+ZgN8=;
 b=DmMfm5tKaBXUZzWL0Jh7wo3J5ws/SF43YVpCsRaazBqYiWzm7GV/tVDGNOIZlwU+EEIZ2xy5SxR9shyXkX1JvXE2kwRcCATRc9M6GjZnUQ5iBqFwKfQMCtu8W6mUH5dRszU70ZbdhX3kfpiEag33ovYNyq2izBqPjNsYEEEBopw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 12 Oct 2017 21:02:35 +0000
From:   David Daney <david.daney@cavium.com>
To:     kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/4] kexec-tools: mips: Don't set lowmem_limit to 2G for 64-bit systems.
Date:   Thu, 12 Oct 2017 14:02:26 -0700
Message-Id: <20171012210228.7353-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20171012210228.7353-1-david.daney@cavium.com>
References: <20171012210228.7353-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com (10.162.96.22) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73dd73a7-d42b-4e16-921d-08d511b49066
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:rMUzpPbO450oW7pX83py5MayeUARBddJ5gpv/zCrwD5fgFOfRJieqvsNYhaCXkI+BwWbW2hF/74T6KAzi4zCCgSuj1C784cM8piDAyiL1QBO2uA9d87hO5QrfewE/6tWDmA0FTuArAC9httR/0StW7AN6vYPI2IJXESX5h5BI7lrB/0utEE6F2qDgMpy0UpDfxqz98JSyQd7kKCy73Ao6jHv2FEp53PaUkLob+kPlAfuN8xUBtJPAh7boSvMkac6;25:s/alExofZNTFAvv1LIIIdGSPKrz8yL4S0pAximlIsehWasaTX9o8T/bzx4Mdv/4oNTnCzITVPqLQ6io8+oHvgNFARjyXuXhzn5wOSZe7fdmcoHH9j6jsBilXUq+KeDrRlHxXqy36vr8SyyNyqQ8RU0ndZ2hGgT0lohVFWwvNR9f9iV264GWdlTshLIAPYMJcVdXDCD3crj4/ZCoCtJfnEC030pRNNFXb9zijgffaKpK+ld6EJdArIxToN+NjN0JZjKlcZoH6Y/aab1JyTpqJIuy2OFScnnWV27RSy1CE65hfbFH3vl08AZGf40ZSnlfR3wS5vGDmhZLkiEzZJtLzew==;31:TgANivx/Fp+61LOpukUz5zlzAPwHIWgmwtNA4M/Hkc6qEEe8+mbJ1dpdDfETkn8zyvy1RnuFSVFvR1i4KINP80DJAs975UlNJvplhKfPExfxt86vzL7En6u3vQTW+gEISL8GQ08b25iK9hAVskOqv8gDnc0V4F6tg65qwMQFWXWPNP47lpUPOmA5CuP4hwYYpXEdNrZzQAVkvSc+0Uj5v2I4hMUE9q+uHtJJ46dNfAM=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:TH12VQa2oIzq6J4dr4CSFKx7qFFRc9e9jgRTNKbzdtL4Falhu+HQc6zXJsN+kc0Tyygcnx8rmWmep+CahHw31RozPAnHTd73uMUNdrlvN39xF8++5nWOl1yyDPIGuV2p86XUzvud5V0b4AH6p8T0Ljboxr4T2hbLWRhX5KfykqReID4wYt+cs+EWVGn8KNZ5HY1hX6FLSOyLM6U8XZB+trbddP5HQZq2OWPHn4mJpTz/i5MMIAgYDoPSoFl9Jy+0TKL9gsV9jNUz5/k67+jGOIC8ho2qEUnrT2D4V4jdfGe5qGDbSg+syqisq6sgkRaag2bZQIIlKl0dKiT+NUSN5UPSGRENI8IXRAs4m6b2gvXsEy/oi0jnfEIoDgoWlSj0zfiITBVHFy2rk9WqTKW+ev8uRWxr+bP5o7ND8pyVT7ZFVXDvhUxixKeUOZ1bFvkUc+bJQG7nFt2h3VDKhqJrAdt2QkU77ujLGYOdMulQhG1WF2jv9/+UOA5c/T66y0K/;4:SQwCMjmRObkyE9oXs00JBV6CpNP5k6fnAsDnBdgY+fZXaTttvmeECEljso0cN7knX1kAPTzjX7hyQUsfHJCp6NXjP70yoEC5NgiKxrauLVX0xBQ9iWy7rVQeWYqmWwiw3tS2j9oI9aiKv0PQW2V2wENeZA5QCv/TyTt5pzR2eilvMuaWcL6zLYxtJc6L1YBBfrzi9XNMm9S3vTpTo2yMZyz7NsO9bP0AvosEZYUpEkROqGXQsgqU3TL0r/Z4yyHH
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB350395AF26A74CE4AA80788A974B0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123564025)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(16526018)(68736007)(53416004)(76176999)(25786009)(50986999)(69596002)(47776003)(5660300001)(2950100002)(50466002)(48376002)(6666003)(66066001)(101416001)(86362001)(6512007)(478600001)(316002)(6916009)(6506006)(7736002)(8676002)(81156014)(81166006)(305945005)(2906002)(16586007)(36756003)(72206003)(6486002)(6116002)(1076002)(53936002)(107886003)(3846002)(106356001)(97736004)(4326008)(33646002)(50226002)(5003940100001)(189998001)(8936002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3503;23:GzpkAHChBhE+V/gev9p45t9iHktOrlPy420Amc/NO?=
 =?us-ascii?Q?Mn7RhdyI4UrqZKzCLdXCOIQzz9cySNLjrl8GA9Cz9ec9cRGVFqudgD8yFUSH?=
 =?us-ascii?Q?a1+VBIczNun4+u9H1Zcyu8IEtIliACevHYGou0+zavG+bFo5+1QDmI2er4Jr?=
 =?us-ascii?Q?4z5iGSHxoil4BKH+CzWxd5eZh78lCpmt9083QI8OlVxgR+BYeZEHgrU0Vn7N?=
 =?us-ascii?Q?XmNvLhRNA4yAW8Hdt+Bt1hkNV742Prsw+zxdM9cFZAG3blv5RHObpwVHV+bl?=
 =?us-ascii?Q?fG6qpAELpz1/HeNGZHLU+r1h5sEVAlK77dy32VEGMDfOsDfQBpJTU14HtvEu?=
 =?us-ascii?Q?pKffUtvYvMXc/VbZHmRYGaFhZWC0vbJgqVOvRrWzAQNxwt/hFOdwZ3NBlyc/?=
 =?us-ascii?Q?84BPI9Y9S7P6VMNCDirK7+fPJqWQWh5kz58SMvi5yZhUOlXHy9VIl8dqjcf+?=
 =?us-ascii?Q?/ob62+dSQG1+ELKmNe0/MI/EomognoSofN5w8OWucOwHEJUnrdOeEhxWiSmI?=
 =?us-ascii?Q?/Mkotn9e5aFtLlX+2OGSQJE7R6ZiT6TYF92SCJ/H8fd2hEg9eJRq5aM1KZtv?=
 =?us-ascii?Q?xfdjAPDHkC+Kj2V+nn7V6UX7OkMUaIsxb89OSI+KS9EEYaQqfp/XUaHvQO/2?=
 =?us-ascii?Q?Gfk4h7uHw4vqzfbCt3bW0TZGrCrC9qU8TIHMyZEJyE9EuHGf2rnnwz236FLy?=
 =?us-ascii?Q?ZZKNrcqJoXCQp2Ws0gZEJ9EkG0Z9dtuc6fRLs/tCTdIP+Xo00NzM5jK2nca1?=
 =?us-ascii?Q?VVJZz3vDAp8VWf788+BVeripPDJO/p5u/ak+umQQE1oTXEIBYdyI9VNF6zH1?=
 =?us-ascii?Q?XfhCpUHpJfOvw7YZhfCodHTtxIfq2bGa7gp5TtI8FHDM6GBdt+JY+fW0nN5P?=
 =?us-ascii?Q?S0cIncbt54Gv4GNHFld8t/lcPWjht5d/CIq+gctggViNAjg8CA4XdupX/93d?=
 =?us-ascii?Q?rudyXViBRtEUfznoAa5Sh+mUgAUgXwoBnix528DtPVYdxvOKtrVgbmU2h3TR?=
 =?us-ascii?Q?9kKGrlozI11EbfMlXk0NW1ggl4khzsQgNTC67dNoTa2qlmi8E58SuebPWifO?=
 =?us-ascii?Q?K+sk4iLZZmgLXHxJvLmaHKNoX4CufJXE3rBb/sL3tWYRbioqrRxsS+9dAk90?=
 =?us-ascii?Q?+t1XsSo2b/b6OYvQIGkzpvbwzdY+2nMZU/KXSvjjOJpglhex8iz8A=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:G+5XqppGVUDic+gVas/zIqvj3DzHMekHsCizQqeWqR4lwQP/iNONTHAhdhkmuJuPO0dso9kaC84Ze7i2MbrhHybuPs6RXaAP4YG7N5BqDTR1mHFOBF/t+LQD7dIItl9xizTev2On9f1780Axnz+BQk23RBw+Y8zaWnQwQzEizd/j92NyLtORYQS0jB0lbdxz5PQ9onSf7ef9205Ou7csRIq+IXXgUUgJ0f+R7R2emF1eiGmbH39o1H56rUTA1QvxsAkfZKcRFScRkJzW/c74nGkqAJX8+0fphwIxOSWZzeSU1Qv6XWSMSjYxb/YwgPlWfufwmYIemF8uoZ8qK3hXWw==;5:4L+M4OIVTX8JVoLTZilIa53OxEbkpeGeW58VO+vRvkmnXEbVT2TiUJVbRbGBJMA/jOrnKEXG7Spu/drvJoRudpNvXvHYMKGTfsC2VPb4omcM73c5YNqy3Yc4o1MdejtysVZTPA8xNXj/FuFC2efxYw==;24:w22ndj4mx+1CQxKpwMWobY+DCXrDF/mqdCRuVgd/6GA7KgfS8mXnMzME6zXEqZ4ybfoiafQF6umal1JSH44StxgwM0LEgDD3cqKF6XIXTXk=;7:kNriaO428Hkb+qKasjAghEj1YklN9ACvvrEQiHB0yPt0m0O3MNFcGyaxogYNpJ62h5JLQlzopuMcep9uSuOTfRJsfkrAvBlMnVFABTY/fq/VciDL0eDO/efxnBndupJAovtYmjNyQZmlFNQSJtxxBRRcGC7iU0ggYs7cstyEIwAloJar8BgWB9axTbLOv/HKzkYBiabPGepjMNrS7ngi2SKp8Q0FCOc1sT72T78ak4k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 21:02:35.1751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60395
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

The 64-bit MIPS architecture doesn't have the same 2G limit the 32-bit
version has.  Set MAXMEM and lowmem_limit to 0 for 64-bit MIPS so that
memory above 2G is usable in the kdump core files.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kexec/arch/mips/crashdump-mips.c | 4 ++--
 kexec/arch/mips/crashdump-mips.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 6308ec8..22fc38e 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -201,7 +201,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		memory_ranges++;
 
 		/* Segregate linearly mapped region. */
-		if ((MAXMEM - 1) >= start && (MAXMEM - 1) <= end) {
+		if (MAXMEM && (MAXMEM - 1) >= start && (MAXMEM - 1) <= end) {
 			crash_memory_range[memory_ranges - 1].end = MAXMEM - 1;
 
 			/* Add segregated region. */
@@ -304,7 +304,7 @@ static struct crash_elf_info elf_info64 = {
 	data : ELFDATALOCAL,
 	machine : EM_MIPS,
 	page_offset : PAGE_OFFSET,
-	lowmem_limit : MAXMEM,
+	lowmem_limit : 0, /* 0 == no limit */
 };
 
 static struct crash_elf_info elf_info32 = {
diff --git a/kexec/arch/mips/crashdump-mips.h b/kexec/arch/mips/crashdump-mips.h
index c986835..7edd859 100644
--- a/kexec/arch/mips/crashdump-mips.h
+++ b/kexec/arch/mips/crashdump-mips.h
@@ -6,12 +6,13 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 				unsigned long max_addr, unsigned long min_base);
 #ifdef __mips64
 #define PAGE_OFFSET	0xa800000000000000ULL
+#define MAXMEM		0
 #else
 #define PAGE_OFFSET	0x80000000
+#define MAXMEM		0x80000000
 #endif
 #define __pa(x)		((unsigned long)(X) & 0x7fffffff)
 
-#define MAXMEM		0x80000000
 
 #define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
 #define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
-- 
2.9.5

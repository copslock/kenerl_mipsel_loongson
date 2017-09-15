Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:37:33 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992994AbdIOReFRNw4M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RKsGFLQspHSVx5VJfor74OMdhN6u6lcbYee/s8hdh8c=;
 b=R1mS7rjy46OvpL4SQCqWVAq7+UYuuTm+om6eSMznIMCWXS71tFgxl9LbCqSrBR43lefYT4gjCnw6Wd37fIuiepcCYOoZjra8JzGB6Fv2OwHJ8wlDgCB9riy0lLLNNazpxr5HWa+NX6xo+gL9ImluAp3NfFv/aT0XyoYh2O0JhxI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:57 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 09/11] MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
Date:   Fri, 15 Sep 2017 12:30:11 -0500
Message-Id: <1505496613-27879-10-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2245803-4494-4c41-e417-08d4fc5ff20c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:cXX+gysb1ZUZEpELFOBYbkLkeV41mHkE2/Lp6JTTvGOGImTJ/TEWrzaUvIiNc3pg6NUo+zA4zF/3C4QMmy+7MfQqbf+2lookr0dTLjNJNK3Fud/683TL8VHddZLxgVTOq0gxUSwoh2kbHoWdRe04bbGqXK1A4vkl0t3XfBR/8MTktqSlUP5Cq7fbJGCA3MNur/ohAKABix1fXP7WzvjxpU0C0GcvBtAt3rTbEjRixlyIO/7c2np3/TYxKr9e1Py1;25:okW8arhkn+CFEKSAtz7OfOQNM1Te3/uWiPfXuH9it0DcdXst60FPfmJJYrbGdyOuxkj4eUTaQNuyT/5atlwI4LG177Jg4n6IEK4cGl23ECSQ03leqGpnckMlHlDnAz6jeKJJsfiRWCafAiqaT7BHWMTPRAUJFC6P6OK1T7a/SRDsLvdvPCowuytPGBVQ0OMR8CXj0Z0uXUwOF6DS8QgtggtcmBacECcEvVpIW/b+kwJ8N/Lh8+84WyKP3h08USSlbxkl0az7AK4VHTa3J2fpXjL1x1WUKlICaKUbAg3VYw5rc0VJTOEbEoVqE2wdYu/P0WwoR3rY/goobEf7OYIenQ==;31:0dfo+obMcJGb82H/wEJkJfBUywfooE6lGeFGnkGxky+IoJy0ZwXRh80a0FfSraL+Ke3KBKFI5rrMZYsl62/cmEuc63bP05edfQcse+kDyfzrFZKNjOCl4iLd+JeqYO80+a13QUGEqFkhwFe75DYJDwV5rP3PlkPzajp8atmEjh6hhYYYyDsMjnm1etGmdkjpxx5v5XRrEjwZryCXHST+IkxF9jBG4pI8cQNgHOZ+lxI=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:+sl9Q8pGNv7tIH7zm/huocSxzeRbCeqADq1GJP1ufD4QrGAwIdnal2GbX8/+DPbATV4Fadoyu2aN9pt41nHPfYu+eRsB9t1ckA8n8qkkpqvbPA74OjVwkdSwnO3HoDVVHtQI9A1RMlQabdArhmQkOix/CSe5h47+Ze/TQlITpdSeoYPD4cMng1IuGX1LFxvVygCVz1+oCZ9G+T5G4lFxG7dGhYcLqlEwCE7iU1DRQnJyxxSe9D5E7EHzpEYhlnQF7VKBmkiGZF7j8zlJghkfW8ATEavsJuIrLMtnhmMzAoCSmffRleqMsyOl6dM9RauFnyO90q4Puz96A8YrnzembFglnkpsfV8aeNYjysnX3aw3vIsU9w1AFn+syvYlpK6z2eE2Qwk3peZKI9QuERrWKOUun8Eh/g+UJWP/fO0iirC0Ghw1ZgiHZBpvCH983pyhFpi9Sezb6ZVwifQfL3a7aux92yttmsKqFqqaZJjUc2gIscrjpHeiU8363m25tD2p;4:QZ4kl5N8Y4bTfJ2yFh7RTQ015C0x8JmLLY1L7gViXTD+8MA4hlMfJAZdJZed+Kc7j9pZcOBJgBx+mY57UMoT1Js7MH1iI6rgzO+2CmDnolYhHOhdEivrqzR1I5LKQr85tVKFU3vdF4ioI3TYPkcUjye8E7nAlEXBQyzGheFjToef05AlNHxcp/lrnXUnnV3OZdK/0c7wTT0NctPXujz3WMTu04TfslR2CuPcvW/9zPoSYeUpOYCR722KGC7n4slb
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB380006F7486AEBBDA1EF1E9F806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:A6YzpADAxEpVHJzCCcr9it2Ab0SaAdZR9eSHCSe?=
 =?us-ascii?Q?FWeLXzrP0k/KJ3Z8nTazL+FWpXDh/eREsOjchiHo19ZTiCrCydGbJpw3F9Yq?=
 =?us-ascii?Q?1/vvt08YehFBkIHwPJQebdGY/HV7cUCyIspAaz3rUBBCQPHn4MalJ5pIEfAU?=
 =?us-ascii?Q?yS1uns4BLjYg8WI0CAuqmWCDdJtwyIlHzwlM2HMtZPjPKTUe5+NEqjh8s37y?=
 =?us-ascii?Q?NuxAf7LnKOVQ0Y5wSjfiGIHqzm3O+qpk9GszQWyFDrjqnLrrIjm0w+A+sQ19?=
 =?us-ascii?Q?Ugb8Xeai64zkh1vDCKHz+PvCwtDhOFYktVrSqo4rV+kaE8fs9IqQbnkFPGLW?=
 =?us-ascii?Q?x6Z3aue+AoKdRuNIrF3yiSMQ6TO3XYkCC/aWrJJcIJ2qyjpnu5TLm9WoXXM8?=
 =?us-ascii?Q?pomMkN0jMln3M4PXT8Nt13pWy6HYzYzhycc2ake6U4uOlc3kKl27sIQ5v88K?=
 =?us-ascii?Q?X49dcuD51hB1XQDOlY3gQa6xm151WowKktSbfpe7LPydhX12Zhdi8vs7xtCE?=
 =?us-ascii?Q?0FocHBAsrWS2ms3zFlKxTw8Unlb1xWL6BhJ7og36Q9jt3Xw4AsIot+q9M362?=
 =?us-ascii?Q?QPvcM/WORO6BcX5JoiS9zMj5oNng+Noft0HRwnSPDcz5L8lPza1Fj9602gKR?=
 =?us-ascii?Q?JEK/8Mcf6Wp4Eu2rVZw4O1AkrI5a6SHbA+lqjpYi9pbKB9bZDfZWiSLyLazT?=
 =?us-ascii?Q?3mB/vl5rHuslTgyEdlHgel2GVI2RAGs5l4wd0926Gr8PuvmNyy3rUhG5y7jf?=
 =?us-ascii?Q?Y7OiBunfNFaiC7lvTDTYrtT1Gqv/T37l1+ALCtA1n96oRB6OHQ6qobKeL/kl?=
 =?us-ascii?Q?aq2qDOx4JuqRnr/29a71Eu/TNcJsbzCVSP4nkJSbTRwmvDR2TBZCRlVr2SlB?=
 =?us-ascii?Q?Zj74mvhCvIkyhXHLxUhZ9aaj/vYW3EMUXXDj9DzAuvcklUt0YkJUlZ4J9/2M?=
 =?us-ascii?Q?bUgCQgX3FZI49X6015V6fK4uYeNQlbpyLVH7mQV2cDkFpBRqjou7Llx8J2Eu?=
 =?us-ascii?Q?pegP7++9N7O1qYfuz5hRPJwNS0KAMMD0K0O6dTiJcciBIpCqY6WDiI2AmkOH?=
 =?us-ascii?Q?SMmLyoFYZgh2zOBExtCkDf/L8g2y8LuqvzHeS+8jHIWy7tj7Z+s6FdRbQkr8?=
 =?us-ascii?Q?cO5l0SQ6VW/UJsymbMyraIrolGWWW1xJmCKPOa9vhQVx+PgmqJI+tkjD/kr4?=
 =?us-ascii?Q?iIJxP/XHoJ2duU9rGPVXk1GZSWp/Skqa7UUV7?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:Wf1r+9gq7abgHfem/MOYce4/kZZqYGXAQe3OcbuA2Z0sJhLNX1pzldesyCC522C/G1R1dZN12mCVhCOW+vEI1pnIhSp/8BEM234m0eaIrovIV3VQBpu6xvIxiF1hqB9Gi7TI9u12ei+IpKtyHMlwoyQgKkb8tCjhqIuesacjAK3GuqiejMKyfVAXKHpcnAYdtRaCqJaXmhVIKof/kKXNEPl0FIYJtC/EoUf8i5GvJ1GhBiMayeDqTtETsdXwRR0hLKjSxxv5kmwtk8acVmjHC0S7PL6J67ELiyPQjgW2ecoFkrkE6nejb7XgENAi9RSGODVAZjUQ0f+Mb5nvY3MItw==;5:Ifxvrna2+fSkw76EF2HxZzpM5jTAvqT6Rmf/p65R4/mKsZuVF8dAnunEbe0sX8aEDmWGSU7vRnh1rifL8YCkDC8n76fQ2zRs8VDo12j4j5fnvRHVMVjtCNafQHXeSxC87OaCcegvCJ7FkzyOSORIOw==;24:oq39URVRcakpL59AcW9SVpHDh1wRZJ9fzGUzAHMegdHrQq6eFQ05Ym/Sbq8HB3XeNGe8/NcOM2XAyXWVDsSIiodMrOM/ndxqdlYT9sv9lMw=;7:XMOH1oM5S3zFh15U94sB1/+BzPxxfpIbdUjRUT+b5VoWg0fJKWLgIGxSPJ+E6u3t4NMoR+yWdqhs9ofZYmVa4kNj3dL+eJiYD50NHuEBHYEerZMxGtDZMZxJoADSIh0YWVTQ94SY7S98zNH0JL8lcZHXHPfVg8YiazAhnuClpjgP+/RcW3UTlTnKG7/ZTgxf5yG11HFjyoGE72hujDDFls0Jwx/sIHCyC+7x7DvK+Mk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:57.5668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60021
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

From: David Daney <david.daney@cavium.com>

No change to memory initialization, but this gets us ready for the
next patches adding hotplug CPU and NUMA support for Octeon.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
---
 arch/mips/include/asm/bootinfo.h |  1 +
 arch/mips/kernel/setup.c         | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index e26a093..71dd16e 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -90,6 +90,7 @@ extern unsigned long mips_machtype;
 #define BOOT_MEM_ROM_DATA	2
 #define BOOT_MEM_RESERVED	3
 #define BOOT_MEM_INIT_RAM	4
+#define BOOT_MEM_KERNEL		5
 
 /*
  * A memory map that's built upon what was determined
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fe39397..3dd765a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -200,6 +200,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_INIT_RAM:
 			printk(KERN_CONT "(usable after init)\n");
 			break;
+		case BOOT_MEM_KERNEL:
+			printk(KERN_CONT "(kernel data and code)\n");
+			break;
 		case BOOT_MEM_ROM_DATA:
 			printk(KERN_CONT "(ROM data)\n");
 			break;
@@ -824,6 +827,7 @@ static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
+	phys_addr_t kernel_begin, init_begin, init_end, kernel_end;
 
 	/* call board setup routine */
 	plat_mem_setup();
@@ -834,12 +838,13 @@ static void __init arch_mem_init(char **cmdline_p)
 	 * into another memory section you don't want that to be
 	 * freed when the initdata is freed.
 	 */
-	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
-			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
-			 BOOT_MEM_RAM);
-	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
-			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
-			 BOOT_MEM_INIT_RAM);
+	kernel_begin = PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT;
+	kernel_end = PFN_UP(__pa_symbol(&_end)) << PAGE_SHIFT;
+	init_begin = PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT;
+	init_end = PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT;
+	arch_mem_addpart(kernel_begin, init_begin, BOOT_MEM_KERNEL);
+	arch_mem_addpart(init_end, kernel_end, BOOT_MEM_KERNEL);
+	arch_mem_addpart(init_begin, init_end, BOOT_MEM_INIT_RAM);
 
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
@@ -949,6 +954,7 @@ static void __init resource_init(void)
 		case BOOT_MEM_RAM:
 		case BOOT_MEM_INIT_RAM:
 		case BOOT_MEM_ROM_DATA:
+		case BOOT_MEM_KERNEL:
 			res->name = "System RAM";
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
-- 
2.1.4

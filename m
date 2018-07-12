Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 03:29:08 +0200 (CEST)
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:48896
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993900AbeGLB2XBzH9t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 03:28:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB8ONCwXO+qBXqcUt2nQ7u5xZT02hIBjU+oJ4hSJUow=;
 b=AnTFzzZ3SIWljQBnE+fYV9n0TU/1Gx8kyZgVVALwZbkQUWjszcVSZqBeB6IeKq+u+Z8H/p/ObKNSCXCySmKau8KXeENuwYiFbBLvpJuuHl/cqlQ22ZRw/NlJSADrfLDLKMAmO4yHD52nuuwvAKyN0RoTu460blgxpbdUMoVdaB0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from localhost.localdomain (73.162.151.67) by
 CO2PR0801MB2151.namprd08.prod.outlook.com (2603:10b6:102:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 01:28:13 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v2 4/6] MIPS: kexec: Do not flush system wide caches in machine_kexec()
Date:   Wed, 11 Jul 2018 18:27:46 -0700
Message-Id: <1531358868-10101-5-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
References: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [73.162.151.67]
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To CO2PR0801MB2151.namprd08.prod.outlook.com
 (2603:10b6:102:17::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd5d768-cca4-4a3d-bf20-08d5e796bc5a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2151;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;3:kWVFj9q2lxIRL2LSNrtQbJ7bYTqoAbyszbtyJ9p5cyq/SKo6k99URWwvvyl7RVM3slRAqyEEPiEFGDas1mdQDagnPPTArN+1gESwSx2p8leoD1phoMpJ3BRjwf4FoVqKFUqMKHItlpGJzhPMKhAqL94KetkY+Vr0k9BlfFaXWuYDjqJWYrBI4rfqd4ygNxQIDQJEncKVUAeBt+AnDXC/45UJ1/NmUsp9mqjGOfmGwHWZotbqZvmsnyfm8/9wt3jv;25:YDI3bdOZGSsMl/BiaI47MxUxaQTFtiekyw7IKR9alsD6LeMgT0DwV0BoLo+F0vtaiKG7spAF68h+1KrmIB5E741LQHs+Wzp+pkOy42Xir8dZHCzfO/9cKxuq+LV7n7FEuw/xU+HyRIMznsuIPWEZ8RLw+OQBri0F2sl+WDDCfVNPiaNlkI/TVCUTEe5+cUatuPIjyAs9UcT2P9KiwECpPzFBtgd15J/EYqpfZnSoFUyIxHxzidcc8v1jfhTZqoR0OhlV/L+ZAqqxjApjAY0soZ6yVOMdkdpWKioeNwGv3QgkcyXKXRWbXZisvr3opyj5ycMDcEtF3JJrh+WenwBBiQ==;31:20ouKyaLvQBjNYUh0mWG7phSHYvHQcSkXqk9H4AAUT25akHWpK3IerC4xtIq7J3hk9uTErWWHrEFxE1QmBp2D5mzEf24MRf+Yp3TIWP9haGte88CG+jYoOOPzghSp8AZUy7TnKmzmBl9mpZczLNm8BuoBy18PdFQU8sn9rG3ilOkhITGVFlBIs+eXX1tB/KsO993BiwihDN4nB2WV8KRe777mRhb4V11g8MaBZwXWKw=
X-MS-TrafficTypeDiagnostic: CO2PR0801MB2151:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;20:GTHwYP9uVjorEEw/13eu5fZaj6DGowP62xvzvBRdnboJBgZ1IwzRVVS8JcvfkgtcVW0GsWsaBFgr5aZLFxCLjMy3ItUOfkZWmLpUEQZE0kUfOME6sf9c14mtgPgY8A9V0Cg+32VQ93PJzhPCVuju1iAz2YEp27GfDos4UEonfEqBHAv9URxX16tspYHi+pvt2ud7vla6BDux0YM94psNi0GdLvmUvpsmGrXGWeErFAXTgzoV6MRIe4PsoIHIcFTI;4:cO5FqmHTfoJUBCY3T2bZvBa6P1t9pz1Na0/PSgns2l0Vw+x2MRxg2XmQtKQOXQOgpj8RXlqALu6NQnqN8RQ+mGzpwh8HlKEYSsGR6mlfh3n3e+xCB05b62+bMuTrV9rOwSqdrI70xXITQMui8Ix7BgnmRBzvJOWJjLkJvB9weS9w1kQABED5Bwpdn1MwGoxFs94MCVDFH4C/ZHN1xheOVOIlgR63CuRTqyY7yIk7creFvjaXzmN792BoCm9dAX/Rbfink9uFuquiyHaCX8czAg==
X-Microsoft-Antispam-PRVS: <CO2PR0801MB21510A7F95E5A115B15EA2D3A2590@CO2PR0801MB2151.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CO2PR0801MB2151;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2151;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(386003)(6506007)(26005)(16526019)(86362001)(446003)(486006)(11346002)(476003)(2616005)(956004)(36756003)(106356001)(6666003)(2906002)(6116002)(3846002)(305945005)(5660300001)(68736007)(7736002)(478600001)(6512007)(14444005)(97736004)(50466002)(8936002)(8676002)(25786009)(4326008)(6486002)(107886003)(450100002)(81166006)(48376002)(81156014)(16586007)(105586002)(76176011)(51416003)(52116002)(66066001)(316002)(50226002)(53936002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2151;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0801MB2151;23:uLoD9uGJ5liXAsyXFjntk+TcMdzZZ4S59YHfpit?=
 =?us-ascii?Q?LscwWjuCacjNl/o8SAO0Df5LkqxPILKinGh37o+hsZdyxj3+LTe4g5ynt/VH?=
 =?us-ascii?Q?/z92PfM00dF8nV+dX8L5ZTYcTVfrYYoc2VIJX/70FvYpu6GdgVZRcaItwHLw?=
 =?us-ascii?Q?X0dGSM7DtPsU3jSF7cQ8pQUbkrT5KXsnZkZC3IkmKGCcJcp5wJBkRGxKgFZ1?=
 =?us-ascii?Q?SvcjU8srOg1SrtgGxCZcuzZ1tXLusM3YrZ8XpFj3BMbYcdkRHXvqytvlaShu?=
 =?us-ascii?Q?OX+/BIUbV+XUL75kCGBsacWiW+zkhjnMyWFyCA7GR9JRvULAdOxlpWGUQeRT?=
 =?us-ascii?Q?XBphqCMjHj/rcWLF+qbYy83GDpMHEesPCWDceyEuQPAECZPBbmVaGi4dr+O+?=
 =?us-ascii?Q?MhhF39+cmcu9yZUPid1pgvJrau7Jpk8Cg60wbAoh+XPJzdmBSiddMHD9b0kj?=
 =?us-ascii?Q?AcN9BiQo4coSsJMSuRuaSGGDYswrfjiSr45hXsvwFJFZCy6V2iAopa19Sq5o?=
 =?us-ascii?Q?TG5rS/nVVciCUrxQO7fu9Uu7mBkLvpT30+cgoyA77Pfs42XxPYUFNwijLtOv?=
 =?us-ascii?Q?wXT2EvdZnlZWJQErorGlEjOnF6gDIj0tTAlscg319dFB6n7MEZfoyh8eY4+E?=
 =?us-ascii?Q?nDPgZnGK6XPgAoTEpG2hyGVwD1eCxjGLm9+olZwlcXI7elkLwcmSXNBS3wwk?=
 =?us-ascii?Q?3fIk8kaPlhtV3e8bOA4njDICf9eUm9YT95Fjd82penfogXNZh47pB30ipMuz?=
 =?us-ascii?Q?c17CDyXes3UUjgEvOX2MKtTEA3zon78bxD3CKaH8yehUcwZQUodkGWlXguo+?=
 =?us-ascii?Q?NFOwOxGuoM5AKZROuNVnuuLcnklYk+tQlwiHghTraA6aQ+ecQDpyz7lH7VHM?=
 =?us-ascii?Q?BII321bLmTUQxHdW+vBOEdWgNwGa5BZ4243MZrvbG5OOh/jKLbv7CgpIZF6P?=
 =?us-ascii?Q?8ykWV4o/GwrjTZAVGTv99QTaQRORv6sx87JtWOMer0F2MzKhWrnZwOmJoW8J?=
 =?us-ascii?Q?eTc6kSuuPNb64dbQ//2CBAtQAViO9qZO+aOs0WmdRIsSJoE5vpBtoEUuzjt1?=
 =?us-ascii?Q?E1aSyqs9K05SVnzaBjVYj55nHaKSNJgDVtPnd2EO0TeXbqUPqi396mkAykAg?=
 =?us-ascii?Q?BZD3+eLyTp4GIRW27ZAHQcR8cqYzT8/HH1ISNIiJZ491FMxVPOuOAIjREAih?=
 =?us-ascii?Q?rs0ybINA51PyCy+u0qDwsnYFzuQNAeagmzP60?=
X-Microsoft-Antispam-Message-Info: jbo6oPflWlA7VzylDqRA4PcifetOFKBP1gQeKiUzDuLYExpP4oGMgdKOSTAWapEJKIwbUpIemaIMoAtKyrsLcf49dGGWYWPSLHqugA+yWrRRaIrmYilrIbNrxvE3Di4dUpfT3lLM2hWlyU2Keca4T61qpw1AXE5YG1pOiM+NuvzBvESOBy+QrBEM2oZ7g0ctRi6EIKUXAur467Z0Wjr7a2CPbQPNmN2IczysXC+ttqXFfoJpcwHWKYULfbAfo00/5p/H6MSndLSXq0M6uS3nHErPSSxtfHocwfiq12dNTjyz11d36zxguJ3MN5H4nUXvAxmDyRh8C15nFH5/G/s5ITrEAzsG4BxsCG0c7DIZC+g=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;6:DK8Ifq1xYCUpTpI83wC0BroNLZxiy2urPUM2gZRD/5kvFnassLVCOvBD2Sl6GQeZaZSZD3i5vsdQ8MRxsV9nMokhKjT6wq/AEYDTqnB3WEaO/BDNP1DMCqXsz+5NjFoQavbOLddQaSbr6rxnV9/7b+bshni0zC9Ne+P+0P/bA36HxrUisWRNDqeHE0PN7FOmFWxioRLktZXPMZzakLF6GqDN/D7YWX3KSIS3XkK8ETD68PZEv9wNe7/hCGyf+xFkDWwzWRLLxX6sH2Cp9q3EgT8CEvXteKru+ILdueaworLpAAurz7kLRo84k1jTlxq3OOFJcm5NfRzJYl4ne8DgaJEPaAu8kRu7dvhefZ8tIiw55OIRFOktx2veWjqs47+KT+j3RHntzsNLuOsISzdr9wey2Bb498mYJZWJ4DyxtJsqmkUXn4jvdP9p+/cWyyJ+21pY7AUhhZGgmXIT5aSdaA==;5:UDG7PJK/9p/HMyEkG0/vAdkv5wEY0zGGgoNadlLqDEm0oD8zvAONkR2hvjFxkCD2ddRZAke5IhgZMxRYmnrnHUX9/9aUshcVHAF6xGCgrvLviarBt5bh9YVq4n7fnlqjCZILTAGmPDM3OP6BqSg+EGRX7wWHtdOcBntY9HgR+Gw=;24:aew1mFqGKoTzR4xVZMp0sCgS9mAVck4PbwI25VrBzzSYhbIHNam7Jx4LOlTysX6Uxxw7hleU9HET/4+GHb+O2MgdHMotddzOwExfoWccq3w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;7:4BoWS+rfxOsgLDgdqJn2dorx/MQsWkaBpp/YtUIlXhckDhgvU+525eO0rHot3CegiiA7IUoLX8sIMmYhuNYloyCAYTN6HOB/P9KMJyDu5OUUAEgkCoNqTDYZ8MsJ/z2mZwj2Ne32WnrY9oI85o8VtHzuFrvcnnmmbMzFh0Xw2g4UPifAvzeNXI/XW3OPgY+DDyxPy6PA6JeFrSeyqcKQq3SSk4eyfYjNwzeQWGwRgrC7xDRmndDQQTybvHTLwl5M
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:28:13.1655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd5d768-cca4-4a3d-bf20-08d5e796bc5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2151
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Instead of __flush_cache_all(), simply flush local icache range. In systems
without IOCU, flushing system wide caches require sending IPIs. But other
CPUs have disabled local IRQs waiting for the reboot signal. It will then
cause system hang.

This patch fixes this problem.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/kernel/machine_kexec.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 31da6f2..3ba9d96 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -138,7 +138,16 @@ machine_kexec(struct kimage *image)
 
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
-	__flush_cache_all();
+	/*
+	 * __flush_cache_all() is expensive but unnecessary. More
+	 * importantly, it could freeze the system as it may need to send
+	 * IPIs, whereas other CPUs have been waiting for the reboot signal
+	 * (kexec_ready_to_reboot) with local irqs disabled, because
+	 * machine_crash_shutdown() has been called prior to entering
+	 * this function - machine_kexec().
+	 */
+	local_flush_icache_range(reboot_code_buffer,
+		reboot_code_buffer + relocate_new_kernel_size);
 #ifdef CONFIG_SMP
 	atomic_set(&kexec_ready_to_reboot, 1);
 
-- 
2.7.4

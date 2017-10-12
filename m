Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 21:50:55 +0200 (CEST)
Received: from mail-cys01nam02on0084.outbound.protection.outlook.com ([104.47.37.84]:32113
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992592AbdJLTusP9wF7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 21:50:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+27om/siflZW3vfzQ5O4K7QYNbxNWJXzmqJp8cUu67Y=;
 b=ZT31Tdf1zF1x/3WJaw8vCblU/H/cuEc3D3pAqYnlNPo9+K9iPmi/J+RFJB7tRxCqSAXg+zCLyMeUhX6kQPoiK3Z5S0gYUsTC5Gkj/W+s1J6kMLVLsiKk419izF8iv0xCcMts9F1TISqSDLkhaTd1SD6vpO9G5Zta5ZwOK1nskF4=
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3498.namprd07.prod.outlook.com (10.164.153.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 12 Oct 2017 19:50:37 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Add iomem resource for kernel bss section.
Date:   Thu, 12 Oct 2017 12:50:34 -0700
Message-Id: <20171012195034.5758-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY1PR07CA0023.namprd07.prod.outlook.com (10.166.202.33) To
 DM5PR07MB3498.namprd07.prod.outlook.com (10.164.153.29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1de0f35-fb3d-4049-2499-08d511aa82ed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:DM5PR07MB3498;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;3:1TI4XfUbbXFB8HMPZvWIEDmXMfA2UBa3tz5WiQOOy6XUF1zbu7bST4P0xLGe/8I3rVqvCVHWDzkXER49H5j2qEAEOUI6XksBlvDLn7BH72o77pt1Vs21LW1XFCNfRBNqcwRvkaiwvvTdayZqhQGiLenxPhMLLnOTTqfcLe+S556x7QMSs+L8nTBugAHQxSVhtZdRDg0tl1toBAV+e4io76yi2f13woJ0+WW0K8r+Tq40pD69IVVCrg9+FWfazjRz;25:V0B6O9bJ9eMV5zDvts/mU5FRn27Ak34m3UpyTltqhVbrPhTIY9PrLfFXZfRhf9jufaKuWaLJuww63IfDdeoUhsiQh7ZJ4N/fmOR3S1YUBhGDwUjo76GGRMcxBxetNOcWMyF0uOEVwEnYfngDbE1DD//lZa1o+63AE8SaGovWas/tMLO5ejHBmgHMfBBube3Itfrv7Sn5bKNO+RIxsQzaO5qrd+TIjRiQn8EQXj/plZ4yASJQLpGej3ExT+hW7D9YqLLm9Y++VQwANDcrE4t5lzbzJ7jCLDGAaOgWxz1kyQp0CmaPlxiTjsSivMgbg8zWd9S3g2fKV7tw4kcfh1YQWw==;31:ttTQA1FIDEWA49uHWaSGx0PcezrdZSrmLUe6XQ6SHZRuyvB3RvbefFlhqGzr36L1AVMsptgmJJ+k3Wf9rIZRH3FTh/L1l8udS9o8uPSrWKCvt8ZfdwGS2eYmv57FDCzDnGVsPpq24femMNHLthTiBq8wZmK+ejATcwgAHPmt5pOqMC2BgdVcKxXcX1YVqR0HPBj62dFbsLDdH3PLgb991+0ntcSvokLUYRihVDxCtB4=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3498:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;20:j87cMMfdQ+hMwcaKT/kwG62+sVvgQzV3L5nrUd1uOVLBGqRERFn7RLIfnemx/5ylo48I/+BvUm3/TnLQ/0SwNF+ew7J9RTdlQf6pRIXgWNM6lzRnyfGVQF9E9BmZPfWrRpNN6ulgns0d+NlRZrBVZ9D5F9xqhDaoW4U0UaHxsSjBS20VVhN+cKr1YjpRQr6kr8s5090QHzXmXBSgH7PHXMnniu83t7sZ8m76AJLOhK+nKjZuzXl4T+uKhlE+pUsJKKYVmQUiO6cojMJt/eq6EudUBw83/7cOKM1xZNFpWcGu42pqxFJvXEaEtVP5+rTo63PjCMqU8JmKcbNdBb0OTkw5s5v7H/Ft9ZWz6IB1S/XaaAKwajA9xAMf3zZIyovnhBPV2mGlAxWEOjBW4nEv/fDWCLVWLU3R/G/Gg12ttCw9TOObShhs0K/77DebR8f1vTdcymgaU7eOa6Yd6AQNgGGsEZdiW3Zv0wgNdvlpqk0G8BtGy+lZYQPG55HZh7AU;4:KogyyxkUF6QimCfLhWWLqwtiWR8FC0WZvmV6SbhsYZ5DI4YzvnLkLbD9Ii73h7q4ADVzeVeSMYv+U918S7Xf9w0PtCxCJ8AIM/58N1iOEepHVAd5Ip/eUWtEv224U9982x5KudVkYDrNZsTbOZP+Hm/lLoTFnR1CY2gGtZR0OupXR7+IMs9cXGOwi5dc+AV5nVg3T/PxZmA+7RhNK9BispgHgUye/cDk/vRxOCRdi78+Nnb4kF9UbBpBnixikv52
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR07MB3498B4D4F8ACD5BC569FECA2974B0@DM5PR07MB3498.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(100000703101)(100105400095)(6041248)(20161123564025)(20161123558100)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3498;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3498;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(478600001)(50466002)(2906002)(48376002)(36756003)(54906003)(101416001)(50986999)(16586007)(105586002)(106356001)(53416004)(69596002)(6512007)(5660300001)(6916009)(5003940100001)(6666003)(305945005)(47776003)(66066001)(72206003)(33646002)(8676002)(8936002)(6116002)(7736002)(81156014)(81166006)(6486002)(4326008)(25786009)(107886003)(189998001)(316002)(86362001)(50226002)(97736004)(6506006)(53936002)(3846002)(68736007)(16526018)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3498;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3498;23:tBPEjho3Ha9e8eiChoCGnJiu1xXhUh927xOU4CBdz?=
 =?us-ascii?Q?NJc8FHQ71p98AY5we4K63JURc/C9VLb8qa4nA7jQp5wtmanfauTxEQj0RgZD?=
 =?us-ascii?Q?27Ga3+pHNbYps837AumyLn7qKmIBl8f+VRIRhT8B+Gef869A9guh6iijqYac?=
 =?us-ascii?Q?prJVbENVEZfzWoyftsR37Zl9Y7Ev9M8zCrN9dtr8VL2IALsN0m7Q7tywkDF7?=
 =?us-ascii?Q?M39sZ5mx+xunejpy8S/R84fYxHfeC1cX0gWlYhopUbUF1V0xhQ/JugcVLVpq?=
 =?us-ascii?Q?TQjtfk9TybuWx4GOH7961MYJZcFvhMA0vtozKFLJjissVCxjmGH+s0tm0udk?=
 =?us-ascii?Q?peVRS5Q0aPZ8So9L9WvlR5jpwUyU6Pq9u39KDtQ5BprWWlhflKZzbs/FP/ZN?=
 =?us-ascii?Q?ZNA8BHhj5cPhnvXNGtKV7Qb777VddiThKnvNacbXtg3EONgxKImbz5yvz6DY?=
 =?us-ascii?Q?ctguJfupZffoMlFyG41KRI84rKRvxUe9uyhTZqGxfDsYHOT9yMHF2Ba1eYEk?=
 =?us-ascii?Q?7qOGUDzYHnFfbz53FNGLHcbOK8JmHjMH2Zgh6PwNzhyMFdrn8UgoYlWeUg5l?=
 =?us-ascii?Q?bmXCneCL2h6sG1jLnFrA3Ukz4FVI9scL9LRqhgeZf2+R+AepWYU8MqKbusNQ?=
 =?us-ascii?Q?CLjCBBwGNFlypR7fAWt4O2dEm2Ufn27uK2yj8jNaHKgZoGPoNZ8W8Uq3s41R?=
 =?us-ascii?Q?tPTujWFzdr+ELqn3uRfICCT72ovJFqI14x4qmODzEtpzG+n6eyKJia/rtBj0?=
 =?us-ascii?Q?o4YsHADt97wrrX7alFaG9VvOVX0JVB8nMXsQb6y40RieWIeW41IKx/VCotKv?=
 =?us-ascii?Q?+T5zarL8plXBiVM3DhBaQcI4VcG4cyJ1/sMzNZBCYZqvARFYWp5seesED1za?=
 =?us-ascii?Q?d1aZNuBRJMU7qDtg9mp6zynbi09D1Q9ttf1GDk1y1WFbErt3sXVtHOZiTSmd?=
 =?us-ascii?Q?LTPzr7mkUSBucZ2oOhtThCqwYHh5QYmMiTjjGWJFR7a3xv6jNxWFGOlhE8w7?=
 =?us-ascii?Q?oGSmj1JmwFt2b2HIGX6XLewzu0dmFIBll7e+8soRv5Pt6OZ7MvYrkPuu0GTW?=
 =?us-ascii?Q?j7tOh5ZG2/Kk39Ef3pCf9ogsiuWmvyDvYPMjoqwCf2Lw5RdkqdZ0cLsvCujL?=
 =?us-ascii?Q?kOROBdn6XH0IV0QI1mpqjPdzeXorts/?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3498;6:3er4wh0MvIA/V3qmN8oCPJNYfCEJ7xk6EdYzWRy26kgDzMihnbRC7RfY/jm/aQlGsKrXmTYHxpMRjVXWfkRgWnH+0oy+iF8AUsHMFlxc/bW4E7k9JV+PSO3sDEdCCYRIDS9TnwFhrcWGWL4SuK2wTD4OrJalKNml0gDwrlyYCoEPIExDOgGYIXf93kB83JDMe3PbjyUE9A44vUf+mqFx/IdSsg7vyXvmrAZ2fGsx8RLEaXzyaeYUBs8YU7habC9jO0P35PX2cCcOITOb0LDV0lhmGzAnKGqPQHl+uWZ8qeqXmXuQlkjCdHT+2JFQUMi6iMHyk3MU+Wz9twvavqkmhQ==;5:SolqAztuYMn+fHIE1V7i9gczAfgQa+1oTrpQDbq9WrIHqiWogiffNTbb2IAnqyCjTi9IzdUM6KzPXoZ/eBubl5Ml90wZfrKJU4Y5PprGsd737DW6aed/G66YweLbCClIqIO8AlLrW1DH0wAk9zAIOA==;24:7UtZX0/cpvD4ExHmKHLnhK0C0sVmTYaHRLyOEOQ0QY7AqBmjNufXZnAjNtCml/NavzYVF9IK2vMvjTL+ju9VhqJXn++9zM8d3sNx6Yr+XCg=;7:zOhUBrgxOZHoH2Gf4G4Jo4I+FLEt6QwLlOh8vvopsQEbK3KG3QVv9o40RDPq/dpLik/5I4RR9aH4nz2T/6Rygo2gSv/ZkvtIqyvT/sEBV4ulAaTaTEw1HFM9exnleDc4KbWMl1M+q+o7egaSFlJnmQNXaEvOtnFaNteFisECzZGQO8YRXYSfIva+XJFqhZRokKk62e3EELyteA/nYiCT6cOflj7qZiqwLDxEk81KRLM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 19:50:37.7735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3498
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60392
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

The kexec/kdump tools need to know where the .bss is so it can be
included in the core dump.  This allows vmcore-dmesg to have access to
the dmesg buffers of the crashed kernel as well as allowing the
debugger to examine variables in the bss section.

Add a request for the bss resource in addition to the already
requested code and data sections.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fe39397..702c678 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -80,6 +80,7 @@ EXPORT_SYMBOL(mips_io_port_base);
 
 static struct resource code_resource = { .name = "Kernel code", };
 static struct resource data_resource = { .name = "Kernel data", };
+static struct resource bss_resource = { .name = "Kernel bss", };
 
 static void *detect_magic __initdata = detect_memory_region;
 
@@ -927,6 +928,8 @@ static void __init resource_init(void)
 	code_resource.end = __pa_symbol(&_etext) - 1;
 	data_resource.start = __pa_symbol(&_etext);
 	data_resource.end = __pa_symbol(&_edata) - 1;
+	bss_resource.start = __pa_symbol(&__bss_start);
+	bss_resource.end = __pa_symbol(&__bss_stop) - 1;
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		struct resource *res;
@@ -966,6 +969,7 @@ static void __init resource_init(void)
 		 */
 		request_resource(res, &code_resource);
 		request_resource(res, &data_resource);
+		request_resource(res, &bss_resource);
 		request_crashkernel(res);
 	}
 }
-- 
2.9.5

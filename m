Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 23:03:12 +0200 (CEST)
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:34528
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993022AbdJLVCqbUxuj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 23:02:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MS0M0WJO4haIAPKKSebtRYjgLD59NEkr9nUP+KMAuLw=;
 b=im7VAW7OFQEB5YZhnFPFrjQmqEo4GNmt0BCFIjI1Tkq7Rwy6gFTu8j2pJO14qops7Ohk/8He9zCwKHtb7wB9upyKXiZpM/MOuL4m7PDIRXCqt6LuSPmdYSG2oByvdVwOq9sbnlhto7Cd6Qw6j4wJFwGNVJe9tXu5jbuGHLGeZN0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 12 Oct 2017 21:02:34 +0000
From:   David Daney <david.daney@cavium.com>
To:     kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/4] kexec-tools: mips: Merge adjacent memory ranges.
Date:   Thu, 12 Oct 2017 14:02:25 -0700
Message-Id: <20171012210228.7353-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20171012210228.7353-1-david.daney@cavium.com>
References: <20171012210228.7353-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com (10.162.96.22) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7124d818-1b22-4bfb-0fcd-08d511b48fc2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:e6qvUvXvoiI6m4G6B5DD1mrn6wSlz+gYEg1OAFQBkEralnRKxGx6X4JJtt+ifoo4oz816gJ8b7zo85DdizgMlG5eEb0JhGRLwJ4Pu//gtbTVl3BXOm9o+chgNW9bpVZz0tjIIwLRi4CX6keFFGnURlPSJEuy9xFfc9zEB/YPyplATjWVaUhpeQHnrcSdsy3IXiktnTntEU4rBV9n60K6CBTOwSHtYB850YPzQA0EVLnLSvFPMVLm/my8xfCHbplh;25:reoy0EHPfxnanLorI/B+joE4cLHI8/tr51t4P6n7yoQ5PtMsNCLoWmrImETnvCr7ZH5tCXFIIk+e3kVp4C2Tc/uO6daO+8fUG/rV07ija94kaQfFhOEsRBBdOO0HJOzysXnzA675bg7ftg+A177KZzRBVVX/Q4audZLlZc5650JCaX348Srz7l7u0OCvMAs8fnzrJmtaWDIFLdFxlmI6Hxv+r/1vIxfyOQi4RyAacNN5DLuGH1x6mej/XunySdoU1K1jGhOgrrpH9Y0ZkUmYfMUDwR4Bu0xPyVceCOOWT5SH1lmMI6ICEbzS5nPqx/VXBVS71n9qKH3iThThHDJwWQ==;31:l1BSg2xEfQ6psJK/kSac9szfHU5/8myzJwR5Lej+YpvkGLlNDk1bNIYXGtoxQecCLV2OxH2JroozmmWf9LB6pjgAnMN3zIN3v3taAa/ZMhVg3VKtIFj86MUoLPbXhPXmll/4VyIP/zu8byzF9sBOfPFDcPYEt0HUFsHX/iRWExegqwqmqGUV+n7OBy1KXcQ1NXe7L4SFXLgE96AQrijdH2VzQr/f2K3fIDd30pl9Ye0=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:MD5ObQEm6nUO8Q+n37se8dJ3WXW7Ivx8hdn/e43qiuncgeTbyod1+LV1hRH48OczkSK2fKKv5d64oNnJWfYC8c6WGbRjziflF4E4eZ/0+zAP3ZloZM6C+EHp/kAZYyYEOdlrB/uTkRsIPYNJSLVEjHCg9Hluw0sdnfS462sbMwrCCxASBS/BnESep5zOXJBDxxUuYLUL5s3/kIUQh/9onKmDzTbnjEBazQG+Mombo4BZkslOlYlxdd6Cz0p3TEEnNMjhbInzqreFUNTQS4RufeB5YM/krYGOSUp0y4g6B/W5gu1u7Z/Z7/UwcZC3QkVyD2PzGznDQpb9YBp24xBBSXWqrvNaJ1MlcTYayOlxHsKWav7QoEcBmaTYWHPgB33o2CvRulnBzIJcMDICRM7zZziI8wOCUOy/dr+k5rP1v9x1W2HZGVBAkEW763umrdbEwQW3mjwegSWUIWEkERQMd6WHLWUIDtIa1KQByu+8xeG+waxpqYU6e3HIdseVpKyO;4:01KQKS0Jin9T43iZuYP1dXCUGzkEgLf2bI2+hs3buKOsqswWIFphZrbzJ2O48GfDNMd5ADldJPPYW4Vw3+urRY0N/hCcDn7OzfnoclK7L17CdwzSmdOZuWkyRYhXjUJ3JXe+ptKfkOlbtAciBKbu9EZ3wxg//2vR9e83MTeGGobODHZTHvu804sMU14fD4mrRf8wfxzgnAh9rP3TEPYKqh+2anT9aAVe5ezL025r6JIP76igSq5jFbsYGnpmLCr7
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB35036BC8BC4F3727FC6B9E7A974B0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123564025)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(16526018)(68736007)(53416004)(76176999)(25786009)(50986999)(69596002)(47776003)(5660300001)(2950100002)(50466002)(48376002)(6666003)(66066001)(101416001)(86362001)(6512007)(478600001)(316002)(6916009)(6506006)(7736002)(8676002)(81156014)(81166006)(305945005)(2906002)(16586007)(36756003)(72206003)(6486002)(6116002)(1076002)(53936002)(107886003)(3846002)(106356001)(97736004)(4326008)(33646002)(50226002)(5003940100001)(189998001)(8936002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3503;23:HeORNpdviVrtfco5neKX5sn4G4+ENFau8cvYM7hrU?=
 =?us-ascii?Q?DCm9yxtuGcXAUZAwLl8lQrpr/pu3t+qcH86vmeV2nZ/nNJRhvhHoMTwt90bh?=
 =?us-ascii?Q?LLf6WYnIsmEJvO1/qRNgFv3RK76GMxMJLIOXyCjqChzY/9ST/50WIi+UB4yP?=
 =?us-ascii?Q?yT1WeDcR6yNqRyOKiLBo6WDeJkVdCXXQOaQ2HXqHKEHT4R/Zt9r5ysKeVvDz?=
 =?us-ascii?Q?hlCNkiA+0L4VKGKPfdf4n3i5fsRg9xT16rLl4k51UuAX5gQOCroJbOFeNqg3?=
 =?us-ascii?Q?nHTs4grv2E03KjE8eRqS+Uz+Dx0uQtyhrmRnKaOd/qInvf92xLEUwfGyF1Kg?=
 =?us-ascii?Q?ofNcIm25mX/LtG2feSR3+fAuyEnYgSWB4aTI+GLVSwJf0n6z39+3zYJsIipn?=
 =?us-ascii?Q?pBl2Wop6S53G+H65MhTTnWUZkGofcMhgv2bBIVUarnXECmVm7ZkfKbm2BOV+?=
 =?us-ascii?Q?hRiN2D1ph8xE+KSs0w1JYPTHwwN7pzec2SlcMlKsM4coPqEMEhsiU1MsCt7n?=
 =?us-ascii?Q?+jHsPZIFWR5pw6XiY3jE/4rW7hQJB9tjKkZ8L0uWIQlSXIdiF3blBeQiJMj2?=
 =?us-ascii?Q?v/THMjPMLKl0tz2wcAtlryMtLNnmej1P04X7Zru/+XIqBgym3u+FBu2xe2+L?=
 =?us-ascii?Q?2ZWBwGrQ8gYwckXAglzXkExF1xghAaGSiH4+AlvZOsLxKcx9lud/MavTwoZf?=
 =?us-ascii?Q?yr2QunxKMpwEsr4IzpOCkl/wLRZGEp1ts58riSj8yXpkhI9UCiNyjxRsWd0x?=
 =?us-ascii?Q?vj2q0J8aOtUkeWaHMC1K6rredpqxvduT99FOpdhOw8Kqz2n9aahjuDZ5iBfS?=
 =?us-ascii?Q?QvsW2jPD6IlusNcnHMbX4SmHB9ug59EDOIze6uxWFGP1FSUl6dTPKZZWkpgC?=
 =?us-ascii?Q?Zrw0f4DSaLAbNmMlZKaEUwp9n0yQXLiNsWCoPhhYkkcTLhRjPHqzjEXq6OBq?=
 =?us-ascii?Q?H99/CLVFqm68KD6OXNDxykZgccdSXZviz6RI5s/YVpiK/GVP2mPpzwDUahLV?=
 =?us-ascii?Q?LG387r7GFLv3SpQCCuBQuTCop014GbP71ZBLB7W4+JJ5dZJ7rtyWF+LDv7Dg?=
 =?us-ascii?Q?vGz9TXWOtHuHraE0YsPxEGga4PriGwO7M5VRmHAagMiWcM0LI3hzzjQv7YZW?=
 =?us-ascii?Q?fUupthXmtsQ0+ys01aiwZoA5BTfW2C2n07M6dcyuaYsblwDYFLwhA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:rWPFc39mpVZw6DTDirDU5j5E/iNt7Z6KR7iryv+CEnwe0KwO4OuxAmux0h/Fq2oMnmoVLYZYqJN2+LqAGEfGUDR05fLGvZ8cI54hdIqhvH1YCrsTD8GKM5ut7ZSVOWB7JfJq+kL3XRZGcr5EfG1sz0SgSKPPzPWvjPIOPLjKulVh6i3dsOeiwEKv3sDpCqWCQerch1Fu1YGoNSR4+u1iI9Lt1TM8pHaXIZ2wfvZL8OmJdCMrDmc6X4wvNorPPpt4PKo4wQgh0bdKLG1zTXUPn0SCizgmqCRLSo1yPqU94fmP//gYQfCxZWfhEMTa71i8e/Hk3CNYPkFM2MHzeCvIcQ==;5:hTkBNDTxnwBRCk2c996vR2ynGqpW/mDsQS10B4wfTa537+G57UpQleD+BlahCk/ZY0XRH8xBCDm3ZSJ4T16yYd7abTDQSEtpFD87GCLYSRNceXRv3mmkUWA2xiBbyaPYCHBC2UJBkN9FwUi16aOGfg==;24:jdRBM2Us3xlImJmo9gT6G34GfkERK0ng9YaogVtMdOF4E1WMob2JUHgu+hwmz3OY97BO4Y5amyE3IoejHl/UrrnOIgusN3vc6NBWhpyVPdE=;7:pz0rt63CUgfvAmha7pF/hcLxfr5A4GklJnUHFtOoCGsaPblLm1fiElldOpKnVD91gvGpOh4CK3+uwBpMmZNwouViDGVpca7bDT5u+SXAVOaEAyFs2YbQaAyxgPxk7n35Y6DEcsQPbJvq5YbM+5Tiy/apC9j8Zh7sGVbNY6IH8ZUNdOfrYuNp71s+qmikDWwoU8+dbMVZulWD+aLNADwJccIFVPKJTUNbypCJIZO0eB0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 21:02:34.0969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60394
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

Some kernel versions running on MIPS split the System RAM memory
regions reported in /proc/iomem.  This may cause loading of the kexec
kernel to fail if it crosses one of the splits.

Fix by merging adjacent memory ranges that have the same type.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 kexec/arch/mips/kexec-mips.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index 2e5b700..415c2ed 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -60,10 +60,16 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 		} else {
 			continue;
 		}
-		memory_range[memory_ranges].start = start;
-		memory_range[memory_ranges].end = end;
-		memory_range[memory_ranges].type = type;
-		memory_ranges++;
+		if (memory_ranges > 0 &&
+		    memory_range[memory_ranges - 1].end == start &&
+		    memory_range[memory_ranges - 1].type == type) {
+			memory_range[memory_ranges - 1].end = end;
+		} else {
+			memory_range[memory_ranges].start = start;
+			memory_range[memory_ranges].end = end;
+			memory_range[memory_ranges].type = type;
+			memory_ranges++;
+		}
 	}
 	fclose(fp);
 	*range = memory_range;
-- 
2.9.5

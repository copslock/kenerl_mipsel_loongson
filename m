Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:51:02 +0200 (CEST)
Received: from mail-by2nam05on070e.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::70e]:27336
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992869AbeIKVulklJPb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:50:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdyxzR72XnAi66S//XEvG+0+hFg8uFldf7oKs3pmObQ=;
 b=YCg1rD4O2M2E7UBTDVDUBx66C+QfHlzLvl+WFnM/OQ3FpcPUa+cTtDdOK2aXax9TdiA8txeKVedgYOYoJs0CI7dv9/nAPJ9DT1Hx3VPRyl9m2NVo9H+LhLd6FaTc5/kbS5HRdkKhTgD4HDcc2UtkVXPd+5cK9YTVpDX9aPuI6is=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 11 Sep
 2018 21:49:57 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v5 4/5] MIPS: kexec: Relax memory restriction
Date:   Tue, 11 Sep 2018 14:49:23 -0700
Message-Id: <20180911214924.21993-5-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911214924.21993-1-dzhu@wavecomp.com>
References: <20180911214924.21993-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:3:129::17) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b52b085b-f09b-46fa-fe8c-08d61830848a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:hSMT9sVIxsQSVCX5XxQ+45UDClzM97jjOGELtaTCVuBADcTrqJhudFmBLyRKVSXrexVsKp1YalmyqNynRR2fg8GQgf+vB57yQ+OEpOf5jJ8d0bJcTLqhLb3SkL61illUe5aG+1mVqRowumcB0Z93SPk2um/MiDwTbrwQL5YNOZo6971CEhnnHPsWufl4OG0CrUPYJ4BJNEK+bI+b9vBxFd9N7Pw52jOfNlCxD2V6qcQb3XCCiL1cPCtlUuWPK0ew;25:g9lHUCi09SsnfL0rMebA7tBWgCc2D6fHD3vlkGSrJTI/QxO7JUSUw1gMtxVOVhqZ2Qg2mjgg+CHjH+SV/LD6np42Ngn059o0jkMp2ownfVPnHEk3pjQJZyKZ179C2C+MZjW3gTACmcRkjhq4b0OOLMmme1JzZ5fz55qvVjwsTsECRqiItA+7ovAAjuVz0Z6dZTlqUUi1gslK64rZa7HCkyLaMEBj0vHn8qX7dlZcu6CiSXQBaEQnk0KWSZ60zsb+CGo+SYC2EDfO1FOGufVK8sfEHPiRRADN1t0EdNNYzkNQ3rkXm4MhoZ8fM37YQyqWa9h2BWM/VnCez4NxA8PLuw==;31:hj+RlvSjVNV6XBya4TSPAcZXMcSRC4jLAMWCjWaD4HHaicqiFOVgmdLzoF4x9+4c99Jaba6X5D8NxynWu4gYUzroPIMbemjcBPugiVoteN4Xhec3ml5eCo5AEma45Z1obk6TvUuFjmxhC/mYB5mRL135uoonSQcxdpoqtwJ1jBmolvKDezog9Tt1iPFCvu3POqOU8HsmTS59o98pdeJNTCnI7IBVprAY1VAeGTbqAYI=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:dNRuw19LguiJUAD6x2eJny83yX9o35767C4a9SG/3cq/1NNHY6/p0GbNLUnI/tlsZ2flY154Zhyx6TecqMTGf/hcoXtbR0v/agDwWc4pfbbl63ut6hehsUXgaGRA79JpX6GUhAhgx9GGn9S0gKgbW43egCS8WYL2aQ2po5gAI1ZJbLNubypOgFT4h2K3Mngpu5zcvrGG4LQrqlhv5iUmKmojHNY7WScjpR1hukZN8Hdf4E2JJzouAmi6zCOXYyI1;4:lAyqMx8rQ5Y65ydtBpVU7dS/w65GoywRbflSLFMroGf4eh6D7qEOSUzF78oeY8f+bz+mgEC5w2eaxN8us57jml6atGMG2z5luh6OJ76Lvw1Dc1N+jZU535W8RWBzJTXjKaWWfroJOFgGH/P3fgs61xbJn+AJ5BpJT23AlVV6vLYLVDPEfMvTq7RBTXtTcKX6YGtjrRtf/c+zDpSlzY+ILvUJmAGqNSNDb6gzvCWq+7g5otZAe1P2XqPPWYy2KA5l2Z8/dhCnlqDnbDwNYG+ccMl28PZ0ZTOzyiNdZFuY7WzAvaHWsfJvxXxZBf911vXA
X-Microsoft-Antispam-PRVS: <BN3PR0801MB2145AE9A51FB67FF0D112ECFA2040@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(199004)(189003)(6486002)(4326008)(316002)(2906002)(68736007)(8676002)(36756003)(16586007)(8936002)(53416004)(105586002)(37156001)(86362001)(48376002)(106356001)(25786009)(50226002)(50466002)(6666003)(66066001)(47776003)(305945005)(53936002)(5660300001)(76176011)(81156014)(52116002)(69596002)(16526019)(51416003)(6512007)(97736004)(3846002)(6116002)(6506007)(7736002)(386003)(26005)(81166006)(1076002)(2616005)(11346002)(446003)(478600001)(107886003)(486006)(956004)(14444005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:daHu3hOhFTXvfzzP51vapy5V6k8rQKCTGl08Rqp?=
 =?us-ascii?Q?dHjpGVLKYOOUqNUKakdCmnsxO07se4OSy+0X62ocU+OL6L10llJn27i8UKWI?=
 =?us-ascii?Q?EBOiCSfNJP2ZzuEiBCsGrdF5Hkfkl2JrTEKU+bxT28DhuT1kxcS16+Szrn0B?=
 =?us-ascii?Q?E0XHEz607n7eNOkoHZY9Xpr8wAGKbdkz+QFCIFpAhtVRlIjM+w74q+RbaIBh?=
 =?us-ascii?Q?AB6qEuWU+tjljgrta4JLR+jSlU/61Ir3YdoHyBxkCDFjmetSFpBD+qkTpDLK?=
 =?us-ascii?Q?hKKdCxqAvVLYhx0/0gwjpTVBhVaiGSepUqNw8wbNXLvuDxQ8WPf++TeMEa9z?=
 =?us-ascii?Q?bP74IyP436ye41ibjbJuEqEg1tVAVCx3hHeu74iYtkcxWUIwo7dJV7YEELjI?=
 =?us-ascii?Q?9osh/0jLZb46s91dSRhVCX86CgYo8IlDZx2Ss2tUPha7izWvD4RoZVOJPo9t?=
 =?us-ascii?Q?ndgZAc558bjblz0/Kj//w8JWtjFPmDvUHsXd0syfkSVf3xdA5TFPuYqjQxdj?=
 =?us-ascii?Q?rH7xiVBLordjxy7NIv5uYkkSLyDZfd06Cfz8iVQBf8oJMVDbisUszEPDLin+?=
 =?us-ascii?Q?txnh+t+jRAu9feUPzNEvRo4vHt2pVfChJTMhDfRvmc9HU+19s1YE09FGDy0e?=
 =?us-ascii?Q?XKprkw0C3W9FGisWXjurET+QQx9PvMwotge/G/MqyHrPZG3F4IiY6j0iEkas?=
 =?us-ascii?Q?rmrjeBIV9tGJLm72PjURqkBk95KlNgVyu8UFi/uUjbNifY1l0gzrOj1ERaIz?=
 =?us-ascii?Q?G6imA1ZP5WP/RCeBXk97eJfgc6lx9gHGmfWqefrPY8YxaW+7eetohK2GE7Eg?=
 =?us-ascii?Q?G5u28bDk3kKMiV933cvFPEWTANacNTEf2/ht3TZCvxkgX+IbLxXDxmoaaeIp?=
 =?us-ascii?Q?sGDqyOpsXtnL3rV25U6Vui18NnI3Y7FWEjyiOfPigLD0MhyJpNimBymEnHVo?=
 =?us-ascii?Q?PIO7VVRKk4LRpE+c3ZNd0KdzZ7NSxpZPwfH7/0249VxfcQfz8BwiJXIXa0GV?=
 =?us-ascii?Q?PKEcbl5qTqHgdGI6lH+KHSvv8w9DP9aW3eJ0nUaKbBALHQ+4cpRZbyCz1abY?=
 =?us-ascii?Q?ak1/I0gqWx9DwpjN3b0vmTPMq62Ofj5eSbXqYGdXChOreNwfVIDHZ26XB4Yk?=
 =?us-ascii?Q?WvDaCRiSQoj/w5gGiGyLIWpUAhohVddqpa/Tf0Bf/kKC7xxnlbz9Jbl/ciur?=
 =?us-ascii?Q?Lx/ZIaKe+7zcRKPjepZ+420C3C8W6z0hlauvNhzn9FOhbUyz2DM5i+coq2r6?=
 =?us-ascii?Q?YRJk8PtwPNYzLhdEV320=3D?=
X-Microsoft-Antispam-Message-Info: PDKOXgamnkVNWggoCL+8lPs8EhK4D8gjEKcSPkXqW18gcCn1aMvRTuvrSi4qu24rb4L6EKbe4a47m9zPJU42gSIyvr6vfHWlUMuvhAhVagK0YyHx9uKo9Nv9vDhSNafW7BIrRqBW6qDlSC0+vKSXaKtFYL5BIXS+h6k+gjRrnj0zJNorbixz3LJkgUy5jS01MpgezrX0UFkxp2zZJHjEjV1UzCFzE6qKTSteGF+MkDLe1Qa7nfbtCLAfcb1ObuNj+O5zyAQGgrMtPkEF2f4Gz4dkGUoMCpm5V8Kz75j3kRfFCMo6mx+gEshPk9VrxAC2I3dmSB6bPkB+eJL4jSo4Knb7Kd9ZauhuFFFcEO3bncE=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:7UXv/BrWKHEkvqgzKXfe7hMND4YUA1ieM1K1KP5Djg0PEX4Ll4X0UeYHf3iOx5NCvKB96WejVd6ueYdUBj+guOXafup4yYOj8KYFdsMRo8aUruRF6Jc19abifI4vWxxf2WXSJ9X/vY/8lynO5GovRX5jdrGZxV5INN59t51uAN4auGD9KemiAIG1hOzZRC9xFlL5ajquXi2euzwVkBM1XrjZK/tR7rRH/v2xNTJe3O/sUtD7+P/BlqmSAzf7xQ0Lv7EHkb3VoHo29B76+A8wnavioQuEFg6JjBmFH9ASR5mhR+u3nTL9/IQbbQnG2e6zv7OcR9/bXZbRXxstY8zdDSnpx05Uj8fg7eiolXW75NJJlrMnE1XKv2lhnn4S1q7KNnQYWIOUeLbya+YadnOViHa+KptvZVUABQq4LOWwO0ksJ+6Seqyff2XQ5Zch++r+VXSfjL8Xjp+FuVpgmUimiA==;5:ubZUMPgn6P0siUAiZJLfNuZ3IM7AhM1NjHpsTuKTvfXGjKivprAYrSU1JPjE+y8nTGo2uBNNZPkMhtFnhBlERAcrgrnCD7IGzyEXGBDqGq4V4l4fQ1tE3jJVRX7tXe6x2A7Cxw/fB/XjO52XnCAs6ITdKYPVDj+/WZB+GWmLtkc=;7:nlM/eYrHmNRYUNtI6HgtMeSio0boWYKlciDmkL+Z0zCWXqqXWQRYFsM57Qhe9B+kWFyq0ZDZmoWH7jyUbpP8rt+njZiHNvugSZRmsFTIVAnpjb2SJ/zDVRlNuZI8aBkC6pCvRIMWtmSi0/PfOzfmYhAyDPCBSij/kBccf5UoMHIISN6Z35+K62RNjpiLCUx/R6wuMMpYibLdRxhtsOYnU0AQyarVdvdcwX7ORj8u3UYNy/QnqQWQVQkaB1Rqr4gJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:49:57.4907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b52b085b-f09b-46fa-fe8c-08d61830848a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66209
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

We can rely on the system kernel and the dump capture kernel themselves in
memory usage.

Being restrictive with 512MB limit may cause kexec tool failure on some
platforms.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/include/asm/kexec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 5eeb648c4e3a..40795ca89961 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -12,11 +12,11 @@
 #include <asm/stacktrace.h>
 
 /* Maximum physical address we can use pages from */
-#define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
 /* Maximum address we can reach in physical address mode */
-#define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
  /* Maximum address we can use for the control code buffer */
-#define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
 /* Reserve 3*4096 bytes for board-specific info */
 #define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)
 
-- 
2.17.1

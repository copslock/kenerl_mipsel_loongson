Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 23:02:52 +0200 (CEST)
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:34528
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992592AbdJLVCqBo75j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 23:02:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yf1Z87bgx/g7Lu+hkSloiTO+m7DUtVtXWla838gjbfY=;
 b=CH+1gJlHBUHeeFUE+NGooQsVvu2rLrvV0DJEINr6ftUtAdtCD2TPTIBOWnjC8v2caYiQiNLVX+zf8uhV+fH+d5O3wR5o9kFFqVsulegSNIzHnAjw6dvRBv/YRkb6CvSAh2lfx8JXZTHzLtQFyho6vOE6e2h9zWheAYaHpzl9r/4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 12 Oct 2017 21:02:33 +0000
From:   David Daney <david.daney@cavium.com>
To:     kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/4] kexec-tools: mips: Fixes for 64-bit and OCTEON
Date:   Thu, 12 Oct 2017 14:02:24 -0700
Message-Id: <20171012210228.7353-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com (10.162.96.22) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 075f9adc-786d-4d46-8d79-08d511b48f1d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:A4z+Zg+QcK4IR2/FJr4/w2TpbqqiIju812koLXZTf1BZr5lGkOiruHDd0L1U8xb2BWT3iOI1SfYyaXFy6Ir93fdpS0kt8dmOTWcf2VxmBGIEYtL561VVpxHQ85rWhfeLifOn8qbT/MLF7VJ3+F6ym5SLRBO+gwuyRuWa1BcbfNXYPAk6ZIS040whSzUrKh6JGhjQlffg7Ycj70bmO/Q9bTCdls+05tMpo/Jqm3V38WL367JNowmOPqStd++mU29q;25:sKvBtgymPA1BcSEnITLv6Mzx9SeMfjMxaJxJjuZhUZ3UIpdyRKSdywuD53Ph4rM8CN/javbGRUqASyOOTwDpeacGa9kbOTPjfcG3dLhHkaMTJS0btlUeO0OrMyQh0yBjsfJ7hD8OnKTnTnKxMV9dLEdZUyS44Dsxs20A+s8ZJauZUsRikOsNnNPz0QrHuoO5IH7axYhMJrTppvto2ZaCiaxj5royrNYQ8oc/p+Buzd6vCUjLwM/wJgI7eEOEF7xa/bUeNHvik0Ql+JtLBZP6xqwY5c9z/ho71rRiBAkr0uptFVXRpnQk37mcKu2Njq1ypTwsIjxDR/JezhWZL+NQyQ==;31:mfGq4RrPtO3XNR0WCM9AU3hxVoVbPRuetpNqJw/WTBh7RV4n5EaR6t4sCDWoirThroZRJ8EYTXRIsJTt+ENm0e7Bvpm/mEX8bml0J7DL76gX5mlqR9j7NwMUhneBiPxrnractTQ8eOG+gZsn0lnqf0zuVkblBfVw80mgeIBsTTDn/9aaRQM+g1EYACs64dE24KV3HWKxV1LMUxdbgSeKs0mOfZXWK4+uEjri53clcuw=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:rhiZYa6VU7k2efDn1MD225iynL187h5P9wEgQDaiwMkJv4UK3d29av3WpSWa5na2UyFOqq7N3NeBSv0lsyB35SYHDcIujuugBpkNN4wEYaQMRk1aDimBhuADZ82HAQ5PI7et02I9AEGNIr3GquE5ODULbeVtKZsPoTxu2jROnCQPrSwocaLxGHcgy9y+HZI6ggJ2lyJCqepMYLWcbVQlqCYomh0GeooCrFXBqoHqc8STCQ/5IHXV9gLYOE0asaov4m3rUg/Ny8s9NcXq7Xi3faHNfT+FbbRZ8+BV6xy80xfDu7ZlEn84FMj8m1TQYi8Gmomr6S6m1bJjqolS4wUYK9BO1TxhORMLnL6Y0oPNgeV/YqeB8dnI9Ou3O9nKtDmltmLfqtfE2hQTH4Rjttv5G4C1bIV6kss1miNmU4MtGXr/ee6s0OBf0UHrNxXQckp6Bfcu3IH/KfC0Ddr9xPpSSxaG9xFHbDnVhsuaXpus4n6g02COtmyG4lRAF6wlPuWk;4:Vm6/K0Yv0TGgyM7E9ZBYsH5p2cn3fPlNQBY0R5gFfhYC9grw3cM77FP9vaQ1YPbiGkmvcx9RYFeGfBlP1ahj77T5PrNBqj2iYeJ50oV7FP5DX1XdLRbuyEcTEHF6evKtw/VuFamDsJ68Si5u2dGhnh8VwEdP87XlKPE6XwQLkfX4UOX/3PWF5V/jfLUDQXlLxDotT10xsylyotaGK3I5BAImsnglLpu/xGK7o5yazch80tlBlQy7I/sV0yetWnuh
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB3503B3D4630D73EE529DF559974B0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123564025)(20161123562025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 04583CED1A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(16526018)(68736007)(53416004)(25786009)(50986999)(69596002)(47776003)(5660300001)(50466002)(48376002)(6666003)(66066001)(101416001)(86362001)(6512007)(478600001)(316002)(6916009)(6506006)(7736002)(8676002)(81156014)(81166006)(305945005)(2906002)(16586007)(36756003)(72206003)(6486002)(6116002)(1076002)(53936002)(107886003)(3846002)(106356001)(97736004)(4326008)(33646002)(50226002)(5003940100001)(189998001)(8936002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3503;23:t3ql6C1RTPmaIsygDhVdxyMZ0gF2it6BfInQvDvR1?=
 =?us-ascii?Q?beIH9t5Y/JqC7NVS0v1+5t5Npm+b1tPVGLd0dPDsmDejTdFqb2SbtNnRpMUY?=
 =?us-ascii?Q?uYbVkf0PvYVRJP7LYP7Xly17V4GuUXXgFzfATiGr9RWBcOnBPItjnR2JjTpC?=
 =?us-ascii?Q?BWSqm3JG3hDtAYw1X958ve2vI4Jw/TYkPohGDpn5+UIAV+KKHEE1ZYTW/Ric?=
 =?us-ascii?Q?qFOGIufy9LgUtmKOgqt8u3LMdlL1BQV9Pg0pddqgnMJ9NvO3TdQOXKr4rVbi?=
 =?us-ascii?Q?t5Tgaycf4wtmyRKZJS692pejmbU1rabxCVx9wzvpRfK2NbCLPt0/buhGeQsl?=
 =?us-ascii?Q?PHSj+PQC9YdJLtVjxZsg8kd3oF5SBhy1fMs3JqBiPAqPwFJfnCElJGJLUYI/?=
 =?us-ascii?Q?Bli7AHi04sGozbmDh3lX7UfxMYoZNhk6y0cE6KbLs36PNtOGgCG62xs5cuSJ?=
 =?us-ascii?Q?n9CwVtsiE5S7J2sBA1yMqVdlkhsIxgUwCIN99xbCntpQ7uvgANcvh4bFce/e?=
 =?us-ascii?Q?JBbHeSB+Ur3o7zdSVdsqGF7uRuiYGRP5j9s8mQMKup5M0PFcaYhtL2IS2DBr?=
 =?us-ascii?Q?CaT6akIO7st89yDF4MsGBj2fEapDmphW6T3qySHy4ogc4mtSZfoFYh8VKjMC?=
 =?us-ascii?Q?evfOpgvXagXrNjIgpc7xjxfNIXPSFkWlsc7mHWYfIOxIaFViJZrj7ZD2rjVI?=
 =?us-ascii?Q?z0Vv1y7wQdRoStt8H9YAHarML5KqY+MUFasgoJJ9xp69778TeYUmyIdINFCF?=
 =?us-ascii?Q?uLG3/OFax8DLRlinvi1OeAOBxVy0Ap2wrq6commmxXe21Duye9pJ5wn+3z+s?=
 =?us-ascii?Q?gAMUNWZ/9quPFC1K7Vv+qIm+xXNwWWCtl+0Y7tXmMhMPyfv5V3qXlaHko40r?=
 =?us-ascii?Q?mTtriVDJMIogyA6/74lEIDprVN1bTtFUhliwpfHOnQAIwzzz+VtfYMuhCjk3?=
 =?us-ascii?Q?5CQZA5q+Zr0oIBNFwkvGsnIu+juTDzQ2qaR+TmiTVZTZp/myjfn7G4DjPBN2?=
 =?us-ascii?Q?BLQHHITyGKkh7lgM5JBSUv2Xa1J8LVtlk8Li/KUMMx896u9CkM0MBBXbb8Tv?=
 =?us-ascii?Q?yQN1HTGQe19fK1NAEzFd/c8zV2FDkg++v5FPCJfDYI1AnMwmEURZ9d9Y85+f?=
 =?us-ascii?Q?PBTxh8kKPs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:3VpV0VzoqPLXnX4Hwrc8FyiKGjfLudMBgnoR4aIM8n1WuVgZSClsSMSXHnlO3VjSaZCtLJLdyIyCvg6qdWjQ48Q54L9oOwbdzVX0FAMLbolkhxKtRs5xfRZ1MzKEcjwtuFmG0Huc6MTBnusjUrM+s8k17NNe2ImjiQDyNWl3riON2WVt4ZHl+4NgU+amuZz20Jy9CQpyYlZIcOCOBwWpv5i/LZN+GhClOc/9SCPDcyS3X8AH8164FPHEOntD+GEjloebLUPnYZplYfPPhuVcRYTNjxKTTQEaoVnC8dVgd96NgKMsG08VV/VBbSd2j/8GzOr8Q4xVOljcTCUcGXfL7w==;5:JqI18N/Owh+BIEjmYcRNl3qE5LYSIawd08HWz7aueFCAswFyG3qvZreN3BW3nHi+j6E9GAWCjALzsjsO0ngNVxD94bhW8TZ/tiq6FFixPtAwlVCuMrj12GcwdLclXTNlacwj2Kwby3ygUaylG6Rn5A==;24:m9wqi33qXyeRk6ODLO/XhvTkGimbelDiEQGOxRZDBkkQljaGyV8oULigBzmpm1YVBWEZ9wLvv0zWczvCgchW1ajKSgcDPpF60jmx4bqyKRg=;7:THy0U8+KvcDNlLodyLGjsWMMXMvBjaPAnLLcEYumKEAg9eqFdp19TywjgpnVfsQ9jWEIyEzPfLOvQBpi3zQkAEp1/7v+aEeYjp/AYy0nFwhUMpysN6Zrgz7CYsUKVFdBfEI6uS25J+EIAbvd5ohFuOOSh2vuhelxW3axzrr8Ovx/hectTWg+xDdSZrdCTUdO+LcnrbsdSOqdTa4KYz4GuH8b2+DbR7d/b/067N56DgY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2017 21:02:33.0188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60393
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

Here are a few improvements to the kexec-tools needed to get usable
core dumps out of 64-bit kernels running on Cavium's OCTEON
processors.  Patch 3/4 is OCTEON specific, the rest are needed for
good results on MIPS64 in general.

David Daney (4):
  kexec-tools: mips: Merge adjacent memory ranges.
  kexec-tools: mips: Don't set lowmem_limit to 2G for 64-bit systems.
  kexec-tools: mips: Use proper page_offset for OCTEON CPUs.
  kexec-tools: mips: Try to include bss in kernel vmcore file.

 kexec/arch/mips/crashdump-mips.c | 36 +++++++++++++++++++++++++++++++++---
 kexec/arch/mips/crashdump-mips.h |  3 ++-
 kexec/arch/mips/kexec-mips.c     | 14 ++++++++++----
 3 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.9.5

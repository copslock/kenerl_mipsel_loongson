Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 01:49:58 +0200 (CEST)
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:38921
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994625AbdFMXtwBW8hW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 01:49:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yQK4qxjHaUbMzms0IvjjH24tnZfe1At+0dFKRVF5BUg=;
 b=eSzzDEcT5gfs8pbTAD6IG+Df9EDo12bQzf9nRI38zws4QV8XAig9YJN16dUp0CS1ZYQvVflRgX5/csbLyUN+a/7pYpw7snZceFb3CYqIvGdqQrGW4aoX3TTAPRB0KkvNGogfHP9m6a50qQNLjMC4FkGt+x7GTs4xJWG9txXBqZo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 23:49:43 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/4] bpf: Changes needed (or desired) for MIPS support
Date:   Tue, 13 Jun 2017 16:49:34 -0700
Message-Id: <20170613234938.4823-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0024.namprd07.prod.outlook.com (10.166.107.19) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-MS-Office365-Filtering-Correlation-Id: 4dbac646-960a-48b4-44c3-08d4b2b6dd68
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:/zuFE79020yaufl+9Am4TsxS7cssxHYvFSZ8YwjDkbsmHYq6qiZ1BmHS4EzlbVdwAodm7gBlqxMlqw8luVoS2lg1jifM4XJ5C4R+Q/tp0Xz+2I5suZ3giXSsoRoc9oX4ULUe3v12FMBtMl1vTUmcUz8PdW5LZPykqyr6salFjmq4wVWWEMJvc3euWbidqm+C8rljDCFZxjSn/k3d60X1iQFAXENNdTEVmQ6YAHfhYXE9uXeRewqUsgJbblyOf8R2mqVwXwZyxAUx/aA9AdPlFz+vt+dN/gunIdrwOuA1wMudAmbLLOmd37fmjrBcpzHh+LAn0qR8vVy+EbYmRQtLpA==;25:7yvbinSFlpZNFKocEFuFSvkK4cKPL8W7x8Y+2oRpLVUeMzYsGz0uqMSJRssbmK2oizucKjOFtvmaab8BweDZRvCIzs5Ag3pBb4jYI0JkSX28D+qMAdForDQ20B4Frzmepy1jCZuq81u3T3jD54v5tLHljKfdA/E1MfR0zuIxFUz5//ykhqX920575Kn1F04ikptgn5X/Du6cFbwvo1tc7xnNOJkx3/kRh1t9TqFdQGUQgiuFmxE42/PiZ5n3h5o5BDsl6Nkeefb7aB1j9IMK2J94gqEpNzUX4XKNdsVPlaM1vAl56sP/9B8DoQO87mR6y4YXRsZOp7SGzCu8VzsIogzaG7LkcKH6QjwLfq08Wvk4wKobsSxK8zDR8KrKmvDPforTMe8Kkj5GgGQt0RlQ8ZPWOCCn7CpzkiboOT85bjkHo+S6SsuMp2oE2aPYvkyfNrMOIAsw5+Q0TAWh4gQIV36YbB1KvXw0nVLA0PFccGI=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:045mIAtd92f0NFq0Y6Y0UPxMNvtkO41ZXC1jdHbhX+y97quUZbeGvD5J8o4+hkCQXhaXTGKklplEqjCuqsoM+rPdJPPcOk6IfrwnhPnvaSg3K468jEew8ACP70MJiH9mHbFU0W9JJUOq87xyRI1xRjt719LFQEs+BCFEqqDonQeGEXZ5lYVlUpJchbrKX1kd4DURQkKNYpTcWXp6ha5w6Be7f2dHDXTafE6CMk9cuCo=;20:hO9XvnQK9/iw7+dAXYIKnnFa55RlOkyPneCzEUjbyLos6Tw+XlyVieOAvJfRd08/GxWHlGdDZ8A+ntGPwAoUpNt5PvUR5OFienoDWHso2RBASAurUDhbp68xoDWFnAMpgZ3AIhYvQ4zkJ91PHmS6h9ssjZTMYe5FCsac76Iwm8+GKgLwH9h/KDpAvwdkX4K3R9lPGdsFNfdZAVJlP/lGxTvfj8LECore+ITOM9AsOW9D+65dY/bnKAb8cG0akgggGaHTxQgUJGLcVwctewE0nL91nBd8XpryXIxX5i4y4Mv9MKGXbx1HswvwnlR3zOO+O8kImA0doU9YKBulM1D7JglJsDQyBaXjQAdS9p4lJK1Cx5j8Sne83tzFNlDLhW5qWP3o/4lHzhXvdzwfDcDlKtFt7CgUMhB7DPYzqOWGMT+AHyOFTFKqqphGuYhL0vYnYydCkiLPzXNUOL6kbDfuzsY3O5aagPLQEPvBuMMTgiua+Z04G7KoDniIDN2TF61v
X-Microsoft-Antispam-PRVS: <MWHPR07MB3501583C35E12BF3CDE4046297C20@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123558100)(20161123560025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:WbJSqpBuMrApbnUktvibnVwbqhWsjrcJPGw2KeG9Rw?=
 =?us-ascii?Q?ZyX3JsjbgTeiVkL2MCe6djtdb/L8RFbzoOmLLk9ziiYc8jv5JhKvnIDvhcoP?=
 =?us-ascii?Q?CQSYF4VDwgxw0GuEGKWJsyjC6mpObFqqS6soViQVOV46/j/US3Feg1ZXQWFw?=
 =?us-ascii?Q?8MOXjyvg6pMa0fvLM19w3djYk6Ua2NXYlqeKiIzK/1AEeyufY5+19xkn2zvu?=
 =?us-ascii?Q?A9vuA+FMndb7u4JY7b2hbOCxFofk6C2FYcYuNHuyyav/+Y/KKrsUxfIdw1DJ?=
 =?us-ascii?Q?veIbscDqzrHSOUHYb55PLwmYsRCzKaaKvTCYNJxtfMim7Kzwi43enaWKzVlm?=
 =?us-ascii?Q?8TtojpwZIF+eIUOZAhwL5rmqeTrmLGudO2E/PhnDeepM+5fllKYLbiVIUwO6?=
 =?us-ascii?Q?6Gkqzb9/OwGCK7TackTGH7+aQOgfs15JtE8XF5QtvAL3CNyPVEsgooMTka9g?=
 =?us-ascii?Q?smwcihgmpvXhmgoSrDbqPvMUbQElrhpS8HETPGNjW9fnGg4m8GwrFFrZYsgL?=
 =?us-ascii?Q?jpgUtQ6b6HVvhxztVYyVVhauGT8fh7kB5QV9wimtPhmZmDAKkjCC6wy1f5Vd?=
 =?us-ascii?Q?h6QdTthtHGXwiru1TqgebuoSZuuuzDfQPDwAb1gKmujcpG3tGb5w9i0Naww2?=
 =?us-ascii?Q?208+R2HNsF1mRP84zoyYjUPhPYgVO/Hp4cyQC8JnRNZGlOqov9IOeflfB8xW?=
 =?us-ascii?Q?Rj061PamaJreuINc1QxZ+vkywUd+YTwGYmRTEzMk1xdjaWfCcOBj1txsCpAv?=
 =?us-ascii?Q?aBy3G9l1Kf70zv3iAcYlSAS8dWGi+O/FP98Z4wMa7O20sw7iPABK+t8VIj79?=
 =?us-ascii?Q?/4UMfq5auMjh5dIk/5oGUa5IyE+yx7x/91UHiMexkzAzYFssBcwMYcSupVpF?=
 =?us-ascii?Q?nSq/jdBPnarjRCwAm++8p4ib/s1zO0fP73NTFSdoojV+z+4t9M0jbZRxOMuc?=
 =?us-ascii?Q?5m3YRrwxj3P6IFP4R0xtIQbZX2OI/GlPtTKUeBhqRcsP7v/ynixSZoQLJzlq?=
 =?us-ascii?Q?TvuJlcYQwyrXwB0TfGXmB3gL8KGg6OZg5GdK+w9ZehGRuM4CsVeFEnAJ4u1G?=
 =?us-ascii?Q?/I0fMaeNrulA5/2rs2KfEnBb74NeEKB1fKbx3q3imKwQZVUh2RvSMjkt/Xzf?=
 =?us-ascii?Q?o8wMCasyvTN511oC+6Hce3v1Bh858T?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39840400002)(39450400003)(39410400002)(39400400002)(39850400002)(189002)(199003)(6512007)(105586002)(53936002)(50226002)(53416004)(106356001)(4326008)(189998001)(6506006)(25786009)(42186005)(6666003)(33646002)(50466002)(69596002)(5003940100001)(6486002)(48376002)(47776003)(7736002)(305945005)(1076002)(478600001)(101416001)(2906002)(81156014)(8676002)(81166006)(72206003)(107886003)(36756003)(5660300001)(66066001)(38730400002)(3846002)(68736007)(97736004)(6116002)(86362001)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:QjSma4+1Df22H7/U/8A+iOeGe5HB+skL0OLUW8MCd?=
 =?us-ascii?Q?Dx8MLdsgLZEn5MF59e+Mjaurh/GK0wBY2i/Dhomj8LIQ4e847UisWuurHlZ9?=
 =?us-ascii?Q?sa3iphkpYxo75R/9OYhRjFh8XBW+JAsrRaPXMAFK3uJJmhFkD1nlR1MmE2Xv?=
 =?us-ascii?Q?SUdotZRIq+6oDG3V4siMFHfDqOqs45qTwwr1qF+qS1Kc0mdpLd5htCJg06/Q?=
 =?us-ascii?Q?eN4OeCU5Zz5wXQ9+ZZiOhjPj9rf2R9rkHDfezKZbjDaCgHxeZFVmz0m8/sCa?=
 =?us-ascii?Q?lXF5mFlK6MgeST1xXr8Wc38QdsDRya5/RP3iBAxFV6D5roEQtLuYyTo4IHS9?=
 =?us-ascii?Q?05NCktPhFQmuNSIVyu9g+ZNXKpzapw00UoHqoXN7R4VaGxU4+MgagmU+cKoB?=
 =?us-ascii?Q?T9CUPSb6OrVH7Zvb2nwGGPMNI2eONIGfkXEUeO+eM1wy4Tm4vErsGmyl9Hg6?=
 =?us-ascii?Q?+XRJ8xGdeELjPmsFmcdT0EId0QldjyFmT/rksonV0O73WdLyhk5MU6VBlrw2?=
 =?us-ascii?Q?e7aGrib/NkkvVtRNyiHLGSi3EKM66PoWpZI6aVaWw0sOPxLfasFcaN4Ewaua?=
 =?us-ascii?Q?IIgeWLhKYyISdsZpwsNknUfVEcJ1AL6eQlAqG9p6mZJFzGfvU0Hn8sJs8zDo?=
 =?us-ascii?Q?oBXdeiTaL5Jet6zNdA9sB5NGe6tgpSDr/Pj8ccAzvNNMx8z7jN/1FcuX8U70?=
 =?us-ascii?Q?D+bllaAqDE8H7dXjZ1+1JKYKKok0EreWNFeO8hP8bExhaptZ4Uej3XnJJJum?=
 =?us-ascii?Q?GaaQVJQZ+Zo/mj9mWjFwKvdRS2mGBPhcvJaKAaTdDmKl0OMgNkcUJn87hg8a?=
 =?us-ascii?Q?JKiS4rlGrPGlS3bl8WsbtA87wvvaxLAWtv4WMUDH8CGIMoVCFPyjh5VWeQ/c?=
 =?us-ascii?Q?qMqtQLN2R2T2sel4/dw4m/8vi2iYDh0oLdY/bQK6bzx1HKMpMxeEBQqPFN8n?=
 =?us-ascii?Q?MCFzevVA6kQ7onoJLdZ6DrRVUMOCvDfWKlXbvghutJtSDGj5+JItPn1i0cpI?=
 =?us-ascii?Q?QmaFgcm3fVIVlZcQBn0WSQ+fWA5i9IctbXV9iN0dIAKrO0mO5XqYbCX8AChP?=
 =?us-ascii?Q?dX35gj2tgoZgnTJJzv5FW3LceXnwQ80s0/ODNXnMRwt0COVRCCQzSYo+WY+7?=
 =?us-ascii?Q?iS0uPKUJcaI6wPCXwz62GfzHlz1BhpB2jPWEIlQvWu9muCh+2Qwjfa/QeNGL?=
 =?us-ascii?Q?oSEJXPfYFjt10ea3mbgQPFj3WtcB5OQUCFN?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:4uQIGDiw5PgA4E2PAabpMfFgbSyjXU2UsMH3jtcGzcvsO4ojronzXM4JgPy/Up0XINdnsWtvx1WHXVscEPwzEjGj5+rgFrcINzKKnsQhpPzZw5zDGGbjFCBsH+c7jWJ/J/pgSGNXVfUrkn+ybS9hzYuib+0k2ExX5V3XLdREdadAKvpgqDNXz3eGByYdktL1+fh2dgYZRcbl1EqlIWhIFlwtsIHryhaQZzRAdH+zsl8Sd2Pj3+p2PgiY7Fw5JfZ+DVKeKf/oF61gJAZVnxliiVYt5LibAkUW/5yyFFD9ASLHj28eRhNi94KfcZ15UmLJ3T+F+5zJ62nmOLFNva6XZwF3Heg/s01a8x0SSM3cbBOyEmiv3XGH+sm3K9UAuhI9qHAVYuVXcFhvDtpJxWr90ievxpmkq0p6o5I1InDu0/Uq3EJLiUGNc5qXwlKKr3UWZ98ahC3kaW19CLpqJDKRFBTs6OqslOEv2qRTzLIqJ6Hn3TLLyIhADyL+pcusmh6TMFNaD6XxSGKfLeGDRNvdkw==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:dOtyNospvEAqx1n0qvbFYR5zMIxnFAhlReqqGLulqWt/yTbs+gFeINZxnYyBxb6zHVUAhOav25lyPocIc5+xfgGdmHP2NXDxhU953zTP5S99w3Ugb4FhQX6784iuI4wkAZSZhev1EL7sFo8TUbTqfwVyatlC8N4KTJ0N1dj1sjhksTVAFGsO1hImtuceomH1EmZ4Og1kSnKYzRCkytm/prPZfR4GQIOET4/T0OKqK/ADqHBKr4zlG1bBYKduWiD/ObF1RT/4VsHPmMpoiN5H2/Rg4DeewX4daSLqNqCEH8XxsSelIkQxpeQi7g/Fo1aCY6R98g8k3ZeRX3Jilxk6k4C0gkU7ZDoQo/P8sp9OSPwnCKVoSTAFxI2mO4b9gJfZvC3hGSgB2aqHJTSxbvI84wVOu/0WTzHtl2N0qoAlVOk+C3gvrMDmVIP7wtFFzMLDzbx8N/VIdammgzKTgiUPm6gm7K21Z10PSntCstqSPp7Bgr9VWRP+X62UC7CY4KGr;24:SU45G+DrKkfZbxoX75MHaIaUxU+fw88LFnEPwQ4dr5LBF/3W1soIoFsDwtY4lJYiPge8ZYz4CU8t8d05Gc7An3A4P+L+Kf6GOTnd1Ah3zo0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:y6bc8OR6nQv3Ox/cP2Cy9Vcm1aqu8T2QU7mAyvA43Jk+YsjX5gamLnnCMFzCkobqUxf7siX4TD+I6FPKe1MPlAFm2Nn+5lwAoVG1vjR3+tFV5Mz7MhuWxQLDYVlmbDbtUQV2D+/ce/n8blnJkyvs1Wf1rZjBx2uqw1tp7k4zlfjQBe3wEka+5EhCTsGP5ZB0mq42x7CY2Cs1qw4fOIZ4vlSFmYKfqEyc06VI3IAnz8hsE28jbOHx/x28AdxG922Ilq/q4OyMFxLTO8oIUnMyZlK8YZ3bwpxkPVfA6YFwGdEmvKj2LgAho5irc/WhmEAwcwJawpypDQyBKGPj6ZrEjA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 23:49:43.1816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58432
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

This is a grab bag of changes to the bpf testing infrastructure I
developed working on MIPS eBPF JIT support.  The change to
bpf_jit_disasm is probably universally beneficial, the others are more
MIPS specific.

David Daney (4):
  tools: bpf_jit_disasm:  Handle large images.
  test_bpf: Add test to make conditional jump cross a large number of
    insns.
  bpf: Add MIPS support to samples/bpf.
  samples/bpf: Fix tracex5 to work with MIPS syscalls.

 lib/test_bpf.c             | 32 ++++++++++++++++++++++++++++++++
 samples/bpf/Makefile       | 13 +++++++++++++
 samples/bpf/bpf_helpers.h  | 13 +++++++++++++
 samples/bpf/syscall_nrs.c  | 12 ++++++++++++
 samples/bpf/tracex5_kern.c | 11 ++++++++---
 tools/net/bpf_jit_disasm.c | 37 ++++++++++++++++++++++++++-----------
 6 files changed, 104 insertions(+), 14 deletions(-)
 create mode 100644 samples/bpf/syscall_nrs.c

-- 
2.9.4

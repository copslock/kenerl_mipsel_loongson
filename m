Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 00:36:24 +0200 (CEST)
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:37054
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994787AbdFOWf5tCjYr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 00:35:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jOG/Q1AiOwHz42xmwCTqBi7goN/lS9xDBFvmMt7aoac=;
 b=b1q4oIkcNlinjJr+u+PKUGlqOQ+Z2NBRAeKK/OK8/Dis06K9a4+nw5UCo0F9Fb8IOuu/I+RjoKOIwTk6Nucszs29GRdVSA26A6EbxWD7mB8K5wOZbrItvcaO1QuJSqzv6VzMfBXoNU4EzROsBYOfpokD7G3FYntcBUiPKG44BM8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Thu, 15 Jun 2017 22:35:47 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 1/3] arm64: Gate inclusion of asm/sysreg.h by __EMITTING_BPF__
Date:   Thu, 15 Jun 2017 15:35:41 -0700
Message-Id: <20170615223543.22867-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170615223543.22867-1-david.daney@cavium.com>
References: <20170615223543.22867-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0070.namprd07.prod.outlook.com (10.174.192.38) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-MS-Office365-Filtering-Correlation-Id: 04035878-52ea-4ee5-eeb3-08d4b43ede97
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:vL3GmektZA0mb+ITBjUK9YRk/fZlXnBwltGZtK1f+s8DH8T+yB6b+J/zyl5QGPMbLaXfPPP9aGhXmZtTz6HLuOvGzFBpByG0yuBdzGhR//ALsi1ffRnLU59RyTxW9LTYsdljweENS07rqzRH8z0AA6ISAzblwTdZFHns9XDmUYeDGLBfinpW7skq6RCcWByMUXUruh4N4j4GZZZEzEz09sYB4lcbXh5RRQl/F7O5K9rxdgpUoq8LsOdWtmNAdi5jV2kdkZnQkMqy2y/f5oQ0pQo8oTCzy8S7VGlxar+b4ltK4PccwgAAYo8t004QksHput9/vxysxwg8cwvt1wQcVw==;25:Ef+G3ukDtose9sFa0rt5vQmz+RSxMh1QWhgLbYM8yD+7cMNyQx46TubrA58ql4Gfi8mCYNHXSrt5NSo/vp2E2lLITzd/NxxyAYZz5FL9pcrGjEhkuWRhY9NBpibkLUCZ6w1XzAz0fVGXCCJW3GC2vG8BBETsncDaupSFjtxuoXZULKtVdi17RrKmJpBKWq7/zH2bG69lMmTHdUGEVFFTp6L2INztvlElegUdeHgfPUPFOGdxrDkKW34WNoBEQRV+9sh9Zfwk2OS/UZCZ9BymeAsAcnYIo0yFZ8lph6oKU+5128Cbn+PJNAONkdxZ6bzIRQVjHEJuL57/w0YiDvULHaVOhjZydDNwo7On0rUEDdKveMolrF1q50erLN8lHFAJKTDMIT2HCX5pJAiXzTzjyNhe59q7G6LVyZijNC1anAZLOrtE6yZxWYMqWnI0edxH3a7CxAvdggoj/0CLCFWurNOZ/7bzOv74JlCgKOIKB7o=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:ISM5W6VMQ8wGXIeYEeVL02DhfHq3fpgVgbG3/9wfK9dt8A2XrqglTYEVby/KDEujqCktse2XrlBeU/c7g4ZurT1+DMWZuKYte5uKv1NA0tnS8WBji5821P/ssAspGQejjlnJ+b2oe3q6fDoUr4FgNw4gMRn+wAR/Tv7VLCK/Xb09N2AvNiX2QvwIbm3fERWpMdsv0C1J5IEmPR+IAbbgc327BW8qB0HfZ1MLdKINWEs=;20:kZxvSAQLFhKjRK2eiVKQgiC+Y/rJFiDTMZEw0nww5KGByrj03DUoPmGcWVXuQbAGSXrsWBaQk3A9PMZS0Cmze80L2pYtb2ZTiz09TkR21jT6AgISon/7f26w5/uv2Ts/vuF8Y9GdOa7FqR8UcYUP/eOUEnIzfEaC67tW0/X80Eh3YaG5J3SU5M4XvBOcGBnF3k0J9hMwijpwpfIWuOGb0A2MQl4BRlzvLSDBK4Fphl6VczWgJ1ZYaEBKizlHMdSWVg3R6q7/jLmyl+DGiytghdK0WpvmwI2FHznfW0R8dri+APascZO/ViU9y40NBH7nMj1lBGWmB7QLKE2ZZKDodaLc0xlkAgbOu8gx/INKQwnTt5Qx4WnurnYVn+Ijgpvwj6RLnYaR5Vds0yahNKmDghHdB+KQiwaGDqGNX0tCAMFpDSZ9IH8GkEjSZbdLZTPQmcwXYEM8bS5Z+lnfGsTKzTv1XrfH6NbSOfsahdxaCxfcz4yD09Nv3AX2A1Ud4QjP
X-Microsoft-Antispam-PRVS: <MWHPR07MB3501FF19E11E2944CB19D44197C00@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:7mnhKNd+kOK8lv7ud4vqsDRMGpUkNhmWbCIxFJBHjW?=
 =?us-ascii?Q?7DUZAs7s+WuAz5wwUZnXtcIvYMQ78ni4wTtE4mebTEJ6l6iD5lqRvtxcOS/Z?=
 =?us-ascii?Q?A1/7ierCP30jq+HxPv0U0FI50p9e2PWmjWn0Pl8VaanqMWAK0E7gkDmN+Fhr?=
 =?us-ascii?Q?x4VOUhIES0wWynCovFI0Ea+LBIApL228tAxjYZ699AiC5hbdWk+I8AAkTRao?=
 =?us-ascii?Q?DsnRysEoQUoupqprVz7upA0jeuqNH8El5IfyrYVxNACxFSXV1Bf8Ux7J58Xs?=
 =?us-ascii?Q?1Af36Ki5k8zd2pJVFVUEDIuby54pfJvk8GEdQqD2ilpkZuDChQoBzZ7IbexX?=
 =?us-ascii?Q?M09JrvB9EYJ3+0vXXZW024sf1D/1ylZwGGYdFLKefW9XwoPy0Vkt2dWzRN2X?=
 =?us-ascii?Q?/P6pmQoJY3DQOQwtoMCQa8iKeA5xsEf44VJaU+lPEcwJRNdcXjQ32q/eNsDO?=
 =?us-ascii?Q?/P0RPSJ18CvyfmMZisngF2cGEwlvkjai/t84QdaBnic3n/HxlzzCpgmKZGHk?=
 =?us-ascii?Q?+zqRoQoHckd/JnZoKdWRIaJrY2zsqkjONUWTORJfAU1+/VziMrlanOROGq+B?=
 =?us-ascii?Q?6r2oAr5pfXFPjvLHYvutYyuq5utqtLILLEDd1U8V+11DtdFvpBE9uzY9c11/?=
 =?us-ascii?Q?GPhlKH6/VB+se2vqFZZwSDJldc22n6McdaQ6nkSI0RALOlAqX8ScmUEJXnOw?=
 =?us-ascii?Q?yB62gmGt6UDZNI37xD8Y7kOxs+2IgDdSJ5IdCaeP3ZXF2vmLS+fuKnxim/W7?=
 =?us-ascii?Q?eTsz6UV1Y0JZkT+3zuO1PpdP4utVlGp31BdudfSJgFiuASCMXdsnGBWURt1I?=
 =?us-ascii?Q?L9DWUM2ep1ZUQldTZ6L5hRRB0FgyW1iC+zvEjFsMEmZz8NsFw7f/Y3vWXVe/?=
 =?us-ascii?Q?65bBacjrrNl3BkeCU7jpxlszcSSLl6kZtvZ9yimG1jnPI/oe18YB8dReBF7G?=
 =?us-ascii?Q?5zwaj8Ufe66HvRJ7aRm/xzSwN3Ka0Xc28SdlMTHP8ganefEwUkMn+A9jRM71?=
 =?us-ascii?Q?H/s/LADaxz/1dY/OnOYZK0DOxBTeBK60CjY7qNuwv3Z/1nRElOKXSd5WtWp7?=
 =?us-ascii?Q?vP8HSLCqhy2Bnzfeckaeo/9CA8EI+Yjz9SrzMc4eII2kJCp6Jz9ZqOtK0RAH?=
 =?us-ascii?Q?mUebbmm1Bvzfx7eJTpEczhQgbEiVI0?=
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39400400002)(39850400002)(39410400002)(39450400003)(39860400002)(39840400002)(81166006)(72206003)(8676002)(47776003)(1076002)(7736002)(305945005)(76176999)(6116002)(50986999)(86362001)(5660300001)(2906002)(36756003)(3846002)(38730400002)(66066001)(2950100002)(53416004)(6506006)(189998001)(478600001)(107886003)(4326008)(6512007)(5003940100001)(42186005)(33646002)(6486002)(50466002)(53936002)(48376002)(25786009)(50226002)(6666003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:zxyrhIXfvRMRN62xWIkG7HMLQI3gM3v00LHjAOMaP?=
 =?us-ascii?Q?4Q3UkEkJrAs8KAJdfK9hsgeqnuOCOQHpBcbUJLzSkMfPQ9FlOJUe9hs0pFlw?=
 =?us-ascii?Q?tJay8YCg88yJsDkl2KgJu43nQrbPcBSjU17s/f3fiTv8RezSs148+d2jea4E?=
 =?us-ascii?Q?ls3imqETHx9SLzZfMOLHPQyCyYFKeQcd5EBkdfnm/Nt428S4rfm6XbO44pbt?=
 =?us-ascii?Q?fLf+j9fhQL9v23akYPnlcgYXPBtqRrHIs1hC5FIge89KPDq9Oix0FBXm445d?=
 =?us-ascii?Q?3d/jlUEInZqAi/rMOO/LudY8OC8EbKgF4B6Kp23WmmyvZg6lF4v0Bd1sOgye?=
 =?us-ascii?Q?ShDywLrNEsjb/RZlP2YB1eGVnQbEHWuBDZu0ErTHDKzlb2/Br4bTyvNS2j9L?=
 =?us-ascii?Q?OKI+A/+/GKJVAf48//yNIsNaktPnIBvpQssq6MBK8mUegWMlgwvFNeoTO0jL?=
 =?us-ascii?Q?yFsu6T5/smS1FFWLzK2YbNcPTOevEsVSeTLrCQK+XjE8Ig5NTWrXQxMYJvOM?=
 =?us-ascii?Q?MtOrnITWysyf9eMhA4d+X91VweF85bbqqa6mado7wBpUH9timtpvtcuqkGTh?=
 =?us-ascii?Q?D8cpNhz0h5a/FNT6iV7tlP5UzwxW6n/u6mikcqkXPvVqdYObQDJ0cYjNYdeb?=
 =?us-ascii?Q?/32gqs/D/Hbu+ykQwCbrUN/LpKZFUCx4i7l8kQF2YWep5JLWuI5US3qDqQ8x?=
 =?us-ascii?Q?DfnXVwEbBm4ahJc8eulc5Lt09+poyVQy/Eg5Y90KTuocN4HCMasojyKC9M+j?=
 =?us-ascii?Q?oV3grlj0nFX+Fg4ckr34IhDspcnQYgQP2R0GVPfcdA/4BHHQ1RXlURrJP+R8?=
 =?us-ascii?Q?h7TLtu0N0izjEOZwt+n42hyn2AcIqkax0O09ZpvFdzmgsRUVbmJDeqgSpjSh?=
 =?us-ascii?Q?qfLhPTi/rHN91/xPGCYxPC8tBvuFeYaRX8Q58LGhXcJXjM0QLJG8bkZdMYfI?=
 =?us-ascii?Q?yct1Up48ctTDjXQITqrV2h7qeyvbHcJ3f8NC+Z6YcWydzTn+/Kh8J3tYmpQu?=
 =?us-ascii?Q?hjonWsbS6NzG4HpTi/HKpp6Qp3YaZsLadF0qmsRWaDm6dPMT4+iqCkaCRz7x?=
 =?us-ascii?Q?UspwO/HRLE2K65enViFF1IhoOcF5Y72wv+UKQHrUFSpWf1DCrgeHkSa5eyvD?=
 =?us-ascii?Q?eX3d51xwv8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:efWdZ5uYSszX1G3FdLvqGLwxxANwi0fI4S0GQ1Tn2RNAJRKLmxjWcRje8gWiiMIYYcwsnltyg8y1ZoZ2XQUktkLtRwnx3iKgvfbRZU1WRgx/nQoti847JbG5bXaxcdOJOeyGJ+w9KSV/aOPXDKn+pczf+/Ua+lmpbYL5l47CbWw5sVm/qEci+3cKy1DAdALmniaw9UlkSqSaULN1dFHFK7x8RUPlAsIOQyOmsmG1sN3bttJ0wFjMgZ1yEH4/tKiC4BE9niSRMG05XyW4g/plG/MiWlr343N0aaR56ii7VvA16lcTwq702ar0VRNWrgI9KPrQThlAh0OcFYLQOzhd03iYKFHvanz3Bpsy+J4lFrMFJRt6sScL0prdjpHth1QUsQIFPRi9L93qMtE3J2/87v5/Ava2Ob1WZnbkTY3kUk10+O7OLqQqPuDHEGn/XTX2hTf3seGXkDPkkMlWUWhjZeUJfeauRh0i00MjAGIIllha0kDoTtx7p1EZ+WWcP5LpS1bFDExjMrgmO02QHD5kTQ==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:hcFLCE0z1aRAk2vUzRMDu/h1WY9LQhz83L6uq1mO9HaMcMxl1ssvvX81gFmtoJ7sQtcZbrjp7KS4m1ONq2kX4aU7Z3jLrwmulstkBTgqwylUGLSXP3orQWs4lwcB2gdxcNkRkDHtAL4pTS27UZ32NFLU4XtFtv16ahCNnr1vveRAOij/E387CAD5OTkz1pD0hWIfhp2tGmUkOGJPeD1hIcaJ30kIatD9Nn3JLfW4dCghcoBLMW8AbJGq49sh7xPpVKFny/TFbX9WM+9l9p+M8KIfK5phGystzbLGt/DEfdE8KageEjyX/CoXYEJztCQ/aXXb0y+fBT/iyZiwjVl33dkfkijIam2cBLh4HOelgS0FQd3YemRbiBcpzLGIFZiSZSbAp6vhp0UGnke/e7YFfZhGhOrpk1KJETLSf6oC6SY6CCS3cXp0SSeu/9yrNuVJPoJBDvBqBCu1aq7VfkfzGmD2YRxs7eZ9U0BToxhWg5cOgB2zrpUF1HxVgi6j+drn;24:/vFzj/p3NTLHawj6hK+u4Ym21I7l0UJqjPcp9HCVgbg9pZUmrVnSIwivyOH0lSfoe5PMP53rWqTDmIjj72JesBc3dxCMjNQ1hVLdq8liTt8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:7S1OjozRdmOql59mU5wcyRiHLsABPYqiKSQc6VrhlB/YeX4MXkChlf5ND9YnKFBRLYKvaTSojKO4EoM1oLM/QAvYNK7SGPKFPmYw7zVWdUsttUMbhwM2TchzmPdGUo3X+G5NbCwTj/UR6UWX6FB5rxI+OGoy05qPeHqfROyQ66/gOcNRw/YF2pCAo1I3GhrhxqWw1Tqiv9mVn5Vb2EoA2m0jGehX4SN2lamencPi80O0aPImRUsm4qxwzbNP5+dSP5XAbZHsg7DaVzkKBCdzky07YuflrnfVErF3+TaAajcmzXHT+1iIyDAac8viC1Xi1YOtak+yOvVsKe18Vu05wA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2017 22:35:47.7959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58480
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

Compilation to eBPF chokes on the inline asm in asm/sysreg.h, so don't
include it when compiling to a BPF target.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/sysreg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 15c142ce991c..faa8f853e369 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,6 +20,8 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
+#ifndef __EMITTING_BPF__
+
 #include <linux/stringify.h>
 
 /*
@@ -502,5 +504,5 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
 }
 
 #endif
-
+#endif  /* __EMITTING_BPF__ */
 #endif	/* __ASM_SYSREG_H */
-- 
2.11.0

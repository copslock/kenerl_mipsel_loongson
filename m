Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jul 2018 03:24:02 +0200 (CEST)
Received: from mail-eopbgr700124.outbound.protection.outlook.com ([40.107.70.124]:62912
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993003AbeG1BXulE8kG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jul 2018 03:23:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iZ6bbqkWtaN7lyHmybH96d5BrlnaVQSR7mqi0LgEsA=;
 b=OGACQwAr61oGVIDVXzEmIuIWZFKeV2j1nEP43BanTIh+a0e6PPSXVhQje/cv2zuQrDn3JjUIA7ycHQdkijnV9tvOgWmlKYa9TuE8MiPzgz0BDxjRpC0LCBviBj0I4nEe5jrlojf97br52XBUl8QuYcl1945SxpVfBCRKD+evbHk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Sat, 28 Jul 2018 01:23:40 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Burton <paul.burton@mips.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/4] MIPS: Make (UN)CAC_ADDR() PHYS_OFFSET-agnostic
Date:   Fri, 27 Jul 2018 18:23:18 -0700
Message-Id: <20180728012321.29654-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728012321.29654-1-paul.burton@mips.com>
References: <20180728012321.29654-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0042.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::28) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 742599b9-7dc9-44a9-054b-08d5f428c0c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:zFi0vA6kIsbmmRz1GPUpd7wnT1STl6KRSnX8hKaxHGzboPr8cNMZyXPHDYvzFD2qwY42tJIA3az7Ex2aQiF8p4bBml4wyYDkiw3UpYeudP7dF9i/3h6Qd8fzwOlBWH+rToR94xAmKJHNMRLnr0R0Wn3orlmGXEr9nxLIVuaHmLq/cNSbH9GLHAuS/rpneB4TiI96itT2fDlD+v6xY3ioV/M5XLdM5bk73sk0nRv6qpKhfNV4j+NiwBxgDYph9OYr;25:TLeyR5RiGlQaJDV/NwbplVSms+2AEyfrSGfIyQNDy1jcvFHnaEg/7IZbUx3mWRJ8IO3WoLX6vCHRjKRW+W7vqa2+2RSxJTuVp6gXQ8DfZoT23YJ92M4aqvtNFUyCmxeBTCDkq+msdT76IV/m3dG86Fki42hhurIzQrXBpsdJrsopGT38T73ZtXm9YHCjgzO8rgyWUSpvUCNk5wtLRuF4iv1bv6fVvZKg2URbB5/C4APyOi92OtXTbyzDyKUDX1+qGkVhJLw2GtqK90kVpzvzCKHqgkfKHk5HJtkA678YM7f1CP7XA3iEBRPS1PtioaKe4cnLhufYnazG2JGUp8lOEg==;31:0xDy7KNqWJRfbnULYmuMkWMJsYoqIAFESRocac4SYrAVtkdr41QVCiksuua4hDi7Cjlow00Xa6URJMWLkKHg3+0bl599tiP48vWI1+Eou313NVYC842jtSlk9s/Z/NiVCRBoXCG3mZZHNwYkYbF4J7EU04mZUhIi9HEP13xSkKsbcRnAnrujqSU+BLvEzw7sS+hTVBUfs7OucvV5j2CQEvgZfTY1uz1NrYi2RBQ3/tk=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:XQNtsKPkaq6lAfRZAy7p1btsIAgcwN9alYdT4ZADjtX5RlLTPxBX/9RugL0YVHEDMtWfU0RXtQHjGmbWnZ1OEL/QDVTxaVyrQIzpQZLiMVtyS5lHZWJZUdscxMYan4CIEStSbs57gRBNQRCvVZRXggL56DOrQ5v+0kPdfJr0f219ElCwtxNrF++mij4+ut3PgKMYhQvn5TiW5TQqsiPp4iZLHG3s1/M/LaYVVyg5DEGQGaaLLz08XR4v3X2zpbZI;4:+HHeYbkIt6bmLz8zIDLfVun1+1k9uIfn1kCsioetaNRn5xh8Pn6w2HocnJV/ia1oPCkhCBkgM7WlKGzuQINYvfnbexFMikitocW8EftfiBYJv3S5V0FYl5db5PhdEdHcYUltPtt6cNC5x1XNNCe+cD4guJGVwM/2WChrswbR37SMvD1pW4K+yl0pWHg1nBixjV1n3tFxfK/hTrQ/XJvA2R9J0U4Uv9RSsvUKJfY6FDlcFh6UhJHEGcaTcakvJJGeg87kcsiHpzNiAdGzgtQXOQblwQlm/uBjOPB/lbEaV9mvHWMJgtM7+g7gvM6RFvJk
X-Microsoft-Antispam-PRVS: <SN6PR08MB49427C1CFF8617E44A993209C1290@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(51416003)(575784001)(48376002)(50466002)(14444005)(47776003)(52116002)(956004)(76176011)(446003)(42882007)(486006)(6486002)(6512007)(11346002)(476003)(66066001)(53416004)(44832011)(2361001)(105586002)(106356001)(2351001)(97736004)(2616005)(69596002)(36756003)(6916009)(16586007)(81156014)(8676002)(81166006)(478600001)(3846002)(1076002)(316002)(6116002)(6666003)(68736007)(5660300001)(8936002)(25786009)(305945005)(4326008)(7736002)(26005)(53936002)(50226002)(16526019)(2906002)(386003)(54906003)(6506007)(186003)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:dBD/mJIuV/4FKTjnyC/YNR7j8FWNZCXYVm1YZ4One?=
 =?us-ascii?Q?RlahyNtAAMNZ2/4K5pdORe9k30G12K5uOp2i+l0V5zEj/x9ENR2gbnfnIb4t?=
 =?us-ascii?Q?QKd9f17F0HBEdlno/DodFTpwcCI38RPy2fPKg/n8wx8aagBbJ6H9mUzwteP4?=
 =?us-ascii?Q?HU29xy54PTn4vX+EPxSj++R8Z2u1VagyvHa7jtNCSGC97aSW9KTLm7RRhjHY?=
 =?us-ascii?Q?1HhkQX4bdJwXcRzL0X3KA4NDmGtlq5i7sKuX8SriIIMuJxkRhmEdU3Rz5lpG?=
 =?us-ascii?Q?2W9wvLKv6LyKr/8JZxvwG5RDkFYklGNlw1SjryyfKuNlM+7lL3r5VBp722+n?=
 =?us-ascii?Q?C8Rn0YYDwp4gk1Za4HRPpPrh5xJdSW5SS92PMXWfW1fTUQ5igpVbUJnK99PC?=
 =?us-ascii?Q?Y01UtNL5eQF6NZN/sNW9Eb8mLubcN4jnHbljUFADwxQylmTON3WqyY6ykRXB?=
 =?us-ascii?Q?F7MO/sOatSy7Exju8SHdgX/m4ZRpQbg5MZJS1SH4dTOaKzYLalssdfd6vXdm?=
 =?us-ascii?Q?5WcZgjohosihr+T14TCyOHwvyM/CkLQi4e93Te7hve9Qf1mqYS7WEN8ubr3h?=
 =?us-ascii?Q?1N8how08pZ/qSobEFY/9Pg1apcYVj3qOlabgg0J1Dt5MJuVnn7ptoPUSIazE?=
 =?us-ascii?Q?wTYQ9M7AwJmtHiRIgR9BNfEI6w+Htw26emPpwnlKq7wqT2QGNrBf3dizaZ2i?=
 =?us-ascii?Q?0OtZeCBAXtLtB7eho7TNaPezEOVv9kLqiiDJr6dLq/C7FEoC701B7IyYXOgE?=
 =?us-ascii?Q?oS0ehDhD4CVx+/kx9K6VW4TWdIErenNc7UwO9GBv3qhi8mnUQz6zYSy8uAcR?=
 =?us-ascii?Q?pgoj8YZSySnf7OCaYFZuJvEqK5NVJY5H1uDHgJxrJlqnvtzFYPqzu2OWcEWi?=
 =?us-ascii?Q?bTW4X1lO1GgHvKTswPRvgnhctub3XyfxQDjMWgHR3RuwOMaEDuLyP7yS9nnK?=
 =?us-ascii?Q?OLeeiGelTdzldsCPnod2WGNYtiM8EMUGhtjbcgLRG1nsVA8hS30Hcr8VS2ZK?=
 =?us-ascii?Q?AMWCgVlfdex4WXE6zGFRHkoORV54bmGY78kvo9wTruv5NV+NVEYhKKHWrtDU?=
 =?us-ascii?Q?M1VF5MzlXlwlNMZ9unDisxSJVsOjwKgXCi2r7nB9zWXhxsqWQyPNHmRJQcGU?=
 =?us-ascii?Q?O6lZiyCK4XsTOr0yKbGftSPjb2e+ne1ADL97vLfJfjdGWC7JkCinBRqO89u6?=
 =?us-ascii?Q?MZinbGSYolfRzDS8rpPpSpH1k9mm/Nx8hgN/Wgj24mbyF7P/l+3c6EbaF8Nf?=
 =?us-ascii?Q?0UiZXntv2y/jW2fhuug6VDj8BLkkc6IbgV9ChdSuSH8OAWfW5yD7JolF1aBj?=
 =?us-ascii?Q?iPJogscqufCT7A9P/GpwdtwyO6jT4NXonNWjaNiuS8FW0z5O9wxvzsIerD6L?=
 =?us-ascii?Q?NpFWPC1eWJx7svTB0yX+5w2r9o=3D?=
X-Microsoft-Antispam-Message-Info: FpHumNTWhfpVo5WZLRiQ6Hr46JsZSa7+TdwhcA+DPWqfPN13JyqdNnWPZH0hRpesyjH4/EM3CRg17s+IZmmmY0p5kF7hCXrniHAASh9iprFahst71PlLohVsZFslS7VIgs0+MpNmf2dbZQZZeT7UA2MHWiPJflLFfSOAGpgJ7TEM6cdbmDJpwrN0CPBG7DmVFFhmk34F8Y7hrtwRd+BYQyJR/av7Mr/pu5XfV6IFM3CM8KOBsVsjJk6Sq7gI+riftA/Ap9RtVVfBZD5xY/4nQoNHhtUQaI/TtbnxEvvYoIqYVZsaAlHU7UkJbA5Fk/YtS5qQOU6GL+1kF+Tc+i2qU9qxU6TqF18iCVQL226dzOI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:5SJksFYoae0MTQuFaJrftoknatIqxHqZACota83xzENbIiMS75dQr0bI8Zo6jh7iP76UQgxku6P4EMUwWzkRXeLy6eUbUUCm4wSF5SiqjFEgEwVf6glA3o+6BK5JAQa2ds67a9rnn8kHAjxJNjiuuk7UkYRuGEf0bpTHZqkCz1/XH2+j1bkqQHWoT6Ww3+QoG+pkAz+Bos7yaG0nT1Gn8BF1TOyB6zY5fgw2A6i6hGBPCr+3wCYBd+acrZtMm0VyqrFdUNGYue2m7oyBUdC8QyFPY0U+JyZ4FrpWvtWkhJvAYBJ7JFKF4OjQy4Yuf7tVSaxP9aQ/j4gJyGD71Y6NfhVSvTBYcgPMHr2kV2UilR5HNIsr9xF08NMQ1FcqC+Oj66cRDWCDInMf4z7Lku6fAHgaGc69ayhqHCwY0KBXYpa1VR/Tw7xrJ+MzgVjCcZceetqOGgCp0/i1KKZ1Ni+MGA==;5:OanoyekWBCBm04f294jJIvJpn+gN/Gb+cUJoum8W9lFUn4pVuLi+0zh94X9ihrRL8R0fpfczW30967m/XeG9u/d/W5McYwgg4qCEmHrY+5T8q8fdyB8eUKlwss8foyxw7ALW1sXXH6mPkhdvhQck03UfpNEOT6JYtA+9ejpLEck=;7:Z3hPt8v8cfBPOPc5yaQM91aRLj37lqPqeQSFxWC50i6i/FIZHTKrGoolMLL9ygLujy21T7IvYRHdswjuz98jNTrqDCWTs/0ZUX3LLz5xSXjNl9oxCmFnN/VJmhduG0QvEqHXSplqi0qGiyVj8BjKOUD9porWNKI+v5krZPvU9RX/Id1udIyBQ/R+iHAeB1+qkObtDyNqkEVRyOLr/exvcHgborRTFMTNZjlfJKrGp6jkEsh7AFVPpG+zKaeZc32v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 01:23:40.8409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742599b9-7dc9-44a9-054b-08d5f428c0c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Converting an address between cached & uncached (typically addresses in
(c)kseg0 & (c)kseg1 or 2 xkphys regions) should not depend upon
PHYS_OFFSET in any way - we're converting from a virtual address in one
unmapped region to a virtual address in another unmapped region.

For some reason our CAC_ADDR() & UNCAC_ADDR() macros make use of
PAGE_OFFSET, which typically includes PHYS_OFFSET. This means that
platforms with a non-zero PHYS_OFFSET typically have to workaround
miscalculation by these 2 macros by also defining UNCAC_BASE to a value
that isn't really correct.

It appears that an attempt has previously been made to address this with
commit 3f4579252aa1 ("MIPS: make CAC_ADDR and UNCAC_ADDR account for
PHYS_OFFSET") which was later undone by commit ed3ce16c3d2b ("Revert
"MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET"") which
also introduced the ar7 workaround. That attempt at a fix was roughly
equivalent, but essentially caused the CAC_ADDR() & UNCAC_ADDR() macros
to cancel out PHYS_OFFSET by adding & then subtracting it again. In his
revert Leonid is correct that using PHYS_OFFSET makes no sense in the
context of these macros, but appears to have missed its inclusion via
PAGE_OFFSET which means PHYS_OFFSET actually had an effect after the
revert rather than before it.

Here we fix this by modifying CAC_ADDR() & UNCAC_ADDR() to stop using
PAGE_OFFSET (& thus PHYS_OFFSET), instead using __pa() & __va() along
with UNCAC_BASE.

For UNCAC_ADDR(), __pa() will convert a cached address to a physical
address which we can simply use as an offset from UNCAC_BASE to obtain
an address in the uncached region.

For CAC_ADDR() we can undo the effect of UNCAC_ADDR() by subtracting
UNCAC_BASE and using __va() on the result.

With this change made, remove definitions of UNCAC_BASE from the ar7 &
pic32 platforms which appear to have defined them only to workaround
this problem.

Signed-off-by: Paul Burton <paul.burton@mips.com>
References: 3f4579252aa1 ("MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET")
References: ed3ce16c3d2b ("Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET"")
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mach-ar7/spaces.h   | 3 ---
 arch/mips/include/asm/mach-pic32/spaces.h | 1 -
 arch/mips/include/asm/page.h              | 4 ++--
 arch/mips/jazz/jazzdma.c                  | 2 +-
 arch/mips/mm/dma-noncoherent.c            | 2 +-
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/mach-ar7/spaces.h b/arch/mips/include/asm/mach-ar7/spaces.h
index 660ab64c0fc9..a004d94dfbdd 100644
--- a/arch/mips/include/asm/mach-ar7/spaces.h
+++ b/arch/mips/include/asm/mach-ar7/spaces.h
@@ -17,9 +17,6 @@
 #define PAGE_OFFSET	_AC(0x94000000, UL)
 #define PHYS_OFFSET	_AC(0x14000000, UL)
 
-#define UNCAC_BASE	_AC(0xb4000000, UL)	/* 0xa0000000 + PHYS_OFFSET */
-#define IO_BASE		UNCAC_BASE
-
 #include <asm/mach-generic/spaces.h>
 
 #endif /* __ASM_AR7_SPACES_H */
diff --git a/arch/mips/include/asm/mach-pic32/spaces.h b/arch/mips/include/asm/mach-pic32/spaces.h
index 046a0a9aa8b3..a1b9783b76ea 100644
--- a/arch/mips/include/asm/mach-pic32/spaces.h
+++ b/arch/mips/include/asm/mach-pic32/spaces.h
@@ -16,7 +16,6 @@
 
 #ifdef CONFIG_PIC32MZDA
 #define PHYS_OFFSET	_AC(0x08000000, UL)
-#define UNCAC_BASE	_AC(0xa8000000, UL)
 #endif
 
 #include <asm/mach-generic/spaces.h>
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index ad461216b5a1..a051b82f8009 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -252,8 +252,8 @@ extern int __virt_addr_valid(const volatile void *kaddr);
 	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
 	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
-#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
+#define UNCAC_ADDR(addr)	(UNCAC_BASE + __pa(addr))
+#define CAC_ADDR(addr)		((unsigned long)__va((addr) - UNCAC_BASE))
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index 446fc8c92e1e..d31bc2f01208 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -576,7 +576,7 @@ static void *jazz_dma_alloc(struct device *dev, size_t size,
 
 	if (!(attrs & DMA_ATTR_NON_CONSISTENT)) {
 		dma_cache_wback_inv((unsigned long)ret, size);
-		ret = UNCAC_ADDR(ret);
+		ret = (void *)UNCAC_ADDR(ret);
 	}
 	return ret;
 }
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 25edf6d6b686..2aca1236af36 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -78,7 +78,7 @@ void *arch_dma_alloc(struct device *dev, size_t size,
 
 	if (!dev_is_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
 		dma_cache_wback_inv((unsigned long) ret, size);
-		ret = UNCAC_ADDR(ret);
+		ret = (void *)UNCAC_ADDR(ret);
 	}
 
 	return ret;
-- 
2.18.0

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2016 17:00:46 +0100 (CET)
Received: from mail-eopbgr00125.outbound.protection.outlook.com ([40.107.0.125]:21323
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992675AbcL3QAQgmeQE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Dec 2016 17:00:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QZ2EB1WlWxDUHXI/0XnmS5DF4UPuE3DLsHvMloKaeWA=;
 b=e8q0JHdhapo5nBXoEGxx1Xpc4USn5vjkrYF/Cy2NR4WOW9eM/n4GIwra8U2KRCMg+qGAPbudC6i7wOpYwMTqnXExUBZiNgt834nIewnaloqMVvkWmLzI7ODLz4nt3UpKo//FfHckJ4EqH7MemJe6oMyfDFExgUXTLAQrtwfb/mE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dsafonov@virtuozzo.com; 
Received: from dsafonov.sw.ru (195.214.232.6) by
 HE1PR0801MB1740.eurprd08.prod.outlook.com (10.168.150.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.803.11; Fri, 30 Dec 2016 16:00:08 +0000
From:   Dmitry Safonov <dsafonov@virtuozzo.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <0x7f454c46@gmail.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mips@linux-mips.org>, <linux-parisc@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <x86@kernel.org>
Subject: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
Date:   Fri, 30 Dec 2016 18:56:31 +0300
Message-ID: <20161230155634.8692-2-dsafonov@virtuozzo.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20161230155634.8692-1-dsafonov@virtuozzo.com>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR09CA0080.eurprd09.prod.outlook.com (10.174.49.152) To
 HE1PR0801MB1740.eurprd08.prod.outlook.com (10.168.150.7)
X-MS-Office365-Filtering-Correlation-Id: 4bb844ac-fa94-402f-6dbb-08d430ccef85
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:HE1PR0801MB1740;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;3:15HV4IBN8kU6HCrk18MTxgm6pa7+pDZKnzU9XV8y+CIj/DE4pw+s8+JJ8Xx2n/b0vVm7+pV4RPkHwmldn2AE4NkpIsTSt1JhjjCCrSaT/ZPPXh/FzvJV2YcTX1U7qxpH0v6OgD5/8DBE0HNbKuomFmY8+nbeRWeQiLamLt4qKLKDNsFeLv4+UK5DwqV6bl5VKF2IbTX2KVezh+iVKAg0UH1+TLYKgskVtqUNYC6zGxsL1khaVjX5CtlTMtSt+7tIxB9RkHaFIKGqF7nZE0wubw==;25:TnpJtdeXSt/mAQP04JzRkZLZ89RaRVmERdnL0TrNN56NISGFSE3o/MWITeGDWOmHdbBqDTsjg80A9bY4yq153uMe1nT1Yqx5z8RlWWDYJKe3HEu1kwNby9f935URG4CMXSVbk4Dots9l37AHTT1lug3nXWcaFRLG5jDn/xR2CO/WcNaCipd3JPvZnz43rJXor4h1QTDEw6GV4U0Fp0p4Hx02ujq8by/7yP6LTmkTQOfkEYK23GkXAcsTqEpgZ8nEfH4pdoEFY5I5PAsrNzArpaCbcJSjd8lDOw8ploSbNrmYiayH9ayop0wT+VkisxKMldud/YQAmSfENJ7YKhs1iyyT8DKJPg36BavBLkdcXFlMjpaBW1taGyJ6FoBl2hBQJmi8yJZ0TSStoY1u4B2tRtlf7ZzFaW2OWND91k635yEMulRjtrEAGhqrcA5OCRiRFvwfVvi6J/zcqZPiAhKAVg==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;31:XK8DqJL3TxCXqgiCaqNxvd5T/KFhSBJCgOEDBnZTVCfu2WP9ZGISgFS38135CzC3GF8pHAJMv9MolFhAFpxuhIUE522p6CMl1xcXphVXLJBJuoA2Wf6KlOgrZThs2itmLO5JFSP3vMcog31vn7gmbqdl++5j0ZAAA+/PiAY9Optdv5ZAqCp6XG51oWYOaLN/AiNDhsf1K/Re3rW/iOp7l93aKzYFObrvVnjSr5ArU5LtcvRgKcIBMS0JAu2EJMrKmFA+E9Gz1B8smMIkRkGtfw==;20:xq0fq0RuCNU0JdfmK7t35wW+i70s6+SYngUnXt5fps9dCG2KGDVVxbs23LJX6F0vXn64AOKtiPh6xI7EEnz+0YBENrseeSNr7930PGGyzzYK952n2o4ID14mDhl7GYjOxkTHIrzN1N4HsuQbb6bBGKnadVkOJc1JvuVrCYWRz9NEQRAzzOGJabHOMGb7HcKrwR1UEHQOARnyVPYR2lMml+MIvXK+b5yWtA0H+vOWrk0TAkUXRHvEEhwoLYBupjSy
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1740AEF21B5286B1DAB71981D16A0@HE1PR0801MB1740.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(26323138287068)(9452136761055)(65623756079841)(190383065149520)(258649278758335)(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123555025)(20161123560025)(20161123558021)(20161123564025)(20161123562025)(6072148);SRVR:HE1PR0801MB1740;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1740;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;4:188llFYAc3cBEAXalG6Hanb6PwvTO3vADJhFpMsoAIBIQWdpoAX7RM9VlStfL2jE5A7GaK12en0NNVsQAtci1DRn5kQ4W6JfqL7BJUmK2JEBIxWVk+yz/cpmMjZGZHdQjt6nCZM5XXH+kGJdpAVp6Wxx53pAPvAwJ0U/IirprMTbrXbYUVITG4FPxBdb3PxmmHnl4KrbkvHp1R8L6Hl1pN1gQd+NlFAuXRW6IF5FS51L4+5ac1j9UIUdtulVcA5Vhj8A1E+dZler+TaEo9stp2Uwlfx+dwdA/J2VInXLWGhym8gGtUJhYy/jt1EyS3L7fPuICaJoEnRl0ZvAN8mIzUPs9/lRXWxopYS29eNno3Da2XxaT6Kx8XE4fxSWbaUVLu29LciktXLAzd7fe9454qCO9LZnj9YyxNGpZSq6Kb/gGCJBoXcNcTICFeVJqBXF8+o1sHSc3ZcwJ7SiIAAKCc++jgg8dT+ofFiIhWrshEh156d9Ah1sX1Z5gVkXy8q8yVrr1LlFEhtnHfeb3FxIezYbx1swwQi9YJRtrR79EqicYU6T8LQ18ZG35COCGaTCSNukMrauxiHEK2n+A5sl5GTV1vNUeSun4/pAgIByXkuHlBrZkeZaw9ucRiS19rYV2cxGMg+OiZl5C1OKDxVD+kXDob0YoVuQsVAaTAuRJhNEtKsAIWSBDfeIXmaEqOa4vLQQnlwlVRuJ6a3/z+VYjr7+ZBKKgo5ZlZhtFZcGVxP57A3oqyC4eQ6IYL5G+Ymy8xvcuJDE4/UBjBJHa5ekmvYcQo9A5KsDmWRUSXFZpbaoSNHfS2wfsUCLnMtCFujoOCuJTLkKDh8UvDAR+2linEEA87KDXdqLPc9zUrV+1Z0=
X-Forefront-PRVS: 0172F0EF77
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(979002)(6009001)(7916002)(39450400003)(199003)(189002)(36756003)(81156014)(8666007)(50226002)(2950100002)(6666003)(6916009)(110136003)(5003940100001)(69596002)(66066001)(6512006)(81166006)(101416001)(68736007)(8676002)(47776003)(25786008)(76176999)(86362001)(50986999)(106356001)(33646002)(92566002)(6486002)(5660300001)(2351001)(189998001)(53416004)(38730400001)(42186005)(105586002)(305945005)(1076002)(6116002)(97736004)(3846002)(39060400001)(7416002)(2906002)(48376002)(7736002)(50466002)(4326007)(6506006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1740;H:dsafonov.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1740;23:FxpyZb/oyLiME23Q9XYsHTEakCRLLVICe1z1HwR?=
 =?us-ascii?Q?6l/tii0WrZeljAxeKcrF6YXTvv+g8YHIFoGuG58gBTgBY9K/RNeB/lGGkt2m?=
 =?us-ascii?Q?WfFfkVKDaBXEsqsh0Pmtm8bJUkp7hPulF6VRDqCPhbMN0q6780NpJ80otBdh?=
 =?us-ascii?Q?koaJiW3C6YWNUlH87x2Z30eNoSFcau3h6m5/JN+jIAj9D5OIurifYrEfJva6?=
 =?us-ascii?Q?MsiFIW5HVKW2FPbmQe65BtWJ5kgm7DY7vIMcP48W+gyTOGDWwmsZVEeCKKVU?=
 =?us-ascii?Q?tVosuSylfs9qFuUQum4hkxO+63ezftFSXEdwGxL9TvUoFqwUDPKWHBIUlgXq?=
 =?us-ascii?Q?r1kJ9Kls0kCfuj+rJ8VqN6dQELlTiTA1bOVGN0od0Rn3i/BUEfy8WttzTb8X?=
 =?us-ascii?Q?eigqEksvCjCUoiUbE4uz4EoHhQNhw+H/gM52bJf+MHLfD5WSkjdcvzLlLypN?=
 =?us-ascii?Q?+49qyjKbTmkqBaUVT6+Tz81MKqxmzM3lcm6CgMhmaep7XQU399YFsyUwW2er?=
 =?us-ascii?Q?jaTUA2OqtSb+vNZ5u4BPn3Pm+P072Ra5jMuD+NGsiWmXc2SkDDghPIh9i+oU?=
 =?us-ascii?Q?lFS921/sU+tzUDEySsEFQkGcTPb7aT1+/SuKkZsPqIdEKd1npr4WxpMexzSl?=
 =?us-ascii?Q?VwXocKYpY0QFBLh1vkqssUjpi1Tdf1KnYnMcfejllM6Cnr4LcB1Y1UpsPAUb?=
 =?us-ascii?Q?IsR2DO8QIIvqj4EQKVnpgfaonUMKDIWz3Ep+yoO17kP+8BWLMxFKjk9aLZ0z?=
 =?us-ascii?Q?KoEC7apwlrLAuLBflTDywpv7yORiLphuy9QQ207ByxYXN/Pc0Ej3d/vFrs7q?=
 =?us-ascii?Q?TP26RhgF/r1TEvA4B4gEQFyoMlWnnHQi/okmINT4hawJUXTMkQU99yyJEFRo?=
 =?us-ascii?Q?4QgykeucecBmeQz5FWCGGoqkz/3DE8+ooZSC7ztl8v88xTm/VbhStZoAVC5x?=
 =?us-ascii?Q?HGpFQc//z/vyqjicWbiB5Hs9o7iV+tEVGciR3ldIcC/Rfpc2dLta5hqEOmAv?=
 =?us-ascii?Q?RvvJrcrVwKQXceCikG4cKfqk1baugTOoA0rhd4kw3e0wiClidpeyYdyHH+l0?=
 =?us-ascii?Q?u1yKBWuAsrpX3NxV5Z0FO9jAATHsEZxuXwk/jGaE2MJJK/P6An96mNyivODD?=
 =?us-ascii?Q?Gmv/UVwZsJEIy0v02uzlG6MTdQ7fWnbbXD6/fmY0AEI93U4yyAYqEPtmHHhj?=
 =?us-ascii?Q?wRL9Y9v1klZyG2rFxSHIEYJSdTf9zNV/4Q4Zp+1Dy0xOFgEkzt1giHLKrk13?=
 =?us-ascii?Q?30+1fD2wSIs7BgsnaCw7OYQKk3VhV+p8G3v72l4V5eZrTQNM6vgdg+IJKLRo?=
 =?us-ascii?Q?/rfwvbezoZmcvsWlOfdYWjB0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;6:QoEEE2234WjUs5DEwJ0GXXrvnt3r2oVLSGLKNWcTo9Of21otuEUHx9RhX5t0KfVn6Sr8/Mcf7O/hO8xjg7Ksz1ltAk19saa3E3kUd4n0idBnZq5XP3on7YBxiVbEfhkSQ1oW2z9jAJAle+0pHTeBn970rRTAEgLJrBw2nbGS53moI/1TsIcfRD36yUtU80GC1fed8pTbZdfa056fyzRlf+pD3L513AxgHWG47Rcbtn9o+j10b5TJygyOv4FN6U5xGx8KFzAYYN1LSssfSU0o1VlroBRkHp6uFSxedOAZnkvcw1Ac21eh0obohLYIjs8zOVtvSOpcbyTcnhzVvsV8xrQ7Uq0OJqiRFtHdHq3nBYJ0SY2QOeQvRYG7s4jZDBcdAlkQNd8N51yWFwWMbRbb3bEX+/vDjPWS/HpYfWpglSU=;5:53qoslIS264I0l3mWK0OnTAfoG9WdbDncYAwAxTWdjwBOoOZ2noJr3Qhht3RpF7ynHJmBhQuFOwmOzkVMIdBvdIcxa53jVBouEspE3+A155jHBq/+j+OKyCZNv72GM1EQV+u/8IJzpjJFuwtiQMqBQ==;24:LvSDWv73mXXMV0vuW5/vaHOano2Jnxl4YDe8064+ceAqXvzglBtlEJpc3OC1jAIKet/CHydDOAXnqqveCFzuDUc3tpvvasoj0JiyIm0LwRc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;7:svpher4DrZeDeNwTc0rwshbo+plJmvk/brYkmPvBbjsjLKoFaHGOGjkMHHunwr2voHD8VdYAKOnXtzdLqz9vS4rXMSK9fcqKnuyqoWKMI25vOrGasJ8WFG94xbIygGpcpGU3CWr8JeEuysPpWfKuO5ONeXf0Ne2W0JeoATEjYehZXknJI5sd3bz07irkX5ahvfsdWyAqW3lNDzaoiCXiHWpXYYp6K2e9g+hrIrCLzZmSTZa4AMnapfEspseoBgxiuzOkj9IQKsEjVdMuglpzMsPtJdZHPfCt27o+1Xeid7xfaTyoHjwYntldzKZ/QRvbX+nRXaaatNjTFPkHY6OdT4JzhZhqhQmPHp0IgkgUWh55Lx+f6U3vpAimyNSyJYL2fSP+1Ou2wn/wKINYHA+oB46qCb5Y4f83P9WARJDauR/GPWOqLFYrJUIfdy6PfKlcH/50XW+e6llsiWheBDfR1A==;20:5cmJVEyTSMuc0MA7HWf330a1Kdf7GDa5MBjjZT5KCr1R+LHftHQdC5rezxd5Tn5TtmPE1//S/Ukf+WR7jF81G5nsbLOtGCAi6XZeWhbV35fBSdAPRiP0M+U2dZzZCAl28Wh3SYjmLjNrDe6Acm9Rnkr0P9MCdSU7M21ahhE92TI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2016 16:00:08.9080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1740
Return-Path: <dsafonov@virtuozzo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsafonov@virtuozzo.com
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

All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
TASK_SIZE_MAX since:
commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
FSBASE/GSBASE upper limits"),
commit a06db751c321 ("pagemap: check permissions and capabilities at
open time"),

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 arch/arm64/include/asm/memory.h       | 2 --
 arch/mips/include/asm/processor.h     | 3 ---
 arch/parisc/include/asm/processor.h   | 3 +--
 arch/powerpc/include/asm/processor.h  | 3 +--
 arch/s390/include/asm/processor.h     | 3 +--
 arch/sparc/include/asm/processor_64.h | 3 ---
 arch/x86/include/asm/processor.h      | 2 --
 include/linux/sched.h                 | 4 ----
 8 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index bfe632808d77..329bb4fd543c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -80,8 +80,6 @@
 #define TASK_SIZE_32		UL(0x100000000)
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-				TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64
 #endif /* CONFIG_COMPAT */
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 95b8c471f572..c2827a5507d4 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -73,9 +73,6 @@ extern unsigned int vced_count, vcei_count;
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
 #define STACK_TOP_MAX	TASK_SIZE64
 
-#define TASK_SIZE_OF(tsk)						\
-	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-
 #define TASK_IS_32BIT_ADDR test_thread_flag(TIF_32BIT_ADDR)
 
 #endif
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index a3661ee6b060..8b51ddae8e4a 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -32,8 +32,7 @@
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
-#define TASK_SIZE_OF(tsk)       ((tsk)->thread.task_size)
-#define TASK_SIZE	        TASK_SIZE_OF(current)
+#define TASK_SIZE	        (current->thread.task_size)
 #define TASK_UNMAPPED_BASE      (current->thread.map_base)
 
 #define DEFAULT_TASK_SIZE32	(0xFFF00000UL)
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1ba814436c73..04e575ead590 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -111,9 +111,8 @@ void release_thread(struct task_struct *);
  */
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
 
-#define TASK_SIZE_OF(tsk) (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
+#define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
 		TASK_SIZE_USER32 : TASK_SIZE_USER64)
-#define TASK_SIZE	  TASK_SIZE_OF(current)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 6bca916a5ba0..c53e8e2a51ac 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -89,10 +89,9 @@ extern void execve_tail(void);
  * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
  */
 
-#define TASK_SIZE_OF(tsk)	((tsk)->mm->context.asce_limit)
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
 					(1UL << 30) : (1UL << 41))
-#define TASK_SIZE		TASK_SIZE_OF(current)
+#define TASK_SIZE		(current->mm->context.asce_limit)
 #define TASK_MAX_SIZE		(1UL << 53)
 
 #define STACK_TOP		(1UL << (test_thread_flag(TIF_31BIT) ? 31:42))
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 6448cfc8292f..6ce1a75d7a24 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -36,9 +36,6 @@
 #define VPTE_SIZE	(1 << (VA_BITS - PAGE_SHIFT + 3))
 #endif
 
-#define TASK_SIZE_OF(tsk) \
-	(test_tsk_thread_flag(tsk,TIF_32BIT) ? \
-	 (1UL << 32UL) : ((unsigned long)-VPTE_SIZE))
 #define TASK_SIZE \
 	(test_thread_flag(TIF_32BIT) ? \
 	 (1UL << 32UL) : ((unsigned long)-VPTE_SIZE))
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index eaf100508c36..090a860b792a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -819,8 +819,6 @@ static inline void spin_lock_prefetch(const void *x)
 
 #define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
 					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
-#define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
-					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
 
 #define STACK_TOP		TASK_SIZE
 #define STACK_TOP_MAX		TASK_SIZE_MAX
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4d1905245c7a..7a2e2f3f38a3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3610,10 +3610,6 @@ static inline void inc_syscw(struct task_struct *tsk)
 }
 #endif
 
-#ifndef TASK_SIZE_OF
-#define TASK_SIZE_OF(tsk)	TASK_SIZE
-#endif
-
 #ifdef CONFIG_MEMCG
 extern void mm_update_next_owner(struct mm_struct *mm);
 #else
-- 
2.11.0

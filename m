Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2016 17:00:23 +0100 (CET)
Received: from mail-eopbgr00125.outbound.protection.outlook.com ([40.107.0.125]:21323
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992571AbcL3QAQNmD0E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Dec 2016 17:00:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HWPViX+t05Vm6BIJdsqkv+l5+UwRcQiJirTQMjzZM4s=;
 b=JXVCAeBaT0nqSugGVLVXq+qBGLnB5cebKW2XXd/GOxujMId4Gb26E9qgA/szHSrupjtmbF2Rr7hC2M3P6FbdOFHmS9hohUbFYJmaZPbhyhXUYolTYZ2zj150NV+jqCzeubT7fjvKE9jRZEle0HAtmsisCaQnmGzcn3P93RHUyNs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dsafonov@virtuozzo.com; 
Received: from dsafonov.sw.ru (195.214.232.6) by
 HE1PR0801MB1740.eurprd08.prod.outlook.com (10.168.150.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.803.11; Fri, 30 Dec 2016 16:00:03 +0000
From:   Dmitry Safonov <dsafonov@virtuozzo.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <0x7f454c46@gmail.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
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
        <sparclinux@vger.kernel.org>
Subject: [RFC 0/4] x86: keep TASK_SIZE in sync with mm->task_size
Date:   Fri, 30 Dec 2016 18:56:30 +0300
Message-ID: <20161230155634.8692-1-dsafonov@virtuozzo.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR09CA0080.eurprd09.prod.outlook.com (10.174.49.152) To
 HE1PR0801MB1740.eurprd08.prod.outlook.com (10.168.150.7)
X-MS-Office365-Filtering-Correlation-Id: 36b4d980-e4ef-474b-5599-08d430ccec29
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:HE1PR0801MB1740;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;3:Mr3/Xv6YseeV2+sUry0pTt6kzsdzQqepN7rOuebXTxxgMlyOL1B7HrlkwXR94lpMXua7ks3xabM5ZRZtIaH/sIwIODxKTo4KiMQThpZWl0oTCanfowvML7pAKJ8GnZ/tr8XSIkz/OoPxCsdS1qAdev8JyRVclYOvlKaKxZl2FVxFffxz8113myf44fa2Y5utg8lvZgVUWxxeSYiRhiZ4rXgvFyh0zniVmtUnqzpz776ImQfOkilAlRD6uki5RKISbCoTNu5JrQY71cHL3r5hAA==;25:YWwMCYr0J99tZ847Zh6rJqn3fu60jaSoirg7FlSEsla4vZo1LhFhJAfXqfMBAxi1ajcwX6kqy/6AcUWWtjx8MrpiHFNrgSYAzmrRnh01rfCYVho0BNxw5oms+8dsR1Wp0iT43rNuEPDDnxUCbBXUKuW4bPLV0XXenzOvw+Mlk+7p+QpVhtNqQwFOCIibkc2uyEn2umax0AmBp5YWlPuTMntlnCZGXoA7zhv+QoCBmBK9T84CDfMzfQKy/Jk1vSMlkPTEvL0A1a7aCfsn6+2at+iEq9uZTSF0EWWJ2qwEH/1qOIgPzXO/m2bx0y9imZT/UtFZwax/eM1dcY7ME9wrGvRv4tF4+Nb9tzD7oRC3/TzlXJDfW6/V6eeVHD7X2qM6HWm9/1Q89w4VSpn7NEV92VN6rFJ+LouiXhdY3ivrTq9oYCy1Z4upj5hqax8MXn/mTL/bIFbwQFk2S9vmGdJi9A==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;31:thztHeEddlSslWxmDauUKBFL5Ylq8Szh7iw2yots7DEwBrKQ8LgDs7guwGzQ38EPeS52CYy0Srg1TiVJyLsP9R6hxMp74cJeGqdDNIFoSe9YSOD6L3EMoD65S0BJ8qESvBzUinq0mfL/yHMXIdZh6lOQJLtYHdMfN0wBqy3P9oqKfs46amFu5+RQGyMH57mPaoBldVBnjkT6YDwxo1RhRle2q4TrsFZ51aIFPd7U6aR7x6D0yEWBftnoFvPAHc/SUxAvHZNFUf0NJRNpnybwug==;20:+aV0kDzTV7CeY51upEl0jaYcWybjidIMW1cgl4o6KXHiqTdvyyTT3WNla+RrsjU8zjCUz9V5NA0hMpWlaaVRYwB+VdjvX2f7JNVEc+1Itf1giks+TqyYQdGLZmlsmUejqcrWBVdV/W8h1/mUO0+/qfZzqowF2BRAHd+AszypXWyyzTWGnw454PDSjJnTe321+zsgnJ3qV/Sr5RWK/2i6HuTm9GoqIXqSmo81BAYteyldMfTHrqebacurBgrebFZM
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1740C39DFCA58F0AD0DD9A25D16A0@HE1PR0801MB1740.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123555025)(20161123560025)(20161123558021)(20161123564025)(20161123562025)(6072148);SRVR:HE1PR0801MB1740;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1740;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;4:G+Ym1O92fu7iMb/RJvyNdnKNrRItp2EBAQMxaQibR+HtsT5RrQ9mGPVcLV9oWlfdvOYb4zqxa4f0aA3NA1+j1Ork5zHx8lD7maT/Qbe5aJF1IoWntRw0mt6pwX3KnD3rNXxsbHGYI/QYdrkYr8qrwMI0zGWgefUOBjHGFR148F3E3xBX4oC6t3Hqws7+r+V52iTZofeYisPlgg189avmQHu9SOX6Q3q+wouauj4maP8VEdVkhO0OKZCSsaQ8PnWxvsFf/5hw+s01pEO5d9CNq+XDWxIZheUIkkkn1gKHcYJ9uUS+fNEqbnuyqV+C7kP1IqVR8COi24FaO/7ztoQ3VUYGFFzxT7VGUbrt8xb145/01ADQRcSTykR4s9XJRI+R1zBUNl7LezDqGPZB6O4fLBToxeXcR35uH12cshZ7sVwB0x3EiEA92zZ8JXuLo0yqQBJsMuDGcVrG/jFdbDTBRaLz33RRuBYQWLY44h2Fzg7nTI9SiRF9rUF0ytC+LChhAEjKm/rPv2sU8cxEodSan8zFh83TC8EKETDoOfMN7fl+CGEK6fTxiyBRX/F66aWaBDipvYE4lD+6Mhc/sz0SNMrKDd/D9G/KxDAASu+SUHK7V4QtM+/JyqoN3QRYf2VDr85yeArERKK2J3pgmw4HuA==
X-Forefront-PRVS: 0172F0EF77
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(39450400003)(199003)(189002)(36756003)(81156014)(8666007)(50226002)(6666003)(6916009)(110136003)(5003940100001)(69596002)(66066001)(6512006)(81166006)(101416001)(68736007)(8676002)(47776003)(25786008)(86362001)(50986999)(106356001)(33646002)(92566002)(6486002)(5660300001)(2351001)(189998001)(53416004)(38730400001)(42186005)(105586002)(305945005)(1076002)(6116002)(97736004)(3846002)(39060400001)(7416002)(2906002)(48376002)(7736002)(50466002)(4326007)(6506006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1740;H:dsafonov.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1740;23:dhQeEb+xm8W/qcsKlpEZJv01CG3GOKFjdMps0jW?=
 =?us-ascii?Q?VuyoA7qDK5AB/+Yj2gyhDY0R5yYIyJy2vaMtBgi2H2lxwitNF/4NIGIHVozv?=
 =?us-ascii?Q?ZSgoOFHkk0p0WXl5qFNM2IkjGTT+egz021ToXjEJ0IX8JWtiB6KSJUL7kguR?=
 =?us-ascii?Q?5PxX/byEc9S8SGyeWGO6OX6rE+Bd/Uqcu76fsl8ueCdHgZCtzuC+8JWFLBDi?=
 =?us-ascii?Q?N/KRTxqmC45g9kafdNU7jEqBNDGSVPijxx0WwzdhXyRdZR2+IvnDTmM8ALZB?=
 =?us-ascii?Q?dTJFcHRwFF72rh36P1XWMkJofJeu2dJsA5hfjevh8M4CXdZYtLRYSMymBjPE?=
 =?us-ascii?Q?SOzWmedkkgmN+TLCddPuHeVlKaRLnFTviw3skebqZzT/MPaGULom5X4MU63m?=
 =?us-ascii?Q?Gq2Tp3sJVn9XInSNuHw3sBG/Iy77q6tDMXnspv8iR4lw9qIZptQhLvwM0wYR?=
 =?us-ascii?Q?SGMJiatnfpfkOLXME609f4+bNpZWeD3IcV3NmpHsdgAQQ1qMartfxium03ho?=
 =?us-ascii?Q?3CAOrTEaW5nFNX9OuHbo/YE32G263lIhbFlFiAtE9NLHjmvutHzl1o0w/ByE?=
 =?us-ascii?Q?vNJGKS7UJyqqapS5C+1brHEbpkHFAf5aV6qGm195yGshFCWv+Qm4GOQz4W3X?=
 =?us-ascii?Q?WumpKIrOVrsDEGcGdHuzXivuB06N5SSMzyEhXeHSB+gpsTXYs/mapl4VtO+K?=
 =?us-ascii?Q?R0u/wUTJM0O/f7oprOR5YnCnfempgG3Ob96N6lNyniGqDZmn1pI6piUDilZ7?=
 =?us-ascii?Q?wQYrctcPAQgxeBpVGmJ0tT9FXo8f0C04agnFuIZHDK0113SOOO77YrNC1MJ3?=
 =?us-ascii?Q?fuGcO8yCgkxLCE1dUYhtjAkWW9BnEBu7jtzPCHO53iiRlLvCm6MjQQVgXnAp?=
 =?us-ascii?Q?+RCeT/PXmRt1L+YeCvqyWJgjjn0yuxW7mZ0JAjnge0XgXlPdV+KCVyTbix63?=
 =?us-ascii?Q?tLX97cYLe+3g3NU8Q1GyjVSmyUkqaY6s3wUixaYAMAgfyIe7naAdxZcTtdjX?=
 =?us-ascii?Q?0ANgm2xNr1crtSx+WTkDqW+CdQCv13mdz3aPQEZZ1oyyzvCgbH87izrTvFgv?=
 =?us-ascii?Q?muxBNeM/UNsw8U/NJeP/0LJ+2Sx9A+uKfhHD/oH//TswOMhEjhdC7ZRnHDW9?=
 =?us-ascii?Q?uBamPtxOPJofQQ/dKQPr7wQhjj1lEyX0+FREZETwxFObkC+RbSQoWkHLHPpK?=
 =?us-ascii?Q?ZUf6CYEj5xd85ZlQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;6:m8p0mglPGReR88h3H2PuE/0Mm286Ol0XZx5wMaDH2i5WwFF5ijR8XqnqTz2bTi46PK10Ap7DQVEqHJj+ELZA2FHi2VdP1j8qmtMu4BCbBL+FUbU+WEt99Mq16BOBy1nQyeIj7RX5x/0RHIt5kkDp9bWtFZVvxlKgWD1j31Xmcch78GJTKuS/BeUeEZS9Mikt2D64fPUWyWtfx9B7WYesBu9IlBNuNWe/GtDldxujFjjRYMnwvX2U76iCFiPxUSQUKd8ThA1h9CQiHNl+YvzqAvH6XhBLbRSqWkokUEK971XhNv7A4Xax/3wJp6ZXLysV31KV7ckKQLaPzYNTEltB3fkyvE7XL2FXu0I3SvH3+auX8dq//vAuXMnBFAjegatuSuAN9CLImvO89zC96u8Ew4PL4tz/jp6HMSoqkzd8Uco=;5:gLvWLTqigHpACGNM9grgQeaoNVDBFotZLMsVhKBevmzX6FuS6Wi1vpDJ0JnbtEdnn6gwIZT2NDWphdoNUP7wDAAC2xcrRitdN9DXqAVTr+pHJ9wjZlAanpCDPHqpxWCOlswvLSjbixDhrSzOGqSlvw==;24:sYCC157suwMhiTK7b7Ia9JTgM1WD5oPWrCDwDa6kqDEYmIKUQGgLHoGFQozK7JYKtv8RMdZvONS6jozeFyA5uddOG50KhYH6TUD7hsqzUEY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1740;7:v4NojDFWWyBPfuWOir6DSTd7HInm1U8ga+QvWY1UhY2bXOeKdukP4MAaAT82uk+vjp+FTVPSptx9ElBvNhp04FJfjj7rKwKyZO+NP4TxZ6Ow5JVfEsJ7ufV5o+6ZcKT4RJUKY/q/CIKjn53Jq9Z1mnreX50Bj5G5H0vXbPXrpo2cfVs3ReqtMb409/TaoTaMeA3Xj8Xjj1Cqlxu6X/cKZa9w3po7XhnqwjM5IP7L3vwwGhUbgJEwthqeplXPNKATefT6yvrMlbtQNigBI7oyWpCYNTPNZsg1Qo1+05hWEoepgFfeY439ojxStXgpXSlorvl0ZPgh3FCYPdsouYkhqJH/v2vUI2N7YvtwK58OQiIcabKK1J3DqMXsf3AB3p4GdR2IgAKXaWuuj8XqhL/UfWx/ZYOIxb1YYH56cwSLzr+B8Eb8rL/G/ZsgN7u7FucKIKb27Ru46nVtjKyQOmWBGQ==;20:DO6ATmrfePIIByG9kGt1Gy+qTiR2WGoS0CxvaNoRgVNQFAjnSL+zrhUxb9NFvZdGgXSuydpaKPe+48UlJ+yrai2nA4H3gD7R8Y/Wm/QzbY7+dkUGUA1tnczpzlY3knxwrEwRgg6YvS0YX8qWTpb9ZQs8CNot9gE+oAsJJnK1qOU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2016 16:00:03.2703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1740
Return-Path: <dsafonov@virtuozzo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56135
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

At this moment, we have following task_size-related things:
- TASK_SIZE_OF() macro, which is unused;
- current->mm->task_size which is used in half and TASK_SIZE() macro
  which is used in the other half of code
- TIF_ADDR32, which is used to detect 32-bit address space and is
  x86-specific, where some other arches misused TIF_32BIT
- personality ADDR_LIMIT_32BIT, which is used on arm/alpha
- ADDR_LIMIT_3GB, which is x86-specific and can be used to change
  running task's TASK_SIZE 3GB <-> 4GB

This patches set removes unused definition of TASK_SIZE_OF (1),
defines TASK_SIZE macro as current->mm->task_size (3).
I would suggest define TASK_SIZE this way in generic version,
but currently I test it only on x86.
It also frees thread info flag (2) and adds arch_prctl()
on x86_64 to get/set current virtual address space size - as
it's needed by now only for CRIU, hide it under CHECKPOINT_RESTORE
config.
Hope those patches will help to clean task_size-related code
at least a bit (and helps me to restore vaddr limits).

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org

Dmitry Safonov (4):
  mm: remove unused TASK_SIZE_OF()
  x86/thread_info: kill TIF_ADDR32 in favour of ADDR_LIMIT_32BIT
  x86/mm: define TASK_SIZE as current->mm->task_size
  x86/arch_prctl: add ARCH_{GET,SET}_TASK_SIZE

 arch/arm64/include/asm/memory.h       |  2 --
 arch/mips/include/asm/processor.h     |  3 ---
 arch/parisc/include/asm/processor.h   |  3 +--
 arch/powerpc/include/asm/processor.h  |  3 +--
 arch/s390/include/asm/processor.h     |  3 +--
 arch/sparc/include/asm/processor_64.h |  3 ---
 arch/x86/include/asm/elf.h            |  7 +++++--
 arch/x86/include/asm/processor.h      | 19 +++++++++----------
 arch/x86/include/asm/thread_info.h    |  4 +---
 arch/x86/include/uapi/asm/prctl.h     |  3 +++
 arch/x86/kernel/process_64.c          | 17 +++++++++++++++--
 arch/x86/kernel/sys_x86_64.c          |  4 ++--
 arch/x86/um/asm/segment.h             |  2 +-
 arch/x86/xen/mmu.c                    |  4 ++--
 fs/exec.c                             | 17 +++++++++++------
 include/linux/sched.h                 |  4 ----
 16 files changed, 52 insertions(+), 46 deletions(-)

-- 
2.11.0

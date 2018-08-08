Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 00:57:44 +0200 (CEST)
Received: from mail-cys01nam02on0099.outbound.protection.outlook.com ([104.47.37.99]:29872
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994748AbeHHW5LodssA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 00:57:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj4XleqmCfHQnSR8GmP25xnQrkU2huHzMdkjNNc6CGk=;
 b=WCMFyXSsGVljA3UWMHpHdOfHNpzawLwS5wB96KeBs5U4XWaLn3ei8VdEurljfAbn+OfKbUhF47Dkov8rNMpt1GKsNviCvLEq5BD2dlbB9I+KhRCbc7JMXlDvI9Ra14uNUyS8xRW89tS5XrFwEOfwRAJn/fanAf43tso03l3XBig=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 22:56:56 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 3/4] compiler.h: Allow arch-specific overrides
Date:   Wed,  8 Aug 2018 15:52:24 -0700
Message-Id: <20180808225225.24450-4-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808225225.24450-1-paul.burton@mips.com>
References: <20180808225225.24450-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0004.namprd20.prod.outlook.com
 (2603:10b6:301:15::14) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8788d91b-d64c-4cbb-5ec7-08d5fd823e52
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:+CnIFTps17GCI74y4aVi0LJe/gzcAgwfHR5V3LuudXsJYVytbngfMPx8CkP24mWj3aYh7AK8HtfFrmsdyTRSQ4GTaB/pBhBslxFFPDzrbomnj03sUiNbzVMRU2FQ2M8F7BDWD/dgpgx9PhJGPrTFhW0OyqAltgyn7lpZg2tDvH75XQKrIqSNZDgyhMs+0OO54dtcDLSWkKItxMWvkzRGO72mkCefV8bCtpRQb4zcgPYLGuD/V00wlu2hZgUfZLpf;25:aJhVr0p090V2PAL1PyIq4iLjk0XUbGY5Gxf3drwkrTvSZ+lgef18No6JoLQ26SZUf4QVgqez279vML8PYN87FdYVGKbNK4g4aFDT5/DSwPrqFodeI6j4QGjygYtk/YNknJ2/bDz1HUUKlmjxBql/RBQP4+idX5AWCDaWdJ0mzmlpAfh/6DT9MfAN1Ij5hP5mTR6AC1CjzMiJ1hpnuZbjLgSl5ZLYFezGolC6IS4hy9B8bZec0+HBQUFcAkAR0/avqj494aRFd+knf3NInFGWIBTQ9G514lsO1dybmJQoODdIauyP9qJs3Y2c9y2NT5D2jIa0cvUta0jzox7ZGlJg0A==;31:m4/WO8ySxFeVOjJ7/DrHYoI3w1eXlmOtaVgukX8ppqkwVhtOZcSqhIc89QAgxNzozLoPM3PU0d37N94mMXKXKZemK3XgxVIqWlUbertm9w4u/0HXq90ib3/5BKYCvA8mRnw7Iz1rJjuu4AtHDnwN8XytlFVGQU39eeQoc0uYh7tNITIxZ/+kfa7+eK6Yjr/BYAumJ3O3Dzevqgs8ClPWvo2VpyIf+s9gJbURFvDPHnk=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:WnboJ+X9Fd68V3HVhwH3dT71XtJsGu1v/nHptwog3rbl0gVnaAi4/VUL4/gkRo58ZeXUMeYMNZ++FNdA4FzJv4Xa0YJALoxi5BpBpHlcPEuwhuEy0RlztFnAhpIkCYu3qgFA2rfWH+g/ITst4Hn7I35DWw9Y9IAg3U7u0Ct+GsJgsnKRClOZPTpXeNlPknD3TyQ6WOX6asFhhe84Jksr4FOJy735X/2NOsf1HO7KwiTSoddLbNmfQ/yHlpI5r0iN;4:6N9JSCBt5bBYl7GqAdO+cWqVNuEVtiu2Hgo/+fKXm7LQLGD0dkF8b+o9qk3q++EVf90X37I7cLoCEPRYnB/FeEtd87XkW9W3pES8V7bkKZu3MHcuIyop0x2T2qaai4szNqhOdiDHw6BELR21d/31tvBVo5J4HEo3H4eu33ObDtAlVrUY4qAwu/lUYQINJKHj2WqVBcOqpHHmjM4wwrK/7ElOekFiYXVk2C2V/5hK+zXuMcWs0jY7aUZXjgNe8gnuai84+BM0CgB/bNYFwQpizwHd2mc2f660NDkU5GRatiRv1hLUeXZUxqVeyGcjBsMF
X-Microsoft-Antispam-PRVS: <SN6PR08MB4942D04829624DD1D4380BD1C1260@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(346002)(136003)(366004)(199004)(189003)(6486002)(575784001)(25786009)(44832011)(66066001)(47776003)(42882007)(476003)(2616005)(16586007)(446003)(11346002)(53936002)(107886003)(956004)(486006)(39060400002)(316002)(6512007)(54906003)(2906002)(4326008)(386003)(1076002)(69596002)(3846002)(305945005)(6116002)(36756003)(2361001)(478600001)(50466002)(7416002)(48376002)(97736004)(7736002)(76176011)(186003)(16526019)(2351001)(8936002)(6506007)(50226002)(53416004)(8676002)(106356001)(68736007)(51416003)(81156014)(81166006)(6916009)(105586002)(26005)(52116002)(6666003)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:TxyTQt7yj5LMhLExBcEqMLKQ4aj4L5e0rUJduRJTw?=
 =?us-ascii?Q?oU39BgMBOsUh1R/ImCwi7Pb+XsPvp3ZYcDJwuRyiXq/imdisLRFadQFtTN8z?=
 =?us-ascii?Q?/1sB3qPf0WBiL5YtpWdNPajbXwb0wrYD0//VEFlj8zxsvF6awhaoZ0U0bj2b?=
 =?us-ascii?Q?OHga9oo1JQOMpqqhgjiGOOrYvr+mbSRkL5uaKCrRvsd1ZUGtclXKensWkigd?=
 =?us-ascii?Q?aMkI9aTafVWp1EiDxXK6QkxMQ+LRThCaEnqCcb6redX3wmETUskLWI1SnS66?=
 =?us-ascii?Q?mAwl8Yt5RrQKNB847t1FYs3bPP9dHKEtGUM/qhTj6K25VJctLb8tnRffIO67?=
 =?us-ascii?Q?elNz+UsKoOfwl9f3fHve9D3ooWmgcR913IAvbL2Et+Cwju8AZDbCe9bB99eM?=
 =?us-ascii?Q?YnRDrVjo1mExPqZNmq1W4zQkDPVBxlFNTRdj6KrokuoPB/agHPaCk8A3yH2P?=
 =?us-ascii?Q?3+WHX47qplgrOhzRWIPFulP6A3G2YQzAHmFurPqnAvTrB9ih83D5nPFuxZAf?=
 =?us-ascii?Q?Ea4gxDMeEBRrvvVmvNDkOWWhXdSSgrjbcZxbEBGFSTb2y+JBgGSF0vJeY6mH?=
 =?us-ascii?Q?5rN5DLiLr4dqGZLSrzuJBn10fugELl6x4PzWda12KnmCbPYN1kljvybjdnck?=
 =?us-ascii?Q?aKdUqbDYwj5k15CpBS5jJu/K75F3bzKhYg9JVnKbg22p6CxhdUVzA7IjjLY3?=
 =?us-ascii?Q?V44TpuBqBkHk+gzC9oFjEL3tvKFTQHLrKjFbGv3NU91D2lKJqg2ZV1sSEt6m?=
 =?us-ascii?Q?LK59yda+9fQfgc5zfjXFKKuC3g3gjhPnJ5Ea4cmLyMMbAsO13n8gz0wIEirp?=
 =?us-ascii?Q?WYh/0Vv51kbW3jzTGp1F/eYja8hxWq9TG/ZB1m8zG48nvp3GCAcoc4mGxQMB?=
 =?us-ascii?Q?U9rp9XXNDk6/UcyMjlDknDeE8ch6mVnQXN0jR23U6Lb4Umt1H56+T+wFjiOt?=
 =?us-ascii?Q?bySxKGWIFfaap+vgYxfG4xbiO/V8575AH46GdP47v+5mXCw4ymBcT+oa4/ST?=
 =?us-ascii?Q?y6TIoFNNhMWiOF8QZHJeQVqA9py2Z8GHI9EJ662n7Z/fAO7aTEFIlMMuhLeO?=
 =?us-ascii?Q?IKN6Eaw5/fQ8geQL+pdbHv+HhZwZ83uvKyNODemC1Rua8n/ZiwcbIj0Ghsjo?=
 =?us-ascii?Q?h4EXyI6OCU72r25Om8SqeBMx3GTyFqgxaBhS/vJ1wja4T1+fDQEyGTEFqDxa?=
 =?us-ascii?Q?OoKD5x0Ig1V7sh7aSlvkaQhNsqOafcJbc22cwkrJhVEs+4+TrKiJWtXJLTHV?=
 =?us-ascii?Q?dmd5zesbjO+poRkbNUzfzBPXLhLmKXxID6fT7wlQeDB1ROUOlBXtwlGqGA0U?=
 =?us-ascii?Q?hLPR+XnxqWALvLvo35oTLwEdqhwFM9274pptF5agdS3+r8C2oDkj1wg+92vX?=
 =?us-ascii?Q?lHN7qCg25Jci083K12vzFVqPVc0jNebpFddOP5UK8FObpzu?=
X-Microsoft-Antispam-Message-Info: cutfmLIvRuqP5NMRWmfRLzzlNAytHitxPuOnenSM/IaDqI9zJVRmjZuPkNaJeADV76TUstfdFbGIsIiF0hGdclVKQ1IH5pKdih+3F2Ga213jZ3i/anZTAtrncJdi7no8aylRhhzowSMhc7mRQoKufIl4stoNIS9Pv2dLHuGBb3ENNoBxuW33bzF/LdMApNchszGtRzkjT+6XTvh/F9JJS71q1I73U5Q1e+cYkRWLdMcjRpv6jY0o13CxXhX6zDBETxTEOXdXKY4urWqXK8ncew+O5mO97jEhtPtT0Y07hl2HvkpP+yp6pNKOCHoZVRfxH0hDYDZ8HwblRCxjaQ8DHkegtpRANxfPdonxRiUuqms=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:k49q8S+8WrWUY8JRu+tXvIdnWN4ye3xNqxz5AVVwv5nPLmCNkQqYmbREZL6I4xVDJ2M817PTVeaA0o5CtxSkcF5Tqg64ormC6sG8z3plINU7TbPoKFtb4EZfwKosMZ7bi0iCNbsOHXb0M5WuFjYHscWu0v1kZMUtJpr5VObz2YqufBW15wEBdaGxktY4Qli4wA0lrijcr0q8Nnmsv9ZY0yHKcCDayMeabhMSkAA7ekatTTCK+/mpuzQrp/aDt54ZH90jG62t8dAvLsrbMuhGxgpKIKJHAdPRjJLEJ4GMGyXgtOjgCInsqibZ3mJWLtBSJqmx8LEtO1waYcm6kQ5VEhmlgMF8X8K0NYC8+66YVWZ2UZFHZ99HXVl4EDUmeojj7n33vs4Bqj5aaQU/qX+LCAcFFk2ymPw5V5xhkf7CAyf2tFtw+rB+DwwAJOE07+TqFg9ySsRGP/J7gpFoRGclyA==;5:nFkNyaqAmgXHes+WCyNZS7NnOehjp1hTrpXtm5QTRSyJwZhBIPsbqi4imlXxPx3bZyLzl9+NpRp06VurXMN1WUrDL5ryE01BCY7Ur5YU7qwJsYK449VKONM49eA4E9sg5hP8+TiloFBi9Md3W7rvRVHveew1U/7nf/itV12Afrw=;7:kBD0S9y9jNNvrgJhSXUoBLYVmtctpD/mTpsAXE+VDd4IifuA5cX3D2Gby/3yIHqwvdABbC6lITmjHt/K2rpgp0N+nqMbOt1EtGlUhDzHN9pqCL7UAggWAysGkT8ownDN6zFEtRXDFP+y7z9pJb7J9ioPkCgB+SiPbQh9IeqUMTMB8G+yqiDaEk+7OPKCfB92UoWZAbwj+xVOUODi/FOCXcqK7HeTJHYf0rd0NyURPw3FBmfA6pZJ3MqMOLbOepte
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 22:56:56.5567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8788d91b-d64c-4cbb-5ec7-08d5fd823e52
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65484
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

Include an arch-specific asm/compiler.h and allow for it to define a
custom version of barrier_before_unreachable(), which is needed to
workaround several issues on the MIPS architecture.

This patch includes an effectively empty asm-generic implementation of
asm/compiler.h for all architectures except alpha, arm, arm64, and mips
(which already have an asm/compiler.h) and leaves the architecture
specifics to a further patch.

Signed-off-by: Paul Burton <paul.burton@mips.com>
[jhogan@kernel.org: Forward port and use asm/compiler.h instead of
 asm/compiler-gcc.h]
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org

---

Changes in v5:
- Rebase atop v4.18-rc8.
- Add SPDX-License-Identifier to asm-generic/compiler.h.

Changes in v4:
- Fix asm-generic/compiler.h include from check, compiler_types.h is
  included on the command line so linux/compiler.h may not be included
  (kbuild test robot).

Changes in v3:
- Rebase after 4.17 arch removal.
- Use asm/compiler.h instead of compiler-gcc.h (Arnd).
- Drop stable tag for now.

Changes in v2:
- Add generic-y entries to arch Kbuild files. Oops!

 arch/arc/include/asm/Kbuild        |  1 +
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/hexagon/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/Kbuild       |  1 +
 arch/m68k/include/asm/Kbuild       |  1 +
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/nds32/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild      |  1 +
 arch/openrisc/include/asm/Kbuild   |  1 +
 arch/parisc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild    |  1 +
 arch/riscv/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild       |  1 +
 arch/sh/include/asm/Kbuild         |  1 +
 arch/sparc/include/asm/Kbuild      |  1 +
 arch/um/include/asm/Kbuild         |  1 +
 arch/unicore32/include/asm/Kbuild  |  1 +
 arch/x86/include/asm/Kbuild        |  1 +
 arch/xtensa/include/asm/Kbuild     |  1 +
 include/asm-generic/compiler.h     | 10 ++++++++++
 include/linux/compiler-gcc.h       |  2 ++
 include/linux/compiler_types.h     |  3 +++
 23 files changed, 35 insertions(+)
 create mode 100644 include/asm-generic/compiler.h

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index feed50ce89fa..55c955621deb 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += bugs.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma-mapping.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 33a2c94fed0d..0bbdfe6481fd 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += atomic.h
 generic-y += barrier.h
 generic-y += bugs.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index a5d0b2991f47..09c6d8cac8be 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index dd2fd9c0d292..ef5f1ca92d64 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 557bbc8ba9f5..5c5a5721fe89 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 4d8d68c4e3dd..e920ada07719 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += barrier.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index fe6a6c6e5003..01317fc236e3 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index dbc4e5422550..a5f2b9058b4c 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -10,6 +10,7 @@ generic-y += clkdev.h
 generic-y += cmpxchg.h
 generic-y += cmpxchg-local.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 64ed3d656956..a157f2049d74 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += bug.h
 generic-y += bugs.h
 generic-y += cmpxchg.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 65964d390b10..54849e38da6f 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 2013d639e735..e458cba4f5ae 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += barrier.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 3196d227e351..636a1dae6adc 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -1,3 +1,4 @@
+generic-y += compiler.h
 generic-y += div64.h
 generic-y += export.h
 generic-y += irq_regs.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 576ffdca06ba..f6a7fcd72d37 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
+generic-y += compiler.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index e3239772887a..689993a319d6 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -6,6 +6,7 @@ generated-y += unistd_nr.h
 
 generic-y += asm-offsets.h
 generic-y += cacheflush.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 46dd82ab2c29..dd49f6b7f036 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += div64.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 410b263ef5c8..e944aac9b198 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # User exported sparc header files
 
 
+generic-y += compiler.h
 generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b10dde6cb793..14b4f6f09816 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += barrier.h
 generic-y += bpf_perf_event.h
 generic-y += bug.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index bfc7abe77905..614a0d99e02e 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += atomic.h
 generic-y += bugs.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index de690c2d2e33..de4246599536 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -6,6 +6,7 @@ generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
+generic-y += compiler.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index e5e1e61c538c..bf08e8a4fb57 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += bug.h
 generic-y += compat.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma-contiguous.h
diff --git a/include/asm-generic/compiler.h b/include/asm-generic/compiler.h
new file mode 100644
index 000000000000..0653ff193b40
--- /dev/null
+++ b/include/asm-generic/compiler.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_COMPILER_TYPES_H
+#error "Please don't include <asm/compiler.h> directly, include <linux/compiler.h> instead."
+#endif
+
+/*
+ * We have nothing architecture-specific to do here, simply leave everything to
+ * the generic linux/compiler.h.
+ */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 573f5a7d42d4..5caf71f15c71 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -233,7 +233,9 @@
  *
  * Adding an empty inline assembly before it works around the problem
  */
+#ifndef barrier_before_unreachable
 #define barrier_before_unreachable() asm volatile("")
+#endif
 
 /*
  * Mark a position in code as unreachable.  This can be used to
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a8ba6b04152c..c66b9222fcf0 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -54,6 +54,9 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 
 #ifdef __KERNEL__
 
+/* Allow architectures to override some definitions where necessary */
+#include <asm/compiler.h>
+
 #ifdef __GNUC__
 #include <linux/compiler-gcc.h>
 #endif
-- 
2.18.0

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 19:46:28 +0200 (CEST)
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:44640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994761AbeHIRpuARllm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 19:45:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhUrVtxFnygwKOAYuv7mEQXIO1h3rVNJgDp8Mc0COSk=;
 b=M1QQvIEWdRe7fRH8QlkFI01pklhFPAUrDK8xySO4G+TpRRIjfVaCshZKv1KujFQx6L9c15Z7nxKH//Y457IfCD3Kce051xqc6wfnYmxl7qbDC8vdg8kBXDXXqtag57KCecA2C8Izw4Tymmp2DF3jMLNRDIfAcb4lyh7IiwaWH/0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 9 Aug 2018 17:45:40 +0000
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
        linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH v6 3/4] compiler.h: Allow arch-specific overrides
Date:   Thu,  9 Aug 2018 10:44:43 -0700
Message-Id: <20180809174444.31705-4-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809174444.31705-1-paul.burton@mips.com>
References: <20180809174444.31705-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0025.namprd20.prod.outlook.com
 (2603:10b6:405:16::11) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4eafe5c-0a62-4478-380f-08d5fe1fed16
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:wvYvlZ7dnMRkf6m1X1+nWvxHtEI0DDfEBb4ESCfQ/dMET0csgD9KzhF7Qk/yWzh409XyXk5WBdJICgMLChawvMP55itdmanD0flrC91buQET+cqI4FJ4PiWPiJwPUCH2tIx33uAqiwJ210r2Tza3hal1SZ12ICY98vY97OEiNtNMuFCHzJ+RlYtu2wg9P++CtzdgrFU/m+WTFQDCmsHHKrC3tisO4gLciixDBwiW4aKftxbtzIWspmPGRREev0+f;25:NBJYUHyaaL/K/EPUYKLTNC1Dh6EH1+bLuyol/0ordwFDs2nwsx2GqyDVeQIzGkSeiQLzBLsWrHenRmERDv5rcHyt8vPKtsPb+VD80mUeAjivmxqKN7JTLQ+aJxyXhRww8KOK4mFC5xQaDb0XlwuPszMMQ6wYrkndhvjoTeESro77tEAuFi/wC4s8l9qyJiNtiCir8hkx//gou1ladwpK08MN21yQ7RUvN4SZeFU0fmzdY1MC2jqgf/8HuR53DkBstevXLlzFwDuCkHBioZ80j8ZpUlv2Cw1TlgBIQ3+MniB2I38/L7hnTLmOA7dXj3HNW8OTz3ojdYLwpGzhP32E9A==;31:NeD7aqEpXUixrfgaCpgiSAVkk2VGlVWpshaBnRmb/757fi0w4A1NRWMdVRrO+n7jYqSds+V7eSLImgGJoJWAnOil2cA6xbo14pPae7woC48cHfD7RNotxOBWtVQ/wY9wuHrANvqxDMVgdiHKVIcRQYb5PzzxkTfJntHhoMfzFxryU8wiWtqLLWA2ZMvpXgIhRG6P5c3b+X+mgh252AtzOpcnMgQqUc+ytjdFDd5fQHc=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:jRTLJsYHdpyGFUjZvcpypq4mAmwtlrQLAQxWYnHwJc6jUMoDv8wK1Ol3XXwn8UYaEVEi6twmST3BIad+EvxgsTn7pEN88gfgu5cMRu6l5JtNW044CWCACKs6siXP7wgkRX9uKGb7JGg+hol3TA6JIzKJXCQvke6Krbp0bCvBLJ+1Vc5cP8Z/66OC/1JKbXK4bCSY4ubZdjtvp1xeYWjGERTsIqNm1kxeJ24tsIWNVniEbAWS9ii81+59Gm7h73v/;4:sCxM4SUPdlYHzm5oJgFJSEUtDANSt3+mn0gId0Z6/S5ktZV7ObuEDrG/SyCxqkl+DykP1EwyuuiKEz8bw8z5mQboptjAAJ3SQLCDUrJ9jnupaSCZKdJWynQ4SB6bkTkmuqV7uK/sXYJxwCi+w1y9rSGzdYBVt9OHbV87bnQ7LPVjermbGN9mVsuavNVbMaU8deDcNUjpspyX/Q1ywI6aKuymesMezdxTsrWk/vOSVzundRUsGhIY6ylxBSm7124P7EclJ2b6pJU7NiC3Gk2kbbpZeHe8vYHUdqTs+9PEc5gV9zl61UvcUmW2EDLf3Htx7lgeWe9fZfXDcNDJD+RRsVsxRjRfyWl+jlwqChVa5mg=
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929D56195AB17A1C18DB95FC1250@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39850400004)(396003)(366004)(199004)(189003)(47776003)(2351001)(7736002)(81166006)(81156014)(6116002)(3846002)(186003)(16526019)(6506007)(386003)(107886003)(5660300001)(39060400002)(25786009)(1076002)(26005)(8676002)(53936002)(478600001)(6512007)(105586002)(106356001)(2361001)(66066001)(53416004)(6486002)(305945005)(6916009)(4326008)(11346002)(50226002)(8936002)(69596002)(476003)(486006)(97736004)(316002)(68736007)(51416003)(52116002)(44832011)(76176011)(16586007)(42882007)(54906003)(50466002)(446003)(575784001)(2906002)(7416002)(48376002)(956004)(2616005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:/oozIoD3wYV9qNQIoyrs06R5PBRzh4H7+bZbkZh8a?=
 =?us-ascii?Q?uK+6GEiclcmQMVkQv6WEDF/n8GjAP8pnkJYWidAZZKrCr8wExxospdgTmGM2?=
 =?us-ascii?Q?gg1QrMBzvoAVZoSL3EgqT27g33D1FIGRhQECTvqAfDxZD9L+Ul34/YY0sQcn?=
 =?us-ascii?Q?vb/arlu4Yhd9qXMnsP//Y/5b/U0VwhndihBt/U9lK4zkifAqALRo17TC+gAO?=
 =?us-ascii?Q?fgRRnuOjoqagIhV3U+47OAG9MFofN1oAwQHP9phd+EieIRfstODlSU0kFYaI?=
 =?us-ascii?Q?U5iJPenHLNbg2Q0r8vuGbzC+XrKnzqFoyoOMqZgq9H6UyByYXXcFs1Rt0APg?=
 =?us-ascii?Q?ZQ1hsJyimq/zwpPCuJaEfSx88QNncS9Gkzis/jGtVEDLlXxkAoxqxxQ9nb6A?=
 =?us-ascii?Q?Ng+xYkgE/fyiHM8Apc7Vh4GsRePE+qjV87PBcQXe+Vmdl96qnfGASjvfsWNt?=
 =?us-ascii?Q?4Hgow4Z5s4QQAy/VE5a3Y8jCOpjVflBDKDSj9Jp36CXqk3kPP0w1WL/D/9vG?=
 =?us-ascii?Q?oTJXUBwd9hY4kH1/8Y2iOhz1wnPcDZnN/hQmxXwi5dlaioqsH3bylrqUNLUD?=
 =?us-ascii?Q?xC6nPxtRKT8cAaEb7wGvacgi/XMrwVsRlvaZ2d4iurmoO69VQrZfSsgdeCqP?=
 =?us-ascii?Q?0Unq4NMI2MGURkWiOzmoCM8aHeBHXF2tQ6Zkl8my4wp+yDb6R63+H7slNeUA?=
 =?us-ascii?Q?neJeIACeUOVu6QzphlKbjATNyRbidZr1/UpZb5qhrJX9Et0j978yreMz7B2z?=
 =?us-ascii?Q?Zj+quWs6wqLCR+x/5saAK+zVqQdIiuNTvz7/MJDz2T3m386U0MYRJSG4V9Ng?=
 =?us-ascii?Q?NpOMO7w5qWvA6FVSmLEbtFVgRIvqlzX1Ds7ViO93yt4CcKfnE5Cw10JaaKd7?=
 =?us-ascii?Q?uH4HwWj6OsIvR85uwQtTJdnhSgS2rQ5YHgsrge+x4M6Q1MORAdzdJoxqUUb3?=
 =?us-ascii?Q?E4FDVamAWCdY3A4BbxaMHFCB5tGAThBLtRq/YI1K3HCYM53xzXIn/AOHWABp?=
 =?us-ascii?Q?g6zkJEmgr4lInWH1XWoXb2zS0/qJPiJAFIMtCERRins9xdzRjff1mZ4CetZP?=
 =?us-ascii?Q?txwzypjx5gH2FCB+xnUaWn8rFnY+EcbGr54CISiU2ZBGx0eEbY2+tYnALSMQ?=
 =?us-ascii?Q?hnu1XhXS67RF/2kEjL2Edx4SFJSVTCHcz+kbaZ1pMt47edzTC/oTMfPUoKcz?=
 =?us-ascii?Q?ptdg1jDvKBGuklMQ1m+tpWIxFu6lO3/L7sNeWHaZYB2LsCDbYWB8WZhezqCZ?=
 =?us-ascii?Q?D1cjklnTiE+kss/CbpBHsFUFWrW8+ByFDyLoDjztvYqvazFLOEaeIBCEreFc?=
 =?us-ascii?Q?pjyD4sb4g4PtfeVKGnPQeir+BJzR/F/9ntVC742fKw9Aa1qdzXlygrJ2KjB+?=
 =?us-ascii?Q?uuBhBb9P2g/poy+X6ba1qusX7s=3D?=
X-Microsoft-Antispam-Message-Info: h+cWn7bnGYy0U2G8PjkH3B1WbyJwL1T9/5zxts5Oebad/vuUHb3kDf5QnMjtlQcHY11kmoMiAlAeP5mS1Soxf+B7T1PWaR0W7Of4rXgGF3COpYNsi/yNKdsvEQswrArlVjHkx7dbXVx8ZivrF/g+eUBXL9k0FALCezf+0RchRltKVsJDT4TUFK3kOPI6JL++Hud9m2SJiXG0Il9pXMD/db/uU0v4LsSF61dlPtsfxCtEnm0wqhNSp07Hd8+TBvpWWcCTERDBU6L7GS4yMAAQKfDbkXtEBVSaRAXmcZU27nCGbjHRe2PuzvVDEiJVO5vTD5dqiAsCc0l1LFEKYEkwu8stOM278TJE1esMmBDWEjA=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:L3TwknRmFkv9ktuhPaR3yuZr/9qbBAczi3gdq1cB2U7+7lik/LGrK4Fkw68hlW+edddKVgNmH5xrr6mCtCJaK+0sg1LPRVOlxj96H3rTQRRp2iBVEQ6gATRfuECePHk8m7TvYM+N2VqvBl4FW3u/5EahrjigoHt8WKSXr4373WYX/zqhWesVzY1ziiH7UQ4EX/J/rh1r2LtIGM1x5b1kCy0eZ/NNzjSYunMRMY1serTHOZ94Ho98dBTSSlPu+otY+CAVD2Kuy9ByUjANLldY0ZqTplzsRPd7zQJrrXeSHtJF2R5BhNc4baY1q0r2vxZgrvQGF7+z0DnV3zPdHUl/taOm66xPJVAZXFoCPmkkpxBchWqJhzeK0mEDDfdTD59NWcNrwo5Y996WyRnMFXkiQor0Wm98auP1xUEfWscj8PRflEPXJtzIu+MU/8LhzkLby/NaT3VfhOI919BnE5uFmw==;5:cPwqtwj3Tgz+44FBdD3aSoFrskFQa4yj+s8jGLmnvkFNN5vdxIeCOpE9MzsQHtIrWWYHZqmRygbaB0dI1EINhv1crugQElpvFrCkAqe9Bq+jo0iDBi2hItnoqNVacoXFgLHcFZkuPDmMXapFkRg3JhqADn90rvsXKAnEc3o/N38=;7:SmvTkJFU2u77nG9a8aYoT0/loMHmZovQ4kjOwWy2Xe53T0+kOFV0VvFyvyf7FAD8NnhMuDiLzOI32PCtb8NsKuWmxWhbu02g4FfNgAfO43syoOwN9S82bYSjugHSD1f5RstrRaA0r7IVVRFVl0u3FKnPnxAyTSQ8XSKdsfc8OOqlavHf8ehiy6DFWwDNWr2/u6nBXxFm8SsbeqdDCZiTUPcou1/aco5TO0e6nxEu4ZWDqQxo1MYyIZ2hDSRkABrj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 17:45:40.6682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eafe5c-0a62-4478-380f-08d5fe1fed16
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65501
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
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-um@lists.infradead.org

---

Changes in v6: None
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

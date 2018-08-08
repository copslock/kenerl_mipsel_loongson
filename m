Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 00:57:34 +0200 (CEST)
Received: from mail-cys01nam02on0099.outbound.protection.outlook.com ([104.47.37.99]:29872
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994741AbeHHW5LI0DeA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 00:57:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBbOzQxI4/B6HU1STBEPjVdn59lNpfMuLp5/rK/ji8U=;
 b=DD2nwzO0XKsAVoKNt+3eNoOFO88VzAviO2ZzBU4qLx9C6xnFATR4u2HfHFMjBNCFpp2tDFCf1KUTmE7jY4U2iHDkdKbOOX3VRFlhGd/Eq+SO/oxVaoUm8W9OsLpokGrJx2F5RO1xnVI84w/cXv40besb9e6AOZZfQmHSV1/yx7s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 22:56:55 +0000
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
Subject: [PATCH v5 2/4] um: Add generated/ to MODE_INCLUDE
Date:   Wed,  8 Aug 2018 15:52:23 -0700
Message-Id: <20180808225225.24450-3-paul.burton@mips.com>
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
X-MS-Office365-Filtering-Correlation-Id: a6d027bb-e7ca-4119-03b1-08d5fd823d78
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:NNBIpGEtjE1puEbehuMt+scFyhRqAPgjXHRVSH/9QCUnBd4lTFCG0nsdx0VIkjGdVoQh7CaI0XIa/OWha9/ssaocTKSQcJ8rHW6y1Rp9xLCqv8w2iJmJwXU7BRAXnyVJLy51IRyDNp9S68YrUoU5ZnAeOmzUHDcproUHZQN8yKF5TVDD6g1p6W82o2aV+BfSuWQA2LlzPBmCCodbWbID6dPMgqIint4b0UIiEj8pJRM8klWMcZ44EUaBcLFvxAYK;25:LFG4Lnd/esXQFnlY9tZz7ueq09t1c8bzM0TlmII3KMUbozS02UMzcpfk3L3ikRcVrULgEuKdHxB6UY9mr1s8iSDryrqGwnkZZrdPx0VnYl3nh0f899OImucnR7849Gvs+RxgTkU0Ar+qZQS7syDenkr4omhbUI6ClsF6LUR2TP8rIfwJYkBMW2NsVNa6o9oDbaa4GW6XXyFULqgkWfQ+0xycfHnejmugdIf3dlwxVVdlD1Aamuqc6KM0pLGL4atpqWWAUSzEkspNHHigfd7fe3wBgm2ibIBwa9rt1kVfhqD2XgouIjyGyf6IQyLSGBdXFatEUrw85DDdx5MldylkEQ==;31:DjaaCgJsfoZYO6oY1haa0FU6/rW2KYHjzp6LAd4dS4e2cxA+nTnY/x+avJaK2D9xP8z1cka4Neav4VGNdLs3pbKdUYyXA89GXp6jy9hkHsZRj/EDNLP+YDEaz1LIcZ8ZfjXdpzYMqZVwmN9A2MEV5tofCro502ReQzvkoYsLd2q76Cu4S+s1JlRWYfw8FeYcGGufx0VHyO4HB02fW5qU7wU0TIHjDn1yyJOl10haC5E=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:OzFobwaR31tHSMSffWbD0Fbobd7UTDvOPExkdq1Ni+JlhHwYfPldfZ5xFDP+FCWhCXhrYgPZt2j86hbr4pfnEHJ+rwO5gHTgNuX1Peop6uI8FK5EX+urp9qrmO1EClxDwm4w2rMtCCw4cuCBuzjifNWHPtoDp1jaHL1/skC0viw22Wzcf5awDlABK+JgAPRqPn7WxWoDcZMaJlITQ7NEbMA7LLJXT2YFruUJGjJPCAfBnGEB1To2tzSoFFlL1bBw;4:KHdzPOyNnoIDi75kVeOvHqv6dTKwW6y9m9Grq7H/3cNHns8PaMcibnONQCCU6ZJQ18LZ0gsfseaPBZuI93WtGX59i8tCC3gu7SNZtTyxpUNra1rpyJi2wQfJn7x5MoHpnIzynksZQWOSXaqVu/ltsPYI45D1hNsKQqywO7AsY/IWFKNeAEsUa+jZJ7Fnyrm2KtolF8cUOnDVf4iS1UqfubfHAdpdBMmkKr2DGnNFgAIISq22mzt9NkLxDl6OcUjn4vxBztdzMWHPbCZGwvyfDIPAQUr+CZ2pF8iwsEglc8owJgc0nEYcm9dIfvzME2rF2oXtwzq6hDuPCKMbb/AzoBQdEd1o5pn9fREBa0ffbBXtAsIMoo0L36waI+QhPgNa
X-Microsoft-Antispam-PRVS: <SN6PR08MB49420A07A090D00E85AEC7F8C1260@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(143289334528602)(42262312472803)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(346002)(136003)(366004)(199004)(189003)(6306002)(6486002)(25786009)(44832011)(66066001)(47776003)(42882007)(476003)(2616005)(16586007)(446003)(11346002)(53936002)(107886003)(956004)(486006)(39060400002)(316002)(6512007)(54906003)(2906002)(4326008)(386003)(1076002)(69596002)(3846002)(305945005)(6116002)(36756003)(2361001)(478600001)(50466002)(7416002)(48376002)(97736004)(7736002)(76176011)(186003)(16526019)(2351001)(8936002)(966005)(6506007)(50226002)(53416004)(8676002)(106356001)(68736007)(51416003)(81156014)(81166006)(6916009)(105586002)(26005)(52116002)(6666003)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:bw54Bwzr8c5UhEv8NlNsBZNOTvGOxWS9q2ZFXAXIk?=
 =?us-ascii?Q?E+K8PBjxWooOF1JXDa3UERraeOzAzxLMubkQYh4BA9loQhiqXDLicxj2z/7z?=
 =?us-ascii?Q?gQdVhIpnhmKHO86Cv/awMKOHVO5kt+/74sRW6fVkToxURPrsFoCmCY/ua2es?=
 =?us-ascii?Q?LzrRpwjBOME6Zz+zAy9OIgvnCHLPGoRM66REUupbex9uAThf53E0gEsYGAjI?=
 =?us-ascii?Q?ve4/04eAffxRNKlxJJnhcQ1e1dhsXZDumeLuFd5d1VwE6gVb6H6cFm7PyHfp?=
 =?us-ascii?Q?36xvH0CTuZoZ2rXLKtUh7HrFAfObM4rU1abMYp6103LXxAYwPAcoUxAeYYuR?=
 =?us-ascii?Q?2KfJ3hiVUCFpwRVPlshuSt8TmJTv2zxTS3Tbcx1WvHJH7y2OFKA0ofw7Qftr?=
 =?us-ascii?Q?EVGpxftN6k20C6E5NkT5xAAxnLFJ1mL7M4KnP4zcxt40fbqcvIPILDSVTbuv?=
 =?us-ascii?Q?6iH4VVZeXcmkpehi6SodUMjEHzRRHipGE+xC+lj0pnVhb/dIKGlOZsbZbirU?=
 =?us-ascii?Q?lbDmg1lJbpEFqLJsD9tsSJueT4OLStH5oxgcb8KiFA9dYG/fZqEkan6xY2Fx?=
 =?us-ascii?Q?LhfL02ycSzMcuK4nO71VNORWMsFBLHh78VNx2UKSrOp8YCMp12bfAng2Meyo?=
 =?us-ascii?Q?8LaNSR27teoElSmOlsdgTQrYB1lJBqxx4J9VYd3444PjPq5onk7err9QDLCK?=
 =?us-ascii?Q?72ZpvDLL4QvXVJ42FYYKSjtVIxM91CQtYCQ2G98JEz0KY0UWTNVWH54w+Qlj?=
 =?us-ascii?Q?7Dm9QepXrmshhWvBnNy467jYP7wJ5H0qR9osFe+9VNyoQo56PnAj97DjvrSS?=
 =?us-ascii?Q?+e1kDu8dpCGGhePA8mLRWlVoC+CPjcwIt+Y95r3Y6TIl7ILw2oUXzRwBQxF1?=
 =?us-ascii?Q?ERjdcnh9AjnQwvn9E26jN2CiHBivq4WxC+aVRdLiNODMaKGcqnLb9hDJ9wAe?=
 =?us-ascii?Q?MI5L2mfXp5B6HAlbIW0+DfhpsDx6CnM+3RBcVknid+6I2ErnqgQFf3JYMeg5?=
 =?us-ascii?Q?eIlVvtyrA2hQcUN9wrwv9a0PTg+4KNgyY8fy3fJXD/+dnG4I/fOB0rlFNwwI?=
 =?us-ascii?Q?XfAdSpGnhCcR0AFUefi9nf/MEdoaY9zZki3MnGp+aMWRBx9lHcc/CBxoWLxG?=
 =?us-ascii?Q?rKjmSf/r62IS/DnsI1b+Hgt/xL++PHD3oMGilpmHbBR4ZGD/L9abQGZSL/qL?=
 =?us-ascii?Q?F4SFM6MtCNjAIw3VeErVUGY6TWBExUJyZHW5j7MbiZnGHKDK2zi6AoTPotAX?=
 =?us-ascii?Q?eBf0P8tJ1+jXxB1PwrBFrmiaUo9OiKqgltUAqv0sACIo+InUq5aClRoNK9cc?=
 =?us-ascii?Q?aU47Zu6cU75lZX6qf0Xya9/d/6i1qTh5ArTEtUh7M2SH1mNphqyslbNBZMaC?=
 =?us-ascii?Q?l2WxzjMIA6bCzhsk8PionSO3Z2ARMEEiJZ5cjRhjs3Lx02wrlNwXMdj3WRfI?=
 =?us-ascii?Q?Tui6vcsOA=3D=3D?=
X-Microsoft-Antispam-Message-Info: homiI1r+eB1SKsH3YxIW4ncy/vWN5x/Ngtm2COE2L0TFmpNGWvfkXEEiq2O5asO5evaL5DxEfDjKM2pQTAJCcm+VszYXBhHwBW3m9btskKg7zFdcB2kqxYzw9VtVxzu6rlteIOQST/EviV3nFV+zdgQC/WsUM5tf5s1hnT3rZIWevm8h/sbk3rBCNNvcOQpnm9lRAFKQLKDSw7r9Uk2++BeE/QzQ2+CHIHU8XYkPaNhYB1oQszhN3+vwijha8Tm2hDnXp1Liue9qmP2Re/yrSpZu5fZG8/slGZ6INgApb1e1DBDjNxt/BldVKVqhiVlfWhKgRfVcsk+O89/OSDkOeLxJiFQF0wM1wL6cMr5O2v4=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:24mUlX/uc9Pca2pW0d+1BEQsNk9b43oUOR+1BI3kp1pC93b36UR58Gj4b+WlDmx9xVFq5jg2BwM7761i0xT89Z6kMv2E71YmjgMGIJz0wdfTTsKk05SwwxHOXV7TwT3QqTvbxqJH01Y1ZWUmpCvEcPfq5h3hnNhLnruUqZeXGatTkTGSwn9hljJt/lpv782XEPrSshztdmxMKJCFNaq51CUPSAUuoRDBpLw4j3O48OE85KYkO6hJudOJappg8sRRDsZsyIlyntE4dbPROWcxHxsjEeHYNF5km2xldhfn4iGtHAweigxP9TqEtCtr6ab9PKm44WmsyQP97sc5JQ0iy0IGHSTyQ7kGq5jyMLXJ3OJtV1bMTHPG3ZDzh45YNpbZujK6zMjVNsYbYq5c0q9iP+7Iyp6gH2Z+oGFwmTLUYQs+QfPWvTkzrEwkUyyTcBVZO9wZSUzqnCtHK2duy24fvA==;5:rH/V+a7Th7Tq7HaVToV0TkzohtYJKK+RYkxYNLV4h3D/hT9PW/U7yIjWs/AmO/NOWrGWsk5Su8T5F8NrIoGiQKPUTGHEXXb+KDDL19NIA2U6Cxpj38wthyzr48kqx8gJvJBtZypeYm/ee/iX1iWhNkdiPl7VBBnNJ6WEp9y60oY=;7:NLUKwo5Y5JmjDnyGQHV+SBcq9iw/vyc1Dh8Aw6jRJX1pPTySKFWf0G5hwyvUZilXwEArCfVUlO0zBzd5D+8BkO9icsTs9TohEVbAaVmwjWlWReCuqRfPvFKmiteybxmntoFEMkunh5vnCs4QZAEJSLtBJJH7XOwKB9DW7Tr0Vx0H/cqtbV7UXZmx3m7SrblXh/YZAsiVTXvKjfr0EmthZ4ROwSXdiA4dhwWOM1l2rT9ku58Eo/saBU26GOJQvQEd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 22:56:55.1207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d027bb-e7ca-4119-03b1-08d5fd823d78
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65483
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

From: James Hogan <jhogan@kernel.org>

Add the um specific generated includes directory to MODE_INCLUDE so that
asm/compiler.h can be used for overriding linux/compiler*.h which is
included automatically, with um using a generated asm-generic wrapper at
arch/um/include/generated/asm/compiler.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
I've been unable to reproduce the error the kbuild test robot reported
for v4 [1], so I'm hoping it may disappear with the rebased series or at
least give me more information if not...

[1] https://www.linux-mips.org/archives/linux-mips/2018-05/msg00094.html

Changes in v5: None
Changes in v4:
- New patch in v4.

 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8a0363..543d12d230ab 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -30,6 +30,7 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/os-$(OS)/
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
+MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/generated
 
 HEADER_ARCH 	:= $(SUBARCH)
 
-- 
2.18.0

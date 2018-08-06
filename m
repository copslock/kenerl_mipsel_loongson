Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 00:25:11 +0200 (CEST)
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:30880
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994671AbeHFWY5pS940 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Aug 2018 00:24:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owJ8G8vPkalcEfupGBMJu1TxrI8dOW/pm6q+WDyGNz8=;
 b=e2QeiDgnyCNWSJXAvAarlGlM7ueg+H9C0bDoS17GV5I+Pn9X1EVuLtzGuJxrIjNjlV3LGvhSQ3bWZ9VJobB8xvvSW/f3DFRsfvb4ArEQARUhd7MiSdEQRMtPlBBMtFgys+0K+7sN9xTavhDAm/MV9dqpGNdSFs8nGbtA0KDu7fE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 22:24:46 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 1/3] MIPS: genvdso: Remove GOT checks
Date:   Mon,  6 Aug 2018 15:24:25 -0700
Message-Id: <20180806222427.2834-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806222427.2834-1-paul.burton@mips.com>
References: <20180806222427.2834-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0045.namprd20.prod.outlook.com
 (2603:10b6:405:16::31) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca681333-c676-46e5-f853-08d5fbeb6b09
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:1hZXIrqM6qr77YXSWY6DntnG8+MfiiDq12+0BqwtZro3NdZX/InUeXj7xAfXfkR7wiSRHYOM7Wxz83jGNJWsrIGbGByysySk1rCSzk8KMaEN812+FsuNM/iEv6tgB5vn4wxhfp39CgBvmL9vBKiIepZjiIWSGOeVfp02Z9VyIei1qA3J+EURtEe1zFvJAKmZOuREEU4z73+V8qImSxcmBEAzrbqvZEglSPDHOsRzWvUAZeAN16XN6OLgZw+9LJdc;25:RELiAw+Hu2brFsPtBsWApBUpzaeY0Xxnzg7kjjBIaRn5MFPLeKNjYTws2jWnrc/B2TKkJFkDKxTLkgFQ8g+3tS4v4/59/GFNsG2pVec0ZLd0bS/s70tdubJDa3uEoEs8fVqUzPJarlEjzA110e4KujkEwGSlKACflZFPse258oTVdlm9ef1HZxEXksA3N2ppzQOyueyrrFqc9ruEs6qL/ijN7VbxZI2ULdbfpwLEO4Md0B3b8xt9gnNHbV+MMWyC+b8k6jG30J1aAdMhPmFF/6bD+J6sxXndchRN+hPCLicx2LLb+n2tBaqxriNCd4y9FpmXlT59FSvuyN5i+luuCw==;31:NjYjB478p0YdHC0twFQrJcTqg2feOLnxjt4m/D28PENH3fnXTyvYep8epbP5DOA3aUJKvsL8zlo2jQPOuoK/tPZGAePxGDS3w16tSKDBal6QO7FNPLgKvt4srwJNSCVo2bJmjmbekYVMfHYqzyYyEZWHq+osc+UW02PnSf6vXmk1yNCoDEPT/xB7x21VkeZE/ZF/JnDy7ufaL3r12xxDcT5555ZVsOwZq1sCWawgJ/M=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:/NKjUbHZ3cHoEciAUUqL+UkTXgR1yDeUtoD1suj2vd6poMTVxU/VnQiZ1ck36D6EhtuxAoJn8q24SoZif4c9SBAnfYsC/A5NcAQ55gL6xxqoBIMr8Lr9dosJUAgyMCnL484m4x7yOho1n/poE+KbFyTIJPElfDMy76kFpfUa2Q7N+1p0G1TOPtN9o61ut/fNzqDzZWo+8ZjyP741c2X2Z9CkMUDBlhYyX/c0k9RoPfC56UU1xBJPFCBt5Izt1hwt;4:AKMU4AfXPG4OFg9BAfwhRo62qPyxLowYakMiQTuXbFIFouhB6/lGOquVsyDGR+zGBEK5rq1Carjh13dB7dI+zJvVnyPhq4yT6Xy1buD+MWKpZxPmC6h51lShtdFjPcF3rPyKS1zjh7X/YB8C1RFmPtKN+MBYPquiuWeRXF4+ahdZs0uyazuHu8gPhAkY1tTjum/bTUYV5TDytYZbnU/NKLOut8RLxA4OkxgIyr0xtq80sEauicLA0vTRKkBFB0vKqrrYfxTgOfdBxZ6xiWWvSw==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932380E1DA54208E809D260C1200@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(376002)(39840400004)(189003)(199004)(97736004)(47776003)(66066001)(42882007)(7736002)(476003)(446003)(11346002)(25786009)(3846002)(1076002)(81156014)(81166006)(4326008)(486006)(76176011)(956004)(2616005)(305945005)(8676002)(2361001)(478600001)(68736007)(50466002)(6116002)(48376002)(69596002)(5660300001)(6916009)(6666003)(2906002)(16526019)(36756003)(26005)(186003)(6506007)(2351001)(386003)(44832011)(6486002)(316002)(6512007)(16586007)(50226002)(106356001)(8936002)(105586002)(54906003)(53416004)(51416003)(52116002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:n/lS3LVdMaokB0E/vE1xyTgMW27PzmRUJMqtZlpTQ?=
 =?us-ascii?Q?BEs4ldbl+OXPUohqk8Rp4MsMdsOWjjdajpED6dABwlZgxwH4YSBfyM4/PCdh?=
 =?us-ascii?Q?imiz3LIOjr/3f02QER0MzwQbBCUVw6F76H6F4Iv69cV4AxdfXbVbjH4iid6f?=
 =?us-ascii?Q?h3Ao4KvJJYZPuTNO0k6BlY+Vi0Q3Odf7QwasXPQyiqYRsJWKcqBRyjILWdR6?=
 =?us-ascii?Q?DakESMkAkzcQ/4/QF8DhKAJSpKqtg+6Isq13hp0a7/tYxMkI2N1REGaQ3Ioc?=
 =?us-ascii?Q?ufk/Q2gV/b8r3BkNQQIwZFNLIDPfAa4UFWF2yFgb8nMujVOOS9+fBvPfcP66?=
 =?us-ascii?Q?ulsVJgUkfb0h81ynczAHuxswHD7ZFOglArPbZGHgj8XBAOcp0PdvlJjOBqHm?=
 =?us-ascii?Q?CwPhRu3IhsNb7Atl/l2X/94h8elvMq+hwmtFfv77rDoeFSTKaW3qElbVLClA?=
 =?us-ascii?Q?ZG9aMtkdByANc4Q8bWie8BHmC3DBEFb7Wg+r40T3I/wzfasHFomY1dvYeN3o?=
 =?us-ascii?Q?SxbyNxX1Z0pmgXr8HE41CVxDdswynvP03ls/oNlpMPABzqN9mdtssOZmwMFV?=
 =?us-ascii?Q?94rIA/9FUJNzKxQVS2OZVLr24xX3r6qvGjAqPyNHibZejhwi1gQeUcnTTiDn?=
 =?us-ascii?Q?zVUzq2Ib5OebFm3p9FEVkPVl9gbTqUot+9Hg7DVhsWirvUlJNKI4X9SCwgGq?=
 =?us-ascii?Q?pP1nqSaXkhNTpf4VOfLFJaPHOsX9lJNI3kafaV3v21H7veSsqIIG1UX8tMQD?=
 =?us-ascii?Q?n+EhXxYY/DeZvORtI8oPDOOOEipm1dHeKxSbevr72yubCq110+z2dg9cy/iH?=
 =?us-ascii?Q?UFmSE6MLF8tLmoZxoVnsGpyMG4driCD6mB1pSdVO9Ud/uDZqjTXPc/OIo7Tc?=
 =?us-ascii?Q?zyXhTn0WUIncWf+jWUcj+Bxc+20Cn3lU7sJWkr/H0ZplV7IyNUHKoM+ggu1P?=
 =?us-ascii?Q?tIl7I2eUzIba8w5zDcql89H+opTn/hoyHz0gjtgiiuVaQUhnQQO81yfsoTuW?=
 =?us-ascii?Q?yDVN6jhu0fuVjP/WBJKRUxEtTiL7wcC3toRQdmdrauc3dTct3KXqw7yQiF0w?=
 =?us-ascii?Q?cTDIIyO6b7FDiSewNxnIo+DwmIyvYn1Nxc0qEpff5KkDh/fGU0VLc2t1aRfk?=
 =?us-ascii?Q?6cVUWo1JEa0HWLUZvDraAbLYEpUJ2TI6ZV/iJuXKkg2ONttwyF32gnCJSV1S?=
 =?us-ascii?Q?kRQElTXX+5YN7r1uibW6q9OxZBsY6zhCXRY13OLXbnDmah3r0kGHK+5aa1rL?=
 =?us-ascii?Q?GQxSmVF78GkNG692Nl5RelSt8r4DMGYodwLitr7XGD/CCzquPdo+geUNcucw?=
 =?us-ascii?Q?LK5FRa+/BzKyIiyVZQAZz0=3D?=
X-Microsoft-Antispam-Message-Info: vTvfgcaI7y4LBBtn6+ejq19AIyAPstTfbD9yBBNpBBGqWlQAksQ/A8kQ59HhUFzR8k/MSvvXZGGHuufh08Ub4yKLpdT+bXErV+dei+KCnieHUstQ112p0cMlZluPzhGpIv8MRxCwDQ3s43jCzmIw1gNAXNAQMrR2T2bts6dCqJTUFCeAWlGzKhX+B0S5kp1Bqx7ZvlpWhfegiifTH5tJr+UtgLGsK/a/alts+KRo95dQHKKqZu+12YYs0u7bm3g0O1zafmpPT7/5ulr+S1mmSEUUvYOo+3WLh6pKa31EfmMRB2SyzpCfrq59L9beNS/vqtrmzoDuRc08TimsRrloTnRNo7AP0m8NoecthWBFpCE=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:0r4BuwV6f5msmE0CpBTSLh68CZYusr24kpcdXzKo9wDFhGd7H2OOY18WQZM5dxED3x8FJHxDP2e3pZGnnYU4KPK/yJ+A0mPCVa04UUuRIoKiN8KEhvj7HupTUXsoD0YJ/Y/OjfBq1nnLh2L9v3IrA1VslArVq3zDgRDb4fPO8Ktv7KSfAbsPNE3UuLZ0bupjt0Rtq0mvYK+dJtVB01rB/u9bd63rcai/tWmhSpqwKx/49cQxDegwR2R5Mc9t/fVbszCVDrcxiUxKBVAfzE4NULkzcCCZXUuN2DpL2KykZ0pZqsp+MRgK/a3SwthmDHTktKaE8fWawfUjteSBBHK+IpANkVea+0oWLCxMLXKKbcRUwHhwJf7WIezh71KmD0+QqZwKTelCk9doxRwSEA4RZVW4AbZoo794mnndA36WSeZ9dMRcDZMxbvGEHAIgMJiyrV4RBvtRBRuQ9u3b9lDLYw==;5:x7KWPE313wbHeJotftc2nL4Ep9wb6jbs+IWHl2LI9/yMInHp2+DAQgMwf0N0j6mjM890uiWmuwQeaw1LUiWNh0vTx/SyreyttiXBH7IKy7sooVtE6hEEt0dxP6qAuAABp0q50Retl28HBfwKKkfFUKwe356RSlyI7CYA1CfAnF8=;7:aVuGypMbxza4Xnh8/2dVHyHChfbNMy0xlzDtRJFZK9mAkksJAwWRqE8YrdHRT5YV+6FCmtK0//IPLlr3njyQFWwnem+nruCmXewhofNnCc55d2S/yIzCfcEVgGZGFuUwac3kQ/rnSsWF01e1vhYEs4plF5UH6V/1KvPT+oLemANpYIaBdwBHmkGuaCOO67e91tactpBkHYqNPDB2ottjaYlBbVDGrgB7kBypmz/WCOVMP11IQH+rXsacjntv/fbW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 22:24:46.9911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca681333-c676-46e5-f853-08d5fbeb6b09
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65439
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

Our genvdso tool performs some rather paranoid checking that the VDSO
library isn't attempting to make use of a GOT by constraining the number
of entries that the GOT is allowed to contain to the minimum 2 entries
that are always generated by binutils.

Unfortunately lld prior to revision 334390 generates a third entry,
which is unused & thus harmless but falls foul of genvdso's checks &
causes the build to fail.

Since we already check that the VDSO contains no relocations it seems
reasonable to presume that it also doesn't contain use of a GOT, which
would involve relocations. Thus rather than attempting to work around
this issue by allowing 3 GOT entries when using lld, simply remove the
GOT checks which seem overly paranoid.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/vdso/genvdso.h | 51 ----------------------------------------
 1 file changed, 51 deletions(-)

diff --git a/arch/mips/vdso/genvdso.h b/arch/mips/vdso/genvdso.h
index 94334727059a..611b06f01a3c 100644
--- a/arch/mips/vdso/genvdso.h
+++ b/arch/mips/vdso/genvdso.h
@@ -15,8 +15,6 @@ static inline bool FUNC(patch_vdso)(const char *path, void *vdso)
 	ELF(Shdr) *shdr;
 	char *shstrtab, *name;
 	uint16_t sh_count, sh_entsize, i;
-	unsigned int local_gotno, symtabno, gotsym;
-	ELF(Dyn) *dyn = NULL;
 
 	shdrs = vdso + FUNC(swap_uint)(ehdr->e_shoff);
 	sh_count = swap_uint16(ehdr->e_shnum);
@@ -41,9 +39,6 @@ static inline bool FUNC(patch_vdso)(const char *path, void *vdso)
 				"%s: '%s' contains relocation sections\n",
 				program_name, path);
 			return false;
-		case SHT_DYNAMIC:
-			dyn = vdso + FUNC(swap_uint)(shdr->sh_offset);
-			break;
 		}
 
 		/* Check for existing sections. */
@@ -61,52 +56,6 @@ static inline bool FUNC(patch_vdso)(const char *path, void *vdso)
 		}
 	}
 
-	/*
-	 * Ensure the GOT has no entries other than the standard 2, for the same
-	 * reason we check that there's no relocation sections above.
-	 * The standard two entries are:
-	 * - Lazy resolver
-	 * - Module pointer
-	 */
-	if (dyn) {
-		local_gotno = symtabno = gotsym = 0;
-
-		while (FUNC(swap_uint)(dyn->d_tag) != DT_NULL) {
-			switch (FUNC(swap_uint)(dyn->d_tag)) {
-			/*
-			 * This member holds the number of local GOT entries.
-			 */
-			case DT_MIPS_LOCAL_GOTNO:
-				local_gotno = FUNC(swap_uint)(dyn->d_un.d_val);
-				break;
-			/*
-			 * This member holds the number of entries in the
-			 * .dynsym section.
-			 */
-			case DT_MIPS_SYMTABNO:
-				symtabno = FUNC(swap_uint)(dyn->d_un.d_val);
-				break;
-			/*
-			 * This member holds the index of the first dynamic
-			 * symbol table entry that corresponds to an entry in
-			 * the GOT.
-			 */
-			case DT_MIPS_GOTSYM:
-				gotsym = FUNC(swap_uint)(dyn->d_un.d_val);
-				break;
-			}
-
-			dyn++;
-		}
-
-		if (local_gotno > 2 || symtabno - gotsym) {
-			fprintf(stderr,
-				"%s: '%s' contains unexpected GOT entries\n",
-				program_name, path);
-			return false;
-		}
-	}
-
 	return true;
 }
 
-- 
2.18.0

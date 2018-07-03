Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 21:22:26 +0200 (CEST)
Received: from mail-eopbgr680121.outbound.protection.outlook.com ([40.107.68.121]:21572
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994061AbeGCTWUIPsdf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 21:22:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN8jTyAXH8VbZZSzQZg8oVjJpT1eGsgy2NBm51HNpgg=;
 b=JlLH9cr3x0W/dAW97VhDsTkZOmY5Sc6p+lm97vxEpM+X0O5Qcy7TIkTaYCEzxTLSpKo8wjRxvYAy79jEZBtAADouBRRx4QpSSOp9fQwiGl+HMtbp63MM2jJipWGt5HzJwv86HWMErqye1tIc9KBv82TCSyJPYagKcq/hlO2c3RI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2154.namprd08.prod.outlook.com (2a01:111:e400:c611::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 19:22:07 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH 0/4] MIPS: kexec/kdump: Fix smp reboot and other issues
Date:   Tue,  3 Jul 2018 12:21:43 -0700
Message-Id: <1530645707-30259-1-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0100.namprd06.prod.outlook.com
 (2603:10b6:4:3a::41) To CY1PR0801MB2154.namprd08.prod.outlook.com
 (2a01:111:e400:c611::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d594ef4f-a309-44b5-a0f5-08d5e11a44b3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;3:SI9H1fp9XZKVzL9RJGSE8bryWGlGxtI46S1C1Ak5E8KKUu/bLjCwq0e0O3QE+23nrqURIlGSSW9hpPEEvcVvYCOkilgKQ3kVwwhrgw+LkdWSF2ELkLokzC2a7bpZJtFVTcQoLly1ZomA83zrSqaB6LrJTrhC0K2ZnuO28VhSjrdAK5n4vuJlnc9NWG2PCGDbTZSlLXi7G/lcvOJTmNcmQ5Br9q3DTvsm3FYw0nm4zkVndkohX2HiphUo+43VfGfX;25:IviLIJatoIQPDpAW568i+x/MuuawJHalrDNmyQ6kBYy0G52YrwACaMgWuU00ghnwkvTRg66oisyx81ArU1g9imcBFi0T5V87jW1R9PoYp769s1YxguqPnue9ymI4zTVMgzxirWVgzvIJSPHBT5UFKOTRxwRIMwOkha8QDK03NruEbVGpZYvTy+Q5bVvUSwvZgYRYcZD8la2iUVBOsC0MiJQP/ayGJz1pQ15OjQT5thGGQ5fIRiSMcgovnHQmcZLP7tbfULcOjQKjM2R46c3sdbP60SU9OOIbPSOw+y7Q1Zjt+bet8/GoP604A1jzQ1m/iAmPee01QiJO6I0Jd0EmNg==;31:LmHsiW/04M6U9X7iOTi0cQaB1A+icqEg6K2A97ixkRxcNTp6hjVxNYDeLnUG/fmiU1naB9ezBri5S/9u06hrwKibT1QFlMN5iFYpongkqmmShVQH14mLSkIAkQelJqVk1UIrM6d2toLW+CeDhGiBxz06YQJ6OUHRVaotU0BIA7RZUPq98rZk+kOpcRXEKG2r1aw3vVIXrYzaK0T6RHythaFK/lJ64vNEz/VUhLLmB74=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2154:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;20:pzeXhwjvz+V0fp4nqx3w9l2EMfagiwCqaDiRln/mj9tM+bkIHu3Ns2QFuiRuBbCZkkWgRrg4fKVMcyuykoFKu1ZorJLLDfaAuR8k0RNsf836HfMNEzpg1HIdJ6v5CChA57uMiD+iAj29nVJl6tBVJbn8PMP7/odyTOUQYjIp+Ef7PbNsLX0lp0kM0+brFQOsd+W2+CO+xYilSQ+4F7B3yUtTgkjjwaAXVkZTWX4UrOfn8VTmmgJOM2nxjgUfXemB;4:nYn3Tu3yGS7IjqLvPAW2/EuHiqXL+tVJT9LCXm7M9fYTHzPbQq926OUck4hfPxbhrj/bAphF/29cFA4Wr0PF7uGkoAAOUd7fyCCYoRT+v59PLtQdfcjX2ERxQaxutlfy9UHDyOrqLh2gt6KCoof1kmG+S3euQoPJw5FlwbL67gTfe8fAp46+dLWrFGXHzU1WhgcunD6uK3VI9IhNumkOAVl1BvMNUBOXOzSpNsF6D7LoiCGHENLk9f5jrEa1aAcu8fMbMSgbzQ0TD6wXvcJbvw==
X-Microsoft-Antispam-PRVS: <CY1PR0801MB21548BA9DB635030CD569DFCA2420@CY1PR0801MB2154.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CY1PR0801MB2154;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2154;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(346002)(376002)(366004)(199004)(189003)(476003)(68736007)(478600001)(81156014)(81166006)(8676002)(97736004)(305945005)(486006)(6116002)(3846002)(956004)(8936002)(69596002)(6512007)(2906002)(14444005)(86362001)(2616005)(316002)(16586007)(6486002)(25786009)(6506007)(66066001)(50226002)(4326008)(53936002)(47776003)(107886003)(450100002)(53416004)(5660300001)(51416003)(52116002)(105586002)(7736002)(37156001)(386003)(16526019)(26005)(36756003)(106356001)(50466002)(6666003)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2154;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2154;23:nUDHHdYNseN/1swSoUqf+Dh4OmPSXD+j0coRDW3?=
 =?us-ascii?Q?3z8Z/dRRcrHuIWP6BAZN6ehFOY+Hc5h6CoEmAIgDGKsSMzSJXj1uuzaXwLIS?=
 =?us-ascii?Q?vVU3koDxtSpe6M1KrWBJ7UtAQ8chJaGWaJiEGB/7eUlJX+bisU20jUOb0YZh?=
 =?us-ascii?Q?qCSarU8x1O0UJsnSJ2PPQG7hPkz8zU4g2FCAPJ9YsKtTi8dYUsdn1cKkY1KI?=
 =?us-ascii?Q?XO0I/WwuQF8xyc4IzU2WWh8DFUBefNUX1gya65cRL7oLCNu8R8PAlC6flW6S?=
 =?us-ascii?Q?5mfHR7NFJ25Ng1mIEm4/bTjnlNacpuj409Zm6oTRDmIMvnKvt+vou5B3LjRC?=
 =?us-ascii?Q?70uGzhB+fVQcEOPeRi5hMKbesUU3l6Gff6Xj+tZbR7JlMEPP5kyIOtQ5l843?=
 =?us-ascii?Q?AJUyphzUhpauwP80oXxC2qLaLiIYmw7hNCRJNjtsB6uMr+zH84muYr3U0xsa?=
 =?us-ascii?Q?N41L+7gMvUc8GL5mGlOPcIIiV/pgWU9RxIN0eQRFYopd5F9d5cOR5iJhA6D7?=
 =?us-ascii?Q?iHXXHs043ziJ9gr/ixp+zVYpue/go6RPgUvHjTuf6Qca9idlkjIFhgtR5WKE?=
 =?us-ascii?Q?o9xT+wGTDs+GiGXPWLqdKzhVTp6EUDUd1ns16pfoALixOfWqnFftiU7STVDG?=
 =?us-ascii?Q?/uE6LPxjHYg/Y3QYd+CvJHoaGwimF2kkUuJQkXScaXASw+wBYx8P0TeREdwn?=
 =?us-ascii?Q?kVezWKIgVnxEPrhVJrSLl/i6iubXOMQfWC8c9KEWaHFYlUnaIULzTyVOLh1X?=
 =?us-ascii?Q?DrDRuYUx2azIpo3HXmpiAjRAI9pK1AXnsgLj6n2GAG7+Rg6AA5CnjEjaAFo3?=
 =?us-ascii?Q?Nc8yY08H8XvqTIwfknavj3/4ApW1MpBVilnW7aZViIRWktEq7zUeh4pCvIT5?=
 =?us-ascii?Q?eROI3iFT+f9rsY+b+vOcCyjH9hQ9qc4xMUYZGCIi7EAFPv+dj1k9yg1Lvc6H?=
 =?us-ascii?Q?XlfGxTd0vEOtb2ZaLpABLS3L63qK6QtPqqVPaW1KpGdEEgblluxoWDnX+0IV?=
 =?us-ascii?Q?IiapPIBiPj2XjbdTUe1KcZSKjzc1tESLFlBvF2O4RwZz7JPtGrG2Uabyg8Zp?=
 =?us-ascii?Q?V3F5YN75yXcLn9IHaCBV8w+3d+cOfHeWcbZtl/xTsgICY4sfc8xosg2KiIFc?=
 =?us-ascii?Q?OAB+IwFK2PMqTlTd3vd+Fgl6PzxTB4qnsEy0xvk3yhA+t/7WBwp0PLWQODel?=
 =?us-ascii?Q?aKJIWxel3eXGJwle2nlkv/MSX2/MtztMcHwZH?=
X-Microsoft-Antispam-Message-Info: CWt/oFGfWMQ9Sr4JD1Ntmij1kDxX05p7ULUbQl5VhGERgZw+ODQwj5Lq0YqASq157fcSz/pMoZRIf6e/RnfHajldEhiijf0kWDm71aFc9lfAdinIYtWaFXJQXsadRA/z/+DZTSLBrz3ixTt15nAR71+NF9rC1fnue3Arw6CYCeCKuO4YLTbYsLR1ttTLX7mvi91Z9G9HFIXNGU5JL+2u5XfaXILsjRysgQrFTaDUZXQ/TeUlI4wJIyWQ9LZtVkVKrVfY8tmyl4hx7wrJS9e+b/MIA4765KttXb6r3WS6G3p7mXaO0dBdb2v+H0NVgj0ZFrnsL5HC/8e1oxMLgHgWe3QQn/0ROuIFOECoExGtEbk=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;6:MXOAFrKsiUugmpZZRXcdiEJoq7gNYeN+5EFxf1U8tI0PqEzgxHLlo4QhtU3X2JuHsgNeEvRx0y4l06s2l0DZpYsGR3xUbThxPQMwSujuwOA/L44kIQh5ZTad5vIRoy4kb9vHFlU6qy530ayCX4P1nqr2YORuY0e7OEfPc14PRqXb32vM24jPwymARii6+Kbe//Lc3fI2idLjct5ZHOi021zUAc3mGiJ7mynfM+gmcyDO7DOWWvoAByM2ese5WinvqJusW8xMyP1+Us+0tP0XKQNjepr+AqV4oz050tQAOcJ7ElJejvR6BmhQ5k2Zwr/Kdl/boVEgPlp7I7zFR6sxdymXmy0e9rs9RHXEPwpn2fHfbi/kmDaIoPebGc0nWbv8F1WEh5RT/ZVzjldDdquZTr0bbOe5QVi/pgn1UBCeEhiDCdh5mo2cpG47w3YKgHO+bAFqC7oQGJHLxVXEddKmkg==;5:Tzn9wwvfH17ka0MC/jMzddUQ5q8f/6a9A/oq1siXof2+nU8x1r4wLXoBX/mffaf7E4VTigG3ZL6xd3OJzI237Z3df+6xLyKndKWKxI55F/6QHIlPXfesZi64TOHXyp48DvxIJXcosLVoEHPibjNYlBkhSKXr8VmCWyetek2ktmM=;24:8YZwpLeV9p9w6AXOd8Kmoo1K7H57sre7wITnYC3y3OOk8gkV9nHJ4azk/VcCEaS/9jxf3P68HMJ80HnlGd1L5L0wTXCurbU8z24EQkmdFQA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;7:nFT08CNKdR704F6JHL6tt/DL2FK4iXXGmLc6VUwkMtbqvuJhA2f2mJBisjdmFsEk9f8VTSKo+60Lx1ijw1qLBVyJnb8QwrfvdCPbZIobqCAS8ct969kKR3CaNOXnA8ST0619Xj46VXiEWJNwJa3wXSEtCGnatbWg+UZLMJO3MNdxZ1SSqUhMt5h20CJq7kyUu9UAUAdMIX7dmjq0EFwJgezp3KoGFAlXhsz6VqemTWpcahwWsaG0M2k4ggvUcZOB
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:22:07.7132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d594ef4f-a309-44b5-a0f5-08d5e11a44b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2154
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

The issues are mentioned in patches #1 and #4. I will update kdump
documentation for MIPS if the series gets accepted. Testing has been done 
on single core i6500/Boston with IOCU, and dual core i6500 without IOCU.

Dengcheng Zhu (4):
  MIPS: Make play_dead() work for kexec
  MIPS: kexec: Let the new kernel handle all CPUs
  MIPS: kexec: Deprecate (relocated_)kexec_smp_wait
  MIPS: kexec: Do not flush system wide caches in machine_kexec()

 arch/mips/cavium-octeon/setup.c       |  2 +-
 arch/mips/cavium-octeon/smp.c         | 35 ++++++++-------
 arch/mips/include/asm/kexec.h         |  3 +-
 arch/mips/include/asm/smp.h           |  4 +-
 arch/mips/kernel/crash.c              |  4 +-
 arch/mips/kernel/machine_kexec.c      | 44 +++++++++++++-----
 arch/mips/kernel/process.c            |  2 +-
 arch/mips/kernel/relocate_kernel.S    | 39 ----------------
 arch/mips/kernel/smp-bmips.c          | 11 +++--
 arch/mips/kernel/smp-cps.c            | 59 ++++++++++++++----------
 arch/mips/loongson64/loongson-3/smp.c | 85 ++++++++++++++++++-----------------
 11 files changed, 151 insertions(+), 137 deletions(-)

-- 
2.7.4

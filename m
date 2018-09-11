Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:50:43 +0200 (CEST)
Received: from mail-by2nam05on070e.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::70e]:27336
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992747AbeIKVujIN8rb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:50:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWiLxcTffvMZd5TboX93/AntpqnwMTnG1enRGnnOigM=;
 b=K1lL3KQtIRkBOkL44gFoirnL+sCiuXLePQxQ0BzqSPv0bVw3iYFd4p4LnfHXHhb8DoMfpb7B/GnSJI1N2xcCVx5QPS8Bf+OTXOv+dAhxHQ57i6NVm6kpQuL+stVBsOLMy+PmPR2DzZzcLUvEoBw0ffQVdXu85lzeyO1e42bFoAs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 11 Sep
 2018 21:49:53 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v5 0/5] MIPS: kexec/kdump: Fix smp reboot and other issues
Date:   Tue, 11 Sep 2018 14:49:19 -0700
Message-Id: <20180911214924.21993-1-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:3:129::17) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 698ea1ce-3077-4ef9-63b2-08d618308206
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:PzZc57pZilmrxGhURmxBJdPkO1cQ8tyMw8xtf8/2LLSwBslpDBKyQxB1aJmNYq3PcuQDQQkdzwmhBw/pNXC7VJ+XU7g3rCZorkkSwMc5irQcBvCi+7L2ExzO4v7M+Q5SiddpkgDsWNoRMg2HMAwDO+GQyf1WV+NvizOvtel2ne0QC0+Dt0FspJCMz9tslKGeL+3HWaWi+/2WnE+T+Xwi2XYOOE5Si2GQ20LOJzeq6gNbV3T7KCpzPFTvkqhDJ7Zc;25:BXdZTf8vJWDVNkA0cZtnxccb+8kr5g6ttum5kxmRe+ofJuPZSOYZzDhiXJ/ZkGS+Og8+UYSAcNkelkl+FqLSxpS2rvu5iEc+IEKhaBqr/nl6bKL1Zg+M75qv6HG8962PwPLk+otfGYuVJIR7tn8cv0zaPJ/HjyS5AzfMl0T1YKVbjJTe9A/s8+dN8bGwRSKPfo+HdGFIWcR+cygSYj0utDmAGoUW2I9FsuxLtjO0lDOJ3OyyqZJS6/+inpv+1Vl7+SDaDebfhcdDkpv9w8C36ZHradbyVAuNsTdyCqNZQC3BWOPW5BiXkla1ooy+mx++EP7Kxsam0/JAcvCtyxp/BA==;31:eKc4luWmXyshvN+5LXF0y/JYBLOotgt9dDtPe2iLIEpl7W//fRqkdYiF96PLvmvrX6wab3m07mecEgmuvna/mtVk+MIDlW1MlXibz5IFZmraXztKnl4wr/LspVzrrfsuWtRccfJ6RlRQ8DlDn6M9bFmbUBV99WvIKsqhL/jNnaMVPq/AqqbiFTECvfOmqB4O+CihG0EeQ9kDv71o5laaN/Qu8FNKyXouBYluVtuVxuA=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:hCtQbb/ELU9JEvi64M5kVkU4TSJ/pvPV3L+PT1giAr/9AuDEqccYjD0IogQYinKuaTjghI8zVQoWPiJlXMYYU9W2CJ+2375a3v4iRxeB0Ug604nwTwJCnk9L0XqQyYMuWEyi0J0dcesA0ZSRzb8EsT4+gjwULliEa8AM+Uh+4C12fyTyeMV1Q9Mfe4XdDEmLt8uLnhVP4mkcSnwnqXwYnBdcoxP2FGN2KUcejDZT/KUEY47atmqUa3w5wPake5nV;4:5DcWZbnVPrgukupN/X2J/OWawgGAHaRRsXfc8Fn75tpJN1kSt7lWMUYKz3OoRJFikjIwdOxN4HgQXx6/+mpy4xieVVmWcH2wGZpUWfXv/u8HJh7NRbn/gDfFwIzbI4pcnd/bwpdd8af8kPvTc6O+1sEUjr+g1HV8v1B7T8ySElD9aWwgtVPTbY0o4FVsWvSMhFbWfvOGfjjavFK4GF69CfQN9ZSQGdNQSrHoKFuGo7LVp39kRLbvnJVFlihCAUXarGatpxjCA31c8Oky+Jx20A==
X-Microsoft-Antispam-PRVS: <BN3PR0801MB2145992FAE7CDCD9303545A0A2040@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(199004)(189003)(6486002)(4326008)(316002)(2906002)(68736007)(8676002)(36756003)(16586007)(8936002)(53416004)(105586002)(37156001)(86362001)(48376002)(106356001)(25786009)(50226002)(50466002)(6666003)(66066001)(47776003)(305945005)(53936002)(5660300001)(81156014)(52116002)(69596002)(16526019)(51416003)(6512007)(97736004)(3846002)(6116002)(6506007)(7736002)(386003)(26005)(81166006)(1076002)(2616005)(478600001)(107886003)(486006)(956004)(14444005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:zNceVVgjua+1Iv+3YIP4IkCj9hrNtLeeZwqapYX?=
 =?us-ascii?Q?cQJkidnoxZUH5vpdrkB934RCbCkg6rG/5DrxQa5aD6TkcbYt6iVH59J+eUvL?=
 =?us-ascii?Q?waazL4DsG/VlFnikiN4ii3Bd3qw0nNqLqTUneDGXlncIIXPSnTgd9DttPgdE?=
 =?us-ascii?Q?ybZ9kI3ps+FUTG8WTV3UjyxaArSDTBCUivhWOmWYtc9kLmGzEBrqZT7T2ceS?=
 =?us-ascii?Q?RtY1JfYKcCxOY8sFM+x6v4EX6CMfuiSidCCgB3lubmJ/swTM+tKlkUbtw8Gt?=
 =?us-ascii?Q?VOaHz3cxTq+gER7TTvyochjX2Gslvw0qh7gy57VmWFwQv65XxpJFLFwEhjGO?=
 =?us-ascii?Q?Wnp3yISCqblV0EnQovf08DT2jiRb0oXX/SDFCjTLoVGv1HwwLX/ec1jjWS/X?=
 =?us-ascii?Q?EIVBzfx17QAHdBnBW10nXt8jvbVI7778y1iGi5Q5lLgfL/4Cp1KPw6y9+Amj?=
 =?us-ascii?Q?y6WQeCXf96Xwf2muXBW8+wwuqVaYI65w5Tv9iP7XDPPe3amsfgHL9JVd1VKm?=
 =?us-ascii?Q?xikiQsqNN4wy2239oXXlurCanE7GFGumVPE/+XpK/IRXWMGLxd8E1CtZIAa6?=
 =?us-ascii?Q?1dqWDkdUPe0C5aFr0mO+CEToFfADHNjQhvnObJuvCNU6jX49jd8BpxxN86R+?=
 =?us-ascii?Q?sNkX3CyKh1nVymw8X7tyXPR/xyj9AZnZEK43PiCcrSoIO8XAfRx5MJUupmHb?=
 =?us-ascii?Q?WItxES3s7pfOBL/r5gRQRpLZfpvgwsctHwu3TQsfz26Xhw1zuBpdfGwhkXZk?=
 =?us-ascii?Q?2fP+3kBoQ95MGp0TVgRZ837LsmEfDZTrSOjKeUJqpepoMzpMpDKxbMKaqnuq?=
 =?us-ascii?Q?UASRibsECU6BpugIfU0dUHmhpXs9cFc7eqHcVi9NVw8cAJUoGOxubqHsFeLV?=
 =?us-ascii?Q?3nouR5CA8ZqFxMeFesisWrp4OWTCxl+OvFULlEASV4uPpOXYvLN1olBZT2oG?=
 =?us-ascii?Q?mM86Lu2FAvo1z7iGHVpAzLjmAPn1p33dKJzKrTWrUHtmfB7EeC4G7E6OeBI0?=
 =?us-ascii?Q?lNi63Z9MfN0ihtmCCXzrWjOJ1Scwo9fE9w9a3kOdlQ9o6CWKViLbGdszFj3U?=
 =?us-ascii?Q?FRgyTKtZxPvtvklIMWXa2w0B6faZP7DJVzuzQMsMUVTXiGmb54GKm0jtYU0M?=
 =?us-ascii?Q?o+GISfPSvdA/O5vAeBIzqsCb7f6JKAMH7VVSko48NaKjEmNEn20zsnMkV+zF?=
 =?us-ascii?Q?YF4IPQrC7RUg/zjz3/dbeKjrIAc0KS34j33AL?=
X-Microsoft-Antispam-Message-Info: zU6PaLDwx9g8c536R2xwQIRMMU/cRsECudIWSK5Tn5Yil+mphB4gUtJPfmYwUkIykTcwspAtS+MD1bdvIPb4+VSUbh8hSof4pI+5ops3YexTF9/6kwzEUDfC3qn3nW13egaNNsSp4qWOPuyTpsACl2Cn1UPKs+QkRrhKEBX+UajopH+VZ6yhA53gWIp9G7XXH2M85VX96samzjIU2D49fhtDmMjUIlYtaI+Qmwoej5hMtdVuWLo4IahG7RsEVejeEm6hSwAVyPAPnCfN00PXwUcIUt++VVaBsAr50kFYN+f0I/EHZ9LcpTCkH8XK5bZw/cGGQuog4JUc9aU1THSjaqZ/AD9vX2jve19ajIbf+4I=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:1lImPU1D0qUJP2tXLC0qeLfDdgndEytK5VJ8zctMQKtcAjSChVsvfxVE+48aZ2wHfCmhZeCxYPCYpp6LPayV9F0TLlu8QcLmFKb+s1MP/nD8g20/Ckk+AzMY3USyCsNxosW6Mhd1m2HbP4GvVIBehvZXEcCO9XFRBVOcxp8NVJo/ovEwtD9ZQeUn+ob/+gOdTMLFo7YqBc0k2Qz3vvVdhEe3SU4RJeLgYrHQDmEdZTxP/Go2+nR6ojj/R6Ud5riRVJjhdaruZbBy7u7SGiV55r44UYGQDJUZIhtIF/UKmCt5Kpwy4Yvzl5BHOXElUpKV+H35+2hjj6Y0rUlxzjLE/OOrKq3a94qQToOuxywrM4Wmdw1Du36IeS5OEPZiToFFeeY4RCwUy4pbLuvr80U4RYQhDjkT0LVHLC7Jf3txjLqVJG+MZ+OeXO+snp04FsSxdc21fvhajmpPizFbJbh9IA==;5:LtZrlXXm4jhL8BD8K/JujWS0yC0ydHdOKAt9fSakPnunsS9E5ZS/j9rgzvB7mTzSd57t8HkIi1WpMzWx6ntDlBSerHEQGe9h1yuvbLPNjwd0OZW3e2Jn1EQOtMfTeF7S3YSeRtsHf0ZcThk9MCICOoDou1otB82FJbLbhWms7Ps=;7:5iAZr2X43c0jPbXsRq0QkqCJ7iYWd7B/O5gcog+inXhEOWIqLpaS3S2HUicKDiyZnIxg+u8b1Dd2CA4HAFaVONnz+Umr/pMbzTdOeirHC+IcCvaJHyhq+vm1KePu3gBzR+GR+/v9CkM+im7Ws7CkPXa4Ex2LzEN1iyecMOXtMErFxYF283+V2zZr336OheYPgQQdbepmj85zRrmeeeZRo/tzIKZIkXbmiPkynzDRqOc2gR4Bw8tiSdBD4bDXbv72
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:49:53.2642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698ea1ce-3077-4ef9-63b2-08d618308206
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66207
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

Hi Paul,

This is a rewrite of the series. Basically patches 1~3 address what we
dissussed so far. Now it allows both methods - shutting off the nonboot
CPUs and jumping to relocated_kexec_smp_wait on nonboot CPUs.

Caches are flushed before signaling reboot. CPUs are marked offline to
prevent getting IPIs. Note that this is done prior to disabling local IRQ.

Patch #4 is unchnaged. Patch #5 is the previous #6 -- I'm still putting
it in here with reasons mentioned in our discussion and in the patch
description.


Thanks,

Dengcheng Zhu (5):
  MIPS: kexec: Mark CPU offline before disabling local IRQ
  MIPS: kexec: Make a framework for both jumping and halting on nonboot
    CPUs
  MIPS: kexec: CPS systems to halt nonboot CPUs
  MIPS: kexec: Relax memory restriction
  MIPS: kexec: Use prepare method from Generic for UHI platforms

 arch/mips/Kconfig                     |   4 +
 arch/mips/cavium-octeon/smp.c         |   7 ++
 arch/mips/generic/Makefile            |   1 -
 arch/mips/generic/kexec.c             |  44 ---------
 arch/mips/include/asm/kexec.h         |  11 ++-
 arch/mips/include/asm/smp-ops.h       |   3 +
 arch/mips/include/asm/smp.h           |  16 ++++
 arch/mips/kernel/crash.c              |   7 +-
 arch/mips/kernel/machine_kexec.c      | 131 ++++++++++++++++++++++++--
 arch/mips/kernel/smp-bmips.c          |   7 ++
 arch/mips/kernel/smp-cps.c            |  80 +++++++++++-----
 arch/mips/loongson64/loongson-3/smp.c |   4 +
 12 files changed, 232 insertions(+), 83 deletions(-)
 delete mode 100644 arch/mips/generic/kexec.c

-- 
2.17.1

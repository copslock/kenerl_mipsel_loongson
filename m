Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:03 +0100 (CET)
Received: from mail-eopbgr680125.outbound.protection.outlook.com ([40.107.68.125]:11886
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992871AbeKGXN7eASLU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:13:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OTyNCcSRhvxikhTfG+FSUB4q2Z1oxGy4+kenjlovtw=;
 b=WiGctSbUpRdc+rfwts2nYnjIjqplMRdYxbcRMZVtXX5Celu1bNH2EpdNSMLMLGvIcUbIyvEhvwaqr6N0FyHqfhA1Z/ezgn7B3e+R7z5dkoXaiPZXMklHYJWGVJGJ9ygLEPxFwsHhqABUAmul0xllJyO4Hs7mBizXPIGqYXDsDfI=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:13:57 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:13:57 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 00/20] MIPS: Allow FP support to be disabled
Thread-Topic: [PATCH 00/20] MIPS: Allow FP support to be disabled
Thread-Index: AQHUdu+PxugEDhA3OEWpCZ0kAhGYJg==
Date:   Wed, 7 Nov 2018 23:13:57 +0000
Message-ID: <20181107231341.4614-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:+bYgeFd7RsH2NUu7KEA0fB3nAC3A79prYyolsujZzwKBGj9H3x2Nl3/sy6WdsYyabQNdyHXHF3KIavHQd12zqERSl6J/4aUc2lrl4TO5vHdF/XSZBsvQy6rJY9cV3aSZ3nJgn/dH4c/CiVUGX/ElWyLGWHgFMikBT7clpxs7ktxEtZj3iIOLA4xSnzGcKOZKualx7mr5L+dOzo6V2Qg4AXQflRt8o9y3tZobonClpkVv3GqLxivCSiyfet7mw7VH3+iIwcNgb8ia4d2DDx8lPeSiWBoajYz/DuCD+cvddLKTPYjw8kUcyZU56AwmW+VMKIobs4JB0dXL5geZebb3A7It8c7ZCJ77/dZYiEmxD9hdPzyeZmP9xyVIGvV82OZsKvZvaiwI7BzGFDPL/BEuxtnlNd7cP4lJV+anWlEkaJiDTfGWYrp1qOTxLKYP+L7y6aVLlmdYdu9UR022wZ8HyA==;5:ZwMx1hvdPGVUcLCRnwK3hNWqlWtsGBoTVCRvV8++/99DTvsR3LFcdOY4Y9wGuZrNxFR9WONLjkYwqUnxuxpgvr8xhiG1kOKMYnliqX1pPbHed8P30NKKhYBD3XogdOMCUpHbXTJAk7GZWOywjX7lFwFx2Xa/ZS3NM/HMZ3lfBCI=;7:U27jtTXtsD0ko6zIlQnNz26EakPkUldbPLhalsXr15qKAcQhJ4hL/x6LGAGT9EQMkANxBtIqtwpgHHDSoFi5u4sdxaAwXWpyU+aRxdmNGjHJcVXt2AR2s+/3dlE/cjSo/GjrQ7M2MGYjt1383DKyZQ==
x-ms-office365-filtering-correlation-id: 3246e8e7-bfb1-47a7-9ea1-08d64506b1c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB14722603F4F10B54423F7228C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(14444005)(26005)(186003)(386003)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZQisBt6STyoX+5DWYXCjFg64nUoRGixgPo7oDvgEhyZQs5hzLnFfXxR2lXwQ9XEepcjN52uXq3zW2WbjaqNP//u6NpphETAZ9l0W4hWo13veYprjzVSK+z2aJKEc2fe3AEI5CYXZCHpwEKNBcrfyDLiaAuepgWYRQhO2VDGdi+b1HNfCWorE6N5NcspxzkILtoNPcNNrsXBIDRCLmtcds8zmEoUGg1Nlw0N65XB6J9piHy53pFXj0X06raNK9fTzq8wlBInplUVbA8G8x4epOmCmYaNVR53lq2WnC6vcYvS99yTE2G9Vrnbm0dw6OEiBUSviDTAa9LgHqGb1LCOLU0XmM+M6BtLh8qAuPI5qb9w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3246e8e7-bfb1-47a7-9ea1-08d64506b1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:13:57.6708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67136
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

This series allows the kernel to be built without any support for
floating point. There are 2 main motivations for this:

  - The specification for nanoMIPS floating point support has not yet
    been finalized, so building the kernel without floating point will
    be useful for initial nanoMIPS support. Current nanoMIPS hardware,
    the MIPS I7200 CPU, has no FPU.

  - If userland is known not to use floating point instructions then
    omiting the kernel's support for it can produce respectable code
    size savings - around 112KB for 64r6el_defconfig.

Applies cleanly atop v4.20-rc1.

Thanks,
    Paul

Paul Burton (20):
  MIPS: Hide CONFIG_MIPS_O32_FP64_SUPPORT prompt for >= MIPSr6
  MIPS: BCM5xxx: Remove dead init_fpu code
  MIPS: Simplify FP context initialization
  MIPS: Ensure emulated FP sets PF_USED_MATH
  MIPS: Drop forward declarations of sigcontext in asm/fpu.h
  MIPS: Better abstract R2300 FPU usage in Kconfig
  MIPS: Introduce CONFIG_MIPS_FP_SUPPORT
  MIPS: Hardcode cpu_has_fpu=0 when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: Stub asm/fpu.h functions
  MIPS: cpu-probe: Avoid probing FPU when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: traps: Never enable FPU when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: branch: Remove FP branch handling when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: unaligned: Remove FP & MSA code when unsupported
  MIPS: ptrace: Remove FP support when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: signal: Remove FP context support when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: Avoid FP ELF checks when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: Avoid FCSR sanitization when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: Don't compile math-emu when CONFIG_MIPS_FP_SUPPORT=n
  MIPS: Remove struct task_struct fpu state when
    CONFIG_MIPS_FP_SUPPORT=n
  MIPS: Allow FP support to be disabled

 arch/mips/Kconfig                     |  29 ++-
 arch/mips/Makefile                    |   2 +-
 arch/mips/include/asm/cpu-features.h  |  11 +-
 arch/mips/include/asm/dsemul.h        |  29 ++-
 arch/mips/include/asm/elf.h           |  26 ++-
 arch/mips/include/asm/fpu.h           | 145 +++++++++---
 arch/mips/include/asm/fpu_emulator.h  |  11 -
 arch/mips/include/asm/processor.h     |  19 +-
 arch/mips/include/asm/switch_to.h     |   6 +-
 arch/mips/kernel/Makefile             |   3 +-
 arch/mips/kernel/asm-offsets.c        |   7 +-
 arch/mips/kernel/bmips_5xxx_init.S    |   6 -
 arch/mips/kernel/branch.c             |  34 +--
 arch/mips/kernel/cpu-probe.c          |  54 +++--
 arch/mips/kernel/elf.c                |   4 +
 arch/mips/kernel/genex.S              |   2 +
 arch/mips/kernel/mips-r2-to-r6-emul.c |   7 -
 arch/mips/kernel/ptrace.c             | 319 +++++++++++++-------------
 arch/mips/kernel/ptrace32.c           |  33 +--
 arch/mips/kernel/r2300_fpu.S          |  58 -----
 arch/mips/kernel/r4k_fpu.S            | 144 ------------
 arch/mips/kernel/signal.c             |  39 +++-
 arch/mips/kernel/traps.c              | 117 ++++++----
 arch/mips/kernel/unaligned.c          |  38 +--
 arch/mips/kvm/Kconfig                 |   1 +
 arch/mips/math-emu/cp1emu.c           |   7 +
 26 files changed, 600 insertions(+), 551 deletions(-)

-- 
2.19.1

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:23:12 +0100 (CET)
Received: from mail-eopbgr770092.outbound.protection.outlook.com ([40.107.77.92]:10368
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993052AbeKMWWKbpV8u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:22:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyTGtRbR30Z6TUt2Clh3fDZ5j/11uOIE4vXoXiVcaXE=;
 b=MqVsvdOnTbm8NOPpyj7wnINn9rMUZ/jabKsrJpDvUYAZEtD2chFOY6PCHjA2OlLKtPm9Yh9RX1rFzmCqE5tSm31wPe2UJ2JnbFJf6CVABRPkHVpRC4tc295uoL5NCUMp+eRF0MoQGABYESHuTpgFcaU7SdBaf4WJ2JtvU72LNPo=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1350.namprd22.prod.outlook.com (10.171.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 13 Nov 2018 22:22:08 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:22:08 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/20] MIPS: Allow FP support to be disabled
Thread-Topic: [PATCH 00/20] MIPS: Allow FP support to be disabled
Thread-Index: AQHUdu+PxugEDhA3OEWpCZ0kAhGYJqVOUMCA
Date:   Tue, 13 Nov 2018 22:22:08 +0000
Message-ID: <CY4PR2201MB12728176D284715C96B56452C1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20181107231341.4614-1-paul.burton@mips.com>
In-Reply-To: <20181107231341.4614-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:300:115::27) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1350;6:N8NPOdvwMWC/EzOiav9RPbSw1RTIgxzkUyvMKQ3Kucrgzk86ItA5j3M4OBo532K5vi3TugDIcc6MZzb97BdS/nkkyTLr2pBh3J2jqZwuSAEkqfQSCV2wsSntPEP3ztrYmnwFoLC4NDcHwGl+Cd0+ew9KsJkOHslwcLIUNHBmWnlUjuNaWOAL4fEGaPUOfID/kuIpdan3S8CfugA5VC4cbJBARe55OTpImqgmPlDLA6b3Z7waBi9G4uXzqLiPxx3vVAB+eh3zkFk+qMABcyduq2PVZXm6yD3I8avXLOxNaUilnZeLn5lyafReedS34+lEmtNTqC5xUJWQAmEL91xITeiUxaCpy4lSsOkREfc4bkN/LDa4uy/1W6mVbqHhok/LU+3AH2OFp+PpGFqHCh1nqKgFmXNIlryMO/3Zwyel8IqNklRYFJyuJj+wguefTWfsCRr3yFnPryl1FdqovzRhBw==;5:0O73HbkacTXm4uNeL7PlI8lRYUJl3e6xhvxfUfzt9yGFa/8MpZJs5S6QDtzdwWe67vDQNDO8eDMz1A+EUEDgj846JTPDGa+K+Sme6Hgk95IwkqbYeA7bFFYmLNDJd4qvq3zeo0TYhdvvN+6XvZY2dNnFyncxB5tT9rmvDs/bk9I=;7:qZCKVIbTxUVXYWg044ukgnAbmVgZm8rTGUSLtfJET9EqxvSADyHXhdxmkIy/jt1bPzRo5+rFvgIbaep5aZw3tfahQBkek7Qr5L8Mo7tXJf8bRA0B1iBhC7ERJ7p05wrdcJcNqxgHYkc3d1wg7OySjw==
x-ms-office365-filtering-correlation-id: d313c8aa-2fde-4713-b4c1-08d649b6730c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1350;
x-ms-traffictypediagnostic: CY4PR2201MB1350:
x-microsoft-antispam-prvs: <CY4PR2201MB13509760D8A57B4C15718F88C1C20@CY4PR2201MB1350.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231382)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1350;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1350;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(366004)(396003)(189003)(199004)(476003)(486006)(446003)(11346002)(42882007)(33656002)(2900100001)(97736004)(25786009)(6246003)(3846002)(6116002)(44832011)(54906003)(316002)(71200400001)(71190400001)(6506007)(102836004)(105586002)(66066001)(106356001)(6862004)(386003)(186003)(9686003)(7696005)(52116002)(76176011)(4326008)(478600001)(26005)(99286004)(14454004)(55016002)(5660300001)(7736002)(305945005)(14444005)(81166006)(6436002)(8676002)(8936002)(74316002)(81156014)(68736007)(256004)(2906002)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1350;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eSn00ashrxKMcVpG1sZXdyo89HQgXFMPPm3/S0Vjl2J/eOKk6x3KI1w7cHhzut6UwgXpjN2CNT1k59A/BU+F3KFsq4pBqIdfMYXKPI9Xd3dbfoTWqmEXmfkSbHeYA9/3TRVqAA1DSsVRMbHaro2RL8s8jsECIiV79fugQQCANu0lxL2zIw4UzdDLp+M4bwyouGCcm2vyXGofNjGIXgiDFsZWReruDhubf/2el6hZKCXOldEpfIn/5BJ7+Rb5STcORhLLDBYozK47Iovo5nvMUJ4rtOQorhj5C+5Rd/6erRCiAm3GAMLlc6r8iIoRnXCNUy8mY6W2RTU7VcQSu+qPbT+a1i4UoWANwWgxZ/p9m5E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d313c8aa-2fde-4713-b4c1-08d649b6730c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:22:08.4253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1350
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67270
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

Hello,

Paul Burton wrote:
> This series allows the kernel to be built without any support for
> floating point. There are 2 main motivations for this:
> 
> - The specification for nanoMIPS floating point support has not yet
> been finalized, so building the kernel without floating point will
> be useful for initial nanoMIPS support. Current nanoMIPS hardware,
> the MIPS I7200 CPU, has no FPU.
> 
> - If userland is known not to use floating point instructions then
> omiting the kernel's support for it can produce respectable code
> size savings - around 112KB for 64r6el_defconfig.
> 
> Applies cleanly atop v4.20-rc1.
> 
> Thanks,
> Paul
> 
> Paul Burton (20):
> MIPS: Hide CONFIG_MIPS_O32_FP64_SUPPORT prompt for >= MIPSr6
> MIPS: BCM5xxx: Remove dead init_fpu code
> MIPS: Simplify FP context initialization
> MIPS: Ensure emulated FP sets PF_USED_MATH
> MIPS: Drop forward declarations of sigcontext in asm/fpu.h
> MIPS: Better abstract R2300 FPU usage in Kconfig
> MIPS: Introduce CONFIG_MIPS_FP_SUPPORT
> MIPS: Hardcode cpu_has_fpu=0 when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: Stub asm/fpu.h functions
> MIPS: cpu-probe: Avoid probing FPU when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: traps: Never enable FPU when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: branch: Remove FP branch handling when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: unaligned: Remove FP & MSA code when unsupported
> MIPS: ptrace: Remove FP support when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: signal: Remove FP context support when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: Avoid FP ELF checks when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: Avoid FCSR sanitization when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: Don't compile math-emu when CONFIG_MIPS_FP_SUPPORT=n
> MIPS: Remove struct task_struct fpu state when
> CONFIG_MIPS_FP_SUPPORT=n
> MIPS: Allow FP support to be disabled
> 
> arch/mips/Kconfig                     |  29 ++-
> arch/mips/Makefile                    |   2 +-
> arch/mips/include/asm/cpu-features.h  |  11 +-
> arch/mips/include/asm/dsemul.h        |  29 ++-
> arch/mips/include/asm/elf.h           |  26 ++-
> arch/mips/include/asm/fpu.h           | 145 +++++++++---
> arch/mips/include/asm/fpu_emulator.h  |  11 -
> arch/mips/include/asm/processor.h     |  19 +-
> arch/mips/include/asm/switch_to.h     |   6 +-
> arch/mips/kernel/Makefile             |   3 +-
> arch/mips/kernel/asm-offsets.c        |   7 +-
> arch/mips/kernel/bmips_5xxx_init.S    |   6 -
> arch/mips/kernel/branch.c             |  34 +--
> arch/mips/kernel/cpu-probe.c          |  54 +++--
> arch/mips/kernel/elf.c                |   4 +
> arch/mips/kernel/genex.S              |   2 +
> arch/mips/kernel/mips-r2-to-r6-emul.c |   7 -
> arch/mips/kernel/ptrace.c             | 319 +++++++++++++-------------
> arch/mips/kernel/ptrace32.c           |  33 +--
> arch/mips/kernel/r2300_fpu.S          |  58 -----
> arch/mips/kernel/r4k_fpu.S            | 144 ------------
> arch/mips/kernel/signal.c             |  39 +++-
> arch/mips/kernel/traps.c              | 117 ++++++----
> arch/mips/kernel/unaligned.c          |  38 +--
> arch/mips/kvm/Kconfig                 |   1 +
> arch/mips/math-emu/cp1emu.c           |   7 +
> 26 files changed, 600 insertions(+), 551 deletions(-)

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750FCC282C4
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AC920811
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="NoLabxly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfBDVSJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:18:09 -0500
Received: from mail-eopbgr780139.outbound.protection.outlook.com ([40.107.78.139]:22162
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729528AbfBDVSJ (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Feb 2019 16:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfMYhc9UVrKyATyQM0IWL+O5LYBmeE+4Q/IVUNrign0=;
 b=NoLabxlyBYr0CSpFwiPYriV8LSyu46xWnOKMODO4ojcB5BsDtmpGooG1uqxObkYIIo9ZV7JJ9G4cSrKUVJmEQlHWu1wvVY6znZGMldRP+dQyWXXI2wzAeZXFIHZ+R3rCDVTFKDGOTlJsioUfdWx96q6SzDw3lC9SWxwvCz6ljIg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1071.namprd22.prod.outlook.com (10.174.169.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 21:18:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 21:18:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 00/14] MIPS: MemoryMapID (MMID) & GINVT Support
Thread-Topic: [PATCH 00/14] MIPS: MemoryMapID (MMID) & GINVT Support
Thread-Index: AQHUupipFxEkdvvxWkqmFP+vbW6GAqXQKQqA
Date:   Mon, 4 Feb 2019 21:18:06 +0000
Message-ID: <MWHPR2201MB127708AE6097B9C6C91D0E8EC16D0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190202014242.30680-1-paul.burton@mips.com>
In-Reply-To: <20190202014242.30680-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0071.namprd07.prod.outlook.com
 (2603:10b6:a03:60::48) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1071;6:1adTEFizHcuySO0P16VKnuKH/OCupyyd8/YbtN7OYfkV7tYz0F5tuL7YFMcJwctz1UarE3CMF66XKZC4WsdFtYX94mCMBaINkrWC+PLNjHCvy9Bqpxf+5oXOKEdLPI9hAYen0M9xsXtpubCyEsybDzYXGsqm9cqGqrqJM/4owCASOadlVh4g7oPXME/4lak8WB60dDv0ELXC1gGMQWHt7G95CQ5SuF86NMa5t9z/0w81B4h5Mm7Yxup3lc1VW7Tpn2ZxRp4TGHk0vo8WLZNCkdMgAACIFCCHZAsx9DAZk9akITyc8ByInyHr9f87szQ+WI2G2RjxCUY7gsqXInxAF07cvmTxjmm1jJVFuLkPGMDXIs5/R2P+/n7JTqNszKiSuDpRb9fayWniNtkTCj5r7EWnTYnUkKsGVfmGn9Z0JOGnfzSzJIB0QecClqyqt25eAaNsQsQmFlMB/3sDWjfpgQ==;5:V5616DIBkqI31uGvBIXZu0W/voNVU1ak7a7v4UibkbfOgAwi/aBVIB3n+rysHvX7mNiVAwEvvXkq5RwDaBZsbI98zyrvjfU1iRA3XebS3X9XbfwU1JzEA26GwnEfOBzcdIC2wpmGtLBCiYbXOGIApuycEiBtEm4dwRq5X5w0G1t92siGjYTzHP5YxTk69+mS2iSrwubls369+czm17onCw==;7:5seh1/FDWPwrwpK7X7lrLl7fE+UzGPeuIVZ18NaAruSeLmsvtjgexzCAIMKrCKrz3bk3KBzH/elz+L87wSAur8sHOJnyC5ZCEXuXmsi1AkRoQC6dFpghQufRBET8y+l5+AvE4yZGNk6GpUzNMxV+PQ==
x-ms-office365-filtering-correlation-id: f848b3fc-f51f-41f3-7bf5-08d68ae64188
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1071;
x-ms-traffictypediagnostic: MWHPR2201MB1071:
x-microsoft-antispam-prvs: <MWHPR2201MB1071B403283994A48C5695F3C16D0@MWHPR2201MB1071.namprd22.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(81166006)(105586002)(97736004)(8676002)(229853002)(71190400001)(71200400001)(4326008)(305945005)(7736002)(106356001)(26005)(14454004)(186003)(53936002)(6116002)(3846002)(25786009)(2906002)(74316002)(446003)(11346002)(476003)(316002)(44832011)(54906003)(486006)(42882007)(9686003)(55016002)(478600001)(6436002)(8936002)(6862004)(14444005)(256004)(66066001)(386003)(6506007)(99286004)(6246003)(102836004)(52116002)(33656002)(7696005)(76176011)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1071;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vOepet7pEfzcoiMLVMjYiBuboC+8CvrDtaNUlr4SUwR3rgmjzZzUmqI4bJ3XsNWfxJZhtT/2UXa5tml1qMEdNodKtaSNfIQFAaZ5h75NKpz2dtrnzFy92yq2sYf4xhf7IauJTziZsM5kzRz513e/R1EcXLImm2pBWY0h9KazE1jInSw/pmrIxgbDnXoNbUqozFckYHJ7bQjdzZUJqRS9cm7md8kF8WXdLfb+n2AE2W8oMwoLRbi1HckV/cA6mu2TArMe2Tz3UMEDGFDYEU7QNm13M0f7GTsqOU5wgNKxlAr63133MW42E0uTWIDFkdzMLTP+sFV7OlghG90DDjGNc+yjmY8vKTf6h26wNXMxL9TrP4+zx5PKrtxtMPEIjkJZfStF3z34WwvsqdFHcdhVxZ23XAGpf8rw3igkXPUkrdA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f848b3fc-f51f-41f3-7bf5-08d68ae64188
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 21:18:06.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1071
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Paul Burton wrote:
> This series introduces support for MemoryMapIDs (MMIDs) & GINVT
> instructions. These give us a larger, global namespace for address space
> IDs & allow for global invalidation of TLB entries without IPIs.
>=20
> This has been tested on various configurations of the MIPS I6500, which
> is the first CPU to support these features.
>=20
> Applies cleanly atop v5.0-rc4.
>=20
> Paul Burton (14):
> MIPS: mm: Define activate_mm() using switch_mm()
> MIPS: mm: Remove redundant drop_mmu_context() cpu argument
> MIPS: mm: Remove redundant get_new_mmu_context() cpu argument
> MIPS: mm: Avoid HTW stop/start when dropping an inactive mm
> MIPS: mm: Consolidate drop_mmu_context() has-ASID checks
> MIPS: mm: Move drop_mmu_context() comment into appropriate block
> MIPS: mm: Remove redundant preempt_disable in local_flush_tlb_mm()
> MIPS: mm: Remove local_flush_tlb_mm()
> MIPS: mm: Split obj-y to a file per line
> MIPS: mm: Un-inline get_new_mmu_context
> MIPS: mm: Unify ASID version checks
> MIPS: mm: Add set_cpu_context() for ASID assignments
> MIPS: Add GINVT instruction helpers
> MIPS: MemoryMapID (MMID) Support
>=20
> arch/mips/Makefile                   |   2 +
> arch/mips/include/asm/barrier.h      |  19 ++
> arch/mips/include/asm/cpu-features.h |  13 ++
> arch/mips/include/asm/cpu.h          |   1 +
> arch/mips/include/asm/ginvt.h        |  56 ++++++
> arch/mips/include/asm/mipsregs.h     |  11 +
> arch/mips/include/asm/mmu.h          |   6 +-
> arch/mips/include/asm/mmu_context.h  | 139 +++++++------
> arch/mips/include/asm/tlbflush.h     |   5 +-
> arch/mips/kernel/cpu-probe.c         |  55 ++++-
> arch/mips/kernel/smp.c               |  67 ++++++-
> arch/mips/kernel/traps.c             |   4 +-
> arch/mips/kernel/unaligned.c         |   1 +
> arch/mips/kvm/emulate.c              |   8 +-
> arch/mips/kvm/mips.c                 |   5 +
> arch/mips/kvm/trap_emul.c            |  30 +--
> arch/mips/kvm/vz.c                   |   8 +-
> arch/mips/lib/dump_tlb.c             |  22 +-
> arch/mips/mm/Makefile                |  16 +-
> arch/mips/mm/c-r4k.c                 |   8 +-
> arch/mips/mm/context.c               | 288 +++++++++++++++++++++++++++
> arch/mips/mm/init.c                  |   7 +
> arch/mips/mm/tlb-r3k.c               |  14 +-
> arch/mips/mm/tlb-r4k.c               |  71 ++++---
> arch/mips/mm/tlb-r8k.c               |  10 +-
> 25 files changed, 698 insertions(+), 168 deletions(-)
> create mode 100644 arch/mips/include/asm/ginvt.h
> create mode 100644 arch/mips/mm/context.c

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

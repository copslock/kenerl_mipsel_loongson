Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A39C282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3249020857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HWT1oz/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfBBBnT (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:19 -0500
Received: from mail-eopbgr700128.outbound.protection.outlook.com ([40.107.70.128]:50592
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbfBBBnS (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG956B/MZTb3VplnAIPl9TCwnsu7fIYYwLMnVEc6PMI=;
 b=HWT1oz/O0BVfRvc3fywZkubcWuryvn0Q9WBLtgatjUZcOlasROqLy3llgAmJkevcr8OJMvK2Mlcv6nJ7wtp5TpapW6Gr86fB6vHiv9gZJ5L3EFXJy2FNMzGWe7PZLp5/28ilVuk6QJ3o1cEC26+xFX3kH7eRDv2kp4INThe7RNE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1055.namprd22.prod.outlook.com (10.174.169.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 01:43:15 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:15 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 00/14] MIPS: MemoryMapID (MMID) & GINVT Support
Thread-Topic: [PATCH 00/14] MIPS: MemoryMapID (MMID) & GINVT Support
Thread-Index: AQHUupipFxEkdvvxWkqmFP+vbW6GAg==
Date:   Sat, 2 Feb 2019 01:43:15 +0000
Message-ID: <20190202014242.30680-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1055;6:1JvlaE2UzJSMnbB4ZZN/9Pgzrn5Ary8Afoy4nLLI+c6074wvMDLcA4ChF5wSh8UCQwTaRtQW3+RLVXIi3DEJxFR1lonLBmi+vnARzRYhNYXoGLdDjD+UlhZE25W+jhTmMprA/VvxJce1quSDif4V9D4RDNHgQ912DRr/8bfC6rt0J2A2uD4ZiNaMa3FFh5bcP/RxP5wDYcljmUIsf/deyjWNq+XMWgBFg6mUcEfOVY2/okSRXv8ECjsYCmTQ7jAhNqocNK22agJRcMInKhEAtBpOuBlsNU2LFXx69PYD83OuAkyZoY6/5SJiemqS/V+3EMkCP0RRW2c1hy8sOPzdDSZbSODXHnzp+yogXIu1aAvbmDWGMQq/SOl1YTbt1CEEHnFJSpUP0JNyJ4ZpxiO6MtvuA5iD9E9oxVuV7ImYc91i87Zes/LKbqGmQX0gv4zS7JzrpREr17olKI8i7bUL5A==;5:gvALs9hU4LbTd7BrNsHhueEpf5PcCZvDJ7Dl2GYq/y2iBMC2KrC7uFdGkKWKHOkIATQrR7NRoh1ZY8sK9H0knfDg4SsNBfDvXk+2UMwtam/oDpLcqYMAuaMxZCcgOwWcT4wgz96NXW9AleMTJmTKfBTgrITPiwyiLNLDc7fW+ZcoEVLHcQ2yK6OQq3EREDglAE2LU4MLFdglQCq9jRa/Rw==;7:XY/tJo93AOeKxun+k3Wq/imx3Zs1hyAhaR/XV8OLTyUPkfSBWzkYYWjuUCZN/fKrZeQeD15vtkyfy6u7993b71aDuYIW/hQ4VG1eONB96RLoUNIVqzXTKXSxn1yAhIlXdd3nMm2MpqMdOpiN4yzgaA==
x-ms-office365-filtering-correlation-id: fe606711-ba1b-477f-dcfc-08d688afcc32
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1055;
x-ms-traffictypediagnostic: MWHPR2201MB1055:
x-microsoft-antispam-prvs: <MWHPR2201MB10552CA19B5EF0430AB688BDC1930@MWHPR2201MB1055.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(366004)(39840400004)(189003)(199004)(4326008)(97736004)(53936002)(1076003)(25786009)(14454004)(71190400001)(71200400001)(66066001)(14444005)(256004)(107886003)(478600001)(2351001)(105586002)(106356001)(476003)(81156014)(81166006)(6506007)(102836004)(8676002)(2616005)(386003)(6512007)(6436002)(50226002)(8936002)(42882007)(5640700003)(68736007)(44832011)(26005)(186003)(305945005)(52116002)(2906002)(6116002)(36756003)(3846002)(6916009)(7736002)(316002)(99286004)(6486002)(486006)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1055;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SGSgmgB7OTVoNx6g+keu5HSCoYhP9+7eKP55mTHK/HKEsjY2hFm4U+/YNeTewOj0LQpvJ7XzZByYKX9XHPFOO6Es+CjJqccGsWK1e3/tETEIu6ids1U3Zyrd1CVkxD6tNp0EIUogy1qALvIsDNTLSrrGudh6+wbgCxamlBjE1QyejdcD3fdlYPMfRULemzzyehis8d7bTvVua342CQJASgCVeBt/wwqETXd21obBf5+WrCesnYDf0bavqp0JQQudxdihjHK0akfi0/15jc6LDCbBy7BjB6JIUDGtw+hK+MeucsdVBvcB2euVQJ6JTOJkGe/kWA4O4ehM1/47Xb3pbvfkKVf+dyp7NsUzXXSEkJUcjfriCXSw9RHAilnwvdBwI1AZrBBy7XdMuFpOFHDGAjs04ULEdefSTOuMXnL9QHY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe606711-ba1b-477f-dcfc-08d688afcc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:14.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1055
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This series introduces support for MemoryMapIDs (MMIDs) & GINVT
instructions. These give us a larger, global namespace for address space
IDs & allow for global invalidation of TLB entries without IPIs.

This has been tested on various configurations of the MIPS I6500, which
is the first CPU to support these features.

Applies cleanly atop v5.0-rc4.

Paul Burton (14):
  MIPS: mm: Define activate_mm() using switch_mm()
  MIPS: mm: Remove redundant drop_mmu_context() cpu argument
  MIPS: mm: Remove redundant get_new_mmu_context() cpu argument
  MIPS: mm: Avoid HTW stop/start when dropping an inactive mm
  MIPS: mm: Consolidate drop_mmu_context() has-ASID checks
  MIPS: mm: Move drop_mmu_context() comment into appropriate block
  MIPS: mm: Remove redundant preempt_disable in local_flush_tlb_mm()
  MIPS: mm: Remove local_flush_tlb_mm()
  MIPS: mm: Split obj-y to a file per line
  MIPS: mm: Un-inline get_new_mmu_context
  MIPS: mm: Unify ASID version checks
  MIPS: mm: Add set_cpu_context() for ASID assignments
  MIPS: Add GINVT instruction helpers
  MIPS: MemoryMapID (MMID) Support

 arch/mips/Makefile                   |   2 +
 arch/mips/include/asm/barrier.h      |  19 ++
 arch/mips/include/asm/cpu-features.h |  13 ++
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/ginvt.h        |  56 ++++++
 arch/mips/include/asm/mipsregs.h     |  11 +
 arch/mips/include/asm/mmu.h          |   6 +-
 arch/mips/include/asm/mmu_context.h  | 139 +++++++------
 arch/mips/include/asm/tlbflush.h     |   5 +-
 arch/mips/kernel/cpu-probe.c         |  55 ++++-
 arch/mips/kernel/smp.c               |  67 ++++++-
 arch/mips/kernel/traps.c             |   4 +-
 arch/mips/kernel/unaligned.c         |   1 +
 arch/mips/kvm/emulate.c              |   8 +-
 arch/mips/kvm/mips.c                 |   5 +
 arch/mips/kvm/trap_emul.c            |  30 +--
 arch/mips/kvm/vz.c                   |   8 +-
 arch/mips/lib/dump_tlb.c             |  22 +-
 arch/mips/mm/Makefile                |  16 +-
 arch/mips/mm/c-r4k.c                 |   8 +-
 arch/mips/mm/context.c               | 288 +++++++++++++++++++++++++++
 arch/mips/mm/init.c                  |   7 +
 arch/mips/mm/tlb-r3k.c               |  14 +-
 arch/mips/mm/tlb-r4k.c               |  71 ++++---
 arch/mips/mm/tlb-r8k.c               |  10 +-
 25 files changed, 698 insertions(+), 168 deletions(-)
 create mode 100644 arch/mips/include/asm/ginvt.h
 create mode 100644 arch/mips/mm/context.c

--=20
2.20.1


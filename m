Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2018 00:44:11 +0100 (CET)
Received: from mail-eopbgr760101.outbound.protection.outlook.com ([40.107.76.101]:43904
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993840AbeKUXnFDPd6q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2018 00:43:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8nv4UKYkORp2tt6yt1A+HZxeU00A/zwg7YZRbK97jw=;
 b=LM8SuSuqMv3ig+pD7Q5T0U+lyy4vvrqxtzpyv5VdOohWvI+RxiQrhjHd5C801SbVC+L4z6dKflZjnTGIRBvJfnvd0aOP3IwK3wPnYaZTQS38zwMvllKWPKlTFz0C48F70uF/ZV5w3dlQSdZJBOVz9R5SgkEtAYadPocCmftD+Zg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1550.namprd22.prod.outlook.com (10.174.170.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Wed, 21 Nov 2018 23:43:01 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 23:43:01 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/24] MIPS: OCTEON: cleanups
Thread-Topic: [PATCH 00/24] MIPS: OCTEON: cleanups
Thread-Index: AQHUgerdZwUCI3geMUqL4MYbYKHkTKVa5AkA
Date:   Wed, 21 Nov 2018 23:43:01 +0000
Message-ID: <MWHPR2201MB1277E4440F24D85DDA79E497C1DA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181121223745.22792-1-aaro.koskinen@iki.fi>
In-Reply-To: <20181121223745.22792-1-aaro.koskinen@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:301:5f::48) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1550;6:n5piqvNnYrsDHjistIJYFZrPvlrGZ1/KKz5tdBNJvkQWsoDt89TdeIDdr7nZjACd9LtIwIS37uogP263haGqdfbLmfa5iUUNYaSa9rE/Ckn2+vk+1oYSV546jw6IMSq63xe8nNIWlCH1bAnNSLIfPvyq94O4+AjIYu9phqkue5rwBh4hfHLPRfVmV0y8c/Rm8hzhjoXc5WLSWfGUH/+DUNhx1sAtxUC5W3T6u69/L+mXgW8os6m73xE/LzdYh0+mR2+3TbI2uZoyk3Azq0cLnrmsszWd9GBgDlE6OOVa3UdY3+AE0xWeh6oPf3EZZqKw771jYM3opU8xHUyWh3YYxxqq7A7ItX7zbIFadu5yuC8QLdkqMz7XwLNuYPoG2+J5XawWxoWBZT5T/jXHjqU1jr8d2OZY3VFOoIQd/EaKTbPJ78X7r5gyeMXpNQbBEdv/GpIW3c89ZdXFs0cSWr5qcQ==;5:oDKawDk021056XeoL7rnQgarelA5DyqwU/GxvB7k+5ZgNSaTIZp5xmdM7UzhQoUY07wwUFAIedEEjvUC+4nkNo5GNIuGmS2N0b22vXjW0sqwpzkuikxAhfR4mfd4HgmUwXaWL1gJaWyzf2qWEHZhoTwIG07OVz9mGPMrNBenfoQ=;7:Wa84QbOfTZtbpb9Q773+kW0imxWmerm4xeojATM+H48/44+eyHkE4FFuD2ETFuqA2m+DQD/cW/7eCqs3V3HWzRwi8UtJ7qAOALblcvwSvB9HGeU8ipfCZ4QZY/4fRwToHWF2XjGAadv7E/qkeQ581g==
x-ms-office365-filtering-correlation-id: b626313f-3c21-43d3-fffa-08d6500b1290
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(4534185)(7022145)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1550;
x-ms-traffictypediagnostic: MWHPR2201MB1550:
x-microsoft-antispam-prvs: <MWHPR2201MB1550477D5F997FD846D75783C1DA0@MWHPR2201MB1550.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1550;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1550;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(136003)(396003)(39850400004)(346002)(199004)(189003)(476003)(508600001)(486006)(97736004)(14454004)(68736007)(11346002)(53936002)(99286004)(44832011)(446003)(25786009)(6916009)(7696005)(52116002)(6246003)(5660300001)(76176011)(386003)(229853002)(105586002)(106356001)(102836004)(186003)(316002)(26005)(54906003)(33656002)(4326008)(42882007)(55016002)(9686003)(66066001)(81156014)(8936002)(81166006)(8676002)(6436002)(14444005)(71200400001)(71190400001)(256004)(74316002)(6506007)(6116002)(3846002)(305945005)(7736002)(2906002)(2900100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1550;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pkyAQO4WKNv4Zh5kntnpKNmEaZe8Jb6GxYU2jhzeEJSwimSLJHT7cEd2sJ07Nu1mS5wT1wpVpPv2hnvWT6XrZBCpLFkuf5oEQFafaB12SFBEI2Srn+LzeWdTj2HdfBhFbJo5A5SiiWzOZABL+YsBnlb26pJwXB19HkuOkursY9pyT+xx8x2P61t+LH1bRBbFFERAdAicHP40Ak/Rv26xuMfGTmBBWewtrndS7vQvGfdCNRGKx5vRQN+g/m52x1Nish+FZXKF6tHwVVnBNeOAxbz1VdZ5WPk4RBncks8QZwCHhMGot5Pw840cAv2TrJksOtgwh8ctSXcih5vJttVj02zGIrakS5kPvVnQyr4WM24=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b626313f-3c21-43d3-fffa-08d6500b1290
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 23:43:01.1693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1550
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67454
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

Aaro Koskinen wrote:
> Hi,
> 
> I noticed some noise from "sparse" when compiling OCTEON platform code,
> and started to fix some of the most obvious issues (e.g. adding includes
> for missing function declarations, using static where appropriate
> etc.). Then I also got around to deleting some of the dead code.
> We have some insanely large include files, and two of the biggest ones
> should be now closer to normal..
> 
> Boot tested on OCTEON+ (EdgeRouter Lite) and OCTEON 2 (EdgeRouter Pro).
> 
> Build tested with cavium_octeon_defconfig.
> 
> A.
> 
> Aaro Koskinen (24):
> MIPS: OCTEON: cvmx-l2c: make cvmx_l2c_spinlock static
> MIPS: OCTEON: setup: make internal functions and data static
> MIPS: OCTEON: setup: include asm/fw/fw.h
> MIPS: OCTEON: setup: include asm/prom.h
> MIPS: OCTEON: cvmx-helper: make
> __cvmx_helper_errata_fix_ipd_ptr_alignment static
> MIPS: OCTEON: delete unused loopback configuration functions
> MIPS: OCTEON: octeon-platform: make octeon_ids static
> MIPS: OCTEON: octeon-platform: fix typing
> MIPS: OCTEON: octeon-irq: make octeon_irq_ciu3_set_affinity() static
> MIPS: OCTEON: csrc-octeon: include linux/sched/clock.h
> MIPS: OCTEON: smp: make internal symbols static
> MIPS: OCTEON: cvmx-helper-util: delete cvmx_helper_dump_packet
> MIPS: OCTEON: cvmx-helper-util: make cvmx_helper_setup_red_queue
> static
> MIPS: OCTEON: make cvmx_bootmem_alloc_range static
> MIPS: OCTEON: cvmx-bootmem: delete unused functions
> MIPS: OCTEON: cvmx-bootmem: move code to avoid forward declarations
> MIPS: OCTEON: cvmx-bootmem: make more functions static
> MIPS: OCTEON: delete cvmx override functions
> MIPS: OCTEON: gmxx-defs.h: delete unused functions and macros
> MIPS: OCTEON: cvmx-gmxx-defs.h: delete unused unions
> MIPS: OCTEON: cvmx-gmxx-defs.h: delete unused union fields
> MIPS: OCTEON: cvmx-gmxx-defs.h: use default register value return when
> possible
> MIPS: OCTEON: cvmx-ciu2-defs.h: delete unused macros
> MIPS: OCTEON: cvmx-ciu2-defs.h: delete unused unions
> 
> arch/mips/cavium-octeon/csrc-octeon.c         |    1 +
> .../cavium-octeon/executive/cvmx-bootmem.c    |  149 +-
> .../executive/cvmx-helper-rgmii.c             |   68 -
> .../executive/cvmx-helper-sgmii.c             |   38 -
> .../executive/cvmx-helper-util.c              |   90 +-
> .../executive/cvmx-helper-xaui.c              |   39 -
> .../cavium-octeon/executive/cvmx-helper.c     |   87 +-
> arch/mips/cavium-octeon/executive/cvmx-l2c.c  |    2 +-
> arch/mips/cavium-octeon/octeon-irq.c          |    4 +-
> arch/mips/cavium-octeon/octeon-platform.c     |    4 +-
> arch/mips/cavium-octeon/setup.c               |    8 +-
> arch/mips/cavium-octeon/smp.c                 |    4 +-
> arch/mips/include/asm/octeon/cvmx-bootmem.h   |   76 -
> arch/mips/include/asm/octeon/cvmx-ciu2-defs.h | 7060 -----------------
> arch/mips/include/asm/octeon/cvmx-gmxx-defs.h | 4940 +-----------
> .../include/asm/octeon/cvmx-helper-rgmii.h    |   17 -
> .../include/asm/octeon/cvmx-helper-sgmii.h    |   17 -
> .../include/asm/octeon/cvmx-helper-util.h     |   23 -
> .../include/asm/octeon/cvmx-helper-xaui.h     |   16 -
> arch/mips/include/asm/octeon/cvmx-helper.h    |   36 -
> 20 files changed, 295 insertions(+), 12384 deletions(-)

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]

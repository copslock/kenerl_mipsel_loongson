Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2018 22:30:33 +0200 (CEST)
Received: from mail-sn1nam01on0123.outbound.protection.outlook.com ([104.47.32.123]:63568
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994565AbeJIUaaBHq07 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Oct 2018 22:30:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTJZG6f3hwlXEiJE15AxpAucqRxucq6fA1ceA9ixNVs=;
 b=cpSVau3r3JPb6nWcoOCXOeDeyYJ3/HwyPKfcbfdXpBeE1x8QzLU4wM3OkHkA2G//VWEBjP8OMTf+MAnt6JrBM/x1vTQB2PaoQ9kzzyw0dcEPUFo73cSwdsPSIrI3MHtPQDV9I3tgO27G6+SL9OVXOkfu/AGAPRHSWHiG0gJnTHw=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1109.namprd22.prod.outlook.com (10.171.223.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.28; Tue, 9 Oct 2018 20:30:19 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::149c:90e9:9414:1330]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::149c:90e9:9414:1330%5]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 20:30:19 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: [GIT PULL] MIPS fixes for 4.19
Thread-Topic: [GIT PULL] MIPS fixes for 4.19
Thread-Index: AQHUYA7kTpNisTG1p0aIyQ5Ww86v/A==
Date:   Tue, 9 Oct 2018 20:30:18 +0000
Message-ID: <20181009203016.twicrnkxfoo4p2yl@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:3:37::12) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1109;6:6hu7Ekm6JZFfIXMCwY4kXU4bkinzd0ZLwngQc50A4WbIiBWgkwn9U3B5+r1CCOvDcdkDf4VZR39DBtRlsYibii1LV3OUp8R9VQPU0LDA11vqIQ9zGbGkQmAV31nBU+e3oAhZiVEJFzRIdsNoe1ycpv48KePITh9VUi2TU4WCP1xTTedUtnB03lLEPrDwayk+0TPeP9eD5xsn7o+8AfNvoP+kBWSNHcfO6vFjxcGRBydXI8XwLzaDxVnQ1WtvvNSajxib4hDN+vALuG10u2XDtc8LnRsrWK5bTkk5hwYLFMNLgBNVn+7s2/R9lEKYGtDW7QYvHf+od4LcjgKS96lzi/m2lIk5oNW8RmJmAWqRuB0D2Fnk2FizLT3kevBrJS9IKNN91O1EDm073zkuJVfMiWDyCpxBY8M65tD3uEuYtOHcU2qMFk4bhlBSzy+S4hg33Jo5wsuNfh8trIKi77MY3Q==;5:9Yz/clH/WQwTwtCo2O4PJVst7A/EpdjTHt4WjcZ1pAX1+eNfqiHegf/XndfBG+6P4ZC45l4gCwdZ02NFeC/4YU6RCT8gKTXnnceRxFZSWay971o0zFhZnO49s9a1w9kBmGDAy/8mMhwJOK2Xqk+nN/DPUALQpDHuCEt3mmizngU=;7:otq7uHYAeX++NzlUS0i5yR4hgcpyw6QqcQ50CzdAkTMmBAtHw+1fAoB8cw4HYvZspU+GBr9lbTiWJ7l7kBqdDuHI5y3RDDqUlQfARxALJv4JDcxGWsTyl9Y4LkWR7BR3kHrw8q2gZ1Rc9DXyEXneRgYM6H5aWvm20E3IKTgTxk1/pngDFCkKjq6+AAubCdHEMeaBWq4oD7lygKRjkJAX2gPrczKImQTvgLfmkyw8OahDRuAu3yMRZoKFGNE4YTlG
x-ms-office365-filtering-correlation-id: 597a207e-129f-4dea-1d59-08d62e260716
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CY4PR2201MB1109;
x-ms-traffictypediagnostic: CY4PR2201MB1109:
x-microsoft-antispam-prvs: <CY4PR2201MB11092EE56FB2521FA1D31098C1E70@CY4PR2201MB1109.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4983020)(52105095)(3002001)(93006095)(10201501046)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051);SRVR:CY4PR2201MB1109;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1109;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(396003)(366004)(39840400004)(346002)(376002)(189003)(199004)(6116002)(81166006)(316002)(3846002)(81156014)(5660300001)(6506007)(6436002)(71200400001)(6916009)(8936002)(1076002)(256004)(71190400001)(97736004)(2900100001)(33896004)(6486002)(14454004)(8676002)(508600001)(25786009)(52116002)(386003)(106356001)(33716001)(486006)(5250100002)(44832011)(58126008)(2906002)(54906003)(575784001)(105586002)(68736007)(26005)(476003)(102836004)(4326008)(9686003)(6512007)(66066001)(53936002)(7736002)(186003)(305945005)(99286004)(42882007)(99936001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1109;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B8Hit503SySC0ma4eO9wdZ95uecFvVVWLj+u8w+iVXS3pOOenhZ3eEWAcG5ke7oWv9ifpUAkJlLxuirznm0EZBz3R6ZG2ya+Rr2kEnhAcYsfDskPDiqr/EsVP+eWG38A0HvyujR1CLFh8co+qroXmavtdmk3FK8/xgP8mZHibBaZBKABTaFFEHMkk0jCM2PTfukWQ4cwSS86ZcXq27fIKFKvpnhUrHZI8W6GqBFNlSlkQBS9bjR76QTeYpDWnkaphJilp9QoUXhEJD4XdobFwH3ah2kzOPBORZdE1WXr6x3UhMWrB00MpaJcNlEKPZkWHQqLo0aWI7w+GyW7YpwNMDFYDLH535KWBq4/vhDbMUE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uhfh2ppu5sjddbap"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597a207e-129f-4dea-1d59-08d62e260716
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 20:30:18.9855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1109
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66737
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

--uhfh2ppu5sjddbap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

Here are a few MIPS fixes for 4.19, dealing with regressions from the
past few release cycles. Please pull.

Thanks,
    Paul

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.19_2

for you to fetch changes up to 148b9aba99e0bbadf361747d21456e1589015f74:

  MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup' regression (2018-10-05 09:41:39 -0700)

----------------------------------------------------------------
A few MIPS fixes for 4.19:

- Avoid suboptimal placement of our VDSO when using the legacy mmap
  layout, which can prevent statically linked programs that were able to
  allocate large amounts of memory using the brk syscall prior to the
  introduction of our VDSO from functioning correctly.

- Fix up CONFIG_CMDLINE handling for platforms which ought to ignore DT
  arguments but have incorrectly used them & lost other arguments since
  v3.16.

- Fix a path in MAINTAINERS to use valid wildcards.

- Fixup a regression from v4.17 in memset() for systems using
  CPU_DADDI_WORKAROUNDS.

----------------------------------------------------------------
Joe Perches (1):
      MAINTAINERS: MIPS/LOONGSON2 ARCHITECTURE - Use the normal wildcard style

Maciej W. Rozycki (1):
      MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup' regression

Paul Burton (2):
      MIPS: VDSO: Always map near top of user memory
      MIPS: Fix CONFIG_CMDLINE handling

 MAINTAINERS                       |  3 ++-
 arch/mips/include/asm/processor.h | 10 ++++----
 arch/mips/kernel/process.c        | 25 ++++++++++++++++++++
 arch/mips/kernel/setup.c          | 48 +++++++++++++++++++++++----------------
 arch/mips/kernel/vdso.c           | 18 ++++++++++++++-
 arch/mips/lib/memset.S            |  4 +++-
 6 files changed, 80 insertions(+), 28 deletions(-)

--uhfh2ppu5sjddbap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCW70P2AAKCRA+p5+stXUA
3V6fAP4j8DmTv1jX2GPBPnW63SUsvxUM1yPiXQ0GOai1Me5zEgEApOg/NORlvQXV
Mdo2EPM3wahPrVbNQsxuNkK6IV2Yfgg=
=FVs+
-----END PGP SIGNATURE-----

--uhfh2ppu5sjddbap--

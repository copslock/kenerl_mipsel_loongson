Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jun 2018 02:17:20 +0200 (CEST)
Received: from mail-eopbgr730122.outbound.protection.outlook.com ([40.107.73.122]:39804
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994667AbeFXARNKEFsH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Jun 2018 02:17:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qthtEGRSGCM+2xqIwqrUM91NYEKIO94Ds/1mJ+nvkzQ=;
 b=DChDa3w10qiGNPPqJ1479HRdgOCgYBkhJaloMlLoSvpbkOtbQgMMu2MuMHoX3BzFh0u2vSzDZlGpLMFawJHsytTQQc2hCXithPm6am0nLtVZRRQx1AeEwXK+mEFx4Hu42S/J5MW6bAY5DdL+u7IsYm68YHMODRN6sBKHwgugMzQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (2601:647:4100:4687:76db:7cfe:65a3:6aea) by
 DM6PR08MB4937.namprd08.prod.outlook.com (2603:10b6:5:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Sun, 24 Jun 2018 00:17:02 +0000
Date:   Sat, 23 Jun 2018 17:16:58 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [GIT PULL] MIPS fixes for 4.18-rc2
Message-ID: <20180624001658.xjjc2dyttoqs7omp@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ih6xvcxsso4ugtem"
Content-Disposition: inline
User-Agent: NeoMutt/20180512
X-Originating-IP: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
X-ClientProxiedBy: CO1PR15CA0102.namprd15.prod.outlook.com
 (2603:10b6:101:21::22) To DM6PR08MB4937.namprd08.prod.outlook.com
 (2603:10b6:5:4b::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9a916fa-3e22-4d3f-7ae0-08d5d967cf46
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;3:YvJ8rmUx5u7t4BpcBRG/sG7OsZjyg833otc5X4apYNf9UEQ2qw/xBFMyvw+fy6jHhle0qx9W5UvIh7j9L3lS6lG8Z8n+38BD3R7lfUMG+IAtPT7pgT2Oic+NE6IJloWfW+VbGpR7JD86ZFhmmXFtT6aYF+kAr2g86pk3OUXLCSddw5mpFyZ1O01semc40TnrgujGydAV1w0NnRVcJFcUOk7DsgyOGETkmK/uiA53CPsopiSlT28eDSgoAPzLjgMv;25:By0Ecy2/yZ5kH7YClsR6L3l5k63lDk+AB2A3OhK7jK+Qneq5rSg0SXCFD4EkYg/Yj6qZWP8AkpvIMAlKVOQuATka/uNRv8SAX4C7B/wPrXYZDUsWIoSAxF2IonEaQS59ZyPtQFgAZrAm3NJvVTo41ARmwY3s7JbpppEkYq9uiC62FV9W2MJeyqlIT8zl4Ls+/nfQ75pSlYsiOsRbm2PgDaXP/67ytGtVgIqKJHNrVVajixC57nMMbbs93ZyLGDIA85MrYXrb+b9jETRH205RO3h1uXFdgyriPReILETdi37mOyTHionSZgAEH8G0oOADoi/GciXAH0AS8flwp50LlQ==;31:r8bSOiCXaLoJPQuQFVfcxnXa6838pEySr6G8eY9TemlwpoxbH6byGqfKrIcO+gkJRaSCWsuFV2+ifkZH74+sEg8LIOW6S/k6ranyrUOQgtNXSly541TivZKLXSb7fpy+er/k/gy0zfqsIBMsLY1ZbxkItBqT19WXEJ02iJndieAmK2B/0VA+bfoo+2P3xpdmV/+8Q1g99D+JuXVNiMZEqcAQbyuOTAIUCB+w8LT73K0=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4937:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;20:RiX7H70C5AdlVUVgpSiYUA11QzKAWYNQxY4C2MmShRQKm7XCqkx8BFvBQVfrqaqae7CcVq425KwBKr73At5MtDGvadvNYGYKTKUjgejVsvwP+ggvCTCUywWbe3RZMX6xNNt/x2PNoUbemn4kEpvLEzHasIxPNb8CIZvn+yBCdItWvug2NWPrXuzQcYQHbHgPUxP+NgkMlq4675s3YqJ9DXAaknFlpDRxQDFaLGn94tZF5RonNpiK6gVlL8sp/DFw;4:0tlQrv2dh2ILRG+mmyws8Wc3t3Ac+5gQzpExsGa0ZJN0MVUBrLQPaypisg9SHJfrTekncyRvT3xea5VofDhR9JsLl8dsbI24NIM/ZCbImNjl8sdahP9CUOHCxAwLBJ9GsnyGtkgoKvHzdZeZVlyVc728klTfnMhhKRcd39ALhufQos2E3xRUKl5tc898Ofn11cQOMjclNOzFbSpWVy1j3wWoojIy67QvGwA5xugoGOU9szWQm/MSqdY0zH+tLV6QOSbKj/Wi6xqjzxpA9f/CkwusLpajacJIkj//UDZKOJvcFMwO+jMC5KQeJh814U5x
X-Microsoft-Antispam-PRVS: <DM6PR08MB4937057154C5BBE4FA1A729DC14B0@DM6PR08MB4937.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4937;
X-Forefront-PRVS: 0713BC207F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39380400002)(376002)(39830400003)(346002)(366004)(189003)(199004)(105586002)(486006)(25786009)(4326008)(6116002)(9686003)(97736004)(575784001)(58126008)(476003)(1076002)(84326002)(53936002)(44832011)(7736002)(68736007)(8936002)(305945005)(478600001)(106356001)(81166006)(8676002)(2906002)(81156014)(6916009)(5660300001)(63394003)(6666003)(52116002)(52396003)(76506005)(6496006)(42882007)(21480400003)(54906003)(186003)(44144004)(6486002)(16526019)(16586007)(33896004)(33716001)(386003)(316002)(46003)(2700100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4937;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4937;23:CDhL8EGV1Gj3GT8JIhEaw4QswNA3zP1oWGcDwtA4r?=
 =?us-ascii?Q?qjJKR/urIuYnloKX8cGc3s+fhO2Ucbx3aR8+RbktsY/FyfUNiO5PHWAWstwc?=
 =?us-ascii?Q?tGezT0PzYLUac0At00J9TgPT54+kDLIpdeWRxgMx654geZOJghKlqd9gihip?=
 =?us-ascii?Q?dB4eGRICQ0k5QOHPmCWK4hJNKXKEmTy/BgTNVQvW5uIsW6ZQpoa7csuIwxCu?=
 =?us-ascii?Q?hFDJqM606Ti7TqfTp4uqqb59L9Qxtr4laaG3FG1LTTsuEvj9mkdy5cquvCI6?=
 =?us-ascii?Q?56QG6//SDUFto/s+DsuBJ88L1znL+3ItDCI78qYvzf+vUMWdbqq4mA5N3Brn?=
 =?us-ascii?Q?nWXn5h3NSKvk3yuAMwDwc+SO4m27qQUv9MHDmZmxIeLZT8AZ9Tvghb+i1ul1?=
 =?us-ascii?Q?j9oRWARVz0NjCKxau87gTvrNXaA58aV9xiEaw3q2evzcOmSOnmk3QVTjLuPW?=
 =?us-ascii?Q?UAof9cQ4z2y7746P42oAbL65jYLAXkuNvqM3fD5jXEw0mF4/Hqv2cxoBMThX?=
 =?us-ascii?Q?dv6BkoFeUi8WXWXxFIMg7wL63+Z2ZPXuMkDBCeGFVym/FIXHmHMpn4qH2g0w?=
 =?us-ascii?Q?T23qjQ5D4P/qXyrcFtT4by+qNKpvPLm8IY7fOygXbezTSOTRloyYIT2rHAVm?=
 =?us-ascii?Q?7w7N/Tf5AuOfAX/YnWnHbsg4Z3G7NyScYNlFaVrssmNTp1r0oCgHAufu4G7/?=
 =?us-ascii?Q?L0zctvkTbDor4YdUxXv/cF9+skllGg1smDmR4cnuKQEvjMEULh9CdtrXdRGo?=
 =?us-ascii?Q?06JoEemjc7HuUwnPUtWmwcoHxIoWgtCmga0owOQMMlbAXBvceLwzy7vkaIxh?=
 =?us-ascii?Q?3WgnePeAQIn/4PoIcbSwDDElaD0lcDmbxhu+hBHb+ZnXKMo6ObKi6Z4Yw2v/?=
 =?us-ascii?Q?Ze5lcdRcOB+hHCdN3WRCzpyFQ5ER38icOdmqyCFQ5+ulj0NvOfRLFqiAu+QU?=
 =?us-ascii?Q?fi5pLbLcQuajBOhD+5nR7dR16dK+2nALDfLYDXttuKKuq7JNGBrmp/aynHxJ?=
 =?us-ascii?Q?qhrUS4zGIKwsvCD8RCmF0jmcUEIdxW6KcS4HR8fEQpKBq8f0pv9d8ZxwggUT?=
 =?us-ascii?Q?bEdV8XxSp4CoH2rh8m34/Uxl5Vw0Kf2HN48W95vfK7ocBRRaljnlYBo0pGZK?=
 =?us-ascii?Q?ksmVcoqiE3yJl1TzRINCUL8rD1RTBjmf84YlrO/7U/+8jBEpVKsnLaJwXbVm?=
 =?us-ascii?Q?/s6qOchMHNGeNrAl3AU47aZ0dNxhGFLy4kVLorCgMyVnZvXpi+r78UVPHfus?=
 =?us-ascii?Q?UGsS0E5uF9ptpqduUjsHvll+4eIf8bW78gq0Q2A?=
X-Microsoft-Antispam-Message-Info: T0N9E+UqKDd6tutAAFM7tE5p5ZQLNslo0PCLeAg17h1EPpBdWwiXIyz/nbizYI9zSBpl7pEHBDF9ZQrA3SFYFiS6Zg3KbDrWlSRMmGfGrVa8h3MjcLJoj12PD2gLvzP5MPgx/qagx+GuHVVm5DeCi6sXlJtxthJS27EAEWkj4+A1pTLi89C+NsD60yRR/1JRh07P/XRkL4NTThTeoloyVZLvC0j8t26aUoS5fAAXk6d9Nbymbpk423UkfNBPM0YWR1Q4UfC4qCXjyEFXDEQ0Oe4haI+x36p4vMoUbWwppCBApLBxUVSjeirtdUdU0oWfxv4ShI2PtTB1ujRwVHsd+WHW/J4dIaH9SCziKxElCn8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;6:p9zHAVOLe1IBs3p0J5YKkbSbAokAu4hqLGJ8Q/qkEjRzrdFP7AYtYGW4LzMQHXbepSmI0geF5I61jdIAIhEj/dnLkAdttKmI2IO/G9DWhcEJT3vILmGF+Eojx2c44n+P2XFr3k6Epl4pN64j4RQGrGkIIOPlVgTDiUkgwtwpLnQ6m6ucCp3U6Gigkiu/w3RMfCQ3BYQGeISGi1kgJH9i232hK5U1pJn87tn7hebDCF//nyqskbeEJ6K3ALOZDq69lL5eUvzP7Ff2JPBuRWWgJ/Fk5dfAnzHCM5KuCJarrsIOQO5WzQ909MGNM5xGxDC/J4FjlDM91IxP6cGtZHxNSJhtRVt/rRTxrzHdUnSVbUEEAsNkffQ0lKYHQwlmbb6HraOEXM+vsaYY+BS7UVK/3dChcwuJHXpW1cd1wD8mVfmSRZFVWAnZWdhQ7H0MRMIcQ7Rp97vRqv7uBk3S/lKzWA==;5:cgJ5TrBFsvcjJiqYncmkCuGEtGM3KNmIlMcjYq8C+Sj4jRF8wxAVUf+krdD1NDYF1YBscMc2MCYxMOMoqEH9VuQWXYE+cZQRK0mWgqVxSEg7xubYYkfU3pFR6sovmqexWqhqzaWNxXljSQJ3wmSEeIZdnONhtLyI4IldhVZVtkI=;24:KjpOgD8fyRCaUOVOzAmr/dwEmI7fNrmpWmswQpK4+4r0M7kdfDcWiA7oeayXNF5upG7UfkvWBB9Em/cVIRyzdPNLd+auWiUmAVlwPsCZxpE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;7:hbOL5J4eoYbGwyXBNGxRgGxx6vBwyvfIAUNZZcPto5HknwtY84RTsc1tDKBjO6HThgribkfuZ2HiUO/HsN7oDM9sVcSuy/3V1zUXH6KvdB21AEIYPmi5PRV9vYOeLXjozCdBruHV4+Si4GHaLkXKzqe9nnEXQlt9oRdzhzUO/9+N1jcGuVMkFCZ9v4Qm/u+AZy1cEX+F+eKdTcFpoWXTtbS4TvcJk2+nIEeAZ5CoL4mcAZ5Pni9TQYPE0HEy9Vlz
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2018 00:17:02.3323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a916fa-3e22-4d3f-7ae0-08d5d967cf46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4937
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64420
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


--ih6xvcxsso4ugtem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are some MIPS fixes & syscall wiring for 4.18, please pull.

Thanks,
    Paul

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_4.18_1

for you to fetch changes up to 4337aac1e1c97cfda56fbec4077fbc0e37b867c0:

  MIPS: Wire up io_pgetevents syscall (2018-06-19 21:14:29 -0700)

----------------------------------------------------------------
A few MIPS fixes for 4.18:

  - A GPIO device name fix for a regression in v4.15-rc1.

  - An errata workaround for the BCM5300X platform.

  - A fix to ftrace function graph tracing, broken for a long time with
    the fix applying cleanly back as far as v3.17.

  - Addition of read barriers to in{b,w,l,q}() functions, matching
    behavior of other architectures & mirroring the equivalent addition
    to read{b,w,l,q} in v4.17-rc2.

Plus changes to wire up new syscalls introduced in the 4.18 cycle:

  - Restartable sequences support is added, including MIPS support in
    the selftests.

  - io_pgetevents is wired up.

----------------------------------------------------------------
Huacai Chen (1):
      MIPS: io: Add barrier after register read in inX()

Linus Walleij (1):
      MIPS: pb44: Fix i2c-gpio GPIO descriptor table

Matthias Schiffer (1):
      mips: ftrace: fix static function graph tracing

Paul Burton (5):
      MIPS: Add support for restartable sequences
      MIPS: Add syscall detection for restartable sequences
      MIPS: Wire up the restartable sequences (rseq) syscall
      rseq/selftests: Implement MIPS support
      MIPS: Wire up io_pgetevents syscall

Tokunori Ikegami (1):
      MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum

 arch/mips/Kconfig                         |   1 +
 arch/mips/ath79/mach-pb44.c               |   2 +-
 arch/mips/bcm47xx/setup.c                 |   6 +
 arch/mips/include/asm/io.h                |   2 +
 arch/mips/include/asm/mipsregs.h          |   3 +
 arch/mips/include/uapi/asm/unistd.h       |  18 +-
 arch/mips/kernel/entry.S                  |   8 +
 arch/mips/kernel/mcount.S                 |  27 +-
 arch/mips/kernel/scall32-o32.S            |   2 +
 arch/mips/kernel/scall64-64.S             |   2 +
 arch/mips/kernel/scall64-n32.S            |   2 +
 arch/mips/kernel/scall64-o32.S            |   2 +
 arch/mips/kernel/signal.c                 |   3 +
 tools/testing/selftests/rseq/param_test.c |  24 +
 tools/testing/selftests/rseq/rseq-mips.h  | 725 ++++++++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 16 files changed, 807 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-mips.h

--ih6xvcxsso4ugtem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCWy7i+gAKCRA+p5+stXUA
3XsBAP0f+izE37WBvWvPx1Dx8z8UP8xcN8WZdmEiaoPNfMbjmAD9GAgWIXi3NID3
MtCFqLuv6ks/cpaSbnoLRWJt8Y0nnAo=
=DVaw
-----END PGP SIGNATURE-----

--ih6xvcxsso4ugtem--

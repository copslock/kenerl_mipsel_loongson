Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:51:57 +0100 (CET)
Received: from mail-by2nam01on0060.outbound.protection.outlook.com ([104.47.34.60]:55296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990419AbdKIAvu3hulQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 01:51:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4HRaMU7g0e0SSZzhBzdMwpwPlwE2cBKYD8XF62TEdrE=;
 b=GEz2oNnNW6xP9zO+Ea/pUXpiVMfrEh2o+DA6pNvHSXj73XW1YzNnW/SaidIgwgcV6rpgJDUORIcxigf9/RrB1w21eYbxoCLu7NfJROKnrNDrtayVWnl7OvDXfMGOsJsgWDqiCFrnbquGS6HGP2vhza7xBt3CN5MIEK50MOkb7Dk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 00:51:37 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/8] Cavium OCTEON-III network driver.
Date:   Wed,  8 Nov 2017 16:51:18 -0800
Message-Id: <20171109005126.21341-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0022.namprd07.prod.outlook.com (10.161.192.160)
 To CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f394f10d-cf43-4083-6778-08d5270c08d4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:LthhonwQeapbRsnSiJxInzdtsVZUaaJpPHG8wkkP7BzLYaW5A6wu6kM5doerdrjP71w30kopNpwy7MQKs8TNQ/b2UtfrXTC/5HRepjU/lxQgjSwSEkbCmQr51+C+mgyqgMPvCqFQ4NjCq4McvruQ+/Rhp+poLX+SDHkihpkyziYXE/kw+Bcuf1DdfqSdlkmE5EOxdd5rDnX8noPCT5k+MnPxIh4uVuWRi/Tjygv0VgNAmHWxlj0kpVTExjCdGFz9;25:Ju6OuH+oi7HL7oeKyPJkV+qoZpAaiCpLnPw1zYt8mICO9aZ25C+sSOqhW0n7/oBi+G67BAWqZ4vU/DSkC/X9qQ3cNPSKtZXq9dHhGUy1u3fOPTY6w1aORK16R9nsDxATJQz8RqmP63OOhE9ldGTsiz+FJuFWR8gpEi5iaHk91BsvIBQxy3GbXtIaj2XQjrwuM0ILA0IJ7P6sTNxyite4qMJtCk98t3fo3Qfh8Kh0sDNnpB6N2hrt9+4OsZNxcaw0NnlpqZMe7MVUh1d6LxHMw5p02t3FASgVpQC6XZyjCKKodMlkNoPECuPZZSUk6jp3Aw8VHZGL0lJef6fU1Um5kw==;31:6b0wvUIuIEAfRxNC54IUM0qQep4TG8MrN2Xam80cE0OJ8XFncb+ozrmS2dbVGcwQyA9B34sKINYBrDKTS8uV2e4L8ruCeFYNPJojH824VT5amST83p0X+mKjMYYVsQqa3KUarm4mv9yCAc6OoFpupphhKLHf8konUic+Zq55Lk166xltDjiTi2NPTpjJ+mxoRVgsAKFc7udnrCLRc0zjhLsXYHa29MNSNOh0LmVWay4=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:ZzXylSZKbEbj95ofLicfH/wlJPWGzLu3yR2ss0V2RPajwrkItsG+DR9KXJTYewJYHkBHHxflY+l5vaica5EGub2siB7bJOutipWMWQjcJ5iyng1wuNXEk8P+XpOm5w87DaCXLzVJ1LYnWYLBeeNzxfiopEdOr1hQ0y74oIqOsacpRyhSk6BxaoxDc4N8gdzDBCTbvHKcCYZFmotjR6pXgxIPq30pu1bzMoee7GJJcl/bTVsxBBT36QweTUFS4orEolwyAgZFemyKyz+IMARn9jvzc6hHpNRz1uFqv1aLcobUtCxQL8UyD0IbjQk1x4rTDwjD2bGuEJnCKQOgqMKz4oH51ds4YFTo+XvFdjmPM56DCVyLEQI3PgabEm0Gmo3RNIRbmcoMQSZv/qXCTGwdDYbzObUutpMSmwAKLoqsJ/nDZw99Ssplmo8ZuyDw3qlyyyvc+aBRdc/Vyv9YdRxS+v5cFbHEQhYVl7Q+feRH6B8ehoycbHe9h9z8bg9fVHlL;4:RjbQ+OR2LWNWg0aE0Eo7m+xGEH3IzfD41IEEP182Nz1rVXoMi0mu8Lx2Eqjl15VQdGYybueEvZr7vtxRo8nEBbggHgpT8cvfMm3/OzC/Xtb74u6anNeV05LURdYz/4vM0qq91tTHToGRYnOw+PxQ1/N1pgPiwOvulhWoXQBUXzM7ez+cHGFcJsjTmKu5cxuN720k4nLeRHkTnTL+83KcD4jRzQ4DIW69zcuoyiqDLkUP1bqMHyM+yIzUKCZ+xbiuGt+OSY1siwdcwDFAor6Kgw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34950C9F0B4D8647E87CBA1F97570@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231021)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(53936002)(6486002)(50466002)(6506006)(110136005)(36756003)(33646002)(7736002)(54906003)(50986999)(106356001)(189998001)(66066001)(2906002)(25786009)(305945005)(7416002)(97736004)(1076002)(48376002)(47776003)(105586002)(16526018)(3846002)(81156014)(6512007)(81166006)(6116002)(8936002)(5003940100001)(101416001)(8676002)(478600001)(53416004)(316002)(6666003)(50226002)(72206003)(4326008)(69596002)(5660300001)(68736007)(16586007)(39060400002)(86362001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:MwMOmUOkw4JV8o04MUrk7/ppSt9SwpAzmISwaqaa5?=
 =?us-ascii?Q?uHXfk1XJ1mFXnrBkjDvnArQu1+ab6BoGGa48mBcR6C+YBaeme1o3Omfl3Kgc?=
 =?us-ascii?Q?4369yEedqk5rSZm8qqj+LEpvZoYlfN4kFBapY2iozASLaud3lThfnPyh0F3V?=
 =?us-ascii?Q?hUvzXxNTaI0tDR2QrTxlDg2QibZK8GjzNeqqrqyL8WX5QvDWJJe3LjJuQ8CO?=
 =?us-ascii?Q?RJmPZt+9w4kuipm8X9Xmv0l3kd1diM7/sdWZB+1DLp+DHE21nR6ZbavCebgj?=
 =?us-ascii?Q?e0vpXkEHbjQoIngP2wlIqLk/5Vv4TfMxlZBWTp5VyNGPcP6ZHuvaXO35x50C?=
 =?us-ascii?Q?UeBem56ioAdCrZjSfN75IElYCfbQ0BwOv8+/Jby2CE1fUHixZoRCveY5PPVD?=
 =?us-ascii?Q?tjbGa9Je7YHwTHYGqiU7Us/OGjx1tCV7++CKvBEHFj0zhTt8aAwbIS8UiMGf?=
 =?us-ascii?Q?pZBph8CEif9ynNpjHUn8N7RCaKV9UpiIL7leYJcIqUcs10PMutfwDhvuDX76?=
 =?us-ascii?Q?KGwOTOh/zYB2h2dsLJGmFkPv68s0XqO2HxILKnwoyhKha547Aa0JyUlkvzc/?=
 =?us-ascii?Q?V3pe1PpBzHmGgm1wyI/TO/7U/uuG5QEFOMTH2hH7Rxzy83eSd4qWEeSynsoK?=
 =?us-ascii?Q?22T5B53QVbkniwBs8ZTqmqapEpoxbsQE0bq8Xf1Zu8+0FV/UofHAJrg1qvFV?=
 =?us-ascii?Q?gZ9l2yn2soecZpDgiNJQZMaHxX93HPHJOphrLhRsZlwTB5xOFM/2lD4o5Oj1?=
 =?us-ascii?Q?+YS8kBktWu2mUCfCukMQdic5ajsTAmcAeWjAkuzjZ0NdsY7GbWAIRmggiJWu?=
 =?us-ascii?Q?efyRClfBzYYQ5CygUXjCywTpbu1cnQ++ghsSYwXpb4FI2NvQvQMn1ohIDx4s?=
 =?us-ascii?Q?Y3iqaiplf6Loan/WPc5iscNMbKPZ5CI4wx7c5Zm8bRJTuVR7JYaMEvYr6M/6?=
 =?us-ascii?Q?4etcOC3aOXSW0fQqZ77qS5A73qls30Xza2cp2CnvHrhpEtO8WVCDegZchNEw?=
 =?us-ascii?Q?V2MoKeMzR/nD9isXxG46I3RLk4nTSV6EXYZAkI06aYmkwOMsxwa9ucEC2HGN?=
 =?us-ascii?Q?EyRV3HtYbT04EmE8LAWvkl+CTlUDatEagaZ+E1RcONYPfmGVccq3u6+R0e3O?=
 =?us-ascii?Q?U9ME3vszGvJco7PF1oXKibOuY2DVP3OBuL+HGSMBTNGf/utxkZUBXyer0Hl4?=
 =?us-ascii?Q?ZKpss4Ti34ZZCI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:yePLLO32h2x/vN6NSlSoop1KWyYyyNG8hMsIW8TcS+yiJ/07ySVXfvfba/VCgRIyZt0cf8jauf254gCBaRMu6YLN6pe1czn9xXXB3fOtd2WspcP9/owx3EFGEIQTjv5mWXGvGlDfjy+B4aMIWqBVP0H8g7Li+/Pemmmw3yTMxRgn411zriNALDX08twpyLqr6kMArKOZQtUYd23yG1PVMT1N1AAg/a6fqWF0MTfcQ3GvdXk35jOFxCgxmglukR+SeDdVBoVsC1aznchNVzJI42zhG8N5dqOCYLDgQQ4fdP+sYylqSa0tkFDX6DkBMDOcn7tjshwKQWm/v3nrcPP4nobKIJ/Drw/0u4GYzKV67uY=;5:c2jjtB4XcPEJ9w6GxTdVayiU3hpCuKFAOMRUKewRW7GX/tLtGNZjnceqSNH8sxipHIZKe5IEtTIMWmAkMmk424BZkuv6KBB0RUrx4totX/9ZT0NQQtsQjrx+ZjcURb7S0e2xspWAu1ar6HFWG/1tiI9i0R6aRGBd+jLXpGkLcS4=;24:vbiO0A123DaHCuYJRgvAA7CsOUfXLFcHQzq2xAKFJvsK+t82Y+GrjFICXHXIdvb+DlmEI3EnZ3SZHE9HP8xERu6nigy3F3ArB58U21Enb2k=;7:hsl0lZ+fgFNE0wxK3mSWRZT04PIe0d6MEJ6ThB7FU9tB4GMdmkgKoC22wgypnZodTjuL2BKSc9HbuM7JzhvavqstxppnAXknCJiUOgw0SV3Kua+wQ5fPwgQztkWgfqRDr4RvHyqZtguH+Ui/QwSBu3gPjtzeaux3QmXsGtqkdtUB/NaBzmn/PCPxX7TbgRxiGEIdPJlMYhupNazU5p2R5JBNTqZX0KqlToJLLOqtdoh59ubu6YxlvhNWbDSOvzTw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 00:51:37.2673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f394f10d-cf43-4083-6778-08d5270c08d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

We are adding the Cavium OCTEON-III network driver.  But since
interacting with the input and output queues is done via special CPU
local memory, we also need to add support to the MIPS/Octeon
architecture code.  Aren't SoCs nice in this way?

The first six patches add the SoC support needed by the driver, the
last two add the driver and an entry in MAINTAINERS.

Since these touch several subsystems (mips, staging, netdev), I would
propose merging via netdev, but defer to the maintainers if they think
something else would work better.

A separate pull request was recently done by Steven Hill for the
firmware required by the driver.

Changes from v1:

o Cleanup and use of standard bindings in the device tree bindings
  document.

o Added (hopefully) clarifying comments about several OCTEON
  architectural peculiarities.

o Removed unused testing code from the driver.

o Removed some module parameters that already default to the proper
  values.

o KConfig cleanup, including testing on x86_64, arm64 and mips.

o Fixed breakage to the driver for previous generation of OCTEON SoCs (in
  the staging directory still).

o Verified bisectability of the patch set.

Carlos Munoz (5):
  dt-bindings: Add Cavium Octeon Common Ethernet Interface.
  MIPS: Octeon: Enable LMTDMA/LMTST operations.
  MIPS: Octeon: Add a global resource manager.
  MIPS: Octeon: Add Free Pointer Unit (FPA) support.
  netdev: octeon-ethernet: Add Cavium Octeon III support.

David Daney (3):
  MIPS: Octeon: Automatically provision CVMSEG space.
  staging: octeon: Remove USE_ASYNC_IOBDMA macro.
  MAINTAINERS: Add entry for
    drivers/net/ethernet/cavium/octeon/octeon3-*

 .../devicetree/bindings/net/cavium-bgx.txt         |   61 +
 MAINTAINERS                                        |    6 +
 arch/mips/cavium-octeon/Kconfig                    |   35 +-
 arch/mips/cavium-octeon/Makefile                   |    4 +-
 arch/mips/cavium-octeon/octeon-fpa3.c              |  364 ++++
 arch/mips/cavium-octeon/resource-mgr.c             |  371 ++++
 arch/mips/cavium-octeon/setup.c                    |   22 +-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |   20 +-
 arch/mips/include/asm/mipsregs.h                   |    2 +
 arch/mips/include/asm/octeon/octeon.h              |   47 +-
 arch/mips/include/asm/processor.h                  |    2 +-
 arch/mips/kernel/octeon_switch.S                   |    2 -
 arch/mips/mm/tlbex.c                               |   29 +-
 drivers/net/ethernet/cavium/Kconfig                |   55 +-
 drivers/net/ethernet/cavium/octeon/Makefile        |    6 +
 .../net/ethernet/cavium/octeon/octeon3-bgx-nexus.c |  698 +++++++
 .../net/ethernet/cavium/octeon/octeon3-bgx-port.c  | 2028 +++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-core.c  | 2068 ++++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  833 ++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1719 ++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  309 +++
 drivers/net/ethernet/cavium/octeon/octeon3.h       |  411 ++++
 drivers/staging/octeon/ethernet-defines.h          |    6 -
 drivers/staging/octeon/ethernet-rx.c               |   25 +-
 drivers/staging/octeon/ethernet-tx.c               |   85 +-
 25 files changed, 9065 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt
 create mode 100644 arch/mips/cavium-octeon/octeon-fpa3.c
 create mode 100644 arch/mips/cavium-octeon/resource-mgr.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-core.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pki.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pko.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-sso.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3.h

-- 
2.13.6

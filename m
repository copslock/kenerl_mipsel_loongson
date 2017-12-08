Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 01:10:06 +0100 (CET)
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:35584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990431AbdLHAJy60TuA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 01:09:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=S7VJN6nmcdK6myzwv6/y7mIQntXhRpr/EQz59YoIDFE=;
 b=AUFh4VKIA8t2a4MJMDD9Fg69X589Qq92A/Ar49Vm8mugwSG8AVard/efiQ7PHN9N0yqNASgzjOE9S7h9TSHZSdCIMtZAi/6PHY8xC2lanr65SZ2csWYoL/uAxLGtdAXZwRXaHsUpMm+HX76yiMworUGEIlGo/vf+HQ0ZihUzBcw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Fri, 8 Dec 2017 00:09:43 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v6 net-next,mips 0/7] Cavium OCTEON-III network driver.
Date:   Thu,  7 Dec 2017 16:09:27 -0800
Message-Id: <20171208000934.6554-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0068.namprd07.prod.outlook.com (10.174.192.36) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d390d2eb-1c5f-40e5-b8a7-08d53dcffc0a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:iZX3AZGDM2UuPC528WUvlAQDyBcmTh/3tCa0M+TO/a1Hxu+rYdvWKLy5s7rOqmMgFcoqIeerr3vmllJcsXgFdJqX7Q2XEkGab6qASuu1MiqwjAmXWLjqj+tzY5r0DkTeXHmMjvf8VwVVjLorqSIe5Q+sGYImAfHX2XuhqJyCXBPyt8d0btK8eGhNpIZG7FDGjrv3MbrKAcNg90O8EGW0aX1hdnEY4AXcfNXVdnTJGEwAs7B6ROjzdKiTsmFM5cNv;25:JJf2XNcNsLXBB/jYZtbRTOBe21QY2B4tnGYYhgqU1Rss6+HhGBKHt/8ERdnbbBbT0dCB6nSNesIgfDr9R6yCXB1ysALaSEVfw1AuTW45wxgTnBMRyxMOurP8kOP5kysp89JNEjRuflRrYqir+ZEJjA+I5YXLBIJy5Ua/MwfnJRj/bWMxeGSRecnJJsGEZ4dbKXyKHnETeHMOzPnHmb6y+wVkplJQfbsuXBjeNQiygCx8FnBZA3SPb46MayhJbSEtWz6PKBj9cnRP8t/k2kuxCW5vekpJV1fBC9XI7lp5tIWsAfLKcdtcF254N74ye9Tg+/6kVv34H14CzsWjhPJu6A==;31:WVtCiannho1C7lNrhXeriDwwPlDZY9sI4ac2KVwW/QJn7ec6bWynEbvpToa7alYw9634qJInejebGEA9SgXbRDAqgpRut7TIX5uUq6wBSCc2QxVQzu09/E0oDKL1VVjkR//bV+zpgTj48JX6sbQknLp/Kj0qNNT+FHdqgPjyvQ/BiCb58r/pEU+tIcbFyowZDW5MlXmieNpWUq7ZAaJmGTz79FEOLwnRd3La5UgRyVE=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:3pjhYUpgfRaehwGHrdARjJKUAjnvW4pOV2vKzDZQh13qOGaylSEz9zoBrJtMfTVjAkyRNjVqJpzFiU/fE4fZjmq9OH5ZDXH2lxYrToh0y0LzubJPo71bMAaWrFBw2Eu9aAchpUh7Kc1mQURT1WTO+gppSGjO7YscEwsvfB6ffBP6u6REFxGRaGI4c6c8djDCVKqC2fyYhWcq/VdO2NnvvfSDfRCr0J/AwZFUn3QG40pYbZwIVBQ792ExxF75gdEGl6GtqFPZPbXZtDlUv8UqreV+AymEOBFb9HCYxxjxTzg88MGdSNGRHMvgCNicbKyhOmRthHunhGFFS8Y+MRdS+RbUpHCVqR/cR1aPIhxIdUOIO/0cj0FM5NCb7xhXFxP90RwETpW/lNcuceQebKxALCcBptf+o39eMApgOjH17VWgySXHpgHdCMEtUYXKCyfdQQkR2+WbV2pVJ463iCTb+Rp3rQ8PlMQG6srrI2bMURuF6Eup45vamyD9h6aF2YOn;4:a7Wd2I+9LTCy0GzkubMJjZSXPq8PVcDpGToHPXoZITRaWx9uOfiojw9oWEkNSB8v9RCfOuIwWGZSMn9+OY40A6fr7GMye3l0P/zJhF4G/zmovhByX0HuHHco/eGTphGVRihWUDqsnP9dYiXXeFbCFVotofuGNtDOJEdmCyy1PaO5UGrTWnhRDyrQHlPC5TO0LaYkIDrIK9S0ngy4M91Xmouc31VFFlmScW3711KNvenrU1np413tTc7DWjtaYLKOvJa0LBJ9XNFLvsZ3ygCZ6w==
X-Microsoft-Antispam-PRVS: <MWHPR07MB350491447BFAE5E5E036FDA897300@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231022)(93006095)(93001095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123555025)(20161123562025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0515208626
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(199004)(189003)(86362001)(105586002)(106356001)(81166006)(81156014)(8676002)(69596002)(6512007)(47776003)(107886003)(66066001)(48376002)(4326008)(39060400002)(7736002)(50466002)(305945005)(53416004)(53936002)(51416003)(52116002)(68736007)(36756003)(6486002)(6506006)(8936002)(50226002)(478600001)(33646002)(72206003)(16526018)(25786009)(3846002)(6116002)(97736004)(16586007)(316002)(2906002)(7416002)(1076002)(54906003)(110136005)(6666003)(5660300001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3504;23:5m9j2EqMSzmWLT2/lOI/Mev7HTnuScVC3tivfdR5L?=
 =?us-ascii?Q?KsJ91A4Xj4ADbRIa/y0hqbNAKwDjC8NkXPxipwWOpqyEqJs5j5HqQ/A5f9z8?=
 =?us-ascii?Q?zcWxhB8fUJSykGWRPprDg7s2lEHgZApiSq/QczbYelKE3SN9em+RTjyAuwWA?=
 =?us-ascii?Q?4kyOH87a7q75wIf1FyyocJKxvuZNz/b4t9pYifqTA4PxmldwAYcYuKpVAeSv?=
 =?us-ascii?Q?KeGkhJeUMzrt5tJlWyAkyhBIGEExoIiP+V52imsAdKKofjEDeIQVAcbwDGWq?=
 =?us-ascii?Q?6Grp6WN20bFrxfPJAizLMZ05Rq0t2KAWVbV/vS1No0cvr0OMVkXYDh9o5sPl?=
 =?us-ascii?Q?hcH+KCthiwnGKbFaFNKj3TkCs7nFsvL/DEyJmYiLaWLs5sldHxTqIbt7xb+V?=
 =?us-ascii?Q?etWgb1jhWPOGbPtW8p5kWRZFtv8oYRwc7nQ3oUa6W7YU1MINvOfNRD3xDg+p?=
 =?us-ascii?Q?rZA1ju4XpcNO6NZvVqzsVmQZYG/itryRVHSBNxkSL63gTxhUSpnFCG9SDs3z?=
 =?us-ascii?Q?vhHj5bb4Z9YSKPUTuGJnPyDs1DZz6Eqx3DZ3KlJzw4uSsndvdg55zGVmO0q/?=
 =?us-ascii?Q?VN0UC4Alv3fqzS9WC3600FoJPsf64hNBw6KAdNnfXRnWE080dUhz9k9KwOGw?=
 =?us-ascii?Q?qcC99mKtcnBBQ322P5JCkw6sg62Nm8XoFyVV5k2+e85AUG4tkcU+ETxsTLHp?=
 =?us-ascii?Q?q4Y54a32pxkooy4qTjqRM3SQIqJPKVZzJ2ovR1095UciGOjEfrT2Dwil34Lc?=
 =?us-ascii?Q?c9ERhAsiNGrsfUX6hFyHWmIDcDZr/64CgiTPZyPASCLQJCMUZYqEuqvpVT20?=
 =?us-ascii?Q?0xHvPKQ0N6q5l3DNkZdFpjGm20kSscIYg0HwQLQUmQLO5v1bSjpRbcaLCxo1?=
 =?us-ascii?Q?YfbRUyGAA7mkB5oWrzmLhigqn6Dk/GRa2TfdOePyShAnhGUbrU96Xj9KMdI3?=
 =?us-ascii?Q?oVHD4HoSSA5cFqp4Q6cHlekEI5cfz2zjHYEGDSfGrfv/zVc3599FQrZ0BnQq?=
 =?us-ascii?Q?zfVzPu6bROgwNUZcVyZ7MrnNaBnGt23RAQbVmxs6xaHJ0CmN3w//6BX1sLxa?=
 =?us-ascii?Q?R9tROvWOU9uar0LKb/4qjyl4k+dc4XaYHLZ1DjKUxM9GvhNt0CGGsgz4PFD3?=
 =?us-ascii?Q?bdCA/GOa8A0ScYVsVgOYVR87RCq515xCdbxlldFxgS+cXSaa9GLjA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:lyK3ESKpsZZsTQa2i3+Wa+v9frxwhMfU/ItHYi+hUipUvBeX0PeuxQHB2ZR9BLLG3f2OOThIUf90eQ7RsOdmgEi6Shpqlfvxmnkq0j6XEspDBtEiJiFMW3wq2C5yIuq3ZBTL89IYapuaODSTkmOtA8Cg6/yCKm0jYAyeC3XwyiFBh2E8DTnL3qs1IudbKKu2L4UiJ59LSYaZA4gAH8eDiaLuTGmPxEdEhVLQhm/mo0P/MUSL0YbD6//yE0e9oBpXvUEa6lbV1W0CggJSG3DrLfCidAMT5mXE33atIMr5faKddKMKHRDuqA6nLiOJWd221R1n6Q3/OFIDiANbITE+hF302hBiSOAqNf6VqbZksQI=;5:NQoW5yaVYmzCW/6S/+RXzeHrLcrNHD0r5Qq1TWmnk/kPMiqXs4YjZV9j/x3cY8LhQK0EWi6u1HoGbJQnV0iFBT26l//QEzag1SG8z/YRP7+t9pRl+CV3TgZwcwGHcJrlttEvFpg3GzPYYAZlYruzrwdDmrlLxOZtEQMLsKYPE7U=;24:T3KVGG9qrCID5k2AAT18UsrUCwWEOycDwddiv8i4uv3Kn0sq4yDya+G9aUO33piBYAE55iwMdxG4anoA9CMKU1Z+jzNOxJ2TbYDFuB9gcTk=;7:uVMa9ZfQKr2I9ql+YRe+PLGGPNOFHFGLBv2NGIild9FZdd1lOnOYYk2GbSkvP14Z2n3+3m135Xm745enC0kmpToeYqhFnyylOq5fdq3TrjWy1uRVNUf7HiytTDCgEiNFukRcVyCUaF8uD/7xlajr+/eCxb9KZEgvY7jiGUehKsIs/QgKxPkelGgo202hOV69lsry+/useQiCSFWdPzF5WDvgQadBHLZIBHIdusan1Wtt0kYGbGRbFOmC3CtAlhiQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2017 00:09:43.4660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d390d2eb-1c5f-40e5-b8a7-08d53dcffc0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61342
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

The first five patches add the SoC support needed by the driver, the
last two add the driver and an entry in MAINTAINERS.

Since these touch several subsystems (mips, netdev), I would
propose merging via netdev, but defer to the maintainers if they think
something else would work better.

A separate pull request was recently done by Steven Hill for the
firmware required by the driver.

Changes in v6:

o Added back cleanup patch for previous generation SoC "staging"
  driver, as Greg K-H acked it.

o Moved FPA driver to drivers/net/ethernet/cavium/octeon as it is
  currently only used by the octeon3-ethernet driver.

o Many code formatting fixes as noted by davem.

Changes in v5:

o Removed cleanup patch for previous generation SoC "staging" driver,
  as it will be sent as a follow-on.

o Fixed kernel doc formatting in all patches.

o Removed redundant licensing text boilerplate.

o Reviewed-by: header added to 2/7.

o Rewrote locking code in 3/7 to eliminate inline asm.

Changes in v4:

o Use phy_print_status() instead of open coding the equivalent.

o Print warning on phy mode mismatch.

o Improve dt-bindings and add Acked-by.

Changes in v3:

o Fix PKI (RX path) initialization to work with little endian kernel.

Changes in v2:

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

Carlos Munoz (4):
  dt-bindings: Add Cavium Octeon Common Ethernet Interface.
  MIPS: Octeon: Enable LMTDMA/LMTST operations.
  MIPS: Octeon: Add a global resource manager.
  netdev: octeon-ethernet: Add Cavium Octeon III support.

David Daney (3):
  MIPS: Octeon: Automatically provision CVMSEG space.
  staging: octeon: Remove USE_ASYNC_IOBDMA macro.
  MAINTAINERS: Add entry for
    drivers/net/ethernet/cavium/octeon/octeon3-*

 .../devicetree/bindings/net/cavium-bgx.txt         |   61 +
 MAINTAINERS                                        |    6 +
 arch/mips/cavium-octeon/Kconfig                    |   27 +-
 arch/mips/cavium-octeon/Makefile                   |    1 +
 arch/mips/cavium-octeon/resource-mgr.c             |  351 ++++
 arch/mips/cavium-octeon/setup.c                    |   22 +-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |   20 +-
 arch/mips/include/asm/mipsregs.h                   |    2 +
 arch/mips/include/asm/octeon/octeon.h              |   32 +-
 arch/mips/include/asm/processor.h                  |    2 +-
 arch/mips/kernel/octeon_switch.S                   |    2 -
 arch/mips/mm/tlbex.c                               |   29 +-
 drivers/net/ethernet/cavium/Kconfig                |   59 +-
 drivers/net/ethernet/cavium/octeon/Makefile        |    7 +
 .../net/ethernet/cavium/octeon/octeon3-bgx-nexus.c |  417 ++++
 .../net/ethernet/cavium/octeon/octeon3-bgx-port.c  | 2018 +++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-core.c  | 2079 ++++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-fpa.c   |  358 ++++
 drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  823 ++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1688 ++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  301 +++
 drivers/net/ethernet/cavium/octeon/octeon3.h       |  430 ++++
 drivers/staging/octeon/ethernet-defines.h          |    6 -
 drivers/staging/octeon/ethernet-rx.c               |   25 +-
 drivers/staging/octeon/ethernet-tx.c               |   85 +-
 25 files changed, 8709 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt
 create mode 100644 arch/mips/cavium-octeon/resource-mgr.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-core.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-fpa.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pki.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pko.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-sso.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3.h

-- 
2.14.3

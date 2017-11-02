Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 01:36:35 +0100 (CET)
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:44904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993090AbdKBAg1yYHKm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 01:36:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kjjyiYqvb2teGQjsyeSjB0XX8lmk5wFbYilDaJlrxgg=;
 b=WWGzeyOE+7oxqG4J5lmhHp6SRo8UC2O0vkhfQBl0weGtjnW+/yko5zFQOQMNs9EeZXHgzx/oGtd90oPAgdWdsscD1PFn+VAtSw8+VD5xdNamw/XKpfd3r6q2XFv/Mo9vPtSmWjwl2Jz/7mp5e0d0B/8bgwHMiklrDHSKPTASeIo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 00:36:16 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/7] Cavium OCTEON-III network driver.
Date:   Wed,  1 Nov 2017 17:35:59 -0700
Message-Id: <20171102003606.19913-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0072.namprd07.prod.outlook.com (10.174.192.40) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f0ff68-bf4b-42d9-0ba8-08d52189bb01
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:pdUPGdUSa1cXQ3ZA+v+DTe0zCxfxtMbmski3VMvPwmJUiW59p7dF6yPWwIqcQ3ouVUHvrtvy4uXPJ5YscvJfrWsegPI1Ij+sQnnbvNOdZtG4aezjRi3r1SaZ+UA2dzUc+cYNw7Y2jn92DcLqiKwXAqHHX6MMnr8PXFg3o2+0etOdDPGS24erwD6TuHbmi7tREoPcu6wWe+HZNK48k4Hw0FcLjjKVMH5Y/8iMgFXY15rrt70dpxzPExvtaxZpU0nF;25:XAzKhqHjXaoIjH6l+pNJmBUhl5AT6GKWKtBxAELH/oe92LQkYqXLewggZKwU7a/AItuqYnJjD4+RhTO3QmxuNCdpTQ9XlsC8m7Sj/+aCYcxTIgT5g3zT4Y0V+wftWEni8kuTf3gfYmosrgLIW9LQcj+hURFcFqqDKJhZLNiw0yb25iVW1M7IxzNqHusYj+2RoNQm7o7hXjticjZ1F2DGa8+Xz32T9Z1O5Lbsg1d4zJkxFbu1uomEiHVal9nDRFjQB1pxt/tkrACY1ThuJYJfkZHCRMeXQzEQ8m5ZcDQCRqvU5vrgK/O3pxHFnYhy+w1nplDSJtS+5Rx4keCYyS83nQ==;31:k2G+JFRSj5Y1Gkgx0T/t0xHctTwUgdoDLr83z3Qg3LalupNqaZ+F10xUVkt9/VbyUMsfK5O4qc+En4t3PaligOqDaYJ72cG9NNcFaqW6WK4JhKKyyvwLdZt2NG+LWburuUnK9Gym6Ko+9CM5jdbu22dW3u8aXw8zjora++2t2bRoFhZF+PRZuoUpvE6L1wdOrstDWJ1CEzGODR+yOU8k+2/Vo3sNVZ9ld+T8vi2sdcI=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:CVRSZPHqs6J8XB0hKL+x0txNOu8Wf32M/X3douzpyA7yuRrEhry6EYg/s1yNKnlouyeOKtgLNOFbAcBVzVtEQjh+cgCZWKB7pzILxmMb0PCx1M+heJAiRIwrZgLTYcolFYnazKurURzvl9qr5NuVoT1f7Kcrk37CKmQNRz/l5zGx1A84Of94s7MraHD7FnRJ5jP3HQKsDDNx/H5yusZY8Sbfc5dqL/snlN0reKHgb0agT0yPYE+MgyJyyb6q0pFUDPYX5YlAEHoI6WsTd/CwRZixRqY1oh2Pzk4PIvdH4W0bRdlx0dPi5sjm0mbrCPgJQ11NHqpXelt6FxVhvO/KhXmM2pm5ugvseuaM5k+o5tNlT/mFMnCQ8GIAjfHz5a3HhZ8KMCdMiu53d5yu3QKSsSEfHU7zdJgFKuaDa0sGhKXh2Pb4zLzNBeGtJGF4D5MSjfwcJbrNgzIgQcR5fzo2m7tbizRSI+XAhId8lQ3dtUM0o2N/uXJL7syn5H573ry7;4:pOu5zIV0N7KpdSDmsxMxlif/WsUGfHuOiSfVXD2G7KBHy9N3Lh8e1WAquJ6MDOmDtoHIOwnsNQxDdygVBpeJQOGHbKDzWcfSQ6shDmJnpP/gEWUFV9M3hSTVocxTd4zps2KCCyRNV5HeNJwXMz5syYr/1UhNEoXxKLZimOg4rHdxxPS7GUN1SbpSUspOWBBsk2YEqWJCBrFonDlQBDutUnAVT61euQkWX3ORWeQhw98fUmLLDJVqnYLvkHVIEM698RIcSnOl/5aPGXxXK/4J2g==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB349621945D32A48AA7045F8E975C0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(3231020)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(25786009)(72206003)(16526018)(50226002)(53416004)(7736002)(105586002)(305945005)(101416001)(48376002)(478600001)(50986999)(6506006)(50466002)(33646002)(47776003)(5003940100001)(106356001)(107886003)(68736007)(2906002)(4326008)(6666003)(6486002)(6512007)(316002)(110136005)(97736004)(16586007)(54906003)(5660300001)(53936002)(189998001)(3846002)(36756003)(6116002)(8936002)(66066001)(1076002)(8676002)(81166006)(81156014)(86362001)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:mf54luDL/Z8aK6vs3mMkNB+gRjUXo8aDYjZX92TlK?=
 =?us-ascii?Q?2HPO7Kg2paR5IV83zMu+f+H37pfbP6Z4SGeomhpx0gsOZeMADg11ipED4Oob?=
 =?us-ascii?Q?8JUl5Bfic0KZLkxC7LmimNhMY43ZAq5fVXvR7M0R7herj11MAvgVWoutSPX+?=
 =?us-ascii?Q?kPA1WgTtQasa9ft3TfXP8E0+3c7i7srtN7odhxspD/XeRfokBPZEUVHwYFPf?=
 =?us-ascii?Q?J+4wpGF5xtJ4uq+kSQ1a+eyzrayju2EL1WDfgAvQKJk46/eth3FbtlPRJ16y?=
 =?us-ascii?Q?QYFEy2FzPq9vdTB47e8x6Vj+1lGlpwXj4UxmwBKNp5EKoC2pneZqB4tzd+yX?=
 =?us-ascii?Q?dYgqOzBwTcYzmoYqoJDcSgYEGuNdzNDSGVDAVnwHBA4gZaFEU4MtI+U7bEGa?=
 =?us-ascii?Q?OljyDHihN3HgnjMPtqswrarXZUpFTKp2FCUbDYzP5tGjnc2tUq/ajEXhO74h?=
 =?us-ascii?Q?ppRPLZ3VPTekvq/BQ7JSBnYblt7Ctm08WxFgvobvC8SP3t5yvirAv7lEaaGS?=
 =?us-ascii?Q?KbawnI4KR4u0pcWye2urB5mjlRS1jiiuAr7R1tBXgQm+fKcSv8ujk8eOc2xz?=
 =?us-ascii?Q?y1X8299ci3wVKaOTitwjA5k+vy5p8bVf13zsb0VsUzd8xnZMgKf1yXgLU5mF?=
 =?us-ascii?Q?ayWLDBQw1paOzxcUjQvomXeTP4/2CEQuOtTF5HfAFN4JUr7WQ4qOP9xGSlzy?=
 =?us-ascii?Q?JGDtacJxuPF+Pzf2PFFGacTUKUVuMR+DwQ5cSDkqFNFXrpzPEcIV0y/D/fXv?=
 =?us-ascii?Q?vl/oLzqqe3t3PDjOkHYNCcO40zKtFAfX0MMDq1XNpgfY/Pgg2l9k9MxxqGgV?=
 =?us-ascii?Q?ysuvA7xloS4Jm8ealBKyiPR1tkjgO5Cxq5H1BkixpBYgDetXqif1XdOVyD1u?=
 =?us-ascii?Q?iIytv/5RnNqPvi3kEkPXGu+SmIvSULeMlNs+dKPzSYd2akZYKbwv505Dwb0J?=
 =?us-ascii?Q?Dr+k4vHEoLE1RbGD7KKaF68rSwYJ66uemVNeFFsXvJ4YXk1KfglUH02Iux4R?=
 =?us-ascii?Q?roQTO8pchzytg+ABORfSoF1p9V/bKRUK/aea5iGBqlaDhKi91OW4bjGeZJuL?=
 =?us-ascii?Q?xV0ULLEFcsMNuDpIWJ/K1Mb7pyD+3cS2OfIkUjPrtw9vIWYWczhLR5WTc/FK?=
 =?us-ascii?Q?ybB3qdMlgp2q+8U2iXPP+6IQXfg8b4s?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:wGAdGxBbbfTD8CKEL3H6grJgyvG9EYarMiyJB+2iZNAUkj/yJ4ba/2FNmWgUPm6hka64Muy5MfOLIdzoz8+dmjz5H0S4jYGNwL6L7dU0XB8gLHRK5XXwsdHRkJw4vaWIl/KvorngHW5NsyNCLDKtFW3F2oXN0Dg0MXVidxNAHRcxgiJbKk+wsaU+w/AxhP5cL9wU7lM81ptfpmTUuithAe+2L10NlEhG+SFFiPhczuT2wQw9Oi/qXTafKE3JCY9zXcHBpR7qP38VlHQdAmTtXpruXpsN59Oqh55Cq0Bhqzd1JgjGsht3pxQDjDigTTX23QBrT5KQz7tek8UL/kmeS87dDbcgBTaU6q/3/hZPLXA=;5:5qA0iD637f4qLybOPphpzr5dtrAdxh/EjHYgt5nzeFDaZvl+jPMvDYQnpNcGo4VWchizpKw9VZwupSccOKCRqQ91ObUm68prP46HYDEybuokpkeD1eH+Nw3FSJG2ztUMCl+zt4xLvL6LFli0DnY7CWUEnWEP4LoFIsxMXp1QSq8=;24:S6Ee9mg9aj29EGXJfhB0kXdXB7hkZocxVY6gXvHuzvqKsQ9DYDi7OAa6GeUzpsON3E4dyEe3RsE3IdkoD71KlmA203yi70wEAAzeP/sIctE=;7:rYHq1Y/3Cevr5w2D5BCryDwgLdXuA1MbSMM1ahphxwK9wB69vZuzj5UIvUmXKotTU2NBfNP0Fi+izRLvmFLREJ+oNW+Rz9TijXfbRjWfn8lc2sIs+AUKp+E0VheW0tZGcHMazxOK/ZzG7h/gnxOrrh+erQzhrOhMYSK36XkjDk9zwyuqHdWjns5XAG+Q7gouQuFRpe/47MOX1nycQlrgioq2dicZFuyl3VXsNjjKT8K/NHweSjsWcj+HGho6uVYK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 00:36:16.6467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f0ff68-bf4b-42d9-0ba8-08d52189bb01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60645
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

Since these touch several subsystems, I would propose merging via
netdev, but defer to the maintainers if they think something else
would work better.

A separate pull request was recently done by Steven Hill for the
firmware required by the driver.

Carlos Munoz (5):
  dt-bindings: Add Cavium Octeon Common Ethernet Interface.
  MIPS: Octeon: Enable LMTDMA/LMTST operations.
  MIPS: Octeon: Add a global resource manager.
  MIPS: Octeon: Add Free Pointer Unit (FPA) support.
  netdev: octeon-ethernet: Add Cavium Octeon III support.

David Daney (2):
  MIPS: Octeon: Automatically provision CVMSEG space.
  MAINTAINERS: Add entry for
    drivers/net/ethernet/cavium/octeon/octeon3-*

 .../devicetree/bindings/net/cavium-bgx.txt         |   59 +
 MAINTAINERS                                        |    6 +
 arch/mips/cavium-octeon/Kconfig                    |   37 +-
 arch/mips/cavium-octeon/Makefile                   |    4 +-
 arch/mips/cavium-octeon/octeon-fpa3.c              |  363 ++++
 arch/mips/cavium-octeon/resource-mgr.c             |  362 ++++
 arch/mips/cavium-octeon/setup.c                    |   22 +-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |   20 +-
 arch/mips/include/asm/mipsregs.h                   |    2 +
 arch/mips/include/asm/octeon/octeon.h              |   47 +-
 arch/mips/include/asm/processor.h                  |    2 +-
 arch/mips/kernel/octeon_switch.S                   |    2 -
 arch/mips/kernel/unaligned.c                       |    3 +
 arch/mips/mm/tlbex.c                               |   29 +-
 drivers/net/ethernet/cavium/Kconfig                |   28 +-
 drivers/net/ethernet/cavium/octeon/Makefile        |    6 +
 .../net/ethernet/cavium/octeon/octeon3-bgx-nexus.c |  698 +++++++
 .../net/ethernet/cavium/octeon/octeon3-bgx-port.c  | 2023 +++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-core.c  | 2075 ++++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  833 ++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1719 ++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  309 +++
 drivers/net/ethernet/cavium/octeon/octeon3.h       |  411 ++++
 23 files changed, 9005 insertions(+), 55 deletions(-)
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

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 20:29:43 +0100 (CET)
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com ([104.47.32.48]:12112
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991743AbdKIT3fUdKCL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 20:29:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qw20GSjqevANVTbjDkXC3X1v2JNWCfHkPGhFq0Q4n2U=;
 b=L2IwdCukFz5Q5kMf3m30qfArtYEC2M64is+i+PXVaNYR+LlxZztkWy1ZXDmIuVpJkfs1GdSKY+gckHePu0oqGrRM6OjHU9k4qVEMlicOsqL68PNsWUq9eMhSist9sAMye9I2loB7UI/cW4VZ1Vm2HwXUqKqiDUrvAjP8S7axz8U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 19:29:24 +0000
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
Subject: [PATCH v3 0/8] Cavium OCTEON-III network driver.
Date:   Thu,  9 Nov 2017 11:29:07 -0800
Message-Id: <20171109192915.11912-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 743ef187-6ea3-4f46-87bf-08d527a82fca
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:X++t4+RtSI8Xz54ab8gYWJkqSiQ62Ar0G0CEPYYZuMWZDZxTof/LczJypg+gd6ppbUCsYdycajdwaRHVpbP7uTK+RzH6uX/gM3E3dYdpqVp0eD8QrMKClmthzGuJEfizU+FRBtSbOLVF/myZ8jccpQDsQIrqcXqwCKMrDimpfZJpn5bl3epGf8R4F4rsF4fOL9V9XncDt7S0HjW0RgLAhFaszY4QI3xyYwpiGhbagVM3SZAsFQwkB/Np0SNQb5YA;25:I2s1QNJPqavtOe57SDwTuJGaePmApXgjAGVXxMK2VW/WEcmJ6k63mQGnJQ621zva12oIAz2mkzFoC5ZCeCtkFtbOWGQCa6/1ueVuomwNVccyvY6FPIoKMeyaUpkOla/pjGY15zIrBP0bunsjFY5d5Iu0IR6bC8CEc51LhajNXoXPu6AvAUT1566hCoQ4TeZO/82/w2HTs0FAIKWYOlKMYE1CNaSVVmbteDRFxDclyHGBeeWwWvGTnJWRocjsu+q+ZOmT6HrHlMH960/pRc6vckkJNWPnb9LY494odTRkWG4dSLZqMgperP9UDe+QAbe7UDywzPMcMhgLq0OQNnUIYw==;31:2adCt8+kFtUDiK8YtbQ9uGIroHqLc5iaISsECIOplq7FcamBvk73BslVfT/5DAh7AOa+GA5wJyk/OXrAXHbY0w0uxM1jYaU6YP8ldCRejnVADO8wuZlHHikZxFWCRdfOp2lP9OubFwXw7Yn7b3hiSvOE0QEMkFU4298Vpw7geQP2cd1a+A2qdAlzCNn/ei7B3PzjdK86Lkyh7u5qx9SlXTSVSeqz39ABMIQ07e2q+G8=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:InUOtEzMT41yMWuAfUiPekPwTA44SXHE93bw+Am5g13eQc7GjJEpPBdyR6Gl1beZWj5h3WqKW/uTaERkEfJ8UFpOsvgpuq8e7Lv52WM3PJ8a9Boq21ItstSnJ7td5EWIlRNfWu9IDjR01Uk/l5rscL2CoccEVcUIbERsGShj5xR8G7VdTmu2ZDP03ilJ6TYvN/VK8lvsaxr1q9y9S9Pzs6546/ACAZk8PWUVofX/JjNviDjK70HS/cw3gR7e9yqvpCNn6I1a8xoh8kPx7e8dPYr4ra1xxb0LLtMV+GnZoWQnbngDdNzj5UNDKnGXhy4gbdRV4oA/inyv0rI2Xa76GsafUDWPc24C1c72MsAVgiX7+I73NI3y4dbwCHDAGCWaCknpNBvkKtMs4ONY1Q9DarPPIy4vkNMkpvwKZ9DZp/lYfr2i8xEMRgtN/Em9qBTCSgHj7c8MhqexC7YSWLxk+L3/3jWUMdMpPMJixjYUeAxJOF1cgIiBq/xL7G1OGQ7s;4:nEQYVRC/gkyZD9sPJSP7AwO9YijkgMtHQrZcasUfj/vLHYwI4c26FlSQqQkYwKclW4JsU+Nwm/zHV4MPBBTp3D6IS5Q3tVWn6/HYzwKoyzPtSl+jDeSXwe+sK3AJo18Y6IjNJLi9pDr920bd19Ck7Ja06svoL/rmBDqVh0SQfiN00KepeJhC6bLNF6xYE+QlPAX27Y3OhVGNQcI2GzotPKM5LCez6MXkIvq4uuc7nXAS/GtApD5I9oIKGZ4U3G0GC/sOjVkZFiVNEvphIQGTIw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496CC21FDEB3D8F30CC57A997570@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(3231021)(6041248)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(6116002)(47776003)(6512007)(8676002)(478600001)(81166006)(81156014)(1076002)(36756003)(101416001)(6666003)(69596002)(110136005)(189998001)(86362001)(97736004)(2906002)(54906003)(3846002)(50986999)(16586007)(316002)(68736007)(8936002)(50226002)(106356001)(48376002)(50466002)(53416004)(105586002)(305945005)(7736002)(72206003)(25786009)(66066001)(53936002)(107886003)(6486002)(16526018)(39060400002)(33646002)(5660300001)(4326008)(7416002)(5003940100001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:0wSj79Yv+B9+VLDVsqMhTTlR25ugjiIK0GFVz5RJm?=
 =?us-ascii?Q?RQOsWWcBIiMTOpwS0+nHgf+E00dl748i+CEJt+wc1iAKaJQBalv+WK/bfbKT?=
 =?us-ascii?Q?1BuTpCXBPA6DT/Vqq56LZqFkoyHuctwVLE8qfz9kErPJSd/CwSjgQWgGgXPY?=
 =?us-ascii?Q?QDLI4YKjldLK7Iw4hsil6EGwh1QqOEtBBiRRZ/YMFAyvQly68/z7Zv+dpg+/?=
 =?us-ascii?Q?JKACCWz3FrtpOiSUaVDwTCuXqEkU3G9xbkjGjJo/52iJfhVNEwk/XMR0Gcma?=
 =?us-ascii?Q?4TdQG/KA811KJA+LfJfS0uWSPhzrjhWDpxibg4uWDXqg7N/IEfCpKLJoySfz?=
 =?us-ascii?Q?IbZDPGPflHMGtPggghnssOcw4nOsIUZOJtQasfGTss6C57v8JtgEDRJdz+W0?=
 =?us-ascii?Q?LXf+O6LZHVTQurT+7bLVQ0kP5Wr4HhQFmAK5qkzRiAzhKnjfR3wCB3rf+/Yg?=
 =?us-ascii?Q?pcBEqcuP+7a3fzzVvgzQideZ7qhP8g8nTyDsAF/4nSleBnd++rO92oLyWj2L?=
 =?us-ascii?Q?F8U5uVoXo71EqI5bb6skA++V0TAjKUqLtElR4Nfwsh4r2Z8W4Togb0ELWOjU?=
 =?us-ascii?Q?k6+Fza7Fjc+hPZnu/r7JzxUiRSShC0bodXsGxygGejFn/S8JrkQa5Z9GPaqy?=
 =?us-ascii?Q?RUTr6hjFpPIFtOdD1nleXrE5PVPe/6RWXx95YWaixBET7kc0esnWr5wHu6uc?=
 =?us-ascii?Q?fF8S+b3ZWlI7/VKkPEmmovGP3RuRZaIbbyXj2TnLH3aVhgG2Hf8AFksqt+CY?=
 =?us-ascii?Q?Q1nO8Y5C07Q/kBwj3RDQCzVsagmdroyHj+RAh5VhyDVt0jY4yfJ955e6EDAX?=
 =?us-ascii?Q?FtOC0lc5vZKSuxK6/BU26VSx5bzEWlDsF4aNP2Vz8rGviiOCkG1y8NAAc01S?=
 =?us-ascii?Q?18mZ7qlKg3ka9C3ZoQxeWsKFXycOiwmRE06lLKJ6sFwHLNCkFoJPVi+1luuB?=
 =?us-ascii?Q?2391LbQK8nvBF/N+XMNNP8YuIHpUC/nnu/xqhg/IutJ9visWN4TM9l8CYdpX?=
 =?us-ascii?Q?qGlsA2Eod7m7mwXYhEXgWbhTX7kxXEIsdsKaVsJW0bAZhWg3WD+luVh5ayWC?=
 =?us-ascii?Q?4PZu1Y2zczxMnKtU2wiUWeqmS8UO0oO7awNaD4W9aH4ygJA/2c9VQPI5QUFK?=
 =?us-ascii?Q?9WYbmE/kpWZ0XJ+/AbJB0dv7bfIwUOOsrJ1TEDVFU/efe3A4awMK6UvV944X?=
 =?us-ascii?Q?mPzW/YihV6G+0s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:AH2JCSHM/vSB1O3nSdNDpUU26nAHWzSi1Gad8UutviY+rT2tkc1VwY1AcVoM8TtRWRLUGZjOlJvyoSM93LAjEVuj/8QiTdBV4zyUG4X0lPEBZrOBcfTXdi1X8BcLIvNZy5ANl7dkeJJGhHWu6IDFFl2vmyy1nQQuTmc4gMrZ8nSayU1LcMgoDAUXXkLRFUIZ1ma13yzDM+XGygYjlpisE1nNtJh2bDM2uj6DDcfuyqV9OnVUwKFPVzdcl0K9QuiCbxEMYMVzZCyQTC4ttS28W3GcrDPZGJ/9pbY1kK07DDuJzqrSen8en3+kbtRspfzFR4j8dgnGYOKjJ8G+yX7ZHJD8TpSsl1Ud5V1flQibpmY=;5:OXMgTQEo+t79mdr/d5aJka7GcO06mbLw/18a+oi+Z/mSpYKr29Mb3hceiob6Xe+GOYt8mSCxSE0GXe5WZaxi4Pw3nqNMoHcs7g/9mq2c3HuT04VKh07MCj6KvfxYpWSAvNiwryVLXJjuVysE4+BHB5p5kVZgy2FIF7y5p+EVfiY=;24:r0t1yQKyNq7ksTCxgUjimCM5Z/NNKY4/8wfFqdSU/v5pxi1rNK4QYnHO58d1A/zczToIYbNACK3/KOvbl/OqoWznbrKcJ+tTGHXgsxMUgdY=;7:Td/YAtz56tn2DGs4rQWQMFgxZVBNCzBjr+MgPK3vNwGLVmboz89NIKZPjrigqKvayTeBeNSL5Izj01lee6W/mJkpkR0BkoMRqBFn8INqhnWZPT6GSvGas5ctxXl4VY+e8WuynBq/ewxeWG7tJ5vTbPG5hTfLt57Ixkm5dTVXJj+VxVCiHeUUWlRKf79U/D3Bx+sHWqmBXp0sCETMgGN4fiVUZF1/74QdKvcjKwtjl1bXFAXusfrwDdWIDVE5yz8x
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 19:29:24.4503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743ef187-6ea3-4f46-87bf-08d527a82fca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60815
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

Changes from v2:

o Fix PKI (RX path) initialization to work with little endian kernel.

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
 drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  832 ++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1719 ++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  309 +++
 drivers/net/ethernet/cavium/octeon/octeon3.h       |  411 ++++
 drivers/staging/octeon/ethernet-defines.h          |    6 -
 drivers/staging/octeon/ethernet-rx.c               |   25 +-
 drivers/staging/octeon/ethernet-tx.c               |   85 +-
 25 files changed, 9064 insertions(+), 143 deletions(-)
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

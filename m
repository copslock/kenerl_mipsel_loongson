Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:18:36 +0100 (CET)
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:17992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990492AbdLAXSaC82ds (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Dec 2017 00:18:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=S5CTZFLhcSATBN+m5aY6Ks8BeGwFJyVRGeqXxnvGNaU=;
 b=On+wLrX2dNFYoWs3r59y3ZIr1PmuCU2/LbF5zXhpX6o9Gx92XjquMbN73BA5JNmKLJJDs48oCmESrnJ625yK88Mmjgu4X6boxt+esOhMprIpjU92SgPnsywIkUMvBNLHnNHBBh+fKExzbM5IqmWygDaJ+Rgd3kD9DPJXPHBk2m0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Fri, 1 Dec 2017 23:18:18 +0000
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
Subject: [PATCH v5 net-next,mips 0/7] Cavium OCTEON-III network driver.
Date:   Fri,  1 Dec 2017 15:18:00 -0800
Message-Id: <20171201231807.25266-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (10.174.192.32) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a92e9e56-ff6c-4d8d-6acc-08d53911ced7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:/JnZ2nPKzdo14ZbnFQq21bnJ568/BBo60EfYGJSCNE738tEJmr7bTMOmmrfNx24q5WxStjPkqk7wOoMioWTu6G7D8AAzhja9lKIuqFVlx4EY3DGlJUGld0XYClfS7/9qQ6OO+2i7MycU+gKHiO5nuK5M4CdVgIQ42cOjY5tLBM//3yOKiyjvNxE8W2svfgAr3v1SgR4mrLInQYqcIyvrhhYZ28efHef3rsst5sOhYhCJr6nO/ecHpgS11vVgbIIl;25:g6BJknMrXJVXi3RibxtW9I9VB1TYEBPJaZWOJSCGfu6z8G/NFagwh2E+BcbvB63EcxG78Xd6XHeYRiI9t1EPgqaAmhWgL7Qfj8gENgfjDwnFg9TmfeSm504AEYswyEfBfGE/qAe3gG2UDp/DIYf4tMMX63a8Fuj1hJxecyuXLHW+0xvn5IP3A6NyAuzBmP+TAgZZzCFsu4PaDi2KlPNgiKl5VzxrY+5+ZtJcdxXokTUTiNDTnzWFFDy1ravqy62yGgxOdOQ/bC43mKHK2+HMgky2MaB+NB7r7ie3f4+xgQXhrW2xM8lYJfgGH7d32+34vYalj4EVV+7tyR+qmHpkpg==;31:bvDXJsYGzFtkNv/w75Ptfpf+lB4tf+2VOYMR7eVOcjbiakipBJS3psbGUEdUuJZt1l1PpahMYVUTVaxSwzH4nQnEY/dKKBmPUpkpf1KqWDIwv+SEeub0pwnV+boY5oXfI3A+tZrrQPeXT4ugWQpfR4ZsJnFi43bFe0WEZhxwl+E7EowMx6Y59aJp4ztg+rQ/I+nMYRKuy8IGRISFUZb7NcHWudKtKCMldLFD/CaIwOI=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:NYDMHqC5qgkdcd1IxxjWn1Sw9rsG7DtuoT8yw/Hc3SntI6/Ct1ZrNo9eOcf4pDebOzUpzOxyzynQX1yRFwJ1ao0Z/sEEclLdfrr3s9aN5E3IziT4Rp0c3clKcpTciSV8pFAGeRVIbQg1BXDTz/PnGcjDgMgUwYc6ase0Y+tJYgqr9O/zaj3bvPf7pwTgxkFPZtgFI+ThaHB/ek9Ai4zR8ZW7xVqlSAsbD662Rwao/pP6tBsfb1BFMdyKJDkwUpUgZGTS31j6w7/icliNnz5DJIi4xMaCCdIi0w7mJO8JwhzvH7ZozCCps1GTOfol9TPQNJw+Tpq1dHoRv0a+R+v4L6MHtNc8Q0MLX4XbQ5d6woxrrtHYaiXA4xnocpTlUQ809cRtlfiJM6pJPUHh1nKqE+ogVhMQ5dlh7pP7/T9v7DsJE1MNuz8O9zwaiwFBfLLmbawwaK7ekNQFXx5mv+ynfBy1Avoai30jEQTkTMsd9tpAG945uYAGsZ/uiYVSzbr+;4:k6Xaz8PEOXjbW1LhyPqdG7XdOAfi1Bs7jYr0DDPwmfKeTuxtN3YbgRWZYeE5Jx7JxYgnhrggkDmQaBQrlcQJBmjJLdq5IwuYDd6hE8OBHuiNTXZZTQcCc9++2fJ9sLjCnZXbMXxV/wBHtkNJxhrKz30JZXess2KRx3FFZPBWDJ1EZfaG4K5OQ5eM9gP5+WlTEhTa6H/qY5CIGNwsjpQF2xWQ1Wjj3j8xkfq2W7fObJwRqJEVPOxpVidNAytwoFJKKekl3xTOLTP5VLSrUcoRHw==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3499F6D93AFED06B9EF94F9D97390@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(199003)(47776003)(72206003)(1076002)(7416002)(50466002)(4326008)(66066001)(16526018)(48376002)(33646002)(6666003)(97736004)(86362001)(68736007)(25786009)(39060400002)(101416001)(478600001)(53416004)(6506006)(106356001)(5660300001)(3846002)(105586002)(36756003)(69596002)(8676002)(6512007)(2906002)(51416003)(53936002)(81156014)(110136005)(6116002)(81166006)(8936002)(7736002)(52116002)(16586007)(316002)(107886003)(189998001)(6486002)(305945005)(50226002)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3499;23:UzJ7aYJ0kPHG+Ybd61rp6LtY4FWiVb0jmiF9Egwda?=
 =?us-ascii?Q?kNOecfJWf2XgWttg9RpJ3H/nW3/P0i3DzcRfVmTe4vyXyu5duCcw786TiSp+?=
 =?us-ascii?Q?cwWVG8laejToY5tlogL5vg0nNTc9OLkoVqvr2zkLnVySnN/oAF/kwXpuKqoA?=
 =?us-ascii?Q?eKZzb7bW+1vDnYwYM0Ypn8QAyrEUTJNdcHgHy+6kCOrs8B5o3zhIf/Iv85+0?=
 =?us-ascii?Q?dlKx6EBmJPx4r+dTW8BCl04iaaC6bvoPai5qRhZOoQVMwDA+L0DHcxwttiB1?=
 =?us-ascii?Q?SbI0SOXztGGUquldZJ5Lu1QRR7JSUMRmyCey/tjbTsDVtSJUGPBTYLbRM97X?=
 =?us-ascii?Q?U7Cc3VjYQuB4e8h7yhnEHqQB/J8wJJHpKe+oROgjTO59hI2Ym9fjjvUhVOOs?=
 =?us-ascii?Q?fWNtsY1u9Np/QPdA04oHZpY56yrCI6iKIaDK3TLn8X7aW2f1CD1EKUKAsRB8?=
 =?us-ascii?Q?WjVQRPA9IacxHJvl60nZIpgwa2ffe5ON1qesEVL/XdS7nbc30GTlqHQXmDAM?=
 =?us-ascii?Q?kXl4meyuEzm31MRy9SymKIEbw6ZcSI+sOeogHW5yj+PTM3kFTbgbqYVVsrpb?=
 =?us-ascii?Q?fQh6knN4zOy0OnoGm1hQSnAzkitc1Eo4MBnE/QLbG2nllDs5PYdjEI+xPtEQ?=
 =?us-ascii?Q?6KTLVM1ZLs2Cz5UWT3si7/0cKbTkTUJVj1O+LVV8MqKz69ZDPGUh6I5cLn4L?=
 =?us-ascii?Q?sVs0NGwGzLEsaNdGv3Qnw7amIacPbs+gplkEGkDBkJxsD2WiTZSfbXdTmm4Y?=
 =?us-ascii?Q?C3l3LGibJzyMMBCdrcfkGz8N+29irqo1tB62P6HDZJw4/AOzW2jWC5ZR3+0c?=
 =?us-ascii?Q?HSAcN6/f8tXUh9nTQyrbkDSdfXJ3X5SZ2nft3KHG++GkUdbf4K7bnOmiSMH3?=
 =?us-ascii?Q?K3EBraoM2b+zrmIaIM7RKzDa0gvD2iTPdGTUNemvegcGjiOu3AaL5CZY50+4?=
 =?us-ascii?Q?g/Tjkw800qOj/pxgTV3igSczx8rKuzhV+q7tGANBavSldrcLirLMnYs+o9O9?=
 =?us-ascii?Q?bVbYhZjQHFSBc1DS2aDJgjoRvxQQvowrRagSx99+ZLsHJtuKR6zezExlB1KI?=
 =?us-ascii?Q?H8iZ4dtwmq99h48Lh4bOccdLG5IcBthl1DRhtw9uhrlUQlVMj+P1JsBqvuRS?=
 =?us-ascii?Q?cDuNOqJhzzqeWgxf/wx6FIPeYJFtACa1s/HvdDtQVWb/ELJUHaDdpmHyhmeE?=
 =?us-ascii?Q?S4ViKmKCS/PPhHxyrHf9J5AFHmUMsVQZ6ljWJAi1jdFY9MSbTMMCdridw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:AwtHRcTpA2FsWFoYDhMtqgGVlQRQsRw/B4KUnnguXmvjgwF9BJA5xCxiNJeNWLzHQv+Vbap/ppzEqggo15p8+VC1boom77zAUWXgbiezOqfn4ZBFLo5WtVeJfO3JKvRVWfB024o8Tl1Vd+zYc8MeBrsaK7jfCquX3JK4qyptAglNUN7QVlNr8LTmQkeAWcOfdK9J63hhCAMnCq9Vzm3wRaoWQjf1oK7bw/QUOaDLE75qDh9BLcbj94Ey/yjCUj9icyIoE/e/iGDskXjRiNGey7OL021ciGJaEd9IXHCCPTZc+1JrqdmG1Wl4XbQntIJn7wwkrsCnKiMX65TuxOSHnrYn3cTyveL7CKXWsDyPg6M=;5:zOanHZxBEjSlCdSvzjJPH+6NCZBYiaB1bsrhiO5ZR7PViUoYdqTRCpktoSFHzW5Li9zwgPTiUbML5hs7SdaMX1WSB3wgwqFGGEE3Isa8PfrOuK9TG7IDKpZHz907fZ4dXFwSgT7LoO821+hUeKMRqLA8SYSE7/naImJE6+bD+us=;24:FB8SGePSn3TXIu4PeJTtaYwtLhVOrX/BD+/ZKy1t2GPvrVCJs1NQ8+1fvh7JwSyZdOzZbcO+XD5X/T2RaoVNT96D9XfDMZOI/sPcqoof9AM=;7:s3lh4kM9MzpHYd9fTTQtheTN0MQv/dBsNPjmJnXuyTnn3j/R/3pBn4EHmMw2n1eh73EAJ1p0+a48/uXFD35JBRBeBHzoKZ+/My99u/hbmqXHHAsL/KBdEm8bnW3atWRJZyGRcRgyD2qgBciHrVxxVeW2jTOcn6WowZB1CYKifr7EH7bxAYe5gHxdLohWh7BjJY75taH9De18L/RLm7TGm4NtmB0yACNULYBplpMK9tUdSF/+mYqOV4VfszHV1DEM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 23:18:18.0400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92e9e56-ff6c-4d8d-6acc-08d53911ced7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61269
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

Changes from v4:

o Removed cleanup patch for previous generation SoC "staging" driver,
  as it will be sent as a follow-on.

o Fixed kernel doc formatting in all patches.

o Removed redundant licensing text boilerplate.

o Reviewed-by: header added to 2/7.

o Rewrote locking code in 3/7 to eliminate inline asm.

Changes from v3:

o Use phy_print_status() instead of open coding the equivalent.

o Print warning on phy mode mismatch.

o Improve dt-bindings and add Acked-by.

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

David Daney (2):
  MIPS: Octeon: Automatically provision CVMSEG space.
  MAINTAINERS: Add entry for
    drivers/net/ethernet/cavium/octeon/octeon3-*

 .../devicetree/bindings/net/cavium-bgx.txt         |   61 +
 MAINTAINERS                                        |    6 +
 arch/mips/cavium-octeon/Kconfig                    |   35 +-
 arch/mips/cavium-octeon/Makefile                   |    2 +
 arch/mips/cavium-octeon/octeon-fpa3.c              |  363 ++++
 arch/mips/cavium-octeon/resource-mgr.c             |  351 ++++
 arch/mips/cavium-octeon/setup.c                    |   22 +-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |   20 +-
 arch/mips/include/asm/mipsregs.h                   |    2 +
 arch/mips/include/asm/octeon/octeon.h              |   45 +-
 arch/mips/include/asm/processor.h                  |    2 +-
 arch/mips/kernel/octeon_switch.S                   |    2 -
 arch/mips/mm/tlbex.c                               |   29 +-
 drivers/net/ethernet/cavium/Kconfig                |   55 +-
 drivers/net/ethernet/cavium/octeon/Makefile        |    6 +
 .../net/ethernet/cavium/octeon/octeon3-bgx-nexus.c |  701 +++++++
 .../net/ethernet/cavium/octeon/octeon3-bgx-port.c  | 2015 +++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-core.c  | 2069 ++++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  824 ++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1688 ++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  301 +++
 drivers/net/ethernet/cavium/octeon/octeon3.h       |  418 ++++
 drivers/staging/octeon/ethernet-defines.h          |    2 +-
 23 files changed, 8955 insertions(+), 64 deletions(-)
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
2.14.3

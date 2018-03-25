Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2018 08:47:15 +0200 (CEST)
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:59066
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990402AbeCYGrHcNsYM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Mar 2018 08:47:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=utRKow74fVF5m29eVRjtswDVEYxP0hIL3ovpR2PpBcA=;
 b=fdIPoJnF6t9mVS3pdt1voojbkMZIpiGURdxHZrBwfnlyHjJAIgtsx0zxgb/+QZLOtWYrPDeJQKgu7vBkhSMJDAvkfbeBu9PTjJdYEmoS9X3Xb6PucbSKG6mbn7TnfyLWbm1gMekyrKMN5s6Q4FBLgXM8ciwCTi2Tti2XrX7rzq8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.609.10; Sun, 25
 Mar 2018 06:46:54 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v6 0/7] Add Octeon Hotplug CPU Support.
Date:   Sun, 25 Mar 2018 01:28:22 -0500
Message-Id: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: SN1PR0701CA0055.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::23) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acf74d56-a8d2-4a07-9253-08d5921c32ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:kWi07HK4BJ0ZAOqY2pySLsXnAKtWrqH2u9DRF1kV+v+SPMdjCIbLbkY5oX+dq/GsuJ5GwVqvYPKfX8FzxKTki6ziw8sdKn+u7oRntV2ovXBpISOlSKMBXv7Wmk7y1xjXE/YwAv53hiSDoe7f1CoV3IWcsWx+yrU//NMk0jsspcRdp8Rde+xljummbuQ9ZZUKvg8+PJJXEClhBUF0gmkhZpyn9wy4N6r1hRtjtdY8KVeIWMgNU4/H/bGrvRfG0SE2;25:9a2mgyXST3RopQ4jYVl+PosfAmbUHEEZkRQuz1VWe8L98cI/mWDAXZgaTvahxf16netGOLv5YrARrlwtG7KRqR912EEYrCTylmEPaVddRxhOuL4yBFqsHwaleVtC02YH5mB4HZ3EWdXDW6z1R+VEechqMn9OLnOJ3U7n9j5SQezfWyErOdUnqV9e9xTOXxlk/ilgpLzLe5sBJdNSjkByWBTfGIn25dtp8kBLrWZQUbAEiuK5Gy9MuZG6fWR+voTYXyXl7yp3ph7RuEJqbdpp/vNQzqfZRK2a2WckQIwpxLBUoWi1ZOkNCZjPE3mEgw2hikQ489oayFtaWKk60Jxjpg==;31:wFu22qiriQO4mWwstRQKySESv3Ab3bsOmTMNzp0b75dBPgZkk6uUaLQtme3ivaGuudMn3E/WvaY/1F8C8IuDdhYoOU5Py8stMzwYQVcVuXSBLK8rFrz6qjXWKBm6VkEwhhx+kD1t7KguaJ5js2cyiRDPDhUhrNoskTCW7+ilIdegLMY8IrNQZVrOkdql5JN+4gTKQ7ABrRRahRyX/bmR7QyclKzT+/Kxj0GpvdYf29U=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:kJrkWG7u0JYxq2xmkT1AFiX55l9pGL81jDLGln0U0Irtd/X23LmI3e+WXQGGxCS1+sdnFDlSmqBdpRZqJwLwksNUO09hjUI961ChpFEP+vZdoNGV4Qsa2qCKqNqZL+hbKGtyNME1ddzV7TI/ur0Y8bBhmBYRYuwQ+DADtxXr0PC9gM3bp0U9wjez5P0qB3s+8O/QOt0gY6U/GKCTtnLLaG7OMBhXXYpoUKPNhVfbkqEgDIm0CzAt2sPaXeMNJPD1zA5ASUS/4XnZ7YNoNi43GJs3Avw0wedc+9hp9HVa6ncDjn8R7OeEV5M4xnW03aufPhw+HRJRlwFPpot9dDvCA9V3Vg0KjNalnLiAHdpYhPjX2JtamwOAnFAbdQcDj1JjR4m11paezilfBOR7wPrTZnEOkvocFU3q9yFRp0hq9BwDsAYMLAE+kuGKMQbDa2Tr0ra8Ydke+2OIYeJ0T0RMRMLoWgqftYCadZgIVQpDMnRE0AAXFzvWyQztAv2Jh5mm;4:cAerZImkHIYWaVBrIeXz2N8qTIzk1xO3vpQcWTF1ntOoTiT5QjYG1P+lHQj9TytWyGBM8QlLYiieh13RaS4jWf0d7ZhH7KSw78RJh6J8TpDkwFESpsc0gPIjdxAwt8CLlw6/Pe33Em1xbMWI2LgYSLP8FfZ0hBrmtTOh4KLuuZctozyy361JoYwptR3/MDZdqsG13MwrhCjxqRl8c9MJvOBrawLcbb85B04Ha/7zIFQ8QWem1zoaezWbhSEpdFITxSA0t/Z8jE90VYMeHSbT2Q==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3610D78016B0DFFAB398D9F980AE0@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39850400004)(39380400002)(199004)(189003)(97736004)(51416003)(8936002)(52116002)(48376002)(478600001)(5660300001)(6512007)(105586002)(8676002)(81156014)(81166006)(25786009)(53416004)(6486002)(6666003)(2351001)(6916009)(6506007)(2616005)(68736007)(386003)(86362001)(59450400001)(2361001)(956004)(47776003)(69596002)(6116002)(106356001)(50466002)(305945005)(7736002)(3846002)(72206003)(36756003)(26005)(50226002)(66066001)(316002)(16586007)(2906002)(53936002)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:45augtHaGR6/ApoKKd7eu93LVDYmTwSJxdgEdWcPr?=
 =?us-ascii?Q?QG2qPocfguFKY9TrP03uzLcee5HZXiquEw8eh/bsMkZbCd8MQKAWMwk+f0gj?=
 =?us-ascii?Q?CHOzz9Ij0PyNdbWV0l7YkZqVEn4yiD9TbfKRmhyUZh3Tuo0L6vAFdw4cEI+3?=
 =?us-ascii?Q?N+DEfW3NcYmETzigQI8JABXuvqchSPemYatinXj7SJp5wButTzDNod96+BQp?=
 =?us-ascii?Q?iryccCj0AAM/jFY0nj2RisBp64WsTy8NO+DAUVz0sXhkPXNGd77kqk/IzjuP?=
 =?us-ascii?Q?cYtqf6M62tAKLiSXZ0up3yw4idZPZsHrUBvytNrS5/haqAMqoX7MMgbSj4mX?=
 =?us-ascii?Q?ILBzfmYk7vfjGzsjP10b222djV5aVyo+gFGGxDHu2/eTYOku5WwwaNVdHMpo?=
 =?us-ascii?Q?B+/g0PJnboG28m3HsIaWqph/lLFMkS9pvgQR6mdmdcQ2uoMR62/khD69Tb64?=
 =?us-ascii?Q?DwsLPb82QoNkEDD8q17gDdidfmdXVj5307W59WkkkzSJXoS9y4qmMyJ9SJAy?=
 =?us-ascii?Q?lAo0j1EaDKHD/9qSQvsqwTqvznOitJMfgmOUV26VUazH3CLRDDS+5xF1hp7P?=
 =?us-ascii?Q?Eig/tsQIu2JSre08nRaMc6dA5OGjpgWGomCsWMWmiNI4VN1s/DMZmYl6tNUv?=
 =?us-ascii?Q?ZnV7z42CNskDVdrsIn+Qv1oQwHVI2veu7hZLvL9oX9MeecUtrVnbRMiX4bqn?=
 =?us-ascii?Q?lJwGBtHjsh93wfUL+Ysm+ce8wwZFivGv/5ycyY/f5c+4Fe2agysBbQXPD8Jp?=
 =?us-ascii?Q?XK0xK3y32EwYS8LKzsjyuQSq0DTUpGdqjXdkJxd4Z4gjLzpSJZlosZgVHc0B?=
 =?us-ascii?Q?LolFT+UYeQpwd7e+qRALOcTTk4Cq66W7EMYT5JtOj97NefbKadmDFFY9BGNd?=
 =?us-ascii?Q?7G0qz0ILlg+5lLfI7kh/4wIudVY+r6T1+vIxd+cBBJgaYyinS6dTWNqAYDXS?=
 =?us-ascii?Q?+924huSuIc+4rG5ZbmGBl13u4JaRLJgbqK47mN+KKiW/jlo49yha7yzfsU78?=
 =?us-ascii?Q?UoUA/bUzp89TUaBCNyKb0lOp1iJ/rqwvPkB7uu9l+UYuh055HEhnUFlg7ODb?=
 =?us-ascii?Q?/AKgImd5SP8XtXoyuOL8bbPxaVFBZ+bzdaUsrXikaiElSGGwIKzQzicUK8bf?=
 =?us-ascii?Q?eWssGCMLG5T3C2MBSluGN3MSV8ggp+Oczqft2LR19krqBzm06CpmnXVYwv31?=
 =?us-ascii?Q?Zq7MXeuGsHWPk6mg2q0p4WZbP+b1nOoNCVT?=
X-Microsoft-Antispam-Message-Info: dchIi+3nrj54BalUoRYICMi+pY5RvaJFoTVGfULxDErJueL4sjHRThFyq4POoJ3h9FbY7JTV5HHLkop8J4SN8hIrWfo/3jzmG6M+A3ENO2nuvZy+91RhyALtWXJNPLrZMAlYl6lQyQFf1Fnpn5n15ArfJ8rzfWmqTdVPJ+ZtHWFOLnFgmQuTmeUxlXcqP69z
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:i9MBOdVTgBCiX0Q2Z/FWQvBggRETGGlmpXSPEoPltROwemci83PP43+zfKCGBcLMyp1iVkLQ0DV8aWWcUGaTH/2GLMoGU/2ptfnR/YK2vwz/5JkTsg52oeOyCMrdjPkvCvEK6yNoV6qnrT/Bc2Y4fSXyJjClPnd7qcZDUeZPMwtJnOKs3YHXjQCsBata20OG/JwnWyQ4LQrLclnWqOMz06a1E7KrmPCbuvWWIhzLr5KC7npe+7XEVSkLtRLV8YWT/dq55GETNHHz9O2rUskoJVE1xCSqBp20i9yNJSt4DBmshhzsZzqEmCRd9W3Q8GOqYIjSgn43UuzCck+mfaXMbj0C2MuS4xB1JA/4nvsdb8JBgVlzaZtg70kmRcPwW1a5d6l5uRKDJZy0lXjzlRXLUEyUyUXK95oennlzrfDr/fGMqHKdRghSnvb7ryl1gApRXIChE3eF/1+zz03yio7kwg==;5:c5sJct/fHHgNYh9jbj1MOCcYXSoXRFJ4+WBKycWLZWE849YrfwsxPVJUtGX9e5d1jQSkZ09qny5wf2ATwsd0mR/ZlfQuFHWOk3/A/vlWg3tEuc2Qastj6FGC0WcCcMDQ+7FIUOZy0rEYgzR/LznUA5KQJNTFedoGz8HvlkUVBxs=;24:vsrf260HcrN+HY1dXpZUth6iv6jJsNWryniG+QUDYk/uN9AVB9mko2aXXjpTKho17I+czS9IMv1KWQf0I6IhrlelzSdYtl4c796IppD6raw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;7:DMExSA81E+fFS1b5V95jZVMWEgkPuD9qaPX99qAtwMCTYTuI0UGGEoQmtiI6c75ZpkmMcGKtyYE9v4dPMlLDp41QUwgb7op9/zjYcuM93cYCWeEBe1PxH2+llC1wvllNHxcJTKZ1lhtwIv2vK81Lk0DgGMb3peGMaMEnmZtJzJwuYtjXiZ/+PnpnCT4xD2IvibF2wuEDSPNn6jM6CEunSso36zKIG+f0XVjGi3nei9zut5u5YFYpbXDxZvdwSNqz
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 06:46:54.7362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf74d56-a8d2-4a07-9253-08d5921c32ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

Changes in v6:
- Rebased against v4.16-rc6 kernel.
- Fixed compile error with Octeon PCI.


David Daney (2):
  MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
  MIPS: Octeon: Add working hotplug CPU support.

Steven J. Hill (5):
  MIPS: Octeon: Header and file cleaning.
  MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
  MIPS: Octeon: Add Octeon III platforms for console output.
  MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
  MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.

 arch/mips/Kconfig                                  |   2 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    |   2 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |   1 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   1 +
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 +
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |   1 +
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   1 +
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |   1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |   1 +
 arch/mips/cavium-octeon/executive/octeon-model.c   |  53 ++++-
 arch/mips/cavium-octeon/octeon-platform.c          |   1 +
 arch/mips/cavium-octeon/octeon_boot.h              |  95 --------
 arch/mips/cavium-octeon/setup.c                    | 246 +++++++--------------
 arch/mips/cavium-octeon/smp.c                      | 236 ++++++--------------
 arch/mips/include/asm/bootinfo.h                   |   1 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |   8 +
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  58 ++++-
 arch/mips/include/asm/mipsregs.h                   |   1 +
 arch/mips/include/asm/octeon/cvmx-asm.h            |   6 +-
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 169 ++++++--------
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |   4 +-
 arch/mips/include/asm/octeon/cvmx.h                |  32 +--
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 arch/mips/kernel/setup.c                           |  30 ++-
 arch/mips/pci/pci-octeon.c                         |   1 +
 arch/mips/pci/pcie-octeon.c                        |   1 +
 28 files changed, 421 insertions(+), 561 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

-- 
2.1.4

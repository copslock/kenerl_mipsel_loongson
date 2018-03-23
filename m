Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 08:31:16 +0100 (CET)
Received: from mail-bn3nam01on0048.outbound.protection.outlook.com ([104.47.33.48]:13634
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990432AbeCWHbKH7z79 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 08:31:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bmdwtjwdCGiytCBGTPDumSqAEPbsU1z6aXFij9+yZQo=;
 b=Xnf6PxprmqYNYD9vjHJpD/Cdvw+voYidrRhtA9Gl8ZTQGTvu35Ar8N0wmRPv4XLB94qQigkmb/jJ1OP9kNFLChbStOT+jrOx3dUxuYXvEbYUy4GhJQviZ7KQZ9FNqytiGC5ggvblKdAZo9FlmwKOZyjeS6ow1n2KmIAHWT0nw2U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3612.namprd07.prod.outlook.com (2603:10b6:4:68::34) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.588.14; Fri, 23
 Mar 2018 07:31:00 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH] MIPS: Octeon: Disable PCI support.
Date:   Fri, 23 Mar 2018 02:12:46 -0500
Message-Id: <1521789166-6096-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: SN1PR0701CA0055.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::23) To DM5PR07MB3612.namprd07.prod.outlook.com
 (2603:10b6:4:68::34)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8575d86-6331-48f6-6a34-08d5909006d5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3612;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;3:PxeG63YDrgMdqkI5BJ7rPnonVlozOJSYC5EXwQFD/68uE+g90P18aMUWndUmyxXOilTr7N5ql5q9vpRIPJj2/bcBd7/7wuWKxtcBLBpClMjmi4ENnAnAVvy8wjqiOl8x+AaQSjRkOHwXwKPmDsOmsN0gA2qlYxTgU3KqU7R/9affwkvoM7f70IhcBRT0R39VHpqumF9T21K+H5Ko62RcCejPSZLe0gT6OnRAmmt9qQqRvJNrhNzk9DUMCWo/jBnA;25:H57IP4YMVk+kE14Yrw4zW/BGdAT8sf7+8GVdzPywubZBFVDKb18mWSiILwD71rFLJJOEGy5TEmefM2z15bJRJM7wHjWzkAbdqN3l4pgnFoUYxpWvjIDern04Y570quUFBACc9D0qzaUPqCYEEUq69kCKGj03fCNLX/yjAOPzRQh7wYgxyioV7SkC4JE3Q9WlSn20VzOVIMHg6045NSXLdg9WZVuk3Xd4wqexO3vTMtc9lOpCp4bsaxJB+CGnx2e9RtkKJQlWD/jXSPCT8gLuUQ5mzbgkWUgStcVIFWFGVdy/ekSipsKXWChnyLaCwOVsQ9dR9zqp2/mNbXGK6YLAEA==;31:i4qq1Curuvpc++a0Vt+BTUNgWb7MIC/gPSUbHr1iQkVLcWT6XYCmwOSoE7RGup5+A9f7B88I7q4jpZkGmjuPo8SOLT91rwHrPAgCY9uVuNw6ti/MXWYYo73ZB9HvK9RlY+w0CXtHG+RFAsBZ9KebcX4oU1Wo06EL4/DFiw6Fl98w1CWobnBZXK2bnUP5b+hXqUKL9Ft53V/51K7cTI2/ksG2ZGCA8rJMdj76Jxul8Tw=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3612:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;20:JQJ9nw2oWqMbh1wsCUWmh/ClPw5qR9cDBlP79DSgPKK2K6RKgK0eaaAvUjgr3pelkQjtN9siYJU35oLwt31VAn5NBRTFQrt7cDUYXYROJdnRLhBaJXEpxDTu4XN2aKA3fXFjUTe+L2/N1sOiun2eFgdiBs0vHo1Sl2s87zxkfO4fKsFmouLTK+bMQ8Th5bxYFterCDSMJXyMDuE/kLSxYxnc+uuc6dTBOI0Qut0+JXbvu5lwcatysK7yX6WYKcEQkbbRGFg0DAqLdEOoGyUbravaveYuT6+mjcuptOJ08bayr+7wUxAP2K9UkMk+KfsT8trkJj3kNNg6LLUEuUhMuRRZb2vIJr+2+Fp55/eRIbrV1b5pz3rVX/9NaJRTNnkiGlDfw+kI7lnCYlUfah93tKS+VOoGTQvhv5IUEQLdNHH/HEDK1vKW2pMzM9FWNzB6yeZRIE/Zy/0WjCUGAQDS9CdAyJ1AJBeonJYN5HR9eGrQ3XZFs8QWDmVIlSzZOtQ3;4:GAP82lrXi/0GuWoMB27UOZNx0w41R2XKEaCF2zM2y5q9bMZ7u7Lga5Hq++VRy7ZsiD8FJs71C6oCi3+ldnoW/kvxAleswPtJDO8ubivG0VUDGb9nPNvIkDcYb7AxvCnSIzDec1ysUNVc81Ivxws/PGHWp0b6WdpR7btXaROgnu2pYdFqrW2wmLASKo2wLYXk/IPryTPyU/lDf5bkXCs1zT7JnFWlKpsPpxU34fK089thAd+vx4FQpQ6QJaRFRmXSW8kIkC26qCp3BimV7CdZ3Q==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3612193AB84A6E139C5858F680A80@DM5PR07MB3612.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3612;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3612;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(199004)(189003)(305945005)(8676002)(81156014)(59450400001)(16586007)(6666003)(6916009)(8936002)(50226002)(6506007)(50466002)(26005)(53416004)(386003)(52116002)(51416003)(97736004)(6512007)(2906002)(48376002)(5660300001)(6486002)(478600001)(81166006)(66066001)(86362001)(25786009)(53936002)(4326008)(186003)(16526019)(316002)(69596002)(107886003)(1857600001)(3846002)(6116002)(47776003)(72206003)(2361001)(106356001)(68736007)(36756003)(7736002)(105586002)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3612;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3612;23:u/pCNPR6DLqRWWC1ph/4OrYsIIB7ndUCm5oaSaUh5?=
 =?us-ascii?Q?C4Co++LxdghpxirAV8wVAjDTdSdYTu39sGi2TDpZjNMaPeqY1iBjluLkfkuH?=
 =?us-ascii?Q?pMByvhrEjhhWAO8jNkA1+kDM9VWjNqPL6AxuFvszX9r6gnAndC11sNVKj2hO?=
 =?us-ascii?Q?gDcm1xODmrK6AsxKLAzr0agvu2L1LJDTr78kkeqhU+ka2XhUBVTzZW1DccNt?=
 =?us-ascii?Q?HmG1c5ybGsn3DMmwZ+uiJzzbkQjfgwDpwA49YOx3HRoCUFNAQmadbhLwTChV?=
 =?us-ascii?Q?8PRlKyIzNLeeIsSdAykecn5pEWLp70dkeiUSaWt9H6BDJvubyPLO0LGJYV11?=
 =?us-ascii?Q?eCKxYPvVVjSJbw5L94lCzGKYrutykUyvxQmV47vK/aZSvROO9xVTxd7qHXVZ?=
 =?us-ascii?Q?5NB/ABn4Qqss42m0ZHYJ3pR2rVYiNf4ySkpEy1syCQA+/6CSMkSGBZxS1Auq?=
 =?us-ascii?Q?5ylurYAOvy4uoz5dPSXXatRFGzNfuld32zUBL+LSv7HC1dOsBFtRnFVGuWZ6?=
 =?us-ascii?Q?eE2bl7AtsFma4TNsECjV3CnpxhztZTcP45MjKmVRpMClQvDeAo7OVzrlQG5Q?=
 =?us-ascii?Q?KDeObi5WTSmiJrRIdtmj1Pd0n+9PcsUamGQ8DihII5CnTS2aZoWvAfE2bEhV?=
 =?us-ascii?Q?Zw/7PUgdUH6ECXQk1plP6ZCsn5Hdy6gOkTzfy52HF0drjWCAGEAXih5vddP3?=
 =?us-ascii?Q?gpnMg/jahb9u412GgGJ6rXtdA6LXIIlMKOsYntSwsxsxc9i6LieYpVsg3Sk7?=
 =?us-ascii?Q?eQGSI+ZTvuJ6xtygyAW4PdOY+KCioGaZuUZtTjk0BX7i/oSqcFZEerOz7AQN?=
 =?us-ascii?Q?tT+uIw4aE9Ka6VTHITWL5LXh1fha1maFtaWz5+NMOiK5P91zbgvfKlHreRa2?=
 =?us-ascii?Q?+pNKFlmNLwxEi4UuHTyZpdaXWaJ2nd8sKC2bHqVaK8VqFhGGyuycR7yWVWTd?=
 =?us-ascii?Q?igpRjkNGWL3NDOXiC8+XHDzI1bYSw6Hp1drZjXHyYe9ah8F4To0lGH6iVZ2A?=
 =?us-ascii?Q?MfjCS/+XBbJDh6nfd6O9KeArRrsgoIuSQNNIKJItRXh4wHlvR66b45J35Z4+?=
 =?us-ascii?Q?VaxCSC8ZtV3bNMv9rii6TcZUSxx4QSAIkg92rX2E8e69LamvTfoMj6CO1bu5?=
 =?us-ascii?Q?r5DLeqVZITlkoPdrSlKNa27qcokBQ7WsAlyGChqt9ZGOzMNjNGp/+5C3i5hM?=
 =?us-ascii?Q?9AgtqzF6twMZHxpGUCcxQ8lGzFmpa4WB6/x6hx25R7HL1y45YmIcD88hw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: zlNYN6tsdLsON42HzTRFYNz3GbZzZeWXJj515e4KrEr7bsT3Prv/J8UTapnuWF4IR+bbd7fHLmZ43hRAEVNhanBTibbqSGa6RHRgn+U25JXmPZua3nlSYWyP0yco6VxiNAQHl4MgskfoWienAroTdxRcZs9VowsGe/Vt9Ya7fCiKULDc6FcBLK0/1kxnMTBJ
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;6:ZqA3kUbSZIF12jAOksout3vMMQnWwSoc618qClGN1XtORimlUDi2Qz4XEScHz72QwnnIXKskzRe9/JXfVEu70O4bnhJirqKuFwfSaKacceExPierFLzuMOF9F8/X6Hggo3Y0GKznAW0YdklrntJj4Sl56L/vgpSYCTEQEQatRbYFKWaWfPDrdbD1ly4fG8KaTbcl+aEFzknrdrjqGotXf4OgOoZgybicCr7xslQvv3/8nonXaOSRIXxtW2+8xxBms9/Xth/dvWhtIWOJ8wiIv9pEokZrVujafL+68pSz5RWR0wvMgPVXZW/8/GptNf7VmwNcoTDVncxM4vajOl9+9OpeJSbpNT3lJBoMPNhlk5U=;5:YPMJaPPO2AcNZ4qm2yNo/G7GhrGZSAfBCEezGmm2vc16BWCl7t/wSdv6Yo76wbPCIq1NH6Nvo35D8NKr7BIQku7JO7c5oM17h6t1m/5mT0kJwypvXNPKbgryBGVmE547wHQTIS2ySrDkAB0mODehTrAo0/Hj7uXDERsSNTOubxs=;24:dfD/N/+u1+QW6ntwYE1A0mBIOY8eBPcbM4mqqnjn2I6arTGuaeo6EgOm6f78e/Oca6ztHKjMR5Y1zDSjZD45mnej64kN3vEigM0lrz7k+xU=;7:JrmlXaW2qfGuv/Zvl3UVNE/eloKwBobAw0JM37ujUM4Edf/bL1oPHbQE9ALNWjKJ4x11iF/Ak5P0+VJze94bbv9Ut+yc3WOBgD+ZIUEsuYjB0yq3V4NWHkoELheEgt7PQrM3tLBDrj9xDh9hG3Z45aRSvQArFNdeWUllIQL7u5z1r7wCmA86Ac7zFcmNSoE/6v2GX+UYpVWbxhhpdQuh1kqSkdn6FTCPqHP9/6wJTmO53YhWx5w5jNe834OVCx6B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 07:31:00.3539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8575d86-6331-48f6-6a34-08d5909006d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3612
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63162
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

Until the new Octeon PCI code is upstreamed, disable it
so the default config file builds again. Other updates
from running 'make defconfig' also.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/configs/cavium_octeon_defconfig | 44 ++++---------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 490b12a..8dcaf09 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -20,9 +20,6 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_MIPS32_COMPAT=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
 CONFIG_NET=y
@@ -42,7 +39,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_SYN_COOKIES=y
-CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 # CONFIG_FW_LOADER is not set
@@ -52,56 +48,28 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_SLRAM=y
-CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
-CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_PATA_OCTEON_CF=y
 CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_NET_VENDOR_ADAPTEC is not set
-# CONFIG_NET_VENDOR_ALTEON is not set
-# CONFIG_NET_VENDOR_AMD is not set
-# CONFIG_NET_VENDOR_ATHEROS is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_BROCADE is not set
-# CONFIG_NET_VENDOR_CHELSIO is not set
-# CONFIG_NET_VENDOR_CISCO is not set
-# CONFIG_NET_VENDOR_DEC is not set
-# CONFIG_NET_VENDOR_DLINK is not set
-# CONFIG_NET_VENDOR_EMULEX is not set
-# CONFIG_NET_VENDOR_EXAR is not set
-# CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MELLANOX is not set
 # CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MYRI is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NVIDIA is not set
-# CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
-# CONFIG_NET_VENDOR_QLOGIC is not set
-# CONFIG_NET_VENDOR_REALTEK is not set
-# CONFIG_NET_VENDOR_RDC is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SILAN is not set
-# CONFIG_NET_VENDOR_SIS is not set
 # CONFIG_NET_VENDOR_SMSC is not set
 # CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SUN is not set
-# CONFIG_NET_VENDOR_TEHUTI is not set
-# CONFIG_NET_VENDOR_TI is not set
-# CONFIG_NET_VENDOR_TOSHIBA is not set
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_MARVELL_PHY=y
-CONFIG_BROADCOM_PHY=y
 CONFIG_BCM87XX_PHY=y
+CONFIG_BROADCOM_PHY=y
+CONFIG_MARVELL_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
@@ -116,10 +84,10 @@ CONFIG_I2C=y
 CONFIG_I2C_OCTEON=y
 CONFIG_SPI=y
 CONFIG_SPI_OCTEON=y
+CONFIG_PTP_1588_CLOCK=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_USB=y
-# CONFIG_USB_PCI is not set
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
@@ -135,7 +103,6 @@ CONFIG_EDAC=y
 CONFIG_EDAC_OCTEON_PC=y
 CONFIG_EDAC_OCTEON_L2C=y
 CONFIG_EDAC_OCTEON_LMC=y
-CONFIG_EDAC_OCTEON_PCI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
@@ -158,10 +125,10 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_DEBUG_INFO=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_CRYPTO_CBC=y
@@ -171,4 +138,3 @@ CONFIG_CRYPTO_SHA1_OCTEON=m
 CONFIG_CRYPTO_SHA256_OCTEON=m
 CONFIG_CRYPTO_SHA512_OCTEON=m
 CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
2.1.4

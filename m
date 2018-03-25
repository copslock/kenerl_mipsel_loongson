Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2018 08:49:22 +0200 (CEST)
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:7200
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991307AbeCYGrMoUI7M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Mar 2018 08:47:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4cz0Zwtk8o+2n9DtRZbrKr/lpxvV7fhi+0OEdUBV29g=;
 b=SYZTx2iYWtohqORV+gzfdP5BeqgzCItkAkvlAF2hSOh7v4BQWX5Sp4xLqo/dr5H/4NB5Id3TueGSwFlwf7dRQM274tJI9b9TkXAZllfli24nhDVR7G+nb18A3jVWsqHjcQJgTtc0DvBEnJL65FqhW+rjL11gpVLDdxO9kyPLG48=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.609.10; Sun, 25
 Mar 2018 06:46:55 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v6 1/7] MIPS: Octeon: Header and file cleaning.
Date:   Sun, 25 Mar 2018 01:28:23 -0500
Message-Id: <1521959309-29335-2-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
References: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: SN1PR0701CA0055.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::23) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65d205af-9659-4723-d1b8-08d5921c3330
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:UaCsTDgQwkCYOGKSgF5U3BnFXdXBQioOfyf5ABCvwaDHiJ95E+QVH4wTEc91JXq9pw4jjxceEG1kNywIJQL8vuztiJ4bDX5jwhkRJhge6Nbin3pc8JHdQPJ29GhWVoiQ96mQX72TSkSZvQsG41RCp/7JdB5Nh2499E0jNw6wMHIZpepjif9J/FJWsBD5dBKhfp5zHmiH17hf1iDgMZm5zKtstjH9mvAW0w3zjZyiq/tbbo6ZIy65uQqUw+yYlXAo;25:2mB12/YPmjAxN86oRKX22AkQf0XzLCa2IGySw8ZipCjU/fgIR0cXYdJ55QX3jly8osMs6tip3bKaNJfjEb4PnMrhNofPRViwMS9i5fV7V2BQPX0CjtGVTJLTjQ7u/ERQJFwzH0UDKLdP7r0cN1nxEoSzmBehAEW5YM+2W0pvJ0jbEhqhzalxZMY2YdxgQHxd66CYjo7sqalDejhWhAwJulaw0m/FQASN13pnFAbMUiJZ/ZFsXNAmKKROHYgrK191aNixX+X1yPuTgElAcx5SmAiFO8EsqWjNRWZA2StpeedsWit8sbC02ZKDFgaedbJU3kygUi164a2inG7otyXaOA==;31:Nt6o0pKv8HXi6jQ3gW4UkPhLnGVOBkMETIvAyKlcp2Ej3G3NRUJWocCreSjcZC+xU+BV1Et8D2TFErV0dg2Z7p0fwXqFKukhPczttaXIfCGhJNe+07XiYVS6UHs/XwvEb2+yYfOU6W9mRd/I5Ma/KlrJXyv85jo8xLNEKK7GA5+nHao5NDwvN4d0xWlFvsXCoZZ1zMacVzb6DXRTYjBEJOBDJ6tqoR9He48LBToK2TY=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:Pc0GwMXSkFseXywWdvLJpx/lwtHWI1XhAW09JI1UFIoMcJf6GkTQFDbM3aVKnFyk7nrm1JhER3Fh4HoSRRNidv9eQuBi4M5IdV6gn1IHV0izxf8Z4Gcd0BZJARN9vji/l5F1q52ez9GGD0653ouhroSHsOErtE7y0D+hAGjOPs2XyebDMZeeexgh/Hvdngbb32QKyNLPc52YPaFb7JoIyk7YA72uPH3f0mmVKGeFXEPOV43PSdkSn+omZk2AR9GBJF0uouXBa3S42WfNhxKU+l8Q22xgTOe2JZVGMjoNvEdzgXZmcUELxqiVEmen77QBzWCeq7YaCWz2enVNz+MyC/KxMnh1bH6WenQ+kRQtORXZAbM3Ik9ae9pnrIMTWMZ05qBE6C9OoHiQVONP1eY+mncr6Exw57eO2wt41B7HCMdu78Oi+U8D61crEExng/P45/VIS+r7vMegy2YM7NLmzSJOaVt6EkSDnmNaVMt5CrH27A3Wd5A3LcwUCNlnndht;4:YeC0zQNTO9zIlcmwtAY7oi4FZZdSXWVHV7XR7hizMWKxsAPUcJb7aAb9v6sOAAvDWqCg5/D6V/eIljXjBAS9Jjt4pORP650cRQ3CCvBa7FiyivvvhApW8xAnr89vMsXnGhl/L3K1ZqrHxrdvE0BBYaaEWEezvmm5lGKgBRrmM3NXK3wpNzyQwgwYFs7v2VQuOdjddqxSkG9172QzhY/10R2bPlb213fm4eyxMpneiGk8LwXT3TjuuwD6lPqO8GohqnR0iIgfE9G2KLjOIPZvQw==
X-Microsoft-Antispam-PRVS: <DM5PR07MB36101A07583CEA48E6954B9580AE0@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39850400004)(39380400002)(199004)(189003)(97736004)(51416003)(4326008)(8936002)(52116002)(48376002)(478600001)(5660300001)(6512007)(105586002)(76176011)(8676002)(81156014)(81166006)(25786009)(11346002)(53416004)(6486002)(6666003)(2351001)(6916009)(6506007)(2616005)(68736007)(575784001)(386003)(86362001)(59450400001)(2361001)(956004)(47776003)(446003)(69596002)(6116002)(106356001)(50466002)(305945005)(7736002)(3846002)(72206003)(36756003)(26005)(107886003)(50226002)(66066001)(316002)(16586007)(2906002)(53936002)(16526019)(186003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:iaDAEKqXvNAs7MiCuyKKaFd9AXrkQaRviokPY37UG?=
 =?us-ascii?Q?vVCN8Q9HQcVKhtYnu8f772QNscBH0pI3a12/BrNFpxv28MvHKp5TbzgzOstT?=
 =?us-ascii?Q?Vk/qzPMyeQAYO0hS8DWZiMTShXYipdZ516U5sKg0drcoJajmkX4jho7dJs+l?=
 =?us-ascii?Q?EA2xFlD8CzJqGJ6bXOf/zApnxxW01PT6EtN7eXpYeV89SOqWv6WMBRebdZW8?=
 =?us-ascii?Q?F7jI8ZLZHBckofHr8r4HKYaLEQQdhOPMUn61ZCpgAxnZ8gU3HqF15EZD8Acu?=
 =?us-ascii?Q?OpYbuBqS9/EvdW73d5rsCsM9duwotI8aw0xanbbmc7pGNy+DDjWuE71tbrZ2?=
 =?us-ascii?Q?T6ID7IqNz5wTTyX1XxlwYflIBjk+bKri+GyFeWzOSNhLR5nAReHn52Tb0I+j?=
 =?us-ascii?Q?MhQf+N6DF3I353mJIihTcn+NfHcG4JMT7zkPZ6Sx0BEl9SzywRWoEfgUmBom?=
 =?us-ascii?Q?bLb0tJme8XCHCwAa44n4MIYo8oyIrGh2A5VNFcHbTYDSQyyMOjeRHmWoMEE4?=
 =?us-ascii?Q?ODkHfbqzgsPqndWWul2bWHBr23cjnlLg4Iu4UlwZQtAID3UwWfShPqDulw9z?=
 =?us-ascii?Q?zwrbUHpql+laV8sV+qVUgZ5aifWuc+Y0HCILwI7mwbh4cbTqIPc+R5EYT+CI?=
 =?us-ascii?Q?jBYfzm/qr7p88a53q5VOtBsd7YSL/RSJieKPL3xsUtW9YezVraP9jYcKIr65?=
 =?us-ascii?Q?JawlL4lET8mmMJn5x1FNr8uLOtYL4mYwHLxTVCBgaBomOczea4A5/uY1k/pZ?=
 =?us-ascii?Q?z5rFCmpL0nKAoETjf6sWJSzoTb9BQDnpFs2EdQ5SgIfP11NuXQYfFYoZmgLT?=
 =?us-ascii?Q?xuRlnTms91PN2YZSGPhduvjunql/RAJA8zdrT6D7YvsIHHF69jq78CcZRtIo?=
 =?us-ascii?Q?AzwsIBVxJP2e3xOkmhFxnRsveDyRzuaLlUaoh+xvEpdOFn9vcr5ot47V63Pg?=
 =?us-ascii?Q?42+Tva8z2cPcgwjWzPV74GoFz10gWez99GZUR8KOUq47gS0W2tafea1wM1+W?=
 =?us-ascii?Q?S8YTtGZ3uza1UkPZ4htUEVVyJjR54K1eIA5q36ZDt4JJ1bBmMjxjJjsVnNqK?=
 =?us-ascii?Q?96aCv1HPDdAk0TNC1MyC3iYH/+NbJTo0ZbXLVgTHQ57e+T0dC1O1X/wQgve6?=
 =?us-ascii?Q?Dox5xtN5ME9HNWz4KnRTi8P3E5h9PXtktZ4/M8uhqX3nztDw1HlKPMwuIYY+?=
 =?us-ascii?Q?PwAGF/UDUkfraNIJwDjcQk9hS4Dwl5m3eHFVpq1kPVwy9iemI62ZZr0+YF3g?=
 =?us-ascii?Q?3j32HQUb9fqXjBPG5HIedR/tV6gg62scZWQzlIz+ftr62dSR1O8qJM9KbBLb?=
 =?us-ascii?Q?JeB7JyO4/B06ZjEoNhw/dGqIwkLMtG16uF56wtAtzJj?=
X-Microsoft-Antispam-Message-Info: Z2YcCezQoDoePSIZege+Yaj9BvRjX7Be8FqSouFypfQEcDHrXmaUirZJrW5+lg86Bi5ayhkZd4tJAbjGktGBQT0NJSRQwlRXfJ/IIhe27eRA0XR8ITkJIleFwcrNBfZE9dFoFC6T0MqP3x9bbCAM6t3a+3QwIu/bUJiM59nYjuMIH/VFy/bk+D7a3rZ9tjQS
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:4ILCX/W77fszC86KzhJx6EieqKeBPY/zsTJ/SwoFUdC4EM6au8w/C2F8BN95nvhB1fb1JFV3cTI0zZwz5RQ0rUqiPF4JIUKmwnLMcTS1MhxQZDqbO7fKAaFgq1skdobZgfhH+digHmD+CgCsNtSYBvu+nBXrawDOezbcRy1OTWP2A3ZaRStDdzkcwHQqX4JB05C07jjWQb/7WGsvJJzweccO47OKkytS/GuQrZKZGt0MoKslSv1MtZXC6Q9XxmriZul0Rli6bt1cCgiIqTHo5QmmqDkktMJAK3HH1bitNS2h3BZwxzXamXYWAHqi5H2i3mIQfESWX1gIXZfJGNt/rzBhLDN4AncktPr83xjq2CaikbMicYHjs6psVrMHGgxIzuo1qKHVXcklFJVurkdJyCgjdq29C/tjNe48o/Wkx1LkS0tduAhUnsKRpenadkxoogupwNKaqbm+S2D3zQvPLQ==;5:QM2LTvZ4GM+jh8YKFN+0Y9LuEIIS/+a8Tf8A8D6SfJehHC4/c1ad4VggAsMtWKmDVVjXLndZOB8ejRyou+ECWX3HqncEw7uoicOI2aPNoZt9hs80aowJ2qoEi0QdtKSXVxz2Z2TBXbuBMX6SUbOteUSaBNsoen5w91xToOP1gHA=;24:Fg92rIxPtWzQ3nk9xCcgL4WnK80PdXNGWg6G0oZIsgCjmQgGKpm910fOPEgfZTBlpwasFI8sRk9OeGQ3u0M59BZXZkMr4SkbQwapJZ8xoq0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;7:qTL4q4ioc+q3DPbJJaJAJBZKJt2Ri60pUDj/k6N9T7f9seFNbgHiezaOGKULZG3Ak46DpRYbISlfyGDaGg7/N3o9ax8MG6Mx4EhqS8iSA9xZ15+vrS2B97zLpQTgXHZ6+qKHH+V0t9Rf9LjXhHMsJz/dbPHZbKBSLyfosCJHRS9HYl03wIpi1fceEL3q2t8A8oowTxHmWaC3SpSvPxgnVmz2APZAyVkgDHoSNZBxbkCoiXT4aBqaV18cJJchfJ/Z
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 06:46:55.2846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d205af-9659-4723-d1b8-08d5921c3330
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63223
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

In preparation for new hotplug CPU, some housekeeping:

* Clean-up header file dependencies, specifically move inclusion
  of some headers to only the files that need them.
* Clean-ups from checkpatch in arch/mips/cavium-octeon/setup.c
* Add defining of NR_IRQS_LEGACY for completeness.
* Move CVMX_TMP_STR macros from top level to cvmx-asm.h
* Update some copyright dates.
* Add some missing register include files to top level.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    |   2 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |   1 +
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   1 +
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 +
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |   1 +
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   1 +
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |   1 +
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |   1 +
 arch/mips/cavium-octeon/octeon-platform.c          |   1 +
 arch/mips/cavium-octeon/setup.c                    |  10 +-
 arch/mips/cavium-octeon/smp.c                      |   1 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |   8 ++
 arch/mips/include/asm/octeon/cvmx-asm.h            |   6 +-
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 141 +++++++--------------
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |   4 +-
 arch/mips/include/asm/octeon/cvmx.h                |  10 +-
 arch/mips/pci/pci-octeon.c                         |   1 +
 arch/mips/pci/pcie-octeon.c                        |   1 +
 19 files changed, 83 insertions(+), 110 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index ab8362e..22d46fe 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -32,7 +32,7 @@
  */
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-bootinfo.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
index 607b4e6..e417037 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
@@ -33,6 +33,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/cvmx-helper-jtag.h>
 
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index d18ed5a..2d84490 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -30,6 +30,7 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 5782833..a25275d 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -31,6 +31,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index ef16aa0..d9dac21 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -34,6 +34,7 @@ void __cvmx_interrupt_stxx_int_msk_enable(int index);
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-spi.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 19d54e0..d692638 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -32,6 +32,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 75108ec..1e807f8 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -31,6 +31,7 @@
  *
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 676fab5..ec5b013 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -30,6 +30,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 #include <asm/octeon/cvmx-pko.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index f51957a..d346ea7 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -30,6 +30,7 @@
  * Support library for the SPI
  */
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-config.h>
 
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 8505db4..a605191 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -13,6 +13,7 @@
 #include <linux/libfdt.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
 #ifdef CONFIG_USB
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0..2085138 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -39,6 +39,7 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/pci-octeon.h>
 #include <asm/octeon/cvmx-rst-defs.h>
 
@@ -165,6 +166,7 @@ static int octeon_kexec_prepare(struct kimage *image)
 			int argc = 0, offt;
 			char *str = (char *)image->segment[i].buf;
 			char *ptr = strchr(str, ' ');
+
 			while (ptr && (OCTEON_ARGV_MAX_ARGS > argc)) {
 				*ptr = '\0';
 				if (ptr[1] != ' ') {
@@ -357,6 +359,7 @@ void octeon_write_lcd(const char *s)
 			ioremap_nocache(octeon_bootinfo->led_display_base_addr,
 					8);
 		int i;
+
 		for (i = 0; i < 8; i++, s++) {
 			if (*s)
 				iowrite8(*s, lcd_address + i);
@@ -429,6 +432,7 @@ static void octeon_restart(char *command)
 	/* Disable all watchdogs before soft reset. They don't get cleared */
 #ifdef CONFIG_SMP
 	int cpu;
+
 	for_each_online_cpu(cpu)
 		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
 #else
@@ -715,11 +719,13 @@ void __init prom_init(void)
 	if (OCTEON_IS_OCTEON2()) {
 		/* I/O clock runs at a different rate than the CPU. */
 		union cvmx_mio_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
 		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
 	} else if (OCTEON_IS_OCTEON3()) {
 		/* I/O clock runs at a different rate than the CPU. */
 		union cvmx_rst_boot rst_boot;
+
 		rst_boot.u64 = cvmx_read_csr(CVMX_RST_BOOT);
 		octeon_io_clock_rate = 50000000 * rst_boot.s.pnr_mul;
 	} else {
@@ -927,6 +933,7 @@ static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 {
 	if (addr > *mem && addr < *mem + *size) {
 		u64 inc = addr - *mem;
+
 		add_memory_region(*mem, inc, BOOT_MEM_RAM);
 		*mem += inc;
 		*size -= inc;
@@ -947,6 +954,7 @@ void __init fw_init_cmdline(void)
 	for (i = 0; i < octeon_boot_desc_ptr->argc; i++) {
 		const char *arg =
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
+
 		if (strlen(arcs_cmdline) + strlen(arg) + 1 <
 			   sizeof(arcs_cmdline) - 1) {
 			strcat(arcs_cmdline, " ");
@@ -1202,7 +1210,7 @@ void __init device_tree_init(void)
 	init_octeon_system_type();
 }
 
-static int __initdata disable_octeon_edac_p;
+static int disable_octeon_edac_p __initdata;
 
 static int __init disable_octeon_edac(char *str)
 {
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 75e7c86..f08f175 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -21,6 +21,7 @@
 #include <asm/setup.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include "octeon_boot.h"
 
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index 64b86b9..7c2bf76 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -11,6 +11,14 @@
 #define NR_IRQS OCTEON_IRQ_LAST
 #define MIPS_CPU_IRQ_BASE OCTEON_IRQ_SW0
 
+/*
+ * 0    - unused.
+ * 1..8 - MIPS
+ *
+ * For a total of 9
+ */
+#define NR_IRQS_LEGACY 9
+
 enum octeon_irq {
 /* 1 - 8 represent the 8 MIPS standard interrupt sources */
 	OCTEON_IRQ_SW0 = 1,
diff --git a/arch/mips/include/asm/octeon/cvmx-asm.h b/arch/mips/include/asm/octeon/cvmx-asm.h
index 31eacc2..0e0d1e1 100644
--- a/arch/mips/include/asm/octeon/cvmx-asm.h
+++ b/arch/mips/include/asm/octeon/cvmx-asm.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,7 +32,9 @@
 #ifndef __CVMX_ASM_H__
 #define __CVMX_ASM_H__
 
-#include <asm/octeon/octeon-model.h>
+/* turn the variable name into a string */
+#define CVMX_TMP_STR(x) CVMX_TMP_STR2(x)
+#define CVMX_TMP_STR2(x) #x
 
 /* other useful stuff */
 #define CVMX_SYNC asm volatile ("sync" : : : "memory")
diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 6e61792..af9164b 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -64,94 +64,47 @@
 #define CVMX_CIU_INT_SUM1 (CVMX_ADD_IO_SEG(0x0001070000000108ull))
 static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	if ((cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) == OCTEON_CN68XX)
 		return CVMX_ADD_IO_SEG(0x0001070100100600ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
+	else
+		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
 }
-
 static inline uint64_t CVMX_CIU_MBOX_SETX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	if ((cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) == OCTEON_CN68XX)
 		return CVMX_ADD_IO_SEG(0x0001070100100400ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
+	else
+		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
 }
-
 #define CVMX_CIU_NMI (CVMX_ADD_IO_SEG(0x0001070000000718ull))
 #define CVMX_CIU_PCI_INTA (CVMX_ADD_IO_SEG(0x0001070000000750ull))
 #define CVMX_CIU_PP_BIST_STAT (CVMX_ADD_IO_SEG(0x00010700000007E0ull))
 #define CVMX_CIU_PP_DBG (CVMX_ADD_IO_SEG(0x0001070000000708ull))
 static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
+	switch(cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
+	case OCTEON_CN30XX:
+	case OCTEON_CN31XX:
+	case OCTEON_CN38XX:
+	case OCTEON_CN50XX:
+	case OCTEON_CN52XX:
+	case OCTEON_CN56XX:
+	case OCTEON_CN58XX:
+	case OCTEON_CN61XX:
+	case OCTEON_CN63XX:
+	case OCTEON_CN66XX:
+	case OCTEON_CN70XX:
+	case OCTEON_CNF71XX:
 		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
-	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX:
+	case OCTEON_CN78XX:
+	case OCTEON_CNF75XX:
+	default:
 		return CVMX_ADD_IO_SEG(0x0001010000030000ull) + (offset) * 8;
+	case OCTEON_CN68XX:
+		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
 	}
-	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 }
-
 #define CVMX_CIU_PP_RST (CVMX_ADD_IO_SEG(0x0001070000000700ull))
 #define CVMX_CIU_QLM0 (CVMX_ADD_IO_SEG(0x0001070000000780ull))
 #define CVMX_CIU_QLM1 (CVMX_ADD_IO_SEG(0x0001070000000788ull))
@@ -179,34 +132,28 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 #define CVMX_CIU_TIM_MULTI_CAST (CVMX_ADD_IO_SEG(0x000107000000C200ull))
 static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
+	switch(cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
+	case OCTEON_CN30XX:
+	case OCTEON_CN31XX:
+	case OCTEON_CN38XX:
+	case OCTEON_CN50XX:
+	case OCTEON_CN52XX:
+	case OCTEON_CN56XX:
+	case OCTEON_CN58XX:
+	case OCTEON_CN61XX:
+	case OCTEON_CN63XX:
+	case OCTEON_CN66XX:
+	case OCTEON_CN70XX:
+	case OCTEON_CNF71XX:
 		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
-	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX:
+	case OCTEON_CN78XX:
+	case OCTEON_CNF75XX:
+	default:
 		return CVMX_ADD_IO_SEG(0x0001010000020000ull) + (offset) * 8;
+	case OCTEON_CN68XX:
+		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
 	}
-	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 }
 
 union cvmx_ciu_bist {
diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
index c6c3ee3..d6feff6 100644
--- a/arch/mips/include/asm/octeon/cvmx-sysinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2016 Cavium, Inc.
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,7 +32,7 @@
 #ifndef __CVMX_SYSINFO_H__
 #define __CVMX_SYSINFO_H__
 
-#include "cvmx-coremask.h"
+#include <asm/octeon/cvmx-bootinfo.h>
 
 #define OCTEON_SERIAL_LEN 20
 /**
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 25854ab..392556a 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -54,8 +54,7 @@ enum cvmx_mips_space {
 #endif
 
 #include <asm/octeon/cvmx-asm.h>
-#include <asm/octeon/cvmx-packet.h>
-#include <asm/octeon/cvmx-sysinfo.h>
+#include <asm/octeon/octeon-model.h>
 
 #include <asm/octeon/cvmx-ciu-defs.h>
 #include <asm/octeon/cvmx-ciu3-defs.h>
@@ -68,8 +67,9 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
 #include <asm/octeon/cvmx-pow-defs.h>
+#include <asm/octeon/cvmx-rst-defs.h>
+#include <asm/octeon/cvmx-rnm-defs.h>
 
-#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-bootmem.h>
 #include <asm/octeon/cvmx-l2c.h>
 
@@ -102,10 +102,6 @@ static inline uint32_t cvmx_get_proc_id(void)
 	return id;
 }
 
-/* turn the variable name into a string */
-#define CVMX_TMP_STR(x) CVMX_TMP_STR2(x)
-#define CVMX_TMP_STR2(x) #x
-
 /**
  * Builds a bit mask given the required size in bits.
  *
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index 3e92a06..7cda3b6 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -17,6 +17,7 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-npi-defs.h>
 #include <asm/octeon/cvmx-pci-defs.h>
 #include <asm/octeon/pci-octeon.h>
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 87ba86b..899cbf2 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -14,6 +14,7 @@
 #include <linux/moduleparam.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/cvmx-npei-defs.h>
 #include <asm/octeon/cvmx-pciercx-defs.h>
 #include <asm/octeon/cvmx-pescx-defs.h>
-- 
2.1.4

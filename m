Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 22:37:42 +0100 (CET)
Received: from mail-bl2on0054.outbound.protection.outlook.com ([65.55.169.54]:53791
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009415AbaKMVhlRufZW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 22:37:41 +0100
Received: from BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) by
 BN1PR07MB021.namprd07.prod.outlook.com (10.255.225.39) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Thu, 13 Nov 2014 21:37:28 +0000
Received: from localhost.localdomain (2.165.41.20) by
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Thu, 13 Nov 2014 21:37:19 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: [PATCH 0/3] USB: host: Misc patches to remove hard-coded octeon platform information
Date:   Thu, 13 Nov 2014 22:36:27 +0100
Message-ID: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.165.41.20]
X-ClientProxiedBy: AM2PR03CA0029.eurprd03.prod.outlook.com (25.160.207.39) To
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141)
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Forefront-PRVS: 0394259C80
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(6009001)(189002)(199003)(164054003)(120916001)(110136001)(15202345003)(4396001)(97736003)(33646002)(102836001)(87286001)(50466002)(88136002)(122386002)(2171001)(87976001)(50226001)(19580395003)(89996001)(15395725005)(104166001)(50986999)(47776003)(92726001)(92566001)(64706001)(86362001)(93916002)(48376002)(95666004)(42186005)(40100003)(106356001)(66066001)(21056001)(101416001)(20776003)(62966003)(229853001)(15975445006)(77096003)(77156002)(36756003)(107046002)(31966008)(46102003)(105586002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB389;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB021;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

Hi Alan,

With following patches I want to base octeon ehci/ohci device
configuration on device tree information.

I picked up patches that were submitted in May. See
http://marc.info/?l=linux-usb&m=140135823325811&w=2
and http://marc.info/?l=linux-mips&m=140139694721623&w=2

Patch #1 is your "untested preliminary pass" to remove
 [oe]hci-octeon drivers.
Patch #2 is the removal of hard-coded platform information (but now
 rebased on your patch)
Patch #3 adapts dma_mask for ehci (as used in ehci-octeon)

Overall diffstat is

 arch/mips/cavium-octeon/octeon-platform.c |  380 +++++++++++++++++++++++------
 arch/mips/configs/cavium_octeon_defconfig |    3 +
 drivers/usb/host/Kconfig                  |   18 +-
 drivers/usb/host/Makefile                 |    1 -
 drivers/usb/host/ehci-hcd.c               |    5 -
 drivers/usb/host/ehci-octeon.c            |  188 --------------
 drivers/usb/host/ehci-platform.c          |    4 +-
 drivers/usb/host/octeon2-common.c         |  200 ---------------
 drivers/usb/host/ohci-hcd.c               |    5 -
 drivers/usb/host/ohci-octeon.c            |  202 ---------------
 drivers/usb/host/ohci-platform.c          |    1 +
 include/linux/usb/ehci_pdriver.h          |    1 +
 12 files changed, 330 insertions(+), 678 deletions(-)

Patches are based on v3.18-rc4-65-g2c54396

Comments welcome.


Thanks,

Andreas

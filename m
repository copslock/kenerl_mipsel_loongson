Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:04:31 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1198 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493670AbZJNTDI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:03:08 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad6205a0000>; Wed, 14 Oct 2009 12:02:50 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:02:52 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:02:52 -0700
Message-ID: <4AD6205A.8070200@caviumnetworks.com>
Date:	Wed, 14 Oct 2009 12:02:50 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>, netdev@vger.kernel.org
Subject: [PATCH 0/6] netdev: Octeon MGMT new driver + octeon_ethernet updates
 (v2).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2009 19:02:52.0627 (UTC) FILETIME=[EE444230:01CA4D00]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is the second version of this patch set.  The only difference
from the first version is that some unrelated changes have been
factored out of 6/6.

The main thrust of this patch set is to add a driver for the Cavium
Networks Octeon processor's MII (Management port) Ethernet devices.
Since it shares an mdio bus with the existing octeon-ethernet driver,
there is also some rearrangement of that code.

The Octeon SOC has an mdio bus that is shared by the PHYs of all the
Ethernet ports on the chip.  Patches 1/6 and 2/6 add a stand-alone
driver for the shared mdio bus

3/6 adds platform devices for the octeon_mgmt devices.

4/6 has the register definitions needed by the driver.

5/6 the octeon_mgmt driver proper

6/6 converts octeon_ethernet to use the PHYs on the shared mdio bus.


davem acked the non-mips parts (Thank You davem) and since the Octeon
is a mips based device, we will be merging these patches via Ralf's
tree.

I will reply with the 6 patches.

David Daney (6):
   MIPS: Octeon: Add platform device for MDIO buses.
   net: Add driver for Octeon MDIO buses.
   MIPS: Octeon: Add platform devices MGMT Ethernet ports.
   MIPS: Octeon: Add register definitions for MGMT Ethernet driver.
   netdev: Add Ethernet driver for Octeon MGMT devices.
   Staging: octeon-ethernet: Convert to use PHY Abstraction Layer.

  arch/mips/cavium-octeon/octeon-platform.c     |   88 ++
  arch/mips/include/asm/octeon/cvmx-agl-defs.h  | 1194 
+++++++++++++++++++++++++
  arch/mips/include/asm/octeon/cvmx-mixx-defs.h |  248 +++++
  arch/mips/include/asm/octeon/cvmx-smix-defs.h |  178 ++++
  drivers/net/Kconfig                           |    2 +
  drivers/net/Makefile                          |    2 +
  drivers/net/octeon/Kconfig                    |   10 +
  drivers/net/octeon/Makefile                   |    2 +
  drivers/net/octeon/octeon_mgmt.c              | 1175 
++++++++++++++++++++++++
  drivers/net/phy/Kconfig                       |   11 +
  drivers/net/phy/Makefile                      |    1 +
  drivers/net/phy/mdio-octeon.c                 |  180 ++++
  drivers/staging/octeon/Kconfig                |    3 +-
  drivers/staging/octeon/ethernet-mdio.c        |  204 ++---
  drivers/staging/octeon/ethernet-mdio.h        |    2 +-
  drivers/staging/octeon/ethernet-proc.c        |  112 ---
  drivers/staging/octeon/ethernet-rgmii.c       |   52 +-
  drivers/staging/octeon/ethernet-sgmii.c       |    2 +-
  drivers/staging/octeon/ethernet-xaui.c        |    2 +-
  drivers/staging/octeon/ethernet.c             |   23 +-
  drivers/staging/octeon/octeon-ethernet.h      |    6 +-
  21 files changed, 3216 insertions(+), 281 deletions(-)
  create mode 100644 arch/mips/include/asm/octeon/cvmx-agl-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-mixx-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-smix-defs.h
  create mode 100644 drivers/net/octeon/Kconfig
  create mode 100644 drivers/net/octeon/Makefile
  create mode 100644 drivers/net/octeon/octeon_mgmt.c
  create mode 100644 drivers/net/phy/mdio-octeon.c

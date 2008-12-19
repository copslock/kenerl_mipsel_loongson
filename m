Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2008 23:41:55 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18915 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207490AbYLSXlw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Dec 2008 23:41:52 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494c312e0000>; Fri, 19 Dec 2008 18:41:34 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:41:35 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:41:34 -0800
Message-ID: <494C312E.9000901@caviumnetworks.com>
Date:	Fri, 19 Dec 2008 15:41:34 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>, netdev@vger.kernel.org
Subject: [PATCH 0/3] Add driver for OCTEON MGMT ethernet device.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2008 23:41:34.0918 (UTC) FILETIME=[54041E60:01C96233]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Queued for inclusion in 2.6.29 is support for the Cavium OCTEON
processor.  See:

http://marc.info/?l=linux-mips&m=122903840412896&w=2
http://marc.info/?l=linux-mips&m=122972878908450&w=2

This patch set adds support for the OCTEON SOC's on-board mgmt ethernet
devices.

The first patch is not too interesting, it adds a missing function to
the boot monitor memory allocator.  This is needed by the third patch.

Second I add register definitions for the hardware blocks used by the
driver.  This is just a lot of boiler plate.

Third is the main driver patch.

I anticipate that some changes may have to be made to the driver, but
I wanted to get some feedback before proceeding.  So please let me
know what you think should change with an eye to getting the driver
merged.

I will reply with the three patches.

David Daney (3):
  MIPS: Add named alloc functions to OCTEON boot monitor memory
    allocator.
  MIPS: Add some register definitions to OCTEON for MGMT ethernet
    driver.
  netdev: New driver for OCTEON's MGMT ethernet devices.

 arch/mips/cavium-octeon/executive/cvmx-bootmem.c |  101 ++
 arch/mips/include/asm/octeon/cvmx-agl-defs.h     | 1194 ++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h      |   85 ++
 arch/mips/include/asm/octeon/cvmx-mdio.h         |  577 +++++++++++
 arch/mips/include/asm/octeon/cvmx-mixx-defs.h    |  248 +++++
 arch/mips/include/asm/octeon/cvmx-smix-defs.h    |  178 ++++
 drivers/net/Kconfig                              |    8 +
 drivers/net/Makefile                             |    1 +
 drivers/net/octeon/Makefile                      |   11 +
 drivers/net/octeon/cvmx-mgmt-port.c              |  818 +++++++++++++++
 drivers/net/octeon/cvmx-mgmt-port.h              |  168 +++
 drivers/net/octeon/octeon-mgmt-port.c            |  389 +++++++
 12 files changed, 3778 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-agl-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mdio.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mixx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-smix-defs.h
 create mode 100644 drivers/net/octeon/Makefile
 create mode 100644 drivers/net/octeon/cvmx-mgmt-port.c
 create mode 100644 drivers/net/octeon/cvmx-mgmt-port.h
 create mode 100644 drivers/net/octeon/octeon-mgmt-port.c

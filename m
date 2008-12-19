Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2008 23:19:06 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:64209 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24208217AbYLSXTE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Dec 2008 23:19:04 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494c2bcc0000>; Fri, 19 Dec 2008 18:18:36 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:18:26 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 19 Dec 2008 15:18:25 -0800
Message-ID: <494C2BC1.2080903@caviumnetworks.com>
Date:	Fri, 19 Dec 2008 15:18:25 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] PCI support for Cavium OCTEON processors.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Dec 2008 23:18:25.0771 (UTC) FILETIME=[18051BB0:01C96230]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch adds preliminary support for PCI and PCIe to the initial
processor support patch that is queued for 2.6.29 (actually it is
against a slightly changed version of that patch set).  It has been
tested with both an RT8139 (PCI ethernet) and e1000e (PCIe ethernet)
on several different boards and seems to be working well.

There are two patches, the first adds register definitions needed by
PCI and PCIe, the second is the main patch that adds the support.


Any comments are welcome.


I will reply with two patches.

David Daney (2):
  MIPS: Add register definitions for PCI.
  MIPS: Add Cavium OCTEON PCI support.

 arch/mips/Kconfig                                  |    2 +
 arch/mips/cavium-octeon/Makefile                   |    4 +
 arch/mips/cavium-octeon/dma-octeon.c               |  310 +++-
 arch/mips/cavium-octeon/executive/Makefile         |    2 +
 .../cavium-octeon/executive/cvmx-helper-errata.c   |  379 +++
 .../cavium-octeon/executive/cvmx-helper-util.c     |  502 ++++
 arch/mips/cavium-octeon/executive/cvmx-pcie.c      | 1053 ++++++++
 arch/mips/cavium-octeon/msi.c                      |  288 +++
 arch/mips/cavium-octeon/octeon-irq.c               |    2 +
 arch/mips/cavium-octeon/pci-common.c               |  137 ++
 arch/mips/cavium-octeon/pci-common.h               |   39 +
 arch/mips/cavium-octeon/pci.c                      |  568 +++++
 arch/mips/cavium-octeon/pcie.c                     |  441 ++++
 arch/mips/include/asm/octeon/cvmx-asm.h            |    3 +-
 arch/mips/include/asm/octeon/cvmx-helper-errata.h  |   92 +
 arch/mips/include/asm/octeon/cvmx-helper-util.h    |  266 ++
 arch/mips/include/asm/octeon/cvmx-npei-defs.h      | 2560 ++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-npi-defs.h       | 1735 +++++++++++++
 arch/mips/include/asm/octeon/cvmx-packet.h         |   16 +-
 arch/mips/include/asm/octeon/cvmx-pci-defs.h       | 1645 +++++++++++++
 arch/mips/include/asm/octeon/cvmx-pcie.h           |  284 +++
 arch/mips/include/asm/octeon/cvmx-pcieep-defs.h    | 1365 +++++++++++
 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h   | 1397 +++++++++++
 arch/mips/include/asm/octeon/cvmx-pescx-defs.h     |  410 ++++
 arch/mips/include/asm/octeon/cvmx-pexp-defs.h      |  229 ++
 arch/mips/include/asm/octeon/cvmx-wqe.h            |  422 ++++
 arch/mips/include/asm/octeon/cvmx.h                |   12 +
 arch/mips/include/asm/octeon/octeon.h              |    2 +
 28 files changed, 14157 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-helper-errata.c
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-helper-util.c
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-pcie.c
 create mode 100644 arch/mips/cavium-octeon/msi.c
 create mode 100644 arch/mips/cavium-octeon/pci-common.c
 create mode 100644 arch/mips/cavium-octeon/pci-common.h
 create mode 100644 arch/mips/cavium-octeon/pci.c
 create mode 100644 arch/mips/cavium-octeon/pcie.c
 create mode 100644 arch/mips/include/asm/octeon/cvmx-helper-errata.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-helper-util.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-npei-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-npi-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pci-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pcie.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pcieep-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pescx-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pexp-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-wqe.h

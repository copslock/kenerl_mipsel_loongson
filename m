Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 01:45:09 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:60181 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20021638AbZDXAo7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 01:44:59 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49f10b720000>; Thu, 23 Apr 2009 20:44:39 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Apr 2009 17:43:37 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Apr 2009 17:43:37 -0700
Message-ID: <49F10B38.7070808@caviumnetworks.com>
Date:	Thu, 23 Apr 2009 17:43:36 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/2] PCI and PCIe support for Cavium OCTEON
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2009 00:43:37.0112 (UTC) FILETIME=[B4409980:01C9C475]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

As per the subject, this set adds support for PCI and PCIe to the
Cavium OCTEON processor support.

The first patch is just register definitions for the PCI related
hardware.

The second contains the drivers and hooks them up.  The DMA mapping
code needs to do quite a bit to handle the PCI.  Interrupt handling
was already present, but we need a couple of more include files.
Other than that, it is all PCI driver things.

I will reply with the two patches.

David Daney (2):
   MIPS: Add register definitions for PCI.
   MIPS: Add Cavium OCTEON PCI support.

  arch/mips/Kconfig                                  |    2 +
  arch/mips/cavium-octeon/Makefile                   |    4 +
  arch/mips/cavium-octeon/dma-octeon.c               |  311 +++-
  arch/mips/cavium-octeon/executive/Makefile         |    1 +
  .../cavium-octeon/executive/cvmx-helper-errata.c   |   70 +
  .../cavium-octeon/executive/cvmx-helper-jtag.c     |  144 ++
  arch/mips/cavium-octeon/msi.c                      |  288 +++
  arch/mips/cavium-octeon/octeon-irq.c               |    2 +
  arch/mips/cavium-octeon/pci-common.c               |  137 ++
  arch/mips/cavium-octeon/pci-common.h               |   39 +
  arch/mips/cavium-octeon/pci.c                      |  568 +++++
  arch/mips/cavium-octeon/pcie.c                     | 1370 +++++++++++
  arch/mips/include/asm/octeon/cvmx-helper-errata.h  |   33 +
  arch/mips/include/asm/octeon/cvmx-helper-jtag.h    |   43 +
  arch/mips/include/asm/octeon/cvmx-npei-defs.h      | 2560 
++++++++++++++++++++
  arch/mips/include/asm/octeon/cvmx-npi-defs.h       | 1735 +++++++++++++
  arch/mips/include/asm/octeon/cvmx-pci-defs.h       | 1645 +++++++++++++
  arch/mips/include/asm/octeon/cvmx-pcieep-defs.h    | 1365 +++++++++++
  arch/mips/include/asm/octeon/cvmx-pciercx-defs.h   | 1397 +++++++++++
  arch/mips/include/asm/octeon/cvmx-pescx-defs.h     |  410 ++++
  arch/mips/include/asm/octeon/cvmx-pexp-defs.h      |  229 ++
  arch/mips/include/asm/octeon/cvmx.h                |   12 +
  arch/mips/include/asm/octeon/octeon.h              |    2 +
  23 files changed, 12365 insertions(+), 2 deletions(-)
  create mode 100644 arch/mips/cavium-octeon/executive/cvmx-helper-errata.c
  create mode 100644 arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
  create mode 100644 arch/mips/cavium-octeon/msi.c
  create mode 100644 arch/mips/cavium-octeon/pci-common.c
  create mode 100644 arch/mips/cavium-octeon/pci-common.h
  create mode 100644 arch/mips/cavium-octeon/pci.c
  create mode 100644 arch/mips/cavium-octeon/pcie.c
  create mode 100644 arch/mips/include/asm/octeon/cvmx-helper-errata.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-helper-jtag.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-npei-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-npi-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-pci-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-pcieep-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-pescx-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-pexp-defs.h

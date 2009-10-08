Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 02:14:10 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17573 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492981AbZJHAOD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 02:14:03 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4acd2ec00001>; Wed, 07 Oct 2009 17:13:52 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Oct 2009 17:13:51 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Oct 2009 17:13:51 -0700
Message-ID: <4ACD2EBF.8020901@caviumnetworks.com>
Date:	Wed, 07 Oct 2009 17:13:51 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 0/2] USB: Add USB HCD for Octeon SOCs.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2009 00:13:51.0364 (UTC) FILETIME=[36D95440:01CA47AC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The subject line kind of says it all.

Some members of the Cavium Networks Octeon family of SOCs contain the
Synopsys DWC-OTG USB controller.  This patch set adds the
corresponding driver.

The first patch adds between zero and two Octeon platform devices.
The second is the driver.

I have done a little bit of clean-up on the driver code, but
undoubtedly the careful scrutiny of the USB maintainers will uncover
more opportunities for improvement.  I look foreword to seeing any
suggestions for how the code might be changed so that it could be
merged.


I will reply with the two patches.

David Daney (2):
   MIPS: Octeon: Add USB platform device.
   USB: Add HCD for Octeon SOC

  arch/mips/cavium-octeon/octeon-platform.c      |  105 +
  arch/mips/include/asm/octeon/cvmx-usbcx-defs.h | 1199 ++++++++++
  arch/mips/include/asm/octeon/cvmx-usbnx-defs.h |  760 +++++++
  drivers/usb/host/Kconfig                       |    8 +
  drivers/usb/host/Makefile                      |    1 +
  drivers/usb/host/dwc_otg/Kbuild                |   16 +
  drivers/usb/host/dwc_otg/dwc_otg_attr.c        |  854 +++++++
  drivers/usb/host/dwc_otg/dwc_otg_attr.h        |   63 +
  drivers/usb/host/dwc_otg/dwc_otg_cil.c         | 2887 
++++++++++++++++++++++++
  drivers/usb/host/dwc_otg/dwc_otg_cil.h         |  866 +++++++
  drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c    |  689 ++++++
  drivers/usb/host/dwc_otg/dwc_otg_driver.h      |   63 +
  drivers/usb/host/dwc_otg/dwc_otg_hcd.c         | 2878 
+++++++++++++++++++++++
  drivers/usb/host/dwc_otg/dwc_otg_hcd.h         |  661 ++++++
  drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c    | 1890 ++++++++++++++++
  drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c   |  695 ++++++
  drivers/usb/host/dwc_otg/dwc_otg_octeon.c      | 1078 +++++++++
  drivers/usb/host/dwc_otg/dwc_otg_plat.h        |  236 ++
  drivers/usb/host/dwc_otg/dwc_otg_regs.h        | 2355 +++++++++++++++++++
  19 files changed, 17304 insertions(+), 0 deletions(-)
  create mode 100644 arch/mips/include/asm/octeon/cvmx-usbcx-defs.h
  create mode 100644 arch/mips/include/asm/octeon/cvmx-usbnx-defs.h
  create mode 100644 drivers/usb/host/dwc_otg/Kbuild
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_attr.c
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_attr.h
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil.c
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil.h
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_driver.h
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd.c
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd.h
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_octeon.c
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_plat.h
  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_regs.h

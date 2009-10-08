Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 22:54:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15086 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097318AbZJHUyi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 22:54:38 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ace1cee0000>; Thu, 08 Oct 2009 10:10:11 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Oct 2009 10:09:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Oct 2009 10:09:17 -0700
Message-ID: <4ACE1CBD.6000106@caviumnetworks.com>
Date:	Thu, 08 Oct 2009 10:09:17 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] USB: Add USB HCD for Octeon SOCs.
References: <4ACD2EBF.8020901@caviumnetworks.com>
In-Reply-To: <4ACD2EBF.8020901@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2009 17:09:17.0306 (UTC) FILETIME=[118A4DA0:01CA483A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> The subject line kind of says it all.
> 
> Some members of the Cavium Networks Octeon family of SOCs contain the
> Synopsys DWC-OTG USB controller.  This patch set adds the
> corresponding driver.
> 
> The first patch adds between zero and two Octeon platform devices.
> The second is the driver.
> 
> I have done a little bit of clean-up on the driver code, but
> undoubtedly the careful scrutiny of the USB maintainers will uncover
> more opportunities for improvement.  I look foreword to seeing any
> suggestions for how the code might be changed so that it could be
> merged.
> 
> 
> I will reply with the two patches.
> 

I did in fact reply with the two patches.  However some spam filtering 
seems to have stopped '[PATCH 2/2] USB: Add HCD for Octeon SOC' from 
making it to the lists.

Ralf has released it to linux-mips@linux-mips.org, but 
linux-usb@vger.kernel.org seems to have eaten it.

It had a Message-Id: 
<1254960926-12185-2-git-send-email-ddaney@caviumnetworks.com>

I won't send it again as it seems likely that it would get eaten again, 
but if the list controllers for linux-usb could release it, that would 
be nice.

David Daney




> David Daney (2):
>   MIPS: Octeon: Add USB platform device.
>   USB: Add HCD for Octeon SOC
> 
>  arch/mips/cavium-octeon/octeon-platform.c      |  105 +
>  arch/mips/include/asm/octeon/cvmx-usbcx-defs.h | 1199 ++++++++++
>  arch/mips/include/asm/octeon/cvmx-usbnx-defs.h |  760 +++++++
>  drivers/usb/host/Kconfig                       |    8 +
>  drivers/usb/host/Makefile                      |    1 +
>  drivers/usb/host/dwc_otg/Kbuild                |   16 +
>  drivers/usb/host/dwc_otg/dwc_otg_attr.c        |  854 +++++++
>  drivers/usb/host/dwc_otg/dwc_otg_attr.h        |   63 +
>  drivers/usb/host/dwc_otg/dwc_otg_cil.c         | 2887 
> ++++++++++++++++++++++++
>  drivers/usb/host/dwc_otg/dwc_otg_cil.h         |  866 +++++++
>  drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c    |  689 ++++++
>  drivers/usb/host/dwc_otg/dwc_otg_driver.h      |   63 +
>  drivers/usb/host/dwc_otg/dwc_otg_hcd.c         | 2878 
> +++++++++++++++++++++++
>  drivers/usb/host/dwc_otg/dwc_otg_hcd.h         |  661 ++++++
>  drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c    | 1890 ++++++++++++++++
>  drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c   |  695 ++++++
>  drivers/usb/host/dwc_otg/dwc_otg_octeon.c      | 1078 +++++++++
>  drivers/usb/host/dwc_otg/dwc_otg_plat.h        |  236 ++
>  drivers/usb/host/dwc_otg/dwc_otg_regs.h        | 2355 +++++++++++++++++++
>  19 files changed, 17304 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/octeon/cvmx-usbcx-defs.h
>  create mode 100644 arch/mips/include/asm/octeon/cvmx-usbnx-defs.h
>  create mode 100644 drivers/usb/host/dwc_otg/Kbuild
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_attr.c
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_attr.h
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil.c
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil.h
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_cil_intr.c
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_driver.h
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd.c
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd.h
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_octeon.c
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_plat.h
>  create mode 100644 drivers/usb/host/dwc_otg/dwc_otg_regs.h
> 
> 
> 

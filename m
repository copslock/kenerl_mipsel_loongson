Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 13:51:48 +0100 (BST)
Received: from host100-213-dynamic.0-87-r.retail.telecomitalia.it ([87.0.213.100]:53512
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20021782AbXIMMvj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 13:51:39 +0100
Received: from 89-96-243-184.ip14.fastwebnet.it ([89.96.243.184] helo=[192.168.215.30])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IVo7K-0005v3-Ug; Thu, 13 Sep 2007 14:48:25 +0200
Subject: Re: pci-to-pci bridges on ip32
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20070912232015.GJ4571@linux-mips.org>
References: <1189536946.7988.62.camel@scarafaggio>
	 <20070912232015.GJ4571@linux-mips.org>
Content-Type: text/plain
Date:	Thu, 13 Sep 2007 14:48:19 +0200
Message-Id: <1189687699.7506.18.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Il giorno gio, 13/09/2007 alle 00.20 +0100, Ralf Baechle ha scritto:
[...]
> Can you give a few more details on the sympthom with this card on IP32?
> 
>   Ralf

I have an SGI O2 with an R5000 CPU, 1 SCSI CD-ROM, 2 SCSI disks, 128Mb
of RAM and a PCI ethernet card. I replaced the PCI card with this new
board, but it seems the board is listed but otherwise ignored. The only
trace is in lspci output. There isn't a list of devices in the other
side of this PCI-to-PCI chip.

# lspci
00:01.0 SCSI storage controller: Adaptec AIC-7880U
00:02.0 SCSI storage controller: Adaptec AIC-7880U
00:03.0 PCI Bridge: Netmos technology Unknown device 9250
(The card vendor and product are IDs 9710:9250.)

When I plug the card on an i386 machine, it is recognised since lspci
display the card and all three devices present on the same card (devices
accessible via the PCI-to-PCI bridge). All these devices are available
to udev, so udev start all relevant drivers.

I started checking my kernel config. Do I have to activate any specific
CONFIG_?? option in order to use such a card (beside the driver for all
devices).

Actually I have:

CONFIG_HW_HAS_PCI=y
CONFIG_PCI=y
CONFIG_MMU=y
# CONFIG_HOTPLUG_PCI is not set

while on i386 I have:

CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
CONFIG_PCI_MSI=y
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=m

I am using kernel 2.6.18 on both machines, as shipped with Debian
stable.

Thanks,
Giuseppe

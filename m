Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 13:04:27 +0000 (GMT)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:32211 "EHLO
	localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225281AbULHNEW>; Wed, 8 Dec 2004 13:04:22 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id iB8C0m8A023916;
	Wed, 8 Dec 2004 12:00:48 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id iB8C0lx8023915;
	Wed, 8 Dec 2004 12:00:47 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: 2.6 kernel & ide_ops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: wlacey <wlacey@goldenhindresearch.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20041208121422.18641.qmail@server212.com>
References: <20041208121422.18641.qmail@server212.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102507245.23635.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Dec 2004 12:00:46 +0000
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Mer, 2004-12-08 at 12:14, wlacey wrote:
> Forgive the stupid question but on the 2.6 kernel I cannot find an ide_ops.h header file and obviously the extern ide_ops structure.
> 

The ide ops are part of the hwif (hardware interface) object.

> How should one go about specifiying an ide device in a 2.6 kernel

Assuming the device has standard behaviour and is just basic legacy IDE
then

	ide_hwif_t *hwif;
	hw_reg_t hw;

	memset(hw, 0, sizeof(*hw));
	ide_std_init_ports(&hw, IDE_PORT, CTRL__PORT);
	hw.irq = whatever;
	hw.dma = NO_DMA;

	ide_register_hw(&hw, NULL);

For DMA devices you need either to use the PCI layer functions or
register DMA handlers. Take a look at something simple like
drivers/ide/pci/triflex.c

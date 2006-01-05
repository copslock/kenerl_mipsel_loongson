Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2006 13:24:46 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:52106 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133529AbWAENY2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jan 2006 13:24:28 +0000
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 5D37FC0EF;
	Thu,  5 Jan 2006 14:26:58 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id D8C301BC08E;
	Thu,  5 Jan 2006 14:26:59 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id C7F191A18B4;
	Thu,  5 Jan 2006 14:26:59 +0100 (CET)
Subject: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI) PROGRESS
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-usb-devel@lists.sourceforge.net, matthias.lenk@amd.com,
	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 05 Jan 2006 14:26:52 +0100
Message-Id: <1136467612.6378.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

Made some progress in the AU1200 USB OHCI/EHCI.

Previously, if both were selected we got:
------------------------------------------------------------------------
[4294669.339000] au1xxx-ehci au1xxx-ehci.0: Au1xxx EHCI
[4294669.347000] au1xxx-ehci au1xxx-ehci.0: new USB bus registered,
assigned bus number 1
[4294669.355000] au1xxx-ehci au1xxx-ehci.0: irq 29, io mem 0x14020200
[4294669.361000] au1xxx-ehci au1xxx-ehci.0: USB 0.0 started, EHCI 1.00,
driver 10 Dec 2004
[4294669.374000] hub 1-0:1.0: USB hub found
[4294669.378000] hub 1-0:1.0: 0 ports detected
[4294669.488000] au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
[4294669.495000] au1xxx-ohci au1xxx-ohci.0: new USB bus registered,
assigned bus number 2
[4294669.504000] au1xxx-ohci au1xxx-ohci.0: irq 29, io mem 0x14020100
[4294679.372000] BUG: soft lockup detected on CPU#0!
[4294679.372000] Cpu 0
[4294679.372000] $ 0   : 00000000 1000fc01 8f6278bc 8f6278bc
[4294679.372000] $ 4   : 00000000 804471d0 00030200 80000000
[4294679.372000] $ 8   : 00000000 802b1df0 00000000 8046e000
[4294679.372000] $12   : 8f63b610 fffffffb ffffffff 0000000a
[4294679.372000] $16   : 8f6278c0 8f63bbe4 80470000 8f63b8c4
[4294679.372000] $20   : 00000002 804e0000 0000001d 24000000
[4294679.372000] $24   : 00000018 00000000                  
[4294679.372000] $28   : 80524000 80525df0 00000000 8013aa48
[4294679.372000] Hi    : 000301ff
[4294679.372000] Lo    : fc85b000
[4294679.372000] epc   : 8013aa68 notifier_chain_register+0x48/0xb8
Not tainted
[4294679.372000] ra    : 8013aa48 notifier_chain_register+0x28/0xb8
[4294679.372000] Status: 1000fc03    KERNEL EXL IE 
[4294679.372000] Cause : 00808000
[4294679.372000] PrId  : 04030201
------------------------------------------------------------------------

The problem was in the ehci-au1xxx.c in usb_ehci_au1xxx_probe before the
call to usb_add_hcd the driver called driver->reset (hcd). 
Reset points to ehci_init which at the end of function calls:
register_reboot_notifier(&ehci->reboot_notifier);

After that the usb_ehci_au1xxx_probe calls usb_add_hcd which *AGAIN*
calls ehci_init *AND* register_reboot_notifer and thus creating
reboot_notifier_list->next pointing to reboot_notifier_list!
------------------------------------------------------------------------
If I remove a call to reset, I get:
[4294669.337000] au1xxx-ehci au1xxx-ehci.0: Au1xxx EHCI
[4294669.344000] au1xxx-ehci au1xxx-ehci.0: new USB bus registered,
assigned bus number 1
[4294669.352000] au1xxx-ehci au1xxx-ehci.0: irq 29, io mem 0x14020200
[4294669.359000] au1xxx-ehci au1xxx-ehci.0: USB 0.0 started, EHCI 1.00,
driver 10 Dec 2004
[4294669.371000] hub 1-0:1.0: USB hub found
[4294669.375000] hub 1-0:1.0: 0 ports detected
[4294669.486000] au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
[4294669.493000] au1xxx-ohci au1xxx-ohci.0: new USB bus registered,
assigned bus number 2
[4294669.502000] au1xxx-ohci au1xxx-ohci.0: irq 29, io mem 0x14020100
[4294669.595000] hub 2-0:1.0: USB hub found
[4294669.599000] hub 2-0:1.0: 2 ports detected
------------------------------------------------------------------------

But it still does not work right. If I plug in USB 2.0 memory
stick, I get:
------------------------------------------------------------------------
/root # [4294699.429000] usb 2-1: new full speed USB device using
au1xxx-ohci and address 2
[4294699.438000] au1xxx-ehci au1xxx-ehci.0: fatal error
[4294699.438000] au1xxx-ehci au1xxx-ehci.0: HC died; cleaning up
[4294699.579000] usb 2-1: not running at top speed; connect to a high
speed hub
[4294709.001000] Initializing USB Mass Storage driver...
[4294709.077000] scsi0 : SCSI emulation for USB Mass Storage devices
[4294709.251000] usbcore: registered new driver usb-storage
[4294709.257000] USB Mass Storage support registered.
[4294714.269000]   Vendor: Generic   Model: STORAGE DEVICE    Rev: 1.04
[4294714.276000]   Type:   Direct-Access                      ANSI SCSI
revision: 00
[4294714.562000] SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
[4294714.577000] sda: Write Protect is on
[4294714.581000] sda: assuming drive cache: write through
[4294714.619000] SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
[4294714.635000] sda: Write Protect is on
[4294714.639000] sda: assuming drive cache: write through
[4294714.644000]  sda: sda1
[4294714.663000] sd 0:0:0:0: Attached scsi removable disk sda
[4294714.708000] sd 0:0:0:0: Attached scsi generic sg0 type 0
------------------------------------------------------------------------

Well, back to work.
I just wanted to keep you posted, because I know somebody else is also
working on it and I wouldn't like to duplicate the effort.

BR,
Matej

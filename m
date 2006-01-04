Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2006 13:05:46 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:36817 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133500AbWADNF2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jan 2006 13:05:28 +0000
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id E3C8EC089;
	Wed,  4 Jan 2006 14:07:51 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 739561BC08D;
	Wed,  4 Jan 2006 14:07:54 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 10C351A18B3;
	Wed,  4 Jan 2006 14:07:55 +0100 (CET)
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	matthias.lenk@amd.com
Cc:	Jordan Crouse <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200601041332.16043.matthias.lenk@amd.com>
References: <20051208210042.GB17458@cosmic.amd.com>
	 <20060103155447.GI15770@cosmic.amd.com>
	 <1136376726.27748.32.camel@localhost.localdomain>
	 <200601041332.16043.matthias.lenk@amd.com>
Content-Type: text/plain
Date:	Wed, 04 Jan 2006 14:07:51 +0100
Message-Id: <1136380071.27748.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> I looked into the issue and came to the same conclusions as you. Something 
> significant has changed from 2.6.15rc2 (what the patch was made for) to 
> 2.6.15rc5. I added the initialization of the caps and regs fields of the ehci 
> structure to the probe function in ehci-au1xxx.c. The driver doesn't crash 
> anymore but does not work either.

Where did you put it?
I don't know much about USB, but by looking into the ehci-pci.c I added
this to the ehci-au1xxx.c, after ioremap of hcd->regs:

ehci = hcd_to_ehci(hcd);
ehci->caps = hcd->regs;
ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));

Is this O.K.?

Now, with this I get:

[4294668.620000] au1xxx-ehci au1xxx-ehci.0: Au1xxx EHCI
[4294668.626000] au1xxx-ehci au1xxx-ehci.0: new USB bus registered,
assigned bus number 1
[4294668.634000] au1xxx-ehci au1xxx-ehci.0: irq 29, io mem 0x14020200
[4294668.640000] au1xxx-ehci au1xxx-ehci.0: USB 0.0 started, EHCI 1.00,
driver 10 Dec 2004
[4294668.649000] hub 1-0:1.0: USB hub found
[4294668.653000] hub 1-0:1.0: 0 ports detected
[4294668.762000] au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
[4294668.767000] au1xxx-ohci au1xxx-ohci.0: new USB bus registered,
assigned bus number 2
[4294668.775000] au1xxx-ohci au1xxx-ohci.0: irq 29, io mem 0x14020100
[4294678.361000] BUG: soft lockup detected on CPU#0!
[4294678.361000] Cpu 0
[4294678.361000] $ 0   : 00000000 1000fc01 807c856c 807c856c
[4294678.361000] $ 4   : 807c8570 80721710 00000000 b4020100
[4294678.361000] $ 8   : 80000000 802a4030 00000000 8045a000
[4294678.361000] $12   : 80721108 fffffffb ffffffff 0000000a
[4294678.361000] $16   : 807214d0 80721400 80721400 80470000
[4294678.361000] $20   : 00000002 804c0000 24000000 0000001d
[4294678.361000] $24   : 00000018 81281d51                  
[4294678.361000] $28   : 81280000 81281e28 00000000 80355484
[4294678.361000] Hi    : 000301ff
[4294678.361000] Lo    : fc85b000
[4294678.361000] epc   : 80139c78 notifier_chain_register+0x18/0x54
Not tainted
[4294678.361000] ra    : 80355484 ohci_au1xxx_start+0x644/0x678
[4294678.361000] Status: 1000fc03    KERNEL EXL IE 
[4294678.361000] Cause : 00808000
[4294678.361000] PrId  : 04030201

Well, a little further :(

> I also tried the Au1xxx OHCI and it hangs while loading the module with rc7. 
> So it'll probably take some time to port the Au1200 EHCI and OHCI drivers to 
> 2.6.15rc7 (again!). 

I think Bora Sahin said he used OHCI successfully on 2.5.15-rc4.
Bora, can you confirm this?

> Any hints on what has changed are appreciated.

I disabled EHCI in .config and tried again. This is what I got:

[4294668.621000] au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
[4294668.626000] au1xxx-ohci au1xxx-ohci.0: new USB bus registered,
assigned bus number 1
[4294668.635000] au1xxx-ohci au1xxx-ohci.0: irq 29, io mem 0x14020100
[4294668.725000] hub 1-0:1.0: USB hub found
[4294668.729000] hub 1-0:1.0: 2 ports detected

When I plug in USB 2.0 Flash key (with the vfat module lodaed):

/root # [4294868.810000] usb 1-1: new full speed USB device using
au1xxx-ohci and address 2
[4294877.045000] kobject_register failed for usbcore (-17)
[4294877.050000] Call Trace:
[4294877.053000]  [<8029e490>] kobject_register+0x74/0x8c
[4294877.058000]  [<8029e440>] kobject_register+0x24/0x8c
[4294877.063000]  [<8014c070>] load_module+0xec4/0x1810
[4294877.068000]  [<8014c04c>] load_module+0xea0/0x1810
[4294877.073000]  [<80206ed4>] do_setlk+0x1cc/0x40c
[4294877.078000]  [<801640f8>] vma_prio_tree_insert+0x28/0x5c
[4294877.084000]  [<8016ae64>] __vma_link+0x34/0x80
[4294877.089000]  [<801533d8>] generic_file_mmap+0x68/0x70
[4294877.094000]  [<8016af40>] vma_link+0x90/0x160
[4294877.099000]  [<8016aef0>] vma_link+0x40/0x160
[4294877.103000]  [<8014cab4>] sys_init_module+0xd0/0x890
[4294877.108000]  [<8010daac>] stack_done+0x20/0x40
[4294877.113000] 
[4294878.449000] Initializing USB Mass Storage driver...
[4294878.508000] scsi0 : SCSI emulation for USB Mass Storage devices
[4294878.606000] usbcore: registered new driver usb-storage
[4294878.612000] USB Mass Storage support registered.
[4294883.623000]   Vendor: Generic   Model: STORAGE DEVICE    Rev: 1.04
[4294883.630000]   Type:   Direct-Access                      ANSI SCSI
revision: 00
[4294883.913000] SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
[4294883.928000] sda: Write Protect is on
[4294883.932000] sda: assuming drive cache: write through
[4294883.965000] SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
[4294883.980000] sda: Write Protect is on
[4294883.984000] sda: assuming drive cache: write through
[4294883.989000]  sda: sda1
[4294884.005000] sd 0:0:0:0: Attached scsi removable disk sda
[4294884.028000] sd 0:0:0:0: Attached scsi generic sg0 type 0

And I can mount /dev/sda1.
I'll try with only EHCI now, then I'll look into this
kobject_register.

BR,
Matej

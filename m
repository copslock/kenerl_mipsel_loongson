Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jan 2006 14:23:30 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:37331 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133761AbWACOXI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Jan 2006 14:23:08 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 7A7EAC008;
	Tue,  3 Jan 2006 15:25:25 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 309651BC084;
	Tue,  3 Jan 2006 15:25:28 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 9BFBD1A18B6;
	Tue,  3 Jan 2006 15:25:27 +0100 (CET)
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org, linux-usb-devel@lists.sourceforge.net,
	matthias.lenk@amd.com
In-Reply-To: <20051208210042.GB17458@cosmic.amd.com>
References: <20051208210042.GB17458@cosmic.amd.com>
Content-Type: text/plain
Date:	Tue, 03 Jan 2006 15:25:29 +0100
Message-Id: <1136298329.6765.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> Ok, here we go.  I give you the OHCI/EHCI host controller support for
> the Alchemy AU1200 processor.  I'm sending this up, partly because I have
> it ready to go, but also because it seems that enough folks are getting their
> hands on AU1200 parts to make this a hot topic.  

I tried you patch, and this is what I get on 2.6.16-rc5:

[4294668.576000] Creating 3 MTD partitions on "Db1200 Flash":
[4294668.581000] 0x00000000-0x03c00000 : "User FS"
[4294668.587000] 0x03c00000-0x03d00000 : "YAMON"
[4294668.593000] 0x03d00000-0x03fc0000 : "raw kernel"
[4294668.602000] CPU 0 Unable to handle kernel paging request at virtual
address 00000008, epc == 80350764, ra == 80350760
[4294668.613000] Oops[#1]:
[4294668.613000] Cpu 0
[4294668.613000] $ 0   : 00000000 1000fc00 8054a000 00000000
[4294668.613000] $ 4   : 8054b000 00000000 00000000 8107d530
[4294668.613000] $ 8   : 00000000 802a4030 8107d520 8053d57c
[4294668.613000] $12   : ffffffff ffffffff 00100100 00200200
[4294668.613000] $16   : 8053c0d0 8053c000 00001000 80460000
[4294668.613000] $20   : 8041dcb0 00000000 00000000 00000000
[4294668.613000] $24   : 00000008 00000000                  
[4294668.613000] $28   : 804f2000 804f3e58 00000000 80350760
[4294668.613000] Hi    : 00000000
[4294668.613000] Lo    : 00000000
[4294668.613000] epc   : 80350764 ehci_init+0x190/0x2c0     Not tainted
[4294668.613000] ra    : 80350760 ehci_init+0x18c/0x2c0
[4294668.613000] Status: 1000fc03    KERNEL EXL IE 
[4294668.613000] Cause : 00800008
[4294668.613000] BadVA : 00000008
[4294668.613000] PrId  : 04030201
[4294668.613000] Modules linked in:
[4294668.613000] Process swapper (pid: 1, threadinfo=804f2000,
task=804eec00)
[4294668.613000] Stack : 8013044c 8033e100 804f2000 804f3e88 00001000
80352018 1000fc03 000301ff
[4294668.613000]         8053c000 fffffff4 8045e138 803520bc 804f3e78
804689e0 804f3ef8 811bb5c0
[4294668.613000]         00000010 00000000 8045e138 8045e140 80471cfc
8045e204 00000000 803521e0
[4294668.613000]         804f3e88 810756a0 00000000 00000000 00000000
00000000 00000000 802e3cd0
[4294668.613000]         8045e18c 804f3f30 8045e18c 8040d780 8045e140
804c0000 80471cfc 802e40a0
[4294668.613000]         ...
[4294668.613000] Call Trace:
[4294668.613000]  [<8013044c>] __request_region+0x38/0xb4
[4294668.613000]  [<8033e100>] usb_create_hcd+0x4c/0xc8
[4294668.613000]  [<80352018>] usb_ehci_au1xxx_probe+0xc0/0x1f8
[4294668.613000]  [<803520bc>] usb_ehci_au1xxx_probe+0x164/0x1f8
[4294668.613000]  [<803521e0>] ehci_hcd_au1xxx_drv_probe+0x38/0x50
[4294668.613000]  [<802e3cd0>] driver_probe_device+0x4c/0xe8
[4294668.613000]  [<8040d780>] klist_next+0x40/0x70
[4294668.613000]  [<802e40a0>] __driver_attach+0x178/0x1a0
[4294668.613000]  [<802e3f28>] __driver_attach+0x0/0x1a0
[4294668.613000]  [<802e3024>] next_device+0x10/0x28
[4294668.613000]  [<802e3f28>] __driver_attach+0x0/0x1a0
[4294668.613000]  [<802e3090>] bus_for_each_dev+0x54/0x90
[4294668.613000]  [<8029e468>] kobject_register+0x4c/0x8c
[4294668.613000]  [<802e374c>] bus_add_driver+0xa8/0x18c
[4294668.613000]  [<8027bb80>] debugfs_create_dir+0x1c/0x28
[4294668.613000]  [<802e47a4>] driver_register+0x40/0x50
[4294668.613000]  [<80100510>] init+0xac/0x2dc
[4294668.613000]  [<80105ee0>] kernel_thread_helper+0x10/0x18
[4294668.613000]  [<80105ed0>] kernel_thread_helper+0x0/0x18
[4294668.613000] 
[4294668.613000] 
[4294668.613000] Code: 0c0a8fd0  00063080  8e030000 <8c660008> 7000003f
10400046  00061102  24020008  ae020028 
[4294668.866000] Kernel panic - not syncing: Attempted to kill init!

Any ideas?

BR,
Matej

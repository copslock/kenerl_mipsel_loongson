Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 15:48:44 +0100 (BST)
Received: from serv07.server-center.de ([83.220.153.152]:59020 "EHLO
	serv07.server-center.de") by ftp.linux-mips.org with ESMTP
	id S20038548AbWH2Osm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 15:48:42 +0100
Received: (qmail 7176 invoked from network); 29 Aug 2006 16:47:53 +0200
Received: by simscan 1.1.0 ppid: 7112, pid: 7117, t: 7.2320s
         scanners: regex: 1.1.0 clamav: 0.88.2/m:39/d:1600 spam: 3.1.0
Received: from p548de4c9.dip.t-dialin.net (HELO mycable-alex.mycable.de) (www518317@84.141.228.201)
  by serv07.server-center.de with ESMTPA; 29 Aug 2006 16:47:46 +0200
From:	Alexander Bigga <ab@mycable.de>
To:	linux-mips@linux-mips.org
Subject: [PATCH] fixup for pci config_access on alchemy au1x000
Date:	Tue, 29 Aug 2006 16:48:34 +0200
User-Agent: KMail/1.7.2
Cc:	ppopov@embeddedalley.com
Organization: mycable GmbH
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291648.35250.ab@mycable.de>
Return-Path: <ab@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ab@mycable.de
Precedence: bulk
X-list: linux-mips

Hi all,

I've encountered a serious problem with PCI config space access on Au1x000 
platforms with recent 2.6.x-kernel. With 2.4.31 the same hardware works fine. 
So I was looking for the differences:

Symptoms:
- no PCI-device is seen on bootup though two or three cards are present
- lspci output is empty
- OR: lspci shows 20 times the same device
(- OR: in some slot-configurations it worked anyhow)

System(s): 
1. platform with Au1500 and three PCI-devices (actually a mycable XXS1500 
    with backplane for three PCI-devices)
2. platform with Au1550 and two PCI-devices (custom board)

Debugging:
I digged down to the config_access() of the au1xxx-processors in 
arch/mips/pci/ops-au1000.c and switched on DEBUG.

The code of config_access() seems to be almost the same as of the 
2.4.x-kernel. But the "pci_cfg_vm->addr" returned by get_vm_area(0x2000, 0) 
once on booting is different. That's of course not forbidden. But the 
alignment seems to be wrong. In my case, I received:

2.4.31: pci_cfg_vm->addr = c0000000
2.6.18-rc5: pci_cfg_vm->addr = c0101000

To make it short: With 2.6.x it fails on the first config-access with:
"PCI ERR detected: status 83a00356".

Fixup:
My fix is now, to use the VM_IOREMAP-flag in the get_vm_area call. This flag 
seems to be introduced in mm/vmalloc.c a long time ago (in 2.6.7-bk13, I 
found in gitweb). 
Now, the returned address is pci_cfg_vm->addr = c0104000 and everything works 
fine.

What do you think about my fixup-patch? 
Nobody's using the get_vm_area()-call without any flag ("0"). Was it only 
forgotten in the  arch/mips/pci/ops-au1000.c?

Or am I completely wrong?

Thanks a lot for your comments!

Best regard,


Alexander

--- linux-2.6.18-rc5/arch/mips/pci/ops-au1000.c	2006-08-28 12:09:15.000000000 
+0200
+++ linux-2.6.18-rc5-dev/arch/mips/pci/ops-au1000.c	2006-08-29 
13:08:59.000000000 +0200
@@ -110,7 +110,7 @@
 	if (first_cfg) {
 		/* reserve a wired entry for pci config accesses */
 		first_cfg = 0;
-		pci_cfg_vm = get_vm_area(0x2000, 0);
+		pci_cfg_vm = get_vm_area(0x2000, VM_IOREMAP);
 		if (!pci_cfg_vm)
 			panic (KERN_ERR "PCI unable to get vm area\n");
 		pci_cfg_wired_entry = read_c0_wired();

-- 
Alexander Bigga     Tel: +49 4873 90 10 866
mycable GmbH        Fax: +49 4873 901 976
Boeker Stieg 43
D-24613 Aukrug      eMail: ab@mycable.de

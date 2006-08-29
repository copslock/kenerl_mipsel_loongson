Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 18:42:23 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:60078 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039481AbWH2RmV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2006 18:42:21 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id E4F903ED1; Tue, 29 Aug 2006 10:42:17 -0700 (PDT)
Message-ID: <44F47CBD.8090202@ru.mvista.com>
Date:	Tue, 29 Aug 2006 21:43:25 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alexander Bigga <ab@mycable.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fixup for pci config_access on alchemy au1x000
References: <200608291648.35250.ab@mycable.de>
In-Reply-To: <200608291648.35250.ab@mycable.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alexander Bigga wrote:

> I've encountered a serious problem with PCI config space access on Au1x000 
> platforms with recent 2.6.x-kernel. With 2.4.31 the same hardware works fine. 
> So I was looking for the differences:

> Symptoms:
> - no PCI-device is seen on bootup though two or three cards are present
> - lspci output is empty
> - OR: lspci shows 20 times the same device
> (- OR: in some slot-configurations it worked anyhow)

> System(s): 
> 1. platform with Au1500 and three PCI-devices (actually a mycable XXS1500 
>     with backplane for three PCI-devices)
> 2. platform with Au1550 and two PCI-devices (custom board)

> Debugging:
> I digged down to the config_access() of the au1xxx-processors in 
> arch/mips/pci/ops-au1000.c and switched on DEBUG.

> The code of config_access() seems to be almost the same as of the 
> 2.4.x-kernel. But the "pci_cfg_vm->addr" returned by get_vm_area(0x2000, 0) 
> once on booting is different. That's of course not forbidden. But the 
> alignment seems to be wrong. In my case, I received:

> 2.4.31: pci_cfg_vm->addr = c0000000
> 2.6.18-rc5: pci_cfg_vm->addr = c0101000

> To make it short: With 2.6.x it fails on the first config-access with:
> "PCI ERR detected: status 83a00356".

> Fixup:
> My fix is now, to use the VM_IOREMAP-flag in the get_vm_area call. This flag 
> seems to be introduced in mm/vmalloc.c a long time ago (in 2.6.7-bk13, I 
> found in gitweb). 
> Now, the returned address is pci_cfg_vm->addr = c0104000 and everything works 
> fine.

> What do you think about my fixup-patch? 
> Nobody's using the get_vm_area()-call without any flag ("0"). Was it only 
> forgotten in the  arch/mips/pci/ops-au1000.c?

> Or am I completely wrong?

    You're correct -- this code was only working by some chance. Once you get 
a virtual address not aligned to 8K, it breaks completely since the pages 
can't constitute a valid pair for wired entry anymore.
    Actually, in 2.4 the situation seems to be even worse as get_vm_area() 
there has no provision for the address alignment at all!

> Best regard,

> Alexander

WBR, Sergei

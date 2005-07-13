Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2005 03:19:42 +0100 (BST)
Received: from smtpr6.tom.com ([IPv6:::ffff:202.108.252.136]:54610 "HELO
	tom.com") by linux-mips.org with SMTP id <S8226522AbVGMCTU>;
	Wed, 13 Jul 2005 03:19:20 +0100
Received: from [192.168.10.105] (unknown [218.94.38.156])
	by bjapp14 (Coremail) with SMTP id GACKXGN61EJXACac.1
	for <linux-mips@linux-mips.org>; Wed, 13 Jul 2005 10:20:21 +0800 (CST)
X-Originating-IP: [218.94.38.156]
Message-ID: <42D47A74.9070709@tom.com>
Date:	Wed, 13 Jul 2005 10:20:36 +0800
From:	IHOLLO <ihollo@tom.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: ADM5120: linux-2.4.31-adm.diff.bz2 does not support PCI bus?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ihollo@tom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihollo@tom.com
Precedence: bulk
X-list: linux-mips

Hi,

I am now working on a board with ADM5120 processor and want a kernel 
newer than 2.4.18, so I tried the linux-2.4.31-adm.diff.bz2 patch 
against vanilla 2.4.31 (http://www.linux-mips.org/wiki/ADMtek#Linux_2.4) 
but failed to compile it with PCI Bus support (It compiles OK without 
CONFIG_PCI). The compile error looks like this:

......
/opt/xyz/buildfarm/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld 
-m elf32ltsmip -G 0 -static -n -T arch/mips/ld.script 
arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o 
arch/mips/pci/pci-core.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o 
drivers/net/net.o drivers/pci/driver.o drivers/mtd/mtdlink.o 
drivers/media/media.o \
        net/network.o \
        arch/mips/lib/lib.a /opt/xyz/linux-2.4/linux-2.4.31/lib/lib.a 
arch/mips/am5120/am5120.o \
        --end-group \
        -o vmlinux
drivers/pci/driver.o(.text+0x2218): In function `pci_fixup_device':
: undefined reference to `pcibios_fixups'
drivers/pci/driver.o(.text+0x222c): In function `pci_fixup_device':
: undefined reference to `pcibios_fixups'
drivers/pci/driver.o(.text.init+0x6d4): In function `pci_do_scan_bus':
: undefined reference to `pcibios_fixup_bus'
drivers/pci/driver.o(.text.init+0x6d4): In function `pci_do_scan_bus':
: relocation truncated to fit: R_MIPS_26 against `pcibios_fixup_bus'
drivers/pci/driver.o(.text.init+0xa98): In function `pci_init':
: undefined reference to `pcibios_init'
drivers/pci/driver.o(.text.init+0xa98): In function `pci_init':
: relocation truncated to fit: R_MIPS_26 against `pcibios_init'
make: *** [vmlinux] Error 1

Is PCI Bus supported by this patch? Or, is there any new kernel 
availible for ADM5120?

Thanks very much.

Zhuang Yuyao

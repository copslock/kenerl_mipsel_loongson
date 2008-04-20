Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 11:04:13 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:27347 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20034109AbYDTKEK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 Apr 2008 11:04:10 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 8E2705BC043;
	Sun, 20 Apr 2008 13:04:09 +0300 (EEST)
Date:	Sun, 20 Apr 2008 13:03:47 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Michael Buesch <mb@bu3sch.de>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: mips BCM47XX compile error
Message-ID: <20080420100347.GH1595@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit aab547ce0d1493d400b6468c521a0137cd8c1edf
(ssb: Add Gigabit Ethernet driver) causes the following
build error with bcm47xx_defconfig:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/mips/pci/built-in.o: In function `pcibios_enable_device':
(.text+0x1f8): undefined reference to `pcibios_plat_dev_init'
arch/mips/pci/built-in.o: In function `pcibios_enable_device':
(.text+0x1f8): relocation truncated to fit: R_MIPS_26 against `pcibios_plat_dev_init'
arch/mips/pci/built-in.o: In function `pcibios_init':
pci.c:(.init.text+0x14c): undefined reference to `pcibios_map_irq'
pci.c:(.init.text+0x158): undefined reference to `pcibios_map_irq'
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 11:15:28 +0100 (BST)
Received: from vs166246.vserver.de ([62.75.166.246]:2951 "EHLO
	vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20034163AbYDTKP0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 20 Apr 2008 11:15:26 +0100
Received: from t5d89.t.pppool.de ([89.55.93.137] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1JnWZg-0004mO-2F; Sun, 20 Apr 2008 10:15:08 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Adrian Bunk <bunk@kernel.org>
Subject: Re: mips BCM47XX compile error
Date:	Sun, 20 Apr 2008 12:14:46 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	"John W. Linville" <linville@tuxdriver.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
References: <20080420100347.GH1595@cs181133002.pp.htv.fi>
In-Reply-To: <20080420100347.GH1595@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804201214.46936.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Sunday 20 April 2008 12:03:47 Adrian Bunk wrote:
> Commit aab547ce0d1493d400b6468c521a0137cd8c1edf
> (ssb: Add Gigabit Ethernet driver) causes the following
> build error with bcm47xx_defconfig:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> arch/mips/pci/built-in.o: In function `pcibios_enable_device':
> (.text+0x1f8): undefined reference to `pcibios_plat_dev_init'
> arch/mips/pci/built-in.o: In function `pcibios_enable_device':
> (.text+0x1f8): relocation truncated to fit: R_MIPS_26 against `pcibios_plat_dev_init'
> arch/mips/pci/built-in.o: In function `pcibios_init':
> pci.c:(.init.text+0x14c): undefined reference to `pcibios_map_irq'
> pci.c:(.init.text+0x158): undefined reference to `pcibios_map_irq'
> make[1]: *** [.tmp_vmlinux1] Error 1

Some parts of the new 47xx arch code are not ported, yet.
Somebody should port all the new code from openwrt SVN over to mainline.
I don't really have time for that, at the moment, though.

-- 
Greetings Michael.

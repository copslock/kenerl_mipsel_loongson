Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 15:39:12 +0200 (CEST)
Received: from r-hh.iij4u.or.jp ([210.130.0.72]:21495 "EHLO r-hh.iij4u.or.jp")
	by linux-mips.org with ESMTP id <S1122962AbSIPNjM>;
	Mon, 16 Sep 2002 15:39:12 +0200
Received: from stratos.montavista.co.jp (h157.p989.iij4u.or.jp [210.138.221.157])
	by r-hh.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id g8GDd0f01804;
	Mon, 16 Sep 2002 22:39:00 +0900 (JST)
Date: Mon, 16 Sep 2002 22:38:51 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@linux-mips.org
Subject: Re: patch for pci.c
Message-Id: <20020916223851.540a112a.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20020912185612.56743fd7.yoichi_yuasa@montavista.co.jp>
References: <20020912185612.56743fd7.yoichi_yuasa@montavista.co.jp>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf

If this patch is not applied, the following errors will occur.
Please apply this patch to linux_2_4 tag.

make[1]: Entering directory `/home/yuasa/src/mips/linux/arch/mips/kernel'
mipsel-linux-gcc -D__KERNEL__ -I/home/yuasa/src/mips/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I /home/yuasa/src/mips/linux/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe -mcpu=r4600 -mips2 -Wa,--trap   -nostdinc -iwithprefix include -DKBUILD_BASENAME=pci  -c -o pci.o pci.c
pci.c:104: conflicting types for `pcibios_enable_device'
/home/yuasa/src/mips/linux/include/linux/pci.h:496: previous declaration of `pcibios_enable_device'
make[1]: *** [pci.o] Error 1
make[1]: Leaving directory `/home/yuasa/src/mips/linux/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2


On Thu, 12 Sep 2002 18:56:12 +0900
Yoichi Yuasa <yoichi_yuasa@montavista.co.jp> wrote:

> Hi Ralf,
> 
> The argument of pcibios_enable_device is changed.
> 
> In include/linux/pci.h:
> int pcibios_enable_device(struct pci_dev *, int mask);
> 
> The following patch is required for the cvs tree of linux_2_4 tag.
> 
> --- ./arch/mips/kernel/pci.c.orig	Wed May 29 12:03:16 2002
> +++ ./arch/mips/kernel/pci.c	Thu Sep 12 18:22:14 2002
> @@ -100,7 +100,7 @@
>  	pcibios_fixup_irqs();
>  }
>  
> -int pcibios_enable_device(struct pci_dev *dev)
> +int pcibios_enable_device(struct pci_dev *dev, int mask)
>  {
>  	/* pciauto_assign_resources() will enable all devices found */
>  	return 0;

Thanks,

Yoichi

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2006 07:26:49 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:53257 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037733AbWJGG0r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Oct 2006 07:26:47 +0100
Received: by mo.po.2iij.net (mo32) id k976QhP8008163; Sat, 7 Oct 2006 15:26:43 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k976QZdb064253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 7 Oct 2006 15:26:36 +0900 (JST)
Date:	Sat, 7 Oct 2006 06:48:05 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] add "depends on BROKEN" to broken boards support
Message-Id: <20061007064805.5b656556.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <4526A0F3.5090202@ru.mvista.com>
References: <20061007005452.45b50d8c.yoichi_yuasa@tripeaks.co.jp>
	<4526A0F3.5090202@ru.mvista.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello Sergei,

On Fri, 06 Oct 2006 22:31:15 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Yoichi Yuasa wrote:
> 
> > This patch has added "depends on BROKEN" to broken boards support.
> > These boards cannot build now.
> 
> > Yoichi
> 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> > @@ -511,6 +517,7 @@ config QEMU
> >  
> >  config MARKEINS
> >  	bool "Support for NEC EMMA2RH Mark-eins"
> > +	depends on BROKEN
> >  	select DMA_NONCOHERENT
> >  	select HW_HAS_PCI
> >  	select IRQ_CPU
> 
>     What's broken about this board?

I got build error under arch/mips/emma2rh .
This board support cannot be built for three months or more.

  CC      arch/mips/emma2rh/common/irq.o
arch/mips/emma2rh/common/irq.c: In function `emma2rh_irq_dispatch':
arch/mips/emma2rh/common/irq.c:59: error: too many arguments to function `__do_IRQ'
arch/mips/emma2rh/common/irq.c:68: error: too many arguments to function `__do_IRQ'
arch/mips/emma2rh/common/irq.c:84: error: too many arguments to function `__do_IRQ'
arch/mips/emma2rh/common/irq.c:93: error: too many arguments to function `__do_IRQ'
arch/mips/emma2rh/common/irq.c:103: error: too many arguments to function `__do_IRQ'
make[1]: *** [arch/mips/emma2rh/common/irq.o] Error 1
make: *** [arch/mips/emma2rh/common] Error 2


> 
> > @@ -717,6 +724,7 @@ config SNI_RM200_PCI
> >  
> >  config TOSHIBA_JMR3927
> >  	bool "Toshiba JMR-TX3927 board"
> > +	depends on BROKEN
> >  	select DMA_NONCOHERENT
> >  	select HW_HAS_PCI
> >  	select MIPS_TX3927
> > @@ -728,6 +736,7 @@ config TOSHIBA_JMR3927
> >  
> >  config TOSHIBA_RBTX4927
> >  	bool "Toshiba TBTX49[23]7 board"
> > +	depends on BROKEN
> >  	select DMA_NONCOHERENT
> >  	select HAS_TXX9_SERIAL
> >  	select HW_HAS_PCI
> 
>     ... and this one?

Also, this board support cannot be built for three months or more.

  CC      arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.o
  CC      arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.o
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c: In function `tx4927_pcibios_init':
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:274: warning: unused variable `s'
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:359: warning: unused variable `s'
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c: In function `toshiba_rbtx4927_setup':
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:1003: warning: implicit declaration of function `prom_getcmdline'
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:1003: warning: assignment makes pointer from integer without a cast
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:1011: warning: assignment makes pointer from integer without a cast
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c: In function `toshiba_rbtx4927_time_init':
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:1031: warning: unused variable `c1'
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:1032: warning: unused variable `c2'
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c: At top level:
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:165: warning: 'tx4927_pcierr_interrupt' defined but not used
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:244: warning: 'early_read_config_word' defined but not used
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:247: warning: 'early_write_config_word' defined but not used
  CC      arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.o
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c: In function `toshiba_rbtx4927_irq_ioc_enable':
arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c:434: warning: implicit declaration of function `wbflush'
  LD      arch/mips/tx4927/toshiba_rbtx4927/built-in.o
  CC      arch/mips/tx4927/common/tx4927_prom.o
  CC      arch/mips/tx4927/common/tx4927_setup.o
  CC      arch/mips/tx4927/common/tx4927_irq.o
arch/mips/tx4927/common/tx4927_irq.c: In function `tx4927_irq_nested':
arch/mips/tx4927/common/tx4927_irq.c:563: warning: implicit declaration of function `toshiba_rbtx4927_irq_nested'
make[1]: *** No rule to make target `arch/mips/tx4927/common/smsc_fdc37m81x.o', needed by `arch/mips/tx4927/common/built-in.o'.  Stop.
make: *** [arch/mips/tx4927/common] Error 2

> > @@ -745,6 +754,7 @@ config TOSHIBA_RBTX4927
> >  
> >  config TOSHIBA_RBTX4938
> >  	bool "Toshiba RBTX4938 board"
> > +	depends on BROKEN
> >  	select HAVE_STD_PC_SERIAL_PORT
> >  	select DMA_NONCOHERENT
> >  	select GENERIC_ISA_DMA
> 
>     There's a patch from Atsushi Nemoto still pending commit, IIRC...

Is it fixed these errors.

  LD      .tmp_vmlinux1
arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `toshiba_rbtx4938_irq_nested':
: undefined reference to `wbflush'
arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `toshiba_rbtx4938_irq_nested':
: relocation truncated to fit: R_MIPS_26 against `wbflush'
arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `arch_init_irq':
: undefined reference to `wbflush'
arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `arch_init_irq':
: relocation truncated to fit: R_MIPS_26 against `wbflush'
arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `arch_init_irq':
: undefined reference to `wbflush'
arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `arch_init_irq':
: relocation truncated to fit: R_MIPS_26 against `wbflush'
arch/mips/tx4938/common/built-in.o: In function `tx4938_irq_nested':
: undefined reference to `wbflush'
arch/mips/tx4938/common/built-in.o: In function `tx4938_irq_nested':
: relocation truncated to fit: R_MIPS_26 against `wbflush'
make: *** [.tmp_vmlinux1] Error 1


Yoichi

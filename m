Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2009 09:28:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:26813 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21070052AbZCLJ2O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Mar 2009 09:28:14 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2C9SCTV005215;
	Thu, 12 Mar 2009 10:28:12 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2C9SAGV005212;
	Thu, 12 Mar 2009 10:28:10 +0100
Date:	Thu, 12 Mar 2009 10:28:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: __do_IRQ() going away
Message-ID: <20090312092810.GA13674@linux-mips.org>
References: <20090311112806.GA24541@linux-mips.org> <20090312072618.GA31978@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090312072618.GA31978@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 12, 2009 at 08:26:18AM +0100, Manuel Lauss wrote:

> 
> On Wed, Mar 11, 2009 at 12:28:06PM +0100, Ralf Baechle wrote:
> > __do_IRQ() is deprecated since a long time and there are plans to remove
> > it for 2.6.30.  The MIPS platforms seem to fall into three classes:
> 
> >  o Platforms that still seem to rely on __do_IRQ():
> >      o All Alchemy platforms:
> > 	db1000_defconfig, db1100_defconfig, db1200_defconfig, db1500_defconfig,
> > 	db1550_defconfig, mtx1_defconfig, pb1100_defconfig, pb1500_defconfig
> > 	and pb1550_defconfig
> 
> I believe that the defconfigs just need to be updated.  There are no
> __do_IRQ invocations in the alchemy/ tree anymore, and generic hardirqs are
> enabled by CONFIG_SOC_AU1X00.

__do_IRQ will be called from the generic code if irq_desc->handle_irq is
not set for an interrupt and handle_irq will be left NULL if a platform
only calls set_irq_chip or even does a homebrew initialization.  Fix is
to call set_irq_chip_and_handler or better set_irq_chip_and_handler_name.
Iow, now with CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ always set half the
platforms will blow up because the function pointer irq_desc->handle_irq
is unset.

  Ralf

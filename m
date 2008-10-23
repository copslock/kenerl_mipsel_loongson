Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 18:20:38 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:30133 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S22231754AbYJWRUd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 18:20:33 +0100
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 6F2A64001C;
	Thu, 23 Oct 2008 19:20:31 +0200 (CEST)
Received: from [192.168.27.166] (152-186-96-87.cust.blixtvik.se [87.96.186.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 05B8840017;
	Thu, 23 Oct 2008 19:20:30 +0200 (CEST)
Message-ID: <4900B260.1090808@27m.se>
Date:	Thu, 23 Oct 2008 19:20:32 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
CC:	linux-mips@linux-mips.org, shinya.kuribayashi@necel.com
Subject: Re: [PATCH 08/12] MIPS: EMMA2RH: Remove emma2rh_gpio_irq_base
References: <4900A510.3000101@ruby.dti.ne.jp> <4900A70B.4040401@ruby.dti.ne.jp>
In-Reply-To: <4900A70B.4040401@ruby.dti.ne.jp>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Reminds me of the I2C driver for EMMA2RH that MontaVista posted, I
ought to take the time to shape it up...

//Markus

Shinya Kuribayashi wrote:
> Let's use immediate value, instead.  This also saves memory
> footprint, and probably a little bit faster.
>
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
> --- arch/mips/emma/markeins/irq.c          |    4 ++--
> arch/mips/emma/markeins/irq_markeins.c |   19 ++++++++----------- 2
> files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/arch/mips/emma/markeins/irq.c
> b/arch/mips/emma/markeins/irq.c index c0f9d46..3577fd5 100644 ---
> a/arch/mips/emma/markeins/irq.c +++ b/arch/mips/emma/markeins/irq.c
>  @@ -54,7 +54,7 @@ */
>
> extern void emma2rh_sw_irq_init(void); -extern void
> emma2rh_gpio_irq_init(u32 base); +extern void
> emma2rh_gpio_irq_init(void); extern void emma2rh_irq_init(void);
> extern void emma2rh_irq_dispatch(void);
>
> @@ -104,7 +104,7 @@ void __init arch_init_irq(void) /* init all
> controllers */ emma2rh_irq_init(); emma2rh_sw_irq_init(); -
> emma2rh_gpio_irq_init(EMMA2RH_GPIO_IRQ_BASE); +
> emma2rh_gpio_irq_init(); mips_cpu_irq_init();
>
> /* setup cascade interrupts */ diff --git
> a/arch/mips/emma/markeins/irq_markeins.c
> b/arch/mips/emma/markeins/irq_markeins.c index 1883421..ea27ec5
> 100644 --- a/arch/mips/emma/markeins/irq_markeins.c +++
> b/arch/mips/emma/markeins/irq_markeins.c @@ -30,8 +30,6 @@ #include
> <asm/debug.h> #include <asm/emma/emma2rh.h>
>
> -static int emma2rh_gpio_irq_base = -1; - void
> ll_emma2rh_sw_irq_enable(int reg); void
> ll_emma2rh_sw_irq_disable(int reg); void
> ll_emma2rh_gpio_irq_enable(int reg); @@ -91,17 +89,17 @@ void
> ll_emma2rh_sw_irq_disable(int irq)
>
> static void emma2rh_gpio_irq_enable(unsigned int irq) { -
> ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base); +
> ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE); }
>
> static void emma2rh_gpio_irq_disable(unsigned int irq) { -
> ll_emma2rh_gpio_irq_disable(irq - emma2rh_gpio_irq_base); +
> ll_emma2rh_gpio_irq_disable(irq - EMMA2RH_GPIO_IRQ_BASE); }
>
> static void emma2rh_gpio_irq_ack(unsigned int irq) { -    irq -=
> emma2rh_gpio_irq_base; +    irq -= EMMA2RH_GPIO_IRQ_BASE;
> emma2rh_out32(EMMA2RH_GPIO_INT_ST, ~(1 << irq));
> ll_emma2rh_gpio_irq_disable(irq); } @@ -109,7 +107,7 @@ static void
> emma2rh_gpio_irq_ack(unsigned int irq) static void
> emma2rh_gpio_irq_end(unsigned int irq) { if (!(irq_desc[irq].status
> & (IRQ_DISABLED | IRQ_INPROGRESS))) -
> ll_emma2rh_gpio_irq_enable(irq - emma2rh_gpio_irq_base); +
> ll_emma2rh_gpio_irq_enable(irq - EMMA2RH_GPIO_IRQ_BASE); }
>
> struct irq_chip emma2rh_gpio_irq_controller = { @@ -121,14 +119,13
> @@ struct irq_chip emma2rh_gpio_irq_controller = { .end =
> emma2rh_gpio_irq_end, };
>
> -void emma2rh_gpio_irq_init(u32 irq_base) +void
> emma2rh_gpio_irq_init(void) { u32 i;
>
> -    for (i = irq_base; i < irq_base + NUM_EMMA2RH_IRQ_GPIO; i++) -
> set_irq_chip(i, &emma2rh_gpio_irq_controller); - -
> emma2rh_gpio_irq_base = irq_base; +    for (i = 0; i <
> NUM_EMMA2RH_IRQ_GPIO; i++) +
> set_irq_chip(EMMA2RH_GPIO_IRQ_BASE + i, +
> &emma2rh_gpio_irq_controller); }
>
> void ll_emma2rh_gpio_irq_enable(int irq)
>


- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJALJe6I0XmJx2NrwRCAkwAJwLnvjgZSCkD9+lc4kDtUxoOIaOGwCg0m8f
tZSAE26XNDffF7fmBLRp6sI=
=WD43
-----END PGP SIGNATURE-----

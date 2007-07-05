Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 17:01:19 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:53660 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023042AbXGEQBO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2007 17:01:14 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F07043EC9; Thu,  5 Jul 2007 09:01:09 -0700 (PDT)
Message-ID: <468D163B.9070907@ru.mvista.com>
Date:	Thu, 05 Jul 2007 20:03:07 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	"Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: dead(?) MIPS config stuff
References: <20070705144641.GA20210@linux-mips.org>
In-Reply-To: <20070705144641.GA20210@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>   a brute force run of my latest dead CONFIG variable script, you can
> decide if any of it is of interest.

> ========== AU1000_SRC_CLK ==========
> arch/mips/au1000/common/time.c:206:#ifdef CONFIG_AU1000_SRC_CLK
> arch/mips/au1000/common/time.c:207:#define AU1000_SRC_CLK	CONFIG_AU1000_SRC_CLK
> arch/mips/au1000/common/time.c:207:#define AU1000_SRC_CLK	CONFIG_AU1000_SRC_CLK
> arch/mips/au1000/common/time.c:209:#define AU1000_SRC_CLK	12000000
> arch/mips/au1000/common/time.c:275:			AU1000_SRC_CLK;
> arch/mips/au1000/common/time.c:283:		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
> ========== AU1000_USE32K ==========
> arch/mips/au1000/common/time.c:250:#if defined(CONFIG_AU1000_USE32K)

    Erm, maybe it's worth to declare these options instead?

> ========== AU1XXX_PSC_SPI ==========
> arch/mips/au1000/pb1200/board_setup.c:134:#if defined(CONFIG_AU1XXX_PSC_SPI) && defined(CONFIG_I2C_AU1550)
> arch/mips/au1000/pb1200/board_setup.c:137:#elif defined( CONFIG_AU1XXX_PSC_SPI )

    I think that CONFIG_AU1XXX_PSC_SPI needs to be changed to CONFIG_SPI_AU1550...

> ========== MIPS_HYDROGEN3 ==========
> arch/mips/au1000/common/setup.c:103:#ifdef CONFIG_MIPS_HYDROGEN3

    Hm, hasn't Hydrogen3 support been removed?

> ========== PCMCIA_XXS1500 ==========
> arch/mips/au1000/xxs1500/board_setup.c:66:#ifdef CONFIG_PCMCIA_XXS1500

    Actually, that PCMCIA driver is controlled by CONFIG_MIPS_XXS1500 itself, 
so #ifdef/#endif should just go, leaving what's between them always compiled.

> ========== SIBYTE_BCM1480_PROF ==========
> arch/mips/sibyte/bcm1480/irq.c:460:#ifdef CONFIG_SIBYTE_BCM1480_PROF
> arch/mips/sibyte/bcm1480/irq.c:467:#ifdef CONFIG_SIBYTE_BCM1480_PROF

    Hm, that could probably be killed. The referenced function isn't defined 
anywhere. Same about CONFIG_SIBYTE_BCM1250_PROF which is here but the kernel 
won't build w/it anyway...

> ========== SIBYTE_SB1250_DUART ==========
> arch/mips/configs/sb1250-swarm_defconfig:665:CONFIG_SIBYTE_SB1250_DUART=y
> arch/mips/configs/bigsur_defconfig:673:CONFIG_SIBYTE_SB1250_DUART=y
> arch/mips/sibyte/bcm1480/irq.c:79:#ifdef CONFIG_SIBYTE_SB1250_DUART
> arch/mips/sibyte/bcm1480/irq.c:407:#ifdef CONFIG_SIBYTE_SB1250_DUART
> arch/mips/sibyte/sb1250/irq.c:64:#ifdef CONFIG_SIBYTE_SB1250_DUART
> arch/mips/sibyte/sb1250/irq.c:362:#ifdef CONFIG_SIBYTE_SB1250_DUART
> arch/mips/sibyte/cfe/console.c:49:#ifdef CONFIG_SIBYTE_SB1250_DUART

    This belongs to drivers/char/sb1350_duart.c which is only maintained in 
the Linux/MIPS tree...

> ========== SOUND_AU1X00 ==========
> arch/mips/au1000/common/setup.c:116:#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)

    The OSS driver has been obsoleted. Kill this piece, it doesn't apply to 
the ALSA driver.

> ========== TX4927BUG_WORKAROUND ==========
> arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:141:#define CONFIG_TX4927BUG_WORKAROUND
> arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:672:#ifdef CONFIG_TX4927BUG_WORKAROUND
> arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c:914:#ifdef CONFIG_TX4927BUG_WORKAROUND

    This one shouldn't have been called CONFIG_* and might be just killed as 
well....

> ========== USB_OHCI ==========
> arch/mips/au1000/pb1000/board_setup.c:57:#ifdef CONFIG_USB_OHCI
> arch/mips/au1000/pb1000/board_setup.c:105:#ifdef CONFIG_USB_OHCI
> arch/mips/au1000/pb1000/board_setup.c:119:#endif // defined (CONFIG_USB_OHCI)
> arch/mips/au1000/pb1500/board_setup.c:59:#ifdef CONFIG_USB_OHCI
> arch/mips/au1000/pb1500/board_setup.c:88:#ifdef CONFIG_USB_OHCI
> arch/mips/au1000/pb1500/board_setup.c:98:#endif // defined (CONFIG_USB_OHCI)
> arch/mips/au1000/pb1100/board_setup.c:57:#ifdef CONFIG_USB_OHCI
> arch/mips/au1000/pb1100/board_setup.c:101:#endif // defined (CONFIG_USB_OHCI)
> arch/mips/au1000/mtx-1/board_setup.c:57:#ifdef CONFIG_USB_OHCI
> arch/mips/au1000/mtx-1/board_setup.c:61:#endif // defined (CONFIG_USB_OHCI)

    Should be changed to CONFIG_USB_OHCI_HCD.

WBR, Sergei

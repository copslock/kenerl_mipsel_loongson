Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2007 15:35:59 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:43491 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021943AbXFYOf5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2007 15:35:57 +0100
Received: from localhost (p3129-ipad201funabasi.chiba.ocn.ne.jp [222.146.66.129])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3E6E4B615; Mon, 25 Jun 2007 23:35:54 +0900 (JST)
Date:	Mon, 25 Jun 2007 23:36:37 +0900 (JST)
Message-Id: <20070625.233637.79301366.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] rbtx4938: Add generic GPIO support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070624205429.GB5814@linux-mips.org>
References: <20070622.232155.122616682.anemo@mba.ocn.ne.jp>
	<20070624205429.GB5814@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 24 Jun 2007 22:54:29 +0200, Ralf Baechle <ralf@linux-mips.org> wrote:
> > GPIO 0..15 are for TX4938 PIO pins, GPIO 16..18 are for FPGA-driven
> > chipselect signals for SPI devices.
> 
> Queued also.

Thanks.  And please queue this too.


Subject: [PATCH] rbtx4938: Add mmio barriers for GPIO.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index a835870..330ee43 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -1021,6 +1021,7 @@ static void rbtx4938_spi_gpio_set(unsigned gpio, int value)
 	else
 		val &= ~(1 << gpio);
 	*rbtx4938_spics_ptr = val;
+	mmiowb();
 	spin_unlock_irqrestore(&rbtx4938_spi_gpio_lock, flags);
 }
 
@@ -1053,6 +1054,7 @@ static void tx4938_gpio_set(unsigned gpio, int value)
 	unsigned long flags;
 	spin_lock_irqsave(&tx4938_gpio_lock, flags);
 	tx4938_gpio_set_raw(gpio, value);
+	mmiowb();
 	spin_unlock_irqrestore(&tx4938_gpio_lock, flags);
 }
 
@@ -1060,6 +1062,7 @@ static int tx4938_gpio_dir_in(unsigned gpio)
 {
 	spin_lock_irq(&tx4938_gpio_lock);
 	tx4938_pioptr->dir &= ~(1 << gpio);
+	mmiowb();
 	spin_unlock_irq(&tx4938_gpio_lock);
 	return 0;
 }
@@ -1069,6 +1072,7 @@ static int tx4938_gpio_dir_out(unsigned int gpio, int value)
 	spin_lock_irq(&tx4938_gpio_lock);
 	tx4938_gpio_set_raw(gpio, value);
 	tx4938_pioptr->dir |= 1 << gpio;
+	mmiowb();
 	spin_unlock_irq(&tx4938_gpio_lock);
 	return 0;
 }

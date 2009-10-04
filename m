Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Oct 2009 14:57:45 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:38985 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492538AbZJDMzo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Oct 2009 14:55:44 +0200
Received: by ewy10 with SMTP id 10so1846521ewy.33
        for <multiple recipients>; Sun, 04 Oct 2009 05:55:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ip6vfd6EawsZjNbmsz8EUGsC7QoTnABEK2lHi0JfwqI=;
        b=JWVmdyty7bniXRPhTJBo5JqYJheoF+orqbD1RZVVybvWGW/psHHrUfj+TYA9YvO5l1
         wmNainINBW8KCwjwK86yS6Cr0+PKSGDW3dw9VIU7+w1IiyaosUgyM4y449kI3ni1Xo1O
         Z5PNUpD2zd1ejqe8jukx+iTL1hCwxsq225DWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qjk37q9Zb0tWqNY3XjrXY0yS0fHbONX57ipFwLx0xBjJNQnFDoN3OQmZ42QeFdLdLo
         lXZZYEYoRe8LO7YGYfpt7Cyd6iZqMpP3q8GFuUGfUir+dt9G3xkv4dt0cgV3lhDtJUmf
         4YnbOsb5WBIP5ikdoHb9st0hlKekgsbfx9KXM=
Received: by 10.211.172.11 with SMTP id z11mr1992369ebo.93.1254660937388;
        Sun, 04 Oct 2009 05:55:37 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 28sm1555483eyg.4.2009.10.04.05.55.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 05:55:36 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>,
	Linux-PCMCIA <linux-pcmcia@lists.infradead.org>
Subject: [PATCH 4/6] PCMCIA: new socket driver for Au1000 demoboards.
Date:	Sun,  4 Oct 2009 14:55:27 +0200
Message-Id: <1254660929-15453-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254660929-15453-4-git-send-email-manuel.lauss@gmail.com>
References: <1254660929-15453-1-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-2-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-3-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-4-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

New PCMCIA socket driver for all Db/Pb1xxx boards (except Pb1000),
which replaces au1000_db1x00.c and (most of) au1000_pb1x00.c.
Notable improvements:
        - supports Db1000, DB/PB1100/1500/1550/1200.
        - support for carddetect and statuschange IRQs.
        - pcmcia socket mem/io/attr areas and irqs passed through
          platform resource information.
        - doesn't freeze system during card insertion/ejection like
          the one it replaces.
        - boardtype is automatically detected using BCSR ID register.

Run-tested on the DB1200.

Cc: Linux-PCMCIA <linux-pcmcia@lists.infradead.org>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
V2: split the patch in two, one (this) with the PCMCIA driver part,
    the other (following) adds the board-specific socket device
    registration.
    Fixed a thinko: use bcsr_mod() in socket_configure() function.

 arch/mips/alchemy/common/platform.c        |    6 -
 arch/mips/alchemy/common/setup.c           |    3 +-
 arch/mips/include/asm/mach-au1x00/au1000.h |   14 +
 drivers/pcmcia/Kconfig                     |   11 +
 drivers/pcmcia/Makefile                    |    9 +-
 drivers/pcmcia/au1000_db1x00.c             |  307 --------------
 drivers/pcmcia/au1000_generic.h            |   12 +-
 drivers/pcmcia/au1000_pb1x00.c             |  119 +------
 drivers/pcmcia/db1xxx_ss.c                 |  630 ++++++++++++++++++++++++++++
 9 files changed, 660 insertions(+), 451 deletions(-)
 delete mode 100644 drivers/pcmcia/au1000_db1x00.c
 create mode 100644 drivers/pcmcia/db1xxx_ss.c

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 117f99f..2b76a57 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -308,11 +308,6 @@ static struct platform_device au1200_mmc1_device = {
 #endif /* #ifndef CONFIG_MIPS_DB1200 */
 #endif /* #ifdef CONFIG_SOC_AU1200 */
 
-static struct platform_device au1x00_pcmcia_device = {
-	.name 		= "au1x00-pcmcia",
-	.id 		= 0,
-};
-
 /* All Alchemy demoboards with I2C have this #define in their headers */
 #ifdef SMBUS_PSC_BASE
 static struct resource pbdb_smbus_resources[] = {
@@ -334,7 +329,6 @@ static struct platform_device pbdb_smbus_device = {
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xx0_uart_device,
 	&au1xxx_usb_ohci_device,
-	&au1x00_pcmcia_device,
 #ifdef CONFIG_FB_AU1100
 	&au1100_lcd_device,
 #endif
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 6184baa..375984e 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -107,7 +107,8 @@ phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 	 * The pseudo address we use is 0xF400 0000. Any address over
 	 * 0xF400 0000 is a PCMCIA pseudo address.
 	 */
-	if ((phys_addr >= 0xF4000000) && (phys_addr < 0xFFFFFFFF))
+	if ((phys_addr >= PCMCIA_ATTR_PSEUDO_PHYS) &&
+	    (phys_addr < PCMCIA_PSEUDO_END))
 		return (phys_t)(phys_addr << 4);
 
 	/* default nop */
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 0507822..fceeca8 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1724,6 +1724,20 @@ enum soc_au1200_ints {
 
 #endif
 
+/*
+ * All Au1xx0 SOCs have a PCMCIA controller.
+ * We setup our 32-bit pseudo addresses to be equal to the
+ * 36-bit addr >> 4, to make it easier to check the address
+ * and fix it.
+ * The PCMCIA socket 0 physical attribute address is 0xF 4000 0000.
+ * The pseudo address we use is 0xF400 0000. Any address over
+ * 0xF400 0000 is a PCMCIA pseudo address.
+ */
+#define PCMCIA_IO_PSEUDO_PHYS	(PCMCIA_IO_PHYS_ADDR >> 4)
+#define PCMCIA_ATTR_PSEUDO_PHYS	(PCMCIA_ATTR_PHYS_ADDR >> 4)
+#define PCMCIA_MEM_PSEUDO_PHYS	(PCMCIA_MEM_PHYS_ADDR >> 4)
+#define PCMCIA_PSEUDO_END	(0xffffffff)
+
 #ifndef _LANGUAGE_ASSEMBLY
 typedef volatile struct {
 	/* 0x0000 */ u32 toytrim;
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 17f38a7..22f6814 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -192,6 +192,17 @@ config PCMCIA_AU1X00
 	tristate "Au1x00 pcmcia support"
 	depends on SOC_AU1X00 && PCMCIA
 
+config PCMCIA_ALCHEMY_DEVBOARD
+	tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
+	depends on SOC_AU1X00 && PCMCIA
+	select 64BIT_PHYS_ADDR
+	help
+	  Enable this driver of you want PCMCIA support on your Alchemy
+	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200 board.
+	  NOT suitable for the PB1000!
+
+	  This driver is also available as a module called db1xxx_ss.ko
+
 config PCMCIA_BCM63XX
 	tristate "bcm63xx pcmcia support"
 	depends on BCM63XX && PCMCIA
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index a03a38a..e58d162 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -34,20 +34,13 @@ obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
 obj-$(CONFIG_BFIN_CFPCMCIA)			+= bfin_cf_pcmcia.o
 obj-$(CONFIG_AT91_CF)				+= at91_cf.o
 obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
+obj-$(CONFIG_PCMCIA_ALCHEMY_DEVBOARD)		+= db1xxx_ss.o
 
 sa11xx_core-y					+= soc_common.o sa11xx_base.o
 pxa2xx_core-y					+= soc_common.o pxa2xx_base.o
 
 au1x00_ss-y					+= au1000_generic.o
 au1x00_ss-$(CONFIG_MIPS_PB1000)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1100)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1200)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_PB1500)			+= au1000_pb1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1000)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1100)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1200)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1500)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1550)			+= au1000_db1x00.o
 au1x00_ss-$(CONFIG_MIPS_XXS1500)		+= au1000_xxs1500.o
 
 sa1111_cs-y					+= sa1111_generic.o
diff --git a/drivers/pcmcia/au1000_db1x00.c b/drivers/pcmcia/au1000_db1x00.c
deleted file mode 100644
index 3fdd664..0000000
--- a/drivers/pcmcia/au1000_db1x00.c
+++ /dev/null
@@ -1,307 +0,0 @@
-/*
- *
- * Alchemy Semi Db1x00 boards specific pcmcia routines.
- *
- * Copyright 2002 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	ppopov@mvista.com or source@mvista.com
- *
- * Copyright 2004 Pete Popov, updated the driver to 2.6.
- * Followed the sa11xx API and largely copied many of the hardware
- * independent functions.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- *
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/init.h>
-
-#include <asm/irq.h>
-#include <asm/signal.h>
-#include <asm/mach-au1x00/au1000.h>
-
-#if defined(CONFIG_MIPS_DB1200)
-	#include <db1200.h>
-#elif defined(CONFIG_MIPS_PB1200)
-	#include <pb1200.h>
-#else
-	#include <asm/mach-db1x00/db1x00.h>
-#endif
-
-#include <asm/mach-db1x00/bcsr.h>
-#include "au1000_generic.h"
-
-#if 0
-#define debug(x,args...) printk(KERN_DEBUG "%s: " x, __func__ , ##args)
-#else
-#define debug(x,args...)
-#endif
-
-
-struct au1000_pcmcia_socket au1000_pcmcia_socket[PCMCIA_NUM_SOCKS];
-extern int au1x00_pcmcia_socket_probe(struct device *, struct pcmcia_low_level *, int, int);
-
-static int db1x00_pcmcia_hw_init(struct au1000_pcmcia_socket *skt)
-{
-#ifdef CONFIG_MIPS_DB1550
-	skt->irq = skt->nr ? AU1000_GPIO_5 : AU1000_GPIO_3;
-#elif defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
-	skt->irq = skt->nr ? BOARD_PC1_INT : BOARD_PC0_INT;
-#else
-	skt->irq = skt->nr ? AU1000_GPIO_5 : AU1000_GPIO_2;
-#endif
-	return 0;
-}
-
-static void db1x00_pcmcia_shutdown(struct au1000_pcmcia_socket *skt)
-{
-	bcsr_write(BCSR_PCMCIA, 0);	/* turn off power */
-	msleep(2);
-}
-
-static void
-db1x00_pcmcia_socket_state(struct au1000_pcmcia_socket *skt, struct pcmcia_state *state)
-{
-	u32 inserted;
-	unsigned char vs;
-
-	state->ready = 0;
-	state->vs_Xv = 0;
-	state->vs_3v = 0;
-	state->detect = 0;
-
-	switch (skt->nr) {
-	case 0:
-		vs = bcsr_read(BCSR_STATUS) & 0x3;
-#if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
-		inserted = BOARD_CARD_INSERTED(0);
-#else
-		inserted = !(bcsr_read(BCSR_STATUS) & (1 << 4));
-#endif
-		break;
-	case 1:
-		vs = (bcsr_read(BCSR_STATUS) & 0xC) >> 2;
-#if defined(CONFIG_MIPS_DB1200) || defined(CONFIG_MIPS_PB1200)
-		inserted = BOARD_CARD_INSERTED(1);
-#else
-		inserted = !(bcsr_read(BCSR_STATUS) & (1<<5));
-#endif
-		break;
-	default:/* should never happen */
-		return;
-	}
-
-	if (inserted)
-		debug("db1x00 socket %d: inserted %d, vs %d pcmcia %x\n",
-				skt->nr, inserted, vs, bcsr_read(BCSR_PCMCIA));
-
-	if (inserted) {
-		switch (vs) {
-			case 0:
-			case 2:
-				state->vs_3v=1;
-				break;
-			case 3: /* 5V */
-				break;
-			default:
-				/* return without setting 'detect' */
-				printk(KERN_ERR "db1x00 bad VS (%d)\n",
-						vs);
-		}
-		state->detect = 1;
-		state->ready = 1;
-	}
-	else {
-		/* if the card was previously inserted and then ejected,
-		 * we should turn off power to it
-		 */
-		if ((skt->nr == 0) &&
-		    (bcsr_read(BCSR_PCMCIA) & BCSR_PCMCIA_PC0RST)) {
-			bcsr_mod(BCSR_PCMCIA, BCSR_PCMCIA_PC0RST   |
-					      BCSR_PCMCIA_PC0DRVEN |
-					      BCSR_PCMCIA_PC0VPP   |
-					      BCSR_PCMCIA_PC0VCC, 0);
-			msleep(10);
-		}
-		else if ((skt->nr == 1) &&
-			 (bcsr_read(BCSR_PCMCIA) & BCSR_PCMCIA_PC1RST)) {
-			bcsr_mod(BCSR_PCMCIA, BCSR_PCMCIA_PC1RST   |
-					      BCSR_PCMCIA_PC1DRVEN |
-					      BCSR_PCMCIA_PC1VPP   |
-					      BCSR_PCMCIA_PC1VCC, 0);
-			msleep(10);
-		}
-	}
-
-	state->bvd1=1;
-	state->bvd2=1;
-	state->wrprot=0;
-}
-
-static int
-db1x00_pcmcia_configure_socket(struct au1000_pcmcia_socket *skt, struct socket_state_t *state)
-{
-	u16 pwr;
-	int sock = skt->nr;
-
-	debug("config_skt %d Vcc %dV Vpp %dV, reset %d\n",
-			sock, state->Vcc, state->Vpp,
-			state->flags & SS_RESET);
-
-	/* pcmcia reg was set to zero at init time. Be careful when
-	 * initializing a socket not to wipe out the settings of the
-	 * other socket.
-	 */
-	pwr = bcsr_read(BCSR_PCMCIA);
-	pwr &= ~(0xf << sock*8); /* clear voltage settings */
-
-	state->Vpp = 0;
-	switch(state->Vcc){
-		case 0:  /* Vcc 0 */
-			pwr |= SET_VCC_VPP(0,0,sock);
-			break;
-		case 50: /* Vcc 5V */
-			switch(state->Vpp) {
-				case 0:
-					pwr |= SET_VCC_VPP(2,0,sock);
-					break;
-				case 50:
-					pwr |= SET_VCC_VPP(2,1,sock);
-					break;
-				case 12:
-					pwr |= SET_VCC_VPP(2,2,sock);
-					break;
-				case 33:
-				default:
-					pwr |= SET_VCC_VPP(0,0,sock);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n",
-							__func__,
-							state->Vcc,
-							state->Vpp);
-					break;
-			}
-			break;
-		case 33: /* Vcc 3.3V */
-			switch(state->Vpp) {
-				case 0:
-					pwr |= SET_VCC_VPP(1,0,sock);
-					break;
-				case 12:
-					pwr |= SET_VCC_VPP(1,2,sock);
-					break;
-				case 33:
-					pwr |= SET_VCC_VPP(1,1,sock);
-					break;
-				case 50:
-				default:
-					pwr |= SET_VCC_VPP(0,0,sock);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n",
-							__func__,
-							state->Vcc,
-							state->Vpp);
-					break;
-			}
-			break;
-		default: /* what's this ? */
-			pwr |= SET_VCC_VPP(0,0,sock);
-			printk(KERN_ERR "%s: bad Vcc %d\n",
-					__func__, state->Vcc);
-			break;
-	}
-
-	bcsr_write(BCSR_PCMCIA, pwr);
-	msleep(300);
-
-	if (sock == 0) {
-		if (!(state->flags & SS_RESET)) {
-			pwr |= BCSR_PCMCIA_PC0DRVEN;
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(300);
-			pwr |= BCSR_PCMCIA_PC0RST;
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(100);
-		}
-		else {
-			pwr &= ~(BCSR_PCMCIA_PC0RST | BCSR_PCMCIA_PC0DRVEN);
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(100);
-		}
-	}
-	else {
-		if (!(state->flags & SS_RESET)) {
-			pwr |= BCSR_PCMCIA_PC1DRVEN;
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(300);
-			pwr |= BCSR_PCMCIA_PC1RST;
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(100);
-		}
-		else {
-			pwr &= ~(BCSR_PCMCIA_PC1RST | BCSR_PCMCIA_PC1DRVEN);
-			bcsr_write(BCSR_PCMCIA, pwr);
-			msleep(100);
-		}
-	}
-	return 0;
-}
-
-/*
- * Enable card status IRQs on (re-)initialisation.  This can
- * be called at initialisation, power management event, or
- * pcmcia event.
- */
-void db1x00_socket_init(struct au1000_pcmcia_socket *skt)
-{
-	/* nothing to do for now */
-}
-
-/*
- * Disable card status IRQs and PCMCIA bus on suspend.
- */
-void db1x00_socket_suspend(struct au1000_pcmcia_socket *skt)
-{
-	/* nothing to do for now */
-}
-
-struct pcmcia_low_level db1x00_pcmcia_ops = {
-	.owner			= THIS_MODULE,
-
-	.hw_init 		= db1x00_pcmcia_hw_init,
-	.hw_shutdown		= db1x00_pcmcia_shutdown,
-
-	.socket_state		= db1x00_pcmcia_socket_state,
-	.configure_socket	= db1x00_pcmcia_configure_socket,
-
-	.socket_init		= db1x00_socket_init,
-	.socket_suspend		= db1x00_socket_suspend
-};
-
-int au1x_board_init(struct device *dev)
-{
-	int ret = -ENODEV;
-	bcsr_write(BCSR_PCMCIA, 0); /* turn off power, if it's not already off */
-	msleep(2);
-	ret = au1x00_pcmcia_socket_probe(dev, &db1x00_pcmcia_ops, 0, 2);
-	return ret;
-}
diff --git a/drivers/pcmcia/au1000_generic.h b/drivers/pcmcia/au1000_generic.h
index 13a4fbc..aa743f6 100644
--- a/drivers/pcmcia/au1000_generic.h
+++ b/drivers/pcmcia/au1000_generic.h
@@ -44,22 +44,12 @@
 /* pcmcia socket 1 needs external glue logic so the memory map
  * differs from board to board.
  */
-#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1100) || \
-    defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1550) || \
-    defined(CONFIG_MIPS_PB1200)
+#if defined(CONFIG_MIPS_PB1000)
 #define AU1X_SOCK1_IO        0xF08000000ULL
 #define AU1X_SOCK1_PHYS_ATTR 0xF48000000ULL
 #define AU1X_SOCK1_PHYS_MEM  0xF88000000ULL
 #define AU1X_SOCK1_PSEUDO_PHYS_ATTR 0xF4800000
 #define AU1X_SOCK1_PSEUDO_PHYS_MEM  0xF8800000
-#elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || \
-      defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550) || \
-      defined(CONFIG_MIPS_DB1200)
-#define AU1X_SOCK1_IO        0xF04000000ULL
-#define AU1X_SOCK1_PHYS_ATTR 0xF44000000ULL
-#define AU1X_SOCK1_PHYS_MEM  0xF84000000ULL
-#define AU1X_SOCK1_PSEUDO_PHYS_ATTR 0xF4400000
-#define AU1X_SOCK1_PSEUDO_PHYS_MEM  0xF8400000
 #endif
 
 struct pcmcia_state {
diff --git a/drivers/pcmcia/au1000_pb1x00.c b/drivers/pcmcia/au1000_pb1x00.c
index b1984ed..5a979cb 100644
--- a/drivers/pcmcia/au1000_pb1x00.c
+++ b/drivers/pcmcia/au1000_pb1x00.c
@@ -1,6 +1,6 @@
 /*
  *
- * Alchemy Semi Pb1x00 boards specific pcmcia routines.
+ * Alchemy Semi Pb1000 boards specific pcmcia routines.
  *
  * Copyright 2002 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
@@ -46,20 +46,11 @@
 
 #define debug(fmt, arg...) do { } while (0)
 
-#ifdef CONFIG_MIPS_PB1000
 #include <asm/pb1000.h>
 #define PCMCIA_IRQ AU1000_GPIO_15
-#elif defined (CONFIG_MIPS_PB1500)
-#include <asm/pb1500.h>
-#define PCMCIA_IRQ AU1500_GPIO_203
-#elif defined (CONFIG_MIPS_PB1100)
-#include <asm/pb1100.h>
-#define PCMCIA_IRQ AU1000_GPIO_11
-#endif
 
 static int pb1x00_pcmcia_init(struct pcmcia_init *init)
 {
-#ifdef CONFIG_MIPS_PB1000
 	u16 pcr;
 	pcr = PCR_SLOT_0_RST | PCR_SLOT_1_RST;
 
@@ -74,21 +65,10 @@ static int pb1x00_pcmcia_init(struct pcmcia_init *init)
 	au_sync_delay(20);
 	  
 	return PCMCIA_NUM_SOCKS;
-
-#else /* fixme -- take care of the Pb1500 at some point */
-
-	u16 pcr;
-	pcr = au_readw(PCMCIA_BOARD_REG) & ~0xf; /* turn off power */
-	pcr &= ~(PC_DEASSERT_RST | PC_DRV_EN);
-	au_writew(pcr, PCMCIA_BOARD_REG);
-	au_sync_delay(500);
-	return PCMCIA_NUM_SOCKS;
-#endif
 }
 
 static int pb1x00_pcmcia_shutdown(void)
 {
-#ifdef CONFIG_MIPS_PB1000
 	u16 pcr;
 	pcr = PCR_SLOT_0_RST | PCR_SLOT_1_RST;
 	pcr |= SET_VCC_VPP(VCC_HIZ,VPP_HIZ,0);
@@ -96,14 +76,6 @@ static int pb1x00_pcmcia_shutdown(void)
 	au_writel(pcr, PB1000_PCR);
 	au_sync_delay(20);
 	return 0;
-#else
-	u16 pcr;
-	pcr = au_readw(PCMCIA_BOARD_REG) & ~0xf; /* turn off power */
-	pcr &= ~(PC_DEASSERT_RST | PC_DRV_EN);
-	au_writew(pcr, PCMCIA_BOARD_REG);
-	au_sync_delay(2);
-	return 0;
-#endif
 }
 
 static int 
@@ -112,21 +84,11 @@ pb1x00_pcmcia_socket_state(unsigned sock, struct pcmcia_state *state)
 	u32 inserted0, inserted1;
 	u16 vs0, vs1;
 
-#ifdef CONFIG_MIPS_PB1000
 	vs0 = vs1 = (u16)au_readl(PB1000_ACR1);
 	inserted0 = !(vs0 & (ACR1_SLOT_0_CD1 | ACR1_SLOT_0_CD2));
 	inserted1 = !(vs1 & (ACR1_SLOT_1_CD1 | ACR1_SLOT_1_CD2));
 	vs0 = (vs0 >> 4) & 0x3;
 	vs1 = (vs1 >> 12) & 0x3;
-#else
-	vs0 = (au_readw(BOARD_STATUS_REG) >> 4) & 0x3;
-#ifdef CONFIG_MIPS_PB1500
-	inserted0 = !((au_readl(GPIO2_PINSTATE) >> 1) & 0x1); /* gpio 201 */
-#else /* Pb1100 */
-	inserted0 = !((au_readl(SYS_PINSTATERD) >> 9) & 0x1); /* gpio 9 */
-#endif
-	inserted1 = 0;
-#endif
 
 	state->ready = 0;
 	state->vs_Xv = 0;
@@ -203,7 +165,6 @@ pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 
 	if(configure->sock > PCMCIA_MAX_SOCK) return -1;
 
-#ifdef CONFIG_MIPS_PB1000
 	pcr = au_readl(PB1000_PCR);
 
 	if (configure->sock == 0) {
@@ -323,84 +284,6 @@ pb1x00_pcmcia_configure_socket(const struct pcmcia_configure *configure)
 	au_writel(pcr, PB1000_PCR);
 	au_sync_delay(300);
 
-#else
-
-	pcr = au_readw(PCMCIA_BOARD_REG) & ~0xf;
-
-	debug("Vcc %dV Vpp %dV, pcr %x, reset %d\n", 
-			configure->vcc, configure->vpp, pcr, configure->reset);
-
-
-	switch(configure->vcc){
-		case 0:  /* Vcc 0 */
-			pcr |= SET_VCC_VPP(0,0);
-			break;
-		case 50: /* Vcc 5V */
-			switch(configure->vpp) {
-				case 0:
-					pcr |= SET_VCC_VPP(2,0);
-					break;
-				case 50:
-					pcr |= SET_VCC_VPP(2,1);
-					break;
-				case 12:
-					pcr |= SET_VCC_VPP(2,2);
-					break;
-				case 33:
-				default:
-					pcr |= SET_VCC_VPP(0,0);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
-							__func__,
-							configure->vcc, 
-							configure->vpp);
-					break;
-			}
-			break;
-		case 33: /* Vcc 3.3V */
-			switch(configure->vpp) {
-				case 0:
-					pcr |= SET_VCC_VPP(1,0);
-					break;
-				case 12:
-					pcr |= SET_VCC_VPP(1,2);
-					break;
-				case 33:
-					pcr |= SET_VCC_VPP(1,1);
-					break;
-				case 50:
-				default:
-					pcr |= SET_VCC_VPP(0,0);
-					printk("%s: bad Vcc/Vpp (%d:%d)\n", 
-							__func__,
-							configure->vcc, 
-							configure->vpp);
-					break;
-			}
-			break;
-		default: /* what's this ? */
-			pcr |= SET_VCC_VPP(0,0);
-			printk(KERN_ERR "%s: bad Vcc %d\n", 
-					__func__, configure->vcc);
-			break;
-	}
-
-	au_writew(pcr, PCMCIA_BOARD_REG);
-	au_sync_delay(300);
-
-	if (!configure->reset) {
-		pcr |= PC_DRV_EN;
-		au_writew(pcr, PCMCIA_BOARD_REG);
-		au_sync_delay(100);
-		pcr |= PC_DEASSERT_RST;
-		au_writew(pcr, PCMCIA_BOARD_REG);
-		au_sync_delay(100);
-	}
-	else {
-		pcr &= ~(PC_DEASSERT_RST | PC_DRV_EN);
-		au_writew(pcr, PCMCIA_BOARD_REG);
-		au_sync_delay(100);
-	}
-#endif
 	return 0;
 }
 
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
new file mode 100644
index 0000000..b35b72b
--- /dev/null
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -0,0 +1,630 @@
+/*
+ * PCMCIA socket code for the Alchemy Db1xxx/Pb1xxx boards.
+ *
+ * Copyright (c) 2009 Manuel Lauss <manuel.lauss@gmail.com>
+ *
+ */
+
+/* This is a fairly generic PCMCIA socket driver suitable for the
+ * following Alchemy Development boards:
+ *  Db1000, Db/Pb1500, Db/Pb1100, Db/Pb1550, Db/Pb1200.
+ *
+ * The Db1000 is used as a reference:  Per-socket card-, carddetect- and
+ *  statuschange IRQs connected to SoC GPIOs, control and status register
+ *  bits arranged in per-socket groups in an external PLD.  All boards
+ *  listed here use this layout, including bit positions and meanings.
+ *  Of course there are exceptions in later boards:
+ *
+ *	- Pb1100/Pb1500:  single socket only; voltage key bits VS are
+ *			  at STATUS[5:4] (instead of STATUS[1:0]).
+ *	- Au1200-based:	  additional card-eject irqs, irqs not gpios!
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
+
+#include <pcmcia/cs_types.h>
+#include <pcmcia/ss.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+#define MEM_MAP_SIZE	0x400000
+#define IO_MAP_SIZE	0x1000
+
+struct db1x_pcmcia_sock {
+	struct pcmcia_socket	socket;
+	int		nr;		/* socket number */
+	void		*virt_io;
+
+	/* the "pseudo" addresses of the PCMCIA space. */
+	unsigned long	phys_io;
+	unsigned long	phys_attr;
+	unsigned long	phys_mem;
+
+	/* previous flags for set_socket() */
+	unsigned int old_flags;
+
+	/* interrupt sources: linux irq numbers! */
+	int	insert_irq;	/* default carddetect irq */
+	int	stschg_irq;	/* card-status-change irq */
+	int	card_irq;	/* card irq */
+	int	eject_irq;	/* db1200/pb1200 have these */
+
+#define BOARD_TYPE_DEFAULT	0	/* most boards */
+#define BOARD_TYPE_DB1200	1	/* IRQs aren't gpios */
+#define BOARD_TYPE_PB1100	2	/* VS bits slightly different */
+	int	board_type;
+};
+
+#define to_db1x_socket(x) container_of(x, struct db1x_pcmcia_sock, socket)
+
+/* DB/PB1200: check CPLD SIGSTATUS register bit 10/12 */
+static int db1200_card_inserted(struct db1x_pcmcia_sock *sock)
+{
+	unsigned short sigstat;
+
+	sigstat = bcsr_read(BCSR_SIGSTAT);
+	return sigstat & 1 << (8 + 2 * sock->nr);
+}
+
+/* carddetect gpio: low-active */
+static int db1000_card_inserted(struct db1x_pcmcia_sock *sock)
+{
+	return !gpio_get_value(irq_to_gpio(sock->insert_irq));
+}
+
+static int db1x_card_inserted(struct db1x_pcmcia_sock *sock)
+{
+	switch (sock->board_type) {
+	case BOARD_TYPE_DB1200:
+		return db1200_card_inserted(sock);
+	default:
+		return db1000_card_inserted(sock);
+	}
+}
+
+/* STSCHG tends to bounce heavily when cards are inserted/ejected.
+ * To avoid this, the interrupt is normally disabled and only enabled
+ * after reset to a card has been de-asserted.
+ */
+static inline void set_stschg(struct db1x_pcmcia_sock *sock, int en)
+{
+	if (sock->stschg_irq != -1) {
+		if (en)
+			enable_irq(sock->stschg_irq);
+		else
+			disable_irq(sock->stschg_irq);
+	}
+}
+
+static irqreturn_t db1000_pcmcia_cdirq(int irq, void *data)
+{
+	struct db1x_pcmcia_sock *sock = data;
+
+	pcmcia_parse_events(&sock->socket, SS_DETECT);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t db1000_pcmcia_stschgirq(int irq, void *data)
+{
+	struct db1x_pcmcia_sock *sock = data;
+
+	pcmcia_parse_events(&sock->socket, SS_STSCHG);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t db1200_pcmcia_cdirq(int irq, void *data)
+{
+	struct db1x_pcmcia_sock *sock = data;
+
+	/* Db/Pb1200 have separate per-socket insertion and ejection
+	 * interrupts which stay asserted as long as the card is
+	 * inserted/missing.  The one which caused us to be called
+	 * needs to be disabled and the other one enabled.
+	 */
+	if (irq == sock->insert_irq) {
+		disable_irq_nosync(sock->insert_irq);
+		enable_irq(sock->eject_irq);
+	} else {
+		disable_irq_nosync(sock->eject_irq);
+		enable_irq(sock->insert_irq);
+	}
+
+	pcmcia_parse_events(&sock->socket, SS_DETECT);
+
+	return IRQ_HANDLED;
+}
+
+static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
+{
+	int ret;
+	unsigned long flags;
+
+	if (sock->stschg_irq != -1) {
+		ret = request_irq(sock->stschg_irq, db1000_pcmcia_stschgirq,
+				  0, "pcmcia_stschg", sock);
+		if (ret)
+			return ret;
+	}
+
+	/* Db/Pb1200 have separate per-socket insertion and ejection
+	 * interrupts, which should show edge behaviour but don't.
+	 * So interrupts are disabled until both insertion and
+	 * ejection handler have been registered and the currently
+	 * active one disabled.
+	 */
+	if (sock->board_type == BOARD_TYPE_DB1200) {
+		local_irq_save(flags);
+
+		ret = request_irq(sock->insert_irq, db1200_pcmcia_cdirq,
+				  IRQF_DISABLED, "pcmcia_insert", sock);
+		if (ret)
+			goto out1;
+
+		ret = request_irq(sock->eject_irq, db1200_pcmcia_cdirq,
+				  IRQF_DISABLED, "pcmcia_eject", sock);
+		if (ret) {
+			free_irq(sock->insert_irq, sock);
+			local_irq_restore(flags);
+			goto out1;
+		}
+
+		/* disable the currently active one */
+		if (db1200_card_inserted(sock))
+			disable_irq_nosync(sock->insert_irq);
+		else
+			disable_irq_nosync(sock->eject_irq);
+
+		local_irq_restore(flags);
+	} else {
+		/* all other (older) Db1x00 boards use a GPIO to show
+		 * card detection status:  use both-edge triggers.
+		 */
+		set_irq_type(sock->insert_irq, IRQ_TYPE_EDGE_BOTH);
+		ret = request_irq(sock->insert_irq, db1000_pcmcia_cdirq,
+				  0, "pcmcia_carddetect", sock);
+
+		if (ret)
+			goto out1;
+	}
+
+	return 0;	/* all done */
+
+out1:
+	if (sock->stschg_irq != -1)
+		free_irq(sock->stschg_irq, sock);
+
+	return ret;
+}
+
+static void db1x_pcmcia_free_irqs(struct db1x_pcmcia_sock *sock)
+{
+	if (sock->stschg_irq != -1)
+		free_irq(sock->stschg_irq, sock);
+
+	free_irq(sock->insert_irq, sock);
+	if (sock->eject_irq != -1)
+		free_irq(sock->eject_irq, sock);
+}
+
+/*
+ * configure a PCMCIA socket on the Db1x00 series of boards (and
+ * compatibles).
+ *
+ * 2 external registers are involved:
+ *   pcmcia_status (offset 0x04): bits [0:1/2:3]: read card voltage id
+ *   pcmcia_control(offset 0x10):
+ *	bits[0:1] set vcc for card
+ *	bits[2:3] set vpp for card
+ *	bit 4:	enable data buffers
+ *	bit 7:	reset# for card
+ *	add 8 for second socket.
+ */
+static int db1x_pcmcia_configure(struct pcmcia_socket *skt,
+				 struct socket_state_t *state)
+{
+	struct db1x_pcmcia_sock *sock = to_db1x_socket(skt);
+	unsigned short cr_clr, cr_set;
+	unsigned int changed;
+	int v, p, ret;
+
+	/* card voltage setup */
+	cr_clr = (0xf << (sock->nr * 8)); /* clear voltage settings */
+	cr_set = 0;
+	v = p = ret = 0;
+
+	switch (state->Vcc) {
+	case 50:
+		++v;
+	case 33:
+		++v;
+	case 0:
+		break;
+	default:
+		printk(KERN_INFO "pcmcia%d unsupported Vcc %d\n",
+			sock->nr, state->Vcc);
+	}
+
+	switch (state->Vpp) {
+	case 12:
+		++p;
+	case 33:
+	case 50:
+		++p;
+	case 0:
+		break;
+	default:
+		printk(KERN_INFO "pcmcia%d unsupported Vpp %d\n",
+			sock->nr, state->Vpp);
+	}
+
+	/* sanity check: Vpp must be 0, 12, or Vcc */
+	if (((state->Vcc == 33) && (state->Vpp == 50)) ||
+	    ((state->Vcc == 50) && (state->Vpp == 33))) {
+		printk(KERN_INFO "pcmcia%d bad Vcc/Vpp combo (%d %d)\n",
+			sock->nr, state->Vcc, state->Vpp);
+		v = p = 0;
+		ret = -EINVAL;
+	}
+
+	/* create new voltage code */
+	cr_set |= ((v << 2) | p) << (sock->nr * 8);
+
+	changed = state->flags ^ sock->old_flags;
+
+	if (changed & SS_RESET) {
+		if (state->flags & SS_RESET) {
+			set_stschg(sock, 0);
+			/* assert reset, disable io buffers */
+			cr_clr |= (1 << (7 + (sock->nr * 8)));
+			cr_clr |= (1 << (4 + (sock->nr * 8)));
+		} else {
+			/* de-assert reset, enable io buffers */
+			cr_set |= 1 << (7 + (sock->nr * 8));
+			cr_set |= 1 << (4 + (sock->nr * 8));
+		}
+	}
+
+	/* update PCMCIA configuration */
+	bcsr_mod(BCSR_PCMCIA, cr_clr, cr_set);
+
+	sock->old_flags = state->flags;
+
+	/* reset was taken away: give card time to initialize properly */
+	if ((changed & SS_RESET) && !(state->flags & SS_RESET)) {
+		msleep(500);
+		set_stschg(sock, 1);
+	}
+
+	return ret;
+}
+
+/* VCC bits at [3:2]/[11:10] */
+#define GET_VCC(cr, socknr)		\
+	((((cr) >> 2) >> ((socknr) * 8)) & 3)
+
+/* VS bits at [0:1]/[3:2] */
+#define GET_VS(sr, socknr)		\
+	(((sr) >> (2 * (socknr))) & 3)
+
+/* reset bits at [7]/[15] */
+#define GET_RESET(cr, socknr)		\
+	((cr) & (1 << (7 + (8 * (socknr)))))
+
+static int db1x_pcmcia_get_status(struct pcmcia_socket *skt,
+				  unsigned int *value)
+{
+	struct db1x_pcmcia_sock *sock = to_db1x_socket(skt);
+	unsigned short cr, sr;
+	unsigned int status;
+
+	status = db1x_card_inserted(sock) ? SS_DETECT : 0;
+
+	cr = bcsr_read(BCSR_PCMCIA);
+	sr = bcsr_read(BCSR_STATUS);
+
+	/* PB1100/PB1500: voltage key bits are at [5:4] */
+	if (sock->board_type == BOARD_TYPE_PB1100)
+		sr >>= 4;
+
+	/* determine card type */
+	switch (GET_VS(sr, sock->nr)) {
+	case 0:
+	case 2:
+		status |= SS_3VCARD;	/* 3V card */
+	case 3:
+		break;			/* 5V card: set nothing */
+	default:
+		status |= SS_XVCARD;	/* treated as unsupported in core */
+	}
+
+	/* if Vcc is not zero, we have applied power to a card */
+	status |= GET_VCC(cr, sock->nr) ? SS_POWERON : 0;
+
+	/* reset de-asserted? then we're ready */
+	status |= (GET_RESET(cr, sock->nr)) ? SS_READY : SS_RESET;
+
+	*value = status;
+
+	return 0;
+}
+
+static int db1x_pcmcia_sock_init(struct pcmcia_socket *skt)
+{
+	return 0;
+}
+
+static int db1x_pcmcia_sock_suspend(struct pcmcia_socket *skt)
+{
+	return 0;
+}
+
+static int au1x00_pcmcia_set_io_map(struct pcmcia_socket *skt,
+				    struct pccard_io_map *map)
+{
+	struct db1x_pcmcia_sock *sock = to_db1x_socket(skt);
+
+	map->start = (u32)sock->virt_io;
+	map->stop = map->start + IO_MAP_SIZE;
+
+	return 0;
+}
+
+static int au1x00_pcmcia_set_mem_map(struct pcmcia_socket *skt,
+				     struct pccard_mem_map *map)
+{
+	struct db1x_pcmcia_sock *sock = to_db1x_socket(skt);
+
+	if (map->flags & MAP_ATTRIB)
+		map->static_start = sock->phys_attr + map->card_start;
+	else
+		map->static_start = sock->phys_mem + map->card_start;
+
+	return 0;
+}
+
+static struct pccard_operations db1x_pcmcia_operations = {
+	.init			= db1x_pcmcia_sock_init,
+	.suspend		= db1x_pcmcia_sock_suspend,
+	.get_status		= db1x_pcmcia_get_status,
+	.set_socket		= db1x_pcmcia_configure,
+	.set_io_map		= au1x00_pcmcia_set_io_map,
+	.set_mem_map		= au1x00_pcmcia_set_mem_map,
+};
+
+static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
+{
+	struct db1x_pcmcia_sock *sock;
+	struct resource *r;
+	phys_t physio;
+	int ret, bid;
+
+	sock = kzalloc(sizeof(struct db1x_pcmcia_sock), GFP_KERNEL);
+	if (!sock)
+		return -ENOMEM;
+
+	sock->nr = pdev->id;
+
+	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
+	switch (bid) {
+	case BCSR_WHOAMI_PB1500:
+	case BCSR_WHOAMI_PB1500R2:
+	case BCSR_WHOAMI_PB1100:
+		sock->board_type = BOARD_TYPE_PB1100;
+		break;
+	case BCSR_WHOAMI_DB1000 ... BCSR_WHOAMI_PB1550_SDR:
+		sock->board_type = BOARD_TYPE_DEFAULT;
+		break;
+	case BCSR_WHOAMI_PB1200 ... BCSR_WHOAMI_DB1200:
+		sock->board_type = BOARD_TYPE_DB1200;
+		break;
+	default:
+		printk(KERN_INFO "db1xxx-ss: unknown board %d!\n", bid);
+		ret = -ENODEV;
+		goto out0;
+	};
+
+	/*
+	 * gather resources necessary and optional nice-to-haves to
+	 * operate a socket:
+	 * This includes IRQs for Carddetection/ejection, the card
+	 *  itself and optional status change detection.
+	 * Also, the memory areas covered by a socket.  For these
+	 *  we require the 32bit "pseudo" addresses (see the au1000.h
+	 *  header for more information).
+	 */
+
+	/* card: irq assigned to the card itself. */
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "card");
+	sock->card_irq = r ? r->start : 0;
+
+	/* insert: irq which triggers on card insertion/ejection */
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "insert");
+	sock->insert_irq = r ? r->start : -1;
+
+	/* stschg: irq which trigger on card status change (optional) */
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "stschg");
+	sock->stschg_irq = r ? r->start : -1;
+
+	/* eject: irq which triggers on ejection (DB1200/PB1200 only) */
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "eject");
+	sock->eject_irq = r ? r->start : -1;
+
+	ret = -ENODEV;
+
+	/*
+	 * pseudo-attr:  The 32bit address of the PCMCIA attribute space
+	 * for this socket (usually the 36bit address shifted 4 to the
+	 * right).
+	 */
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-attr");
+	if (!r) {
+		printk(KERN_ERR "pcmcia%d has no 'pseudo-attr' resource!\n",
+			sock->nr);
+		goto out0;
+	}
+	sock->phys_attr = r->start;
+
+	/*
+	 * pseudo-mem:  The 32bit address of the PCMCIA memory space for
+	 * this socket (usually the 36bit address shifted 4 to the right)
+	 */
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-mem");
+	if (!r) {
+		printk(KERN_ERR "pcmcia%d has no 'pseudo-mem' resource!\n",
+			sock->nr);
+		goto out0;
+	}
+	sock->phys_mem = r->start;
+
+	/*
+	 * pseudo-io:  The 32bit address of the PCMCIA IO space for this
+	 * socket (usually the 36bit address shifted 4 to the right).
+	 */
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pseudo-io");
+	if (!r) {
+		printk(KERN_ERR "pcmcia%d has no 'pseudo-io' resource!\n",
+			sock->nr);
+		goto out0;
+	}
+	sock->phys_io = r->start;
+
+
+	/* IO: we must remap the full 36bit address (for reference see
+	 * alchemy/common/setup.c::__fixup_bigphys_addr())
+	 */
+	physio = ((phys_t)sock->phys_io) << 4;
+
+	/*
+	 * PCMCIA client drivers use the inb/outb macros to access
+	 * the IO registers.  Since mips_io_port_base is added
+	 * to the access address of the mips implementation of
+	 * inb/outb, we need to subtract it here because we want
+	 * to access the I/O or MEM address directly, without
+	 * going through this "mips_io_port_base" mechanism.
+	 */
+	sock->virt_io = (void *)(ioremap(physio, IO_MAP_SIZE) -
+				 mips_io_port_base);
+
+	if (!sock->virt_io) {
+		printk(KERN_ERR "pcmcia%d: cannot remap IO area\n",
+			sock->nr);
+		ret = -ENOMEM;
+		goto out0;
+	}
+
+	sock->socket.ops	= &db1x_pcmcia_operations;
+	sock->socket.owner	= THIS_MODULE;
+	sock->socket.pci_irq	= sock->card_irq;
+	sock->socket.features	= SS_CAP_STATIC_MAP | SS_CAP_PCCARD;
+	sock->socket.map_size	= MEM_MAP_SIZE;
+	sock->socket.io_offset	= (unsigned long)sock->virt_io;
+	sock->socket.dev.parent	= &pdev->dev;
+	sock->socket.resource_ops = &pccard_static_ops;
+
+	platform_set_drvdata(pdev, sock);
+
+	ret = db1x_pcmcia_setup_irqs(sock);
+	if (ret) {
+		printk(KERN_ERR "pcmcia%d cannot setup interrupts\n",
+			sock->nr);
+		goto out1;
+	}
+
+	set_stschg(sock, 0);
+
+	ret = pcmcia_register_socket(&sock->socket);
+	if (ret) {
+		printk(KERN_ERR "pcmcia%d failed to register\n", sock->nr);
+		goto out2;
+	}
+
+	printk(KERN_INFO "Alchemy Db/Pb1xxx pcmcia%d @ io/attr/mem %08lx"
+		"(%p) %08lx %08lx  card/insert/stschg/eject irqs @ %d "
+		"%d %d %d\n", sock->nr, sock->phys_io, sock->virt_io,
+		sock->phys_attr, sock->phys_mem, sock->card_irq,
+		sock->insert_irq, sock->stschg_irq, sock->eject_irq);
+
+	return 0;
+
+out2:
+	db1x_pcmcia_free_irqs(sock);
+out1:
+	iounmap((void *)(sock->virt_io + (u32)mips_io_port_base));
+out0:
+	kfree(sock);
+	return ret;
+}
+
+static int __devexit db1x_pcmcia_socket_remove(struct platform_device *pdev)
+{
+	struct db1x_pcmcia_sock *sock = platform_get_drvdata(pdev);
+
+	db1x_pcmcia_free_irqs(sock);
+	pcmcia_unregister_socket(&sock->socket);
+	iounmap((void *)(sock->virt_io + (u32)mips_io_port_base));
+	kfree(sock);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int db1x_pcmcia_suspend(struct device *dev)
+{
+	return pcmcia_socket_dev_suspend(dev);
+}
+
+static int db1x_pcmcia_resume(struct device *dev)
+{
+	return pcmcia_socket_dev_resume(dev);
+}
+
+static struct dev_pm_ops db1x_pcmcia_pmops = {
+	.resume		= db1x_pcmcia_resume,
+	.suspend	= db1x_pcmcia_suspend,
+	.thaw		= db1x_pcmcia_resume,
+	.freeze		= db1x_pcmcia_suspend,
+};
+
+#define DB1XXX_SS_PMOPS &db1x_pcmcia_pmops
+
+#else
+
+#define DB1XXX_SS_PMOPS NULL
+
+#endif
+
+static struct platform_driver db1x_pcmcia_socket_driver = {
+	.driver	= {
+		.name	= "db1xxx_pcmcia",
+		.owner	= THIS_MODULE,
+		.pm	= DB1XXX_SS_PMOPS
+	},
+	.probe		= db1x_pcmcia_socket_probe,
+	.remove		= __devexit_p(db1x_pcmcia_socket_remove),
+};
+
+int __init db1x_pcmcia_socket_load(void)
+{
+	return platform_driver_register(&db1x_pcmcia_socket_driver);
+}
+
+void  __exit db1x_pcmcia_socket_unload(void)
+{
+	platform_driver_unregister(&db1x_pcmcia_socket_driver);
+}
+
+module_init(db1x_pcmcia_socket_load);
+module_exit(db1x_pcmcia_socket_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCMCIA Socket Services for Alchemy Db/Pb1x00 boards");
+MODULE_AUTHOR("Manuel Lauss");
-- 
1.6.5.rc2

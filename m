Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 18:21:48 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:16860 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022888AbZDIRVl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 18:21:41 +0100
Received: (qmail 2204 invoked from network); 9 Apr 2009 19:21:39 +0200
Received: from flagship.roarinelk.net (HELO localhost.localdomain) (192.168.0.197)
  by 192.168.0.1 with SMTP; 9 Apr 2009 19:21:39 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH v2 2/2] Alchemy: remove unused au1000_gpio.h header
Date:	Thu,  9 Apr 2009 19:21:39 +0200
Message-Id: <1239297699-17407-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1239297699-17407-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1239297699-17407-1-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/include/asm/mach-au1x00/au1000_gpio.h |   56 -----------------------
 1 files changed, 0 insertions(+), 56 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-au1x00/au1000_gpio.h

diff --git a/arch/mips/include/asm/mach-au1x00/au1000_gpio.h b/arch/mips/include/asm/mach-au1x00/au1000_gpio.h
deleted file mode 100644
index d8c96fd..0000000
--- a/arch/mips/include/asm/mach-au1x00/au1000_gpio.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * FILE NAME au1000_gpio.h
- *
- * BRIEF MODULE DESCRIPTION
- *	API to Alchemy Au1xx0 GPIO device.
- *
- *  Author: MontaVista Software, Inc.  <source@mvista.com>
- *          Steve Longerbeam
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __AU1000_GPIO_H
-#define __AU1000_GPIO_H
-
-#include <linux/ioctl.h>
-
-#define AU1000GPIO_IOC_MAGIC 'A'
-
-#define AU1000GPIO_IN		_IOR(AU1000GPIO_IOC_MAGIC, 0, int)
-#define AU1000GPIO_SET		_IOW(AU1000GPIO_IOC_MAGIC, 1, int)
-#define AU1000GPIO_CLEAR	_IOW(AU1000GPIO_IOC_MAGIC, 2, int)
-#define AU1000GPIO_OUT		_IOW(AU1000GPIO_IOC_MAGIC, 3, int)
-#define AU1000GPIO_TRISTATE	_IOW(AU1000GPIO_IOC_MAGIC, 4, int)
-#define AU1000GPIO_AVAIL_MASK	_IOR(AU1000GPIO_IOC_MAGIC, 5, int)
-
-#ifdef __KERNEL__
-extern u32 get_au1000_avail_gpio_mask(void);
-extern int au1000gpio_tristate(u32 data);
-extern int au1000gpio_in(u32 *data);
-extern int au1000gpio_set(u32 data);
-extern int au1000gpio_clear(u32 data);
-extern int au1000gpio_out(u32 data);
-#endif
-
-#endif
-- 
1.6.2

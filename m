Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 19:57:49 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:51369 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S20031516AbZDTS5W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 19:57:22 +0100
Received: by mail-fx0-f175.google.com with SMTP id 23so2289643fxm.0
        for <linux-mips@linux-mips.org>; Mon, 20 Apr 2009 11:57:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=jENvuE/mbvxNXjYSe59NN/JCJmXl3b7mVXs0KkxFBog=;
        b=O4kOG+1Z8Vp5xOMO50Urv+H52UUzRcNGaHVYamIO4pwPeipVnBEqSqxmuCfJykdeJM
         QLJP+SEObZFiRrLcRXK5agxmIRB8z+kWIuLKG05pv6sNG3UjHsbMpBDOxSs5DUz/jvUN
         tr0N2vr9Kbmc5Iq82hwTM8EzYpe+mRJ7tyv84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=d5LlNjpxYHAkwHBfzkvYbSrnxdmO/tUABJ7/r1wwhuiyzLHliYRvE3uV5NcmKUKML+
         qgemBYsJgetk7SC3ZLJDJILvFl+nykeL4U4h0zeGpjMuCtzl758nEFJkh5ElV7pwELMw
         X/RlbVRJKhHTI/d8uP1hqD5crbNST9tEPOZRA=
Received: by 10.103.238.4 with SMTP id p4mr3282634mur.68.1240253841392;
        Mon, 20 Apr 2009 11:57:21 -0700 (PDT)
Received: from localhost.localdomain (p5496DEF2.dip.t-dialin.net [84.150.222.242])
        by mx.google.com with ESMTPS id n7sm14669850mue.6.2009.04.20.11.57.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 11:57:20 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH v5 2/2] Alchemy: remove unused au1000_gpio.h header
Date:	Mon, 20 Apr 2009 20:56:47 +0200
Message-Id: <1240253807-29778-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240253807-29778-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1240253807-29778-1-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22389
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
1.6.2.2

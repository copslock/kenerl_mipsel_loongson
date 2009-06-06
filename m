Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 13:10:17 +0100 (WEST)
Received: from fg-out-1718.google.com ([72.14.220.159]:61779 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023305AbZFFMKL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2009 13:10:11 +0100
Received: by fg-out-1718.google.com with SMTP id 22so762356fge.9
        for <multiple recipients>; Sat, 06 Jun 2009 05:10:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hzId0WFjoSSdphtG/19V9nMKCT9iiJpdG1reZzPJ094=;
        b=hJDhMbwtCq5bpR0oCmmxCQQOFtJ+/o1sG9wh1jK2EIShIpnkiiGLe6a5IA70VsS+nU
         PDVdTEk3o6dOmSNKHqFGGxNP2Gqc/som+r65P5SAJrsRJ6p7I7iMeG3yptclnLf79t7a
         9RFX3Ag8Tl2nK0CVWZNTuZYlUOrWm5KmQsG4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=baxY3Eol5BRYDDGs93UqvEBxhB1QAgaj2U6W8dN/kC3+zUMd2UyIiDpUx3+muPunjG
         VaRg3EPxNB66avZWpHZnmpgMyV5widBiSd+dMiC7EiDK409H7Mj6v2NKJ+0n8uofAVqg
         IzmipytdwAisO3IL1ZlC9s8J7UPjyIPdfBEAM=
Received: by 10.86.74.1 with SMTP id w1mr4904971fga.53.1244290210155;
        Sat, 06 Jun 2009 05:10:10 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id e11sm4489485fga.11.2009.06.06.05.10.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 05:10:09 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/5] Alchemy: remove unused au1000_gpio.h header
Date:	Sat,  6 Jun 2009 14:09:54 +0200
Message-Id: <1244290198-27162-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244290198-27162-1-git-send-email-manuel.lauss@gmail.com>
References: <1244290198-27162-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
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
1.6.3.1

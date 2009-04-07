Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2009 18:42:15 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:61116 "EHLO
	mail-bw0-f177.google.com") by ftp.linux-mips.org with ESMTP
	id S20030672AbZDGRlo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Apr 2009 18:41:44 +0100
Received: by bwz25 with SMTP id 25so2665448bwz.0
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2009 10:41:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=3WidAtP8fKuMhj8dR+hNtmQnvlqpVmF1PHK2EWZxSM0=;
        b=hqJNMlqN5j9tbCl3mJQxs94cgwkqAoJFHDpQemXZWJ8dUVsfyyPUprIYi0BKLtG5Kt
         FJ1bg22GOET7rYLUwTnx+/qUFhntF7iEg1NvSHRJNLD0uponnZFH50u6rZ8AUhr4eXSP
         TEq5/BvTHbsQs94HTJbVgL4ub9ER++k5GIUHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=kt1n+3xi/74NLO9mBLJ5UMn4mGBmJKhpa48y4/oqvGhlco/zOly8tWjhEU5p45JIaH
         G8rl6/9q6cUg7PsxR9rh8iUhQ2zvkTvPieFcD89xFXzZSc3cRBCt1fQKrnZJH80i46dM
         c5P8641+KYTX1xVtLs3W7DcBRzdj6KUM9OC9U=
Received: by 10.204.121.131 with SMTP id h3mr317300bkr.172.1239126098607;
        Tue, 07 Apr 2009 10:41:38 -0700 (PDT)
Received: from localhost.localdomain (p5496DCB6.dip.t-dialin.net [84.150.220.182])
        by mx.google.com with ESMTPS id h2sm2816582fkh.9.2009.04.07.10.41.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 10:41:38 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 2/2] Alchemy: remove unused au1000_gpio.h header
Date:	Tue,  7 Apr 2009 19:41:34 +0200
Message-Id: <1239126094-11385-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1239126094-11385-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1239126094-11385-1-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22273
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

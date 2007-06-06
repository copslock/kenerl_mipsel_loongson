Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 19:33:18 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:49337 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027103AbXFFSdP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 19:33:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l56ISGD0007770;
	Wed, 6 Jun 2007 19:28:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l56ISEq6007769;
	Wed, 6 Jun 2007 19:28:14 +0100
Date:	Wed, 6 Jun 2007 19:28:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"tiansm@lemote.com" <tiansm@lemote.com>, linux-mips@linux-mips.org,
	Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 15/15] work around for more than 256MB memory support
Message-ID: <20070606182814.GD30017@linux-mips.org>
References: <11811127722019-git-send-email-tiansm@lemote.com> <11811127744038-git-send-email-tiansm@lemote.com> <cda58cb80706060101n64dd973fxdd282379595c0b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80706060101n64dd973fxdd282379595c0b1@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 06, 2007 at 10:01:29AM +0200, Franck Bui-Huu wrote:

> >diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> >index cc9a9d0..a19b46a 100644
> >--- a/drivers/char/mem.c
> >+++ b/drivers/char/mem.c
> >@@ -82,8 +82,12 @@ static inline int uncached_access(struct file *file, 
> >unsigned long addr)
> >         */
> >        if (file->f_flags & O_SYNC)
> >                return 1;
> >+#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
> >+       return (addr >= __pa(high_memory)) || ((addr >=0x10000000) && 
> >(addr < 0x20000000));
> >+#else
> >        return addr >= __pa(high_memory);
> > #endif
> >+#endif
> > }
> 
> That would be nice to have a nice log to justify such a hack....

Unfortunately mem.c is soaked with #ifdef stuff.  So I hope I can justify
one more for another architecture but that'll be it.  So I've put
below patch into the queue tree.  It will allow the Fulong code to
override the function as needed.  I also got this in the queue tree.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/mm/cache.c |   10 ++++++++++
 drivers/char/mem.c   |    7 +++++++
 2 files changed, 17 insertions(+)

Index: linux-queue/arch/mips/mm/cache.c
===================================================================
--- linux-queue.orig/arch/mips/mm/cache.c
+++ linux-queue/arch/mips/mm/cache.c
@@ -6,6 +6,8 @@
  * Copyright (C) 1994 - 2003, 07 by Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2007 MIPS Technologies, Inc.
  */
+#include <linux/fs.h>
+#include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -164,3 +166,11 @@ void __init cpu_cache_init(void)
 
 	panic(cache_panic);
 }
+
+int __weak __uncached_access(struct file *file, unsigned long addr)
+{
+	if (file->f_flags & O_SYNC)
+		return 1;
+
+	return addr >= __pa(high_memory);
+}
Index: linux-queue/drivers/char/mem.c
===================================================================
--- linux-queue.orig/drivers/char/mem.c
+++ linux-queue/drivers/char/mem.c
@@ -75,6 +75,13 @@ static inline int uncached_access(struct
 	 * On ia64, we ignore O_SYNC because we cannot tolerate memory attribute aliases.
 	 */
 	return !(efi_mem_attributes(addr) & EFI_MEMORY_WB);
+#elif defined(CONFIG_MIPS)
+	{
+		extern int __uncached_access(struct file *file,
+		                             unsigned long addr);
+
+		return __uncached_access(file, addr);
+	}
 #else
 	/*
 	 * Accessing memory above the top the kernel knows about or through a file pointer

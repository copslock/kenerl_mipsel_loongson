Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 06:31:19 +0000 (GMT)
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:29942 "EHLO
	fed1rmmtao02.cox.net") by ftp.linux-mips.org with ESMTP
	id S8133464AbWAaGaq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 06:30:46 +0000
Received: from liberty.homelinux.org ([70.190.160.125])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131063326.RZJA17006.fed1rmmtao02.cox.net@liberty.homelinux.org>;
          Tue, 31 Jan 2006 01:33:26 -0500
Received: from liberty.homelinux.org (mmporter@localhost [127.0.0.1])
	by liberty.homelinux.org (8.13.5/8.13.5/Debian-3) with ESMTP id k0V6ZbRG007490;
	Mon, 30 Jan 2006 23:35:37 -0700
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.13.5/8.13.5/Submit) id k0V6Za1T007488;
	Mon, 30 Jan 2006 23:35:36 -0700
Date:	Mon, 30 Jan 2006 23:35:36 -0700
From:	Matt Porter <mporter@kernel.crashing.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix vgacon oops on 64-bit
Message-ID: <20060130233536.F4971@cox.net>
References: <20060130083321.B3098@cox.net> <20060130181754.GA29634@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060130181754.GA29634@linux-mips.org>; from ralf@linux-mips.org on Mon, Jan 30, 2006 at 06:17:54PM +0000
Return-Path: <mmporter@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mporter@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 30, 2006 at 06:17:54PM +0000, Ralf Baechle wrote:
> On Mon, Jan 30, 2006 at 08:33:21AM -0700, Matt Porter wrote:
> > +#ifdef CONFIG_64BIT
> > +#define VGA_MAP_MEM(x)	(0xffffffffb0000000UL + (unsigned long)(x))
> > +#else
> >  #define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
> > +#endif
> 
> Looks like driving out the devil with beelzebub.  The 0xb0000000 address
> is totally platform specific and nobody ever noticed ...

Ok, added a platform dependent hook that the setup code can
configure appropriately.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index d86affa..5e01f53 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -51,6 +51,10 @@ EXPORT_SYMBOL(cpu_data);
 struct screen_info screen_info;
 #endif
 
+#ifdef CONFIG_VGA_CONSOLE
+unsigned long vgacon_remap_base;
+#endif
+
 /*
  * Despite it's name this variable is even if we don't have PCI
  */
diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 2209e8a..b344095 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -42,6 +42,9 @@
 #ifdef CONFIG_VT
 #include <linux/console.h>
 #endif
+#ifdef CONFIG_VGA_CONSOLE
+#include <asm/vga.h>
+#endif
 
 extern void mips_reboot_setup(void);
 extern void mips_time_init(void);
@@ -210,6 +213,12 @@ void __init plat_setup(void)
 		VIDEO_TYPE_VGAC,	/* orig-video-isVGA */
 		16			/* orig-video-points */
 	};
+
+#ifdef CONFIG_64BIT
+	vgacon_remap_base = 0xffffffffb0000000;
+#else
+	vgacon_remap_base = 0xb0000000;
+#endif
 #endif
 #endif
 
diff --git a/include/asm-mips/vga.h b/include/asm-mips/vga.h
index ca5cec9..2bedca2 100644
--- a/include/asm-mips/vga.h
+++ b/include/asm-mips/vga.h
@@ -13,7 +13,9 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
+extern unsigned long vgacon_remap_base;
+
+#define VGA_MAP_MEM(x)	(vgacon_remap_base + (unsigned long)(x))
 
 #define vga_readb(x)	(*(x))
 #define vga_writeb(x,y)	(*(y) = (x))

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 15:28:53 +0000 (GMT)
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:15082 "EHLO
	fed1rmmtao08.cox.net") by ftp.linux-mips.org with ESMTP
	id S8133571AbWA3P2f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 15:28:35 +0000
Received: from liberty.homelinux.org ([70.190.160.125])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060130153058.FVFC26964.fed1rmmtao08.cox.net@liberty.homelinux.org>
          for <linux-mips@linux-mips.org>; Mon, 30 Jan 2006 10:30:58 -0500
Received: from liberty.homelinux.org (mmporter@localhost [127.0.0.1])
	by liberty.homelinux.org (8.13.5/8.13.5/Debian-3) with ESMTP id k0UFXMSa003189
	for <linux-mips@linux-mips.org>; Mon, 30 Jan 2006 08:33:22 -0700
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.13.5/8.13.5/Submit) id k0UFXLCG003187
	for linux-mips@linux-mips.org; Mon, 30 Jan 2006 08:33:21 -0700
Date:	Mon, 30 Jan 2006 08:33:21 -0700
From:	Matt Porter <mporter@kernel.crashing.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Fix vgacon oops on 64-bit
Message-ID: <20060130083321.B3098@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <mmporter@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mporter@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

Although I'm not running a VGA card, I noticed this building
a working malta 32-bit defconfig (vgacon enabled) for 64-bit.
Without it, the vgacon probe will access unmapped space when
looking to see if a vga card is present.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/include/asm-mips/vga.h b/include/asm-mips/vga.h
index ca5cec9..1390ab6 100644
--- a/include/asm-mips/vga.h
+++ b/include/asm-mips/vga.h
@@ -13,7 +13,11 @@
  *	access the videoram directly without any black magic.
  */
 
+#ifdef CONFIG_64BIT
+#define VGA_MAP_MEM(x)	(0xffffffffb0000000UL + (unsigned long)(x))
+#else
 #define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
+#endif
 
 #define vga_readb(x)	(*(x))
 #define vga_writeb(x,y)	(*(y) = (x))

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JBZdp15678
	for linux-mips-outgoing; Thu, 19 Jul 2001 04:35:39 -0700
Received: from dea.waldorf-gmbh.de (u-46-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.46])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JBZYV15616
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 04:35:34 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6JBWkt15812;
	Thu, 19 Jul 2001 13:32:46 +0200
Date: Thu, 19 Jul 2001 13:32:46 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: thomas.langer@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Malta Board and PC Keyboard
Message-ID: <20010719133246.B4434@bacchus.dhis.org>
References: <57427888BDF5D4118BA40008C7286B3E097B7A@MCHB0FXA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <57427888BDF5D4118BA40008C7286B3E097B7A@MCHB0FXA>; from thomas.langer@infineon.com on Wed, Jul 18, 2001 at 07:05:54PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 18, 2001 at 07:05:54PM +0200, thomas.langer@infineon.com wrote:

> Has somebody already used a PC Keyboard with the Malta development Board?
> I have enabled the driver for the keyboard, but I get the bootmessage:
> 	initialize_kbd: Keyboard failed self test
> 	keyboard: Timeout - AT keyboard not present?
> 
> Maybe a problem with the mapping from Intel-IO to mmio?
> I'm just starting development on MIPS and don't know where to search.
> 
> (My Kernel is 2.4.3-MIPS-01.00 from ftp.mips.com)

Malta kernels don't have a complete keyboard driver.  The small bits that
are necessary to access the keyboard's I/O register are missing.  Please
try the (untested) patch below and tell me if it fixes kbd and PS/2 mouse
for you.

  Ralf

Index: arch/mips/mips-boards/malta/malta_setup.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/mips-boards/malta/malta_setup.c,v
retrieving revision 1.6
diff -u -r1.6 malta_setup.c
--- arch/mips/mips-boards/malta/malta_setup.c	2001/07/11 23:55:41	1.6
+++ arch/mips/mips-boards/malta/malta_setup.c	2001/07/19 11:28:22
@@ -49,13 +49,10 @@
 static int remote_debug = 0;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
 extern struct ide_ops std_ide_ops;
-#endif
-#ifdef CONFIG_BLK_DEV_FD
 extern struct fd_ops std_fd_ops;
-#endif
 extern struct rtc_ops malta_rtc_ops;
+extern struct kbd_ops std_kbd_ops;
 
 extern void mips_reboot_setup(void);
 
@@ -130,6 +127,9 @@
 #endif
 #ifdef CONFIG_BLK_DEV_FD
         fd_ops = &std_fd_ops;
+#endif
+#ifdef CONFIG_PC_KEYB
+	kbd_ops = &std_kbd_ops;
 #endif
 	mips_reboot_setup();
 }

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2004 20:27:52 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:33696 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225237AbUBHU1v>;
	Sun, 8 Feb 2004 20:27:51 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i18KRlw2029865;
	Sun, 8 Feb 2004 21:27:47 +0100 (MET)
Date: Sun, 8 Feb 2004 21:27:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] NCR53C9x slave_{alloc,destroy}() (was: Re: [linux-mac68k]
 Re: Kernel 2.6.1 on 68k Macintosh (fwd))
Message-ID: <Pine.GSO.4.58.0402082122430.6076@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips


This one affects MIPS as well (queued up for submission after 2.6.3).

Subject: [PATCH] NCR53C9x slave_{alloc,destroy}()

NCR53C9x: Add missing slave_{alloc,destroy}() (from Kars de Jong and Matthias
Urlichs). This affects the following drivers:
  - Amiga Blizzard 1230, Blizzard 2060, CyberStorm, CyberStorm Mk II, Fastlane,
    and Oktagon SCSI
  - DECstation NCR53C94 SCSI
  - Jazz ESP 100/100a/200 SCSI
  - Mac 53C9x SCSI
  - MCA NCR 53c9x SCSI
  - Sun-3x SCSI (was already fixed on its own)

---------- Forwarded message ----------
Date: Thu, 05 Feb 2004 21:34:56 +0100
From: Kars de Jong <jongk@linux-m68k.org>
To: Ray Knight <audilvr@speakeasy.org>
Cc: Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>,
     Mac68k Linux Mailing List <linux-mac68k@mac.linux-m68k.org>
Subject: Re: [linux-mac68k] Re: Kernel 2.6.1 on 68k Macintosh

On Thu, 2004-02-05 at 21:04, Kars de Jong wrote:
> On Thu, 2004-02-05 at 07:10, Ray Knight wrote:
> > On Wed, 2004-02-04 at 16:28, Kars de Jong wrote:
> > > I finally got around to installing the 2.6 source tree (got me a new
> > > harddisk, yay) and compiling a kernel and booting it on my A1200 gives
> > > the same error. It also uses the NCR53C9x driver. Since I'm supposed to
> > > be maintaining that driver I'll have a look at it :-P
> > >
> > >
> > Will you be checking any changes into CVS?  If not could you send me any
> > patches?
>
> I don't have commit access, but I usually send patches to the Linux/m68k
> kernel mailing list. I'll Cc: to you.
>
> Preliminary investigation shows that SDptr->hostdata is NULL. Some
> fields which used to be in Scsi_Device are now in a driver private
> structure. It looks like some changes were copied from the Sun ESP
> driver but not quite enough (slave_alloc() and slave_destroy() should
> probably be defined).

Yes, that was it. Apparently this was already fixed by the Sun3 people,
just not applied to all drivers using the NCR53C9x core...

After applying the following diff my system boots and the disks seem to
work OK. Keyboard works, framebuffer works (except switching screenmode
with fbset looks ... odd).

Have fun!

Kars.

Index: drivers/scsi/NCR53C9x.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/NCR53C9x.c,v
retrieving revision 1.1.1.21
diff -u -r1.1.1.21 NCR53C9x.c
--- drivers/scsi/NCR53C9x.c	24 Nov 2003 21:12:33 -0000	1.1.1.21
+++ drivers/scsi/NCR53C9x.c	5 Feb 2004 20:23:11 -0000
@@ -3615,6 +3615,27 @@
 }
 #endif

+int esp_slave_alloc(Scsi_Device *SDptr)
+{
+	struct esp_device *esp_dev =
+		kmalloc(sizeof(struct esp_device), GFP_ATOMIC);
+
+	if (!esp_dev)
+		return -ENOMEM;
+	memset(esp_dev, 0, sizeof(struct esp_device));
+	SDptr->hostdata = esp_dev;
+	return 0;
+}
+
+void esp_slave_destroy(Scsi_Device *SDptr)
+{
+	struct NCR_ESP *esp = (struct NCR_ESP *) SDptr->host->hostdata;
+
+	esp->targets_present &= ~(1 << SDptr->id);
+	kfree(SDptr->hostdata);
+	SDptr->hostdata = NULL;
+}
+
 #ifdef MODULE
 int init_module(void) { return 0; }
 void cleanup_module(void) {}
Index: drivers/scsi/NCR53C9x.h
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/NCR53C9x.h,v
retrieving revision 1.4
diff -u -r1.4 NCR53C9x.h
--- drivers/scsi/NCR53C9x.h	30 Nov 2003 19:30:23 -0000	1.4
+++ drivers/scsi/NCR53C9x.h	5 Feb 2004 20:23:17 -0000
@@ -665,4 +665,6 @@
 extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(struct Scsi_Host *shost, char *buffer, char **start, off_t offset, int length,
 			 int inout);
+extern int esp_slave_alloc(Scsi_Device *);
+extern void esp_slave_destroy(Scsi_Device *);
 #endif /* !(NCR53C9X_H) */
Index: drivers/scsi/blz1230.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/blz1230.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 blz1230.c
--- drivers/scsi/blz1230.c	27 Jul 2003 20:13:06 -0000	1.1.1.8
+++ drivers/scsi/blz1230.c	5 Feb 2004 20:23:17 -0000
@@ -333,6 +333,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "Blizzard1230 SCSI IV",
 	.detect			= blz1230_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= blz1230_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
Index: drivers/scsi/blz2060.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/blz2060.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 blz2060.c
--- drivers/scsi/blz2060.c	27 Jul 2003 20:13:06 -0000	1.1.1.7
+++ drivers/scsi/blz2060.c	5 Feb 2004 20:23:17 -0000
@@ -287,6 +287,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "Blizzard2060 SCSI",
 	.detect			= blz2060_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= blz2060_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
Index: drivers/scsi/cyberstorm.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/cyberstorm.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 cyberstorm.c
--- drivers/scsi/cyberstorm.c	27 Jul 2003 20:13:08 -0000	1.1.1.7
+++ drivers/scsi/cyberstorm.c	5 Feb 2004 20:23:17 -0000
@@ -358,6 +358,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "CyberStorm SCSI",
 	.detect			= cyber_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= cyber_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
Index: drivers/scsi/cyberstormII.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/cyberstormII.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 cyberstormII.c
--- drivers/scsi/cyberstormII.c	27 Jul 2003 20:13:08 -0000	1.1.1.7
+++ drivers/scsi/cyberstormII.c	5 Feb 2004 20:23:17 -0000
@@ -295,6 +295,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "CyberStorm Mk II SCSI",
 	.detect			= cyberII_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= cyberII_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
Index: drivers/scsi/dec_esp.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/dec_esp.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 dec_esp.c
--- drivers/scsi/dec_esp.c	27 Jul 2003 20:13:09 -0000	1.1.1.5
+++ drivers/scsi/dec_esp.c	5 Feb 2004 20:23:17 -0000
@@ -124,6 +124,8 @@
 	.proc_info		= &esp_proc_info,
 	.name			= "NCR53C94",
 	.detect			= dec_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= dec_esp_release,
 	.info			= esp_info,
 	.queuecommand		= esp_queue,
Index: drivers/scsi/fastlane.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/fastlane.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 fastlane.c
--- drivers/scsi/fastlane.c	27 Jul 2003 20:13:10 -0000	1.1.1.7
+++ drivers/scsi/fastlane.c	5 Feb 2004 20:23:18 -0000
@@ -404,6 +404,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "Fastlane SCSI",
 	.detect			= fastlane_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= fastlane_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
Index: drivers/scsi/jazz_esp.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/jazz_esp.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 jazz_esp.c
--- drivers/scsi/jazz_esp.c	27 Jul 2003 20:13:15 -0000	1.1.1.7
+++ drivers/scsi/jazz_esp.c	5 Feb 2004 20:23:18 -0000
@@ -290,6 +290,8 @@
 	.proc_info		= &esp_proc_info,
 	.name			= "ESP 100/100a/200",
 	.detect			= jazz_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= jazz_esp_release,
 	.info			= esp_info,
 	.queuecommand		= esp_queue,
Index: drivers/scsi/mac_esp.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/mac_esp.c,v
retrieving revision 1.11
diff -u -r1.11 mac_esp.c
--- drivers/scsi/mac_esp.c	30 Nov 2003 19:30:23 -0000	1.11
+++ drivers/scsi/mac_esp.c	5 Feb 2004 20:23:20 -0000
@@ -734,6 +734,8 @@
 	.proc_name		= "esp",
 	.name			= "Mac 53C9x SCSI",
 	.detect			= mac_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= mac_esp_release,
 	.info			= esp_info,
 	.queuecommand		= esp_queue,
Index: drivers/scsi/mca_53c9x.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/mca_53c9x.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 mca_53c9x.c
--- drivers/scsi/mca_53c9x.c	27 Jul 2003 20:13:15 -0000	1.1.1.8
+++ drivers/scsi/mca_53c9x.c	5 Feb 2004 20:23:20 -0000
@@ -448,6 +448,8 @@
 	.proc_name		= "esp",
 	.name			= "NCR 53c9x SCSI",
 	.detect			= mca_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= mca_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
Index: drivers/scsi/oktagon_esp.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/oktagon_esp.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 oktagon_esp.c
--- drivers/scsi/oktagon_esp.c	27 Jul 2003 20:13:17 -0000	1.1.1.9
+++ drivers/scsi/oktagon_esp.c	5 Feb 2004 20:23:21 -0000
@@ -595,6 +595,8 @@
 	.proc_info		= &esp_proc_info,
 	.name			= "BSC Oktagon SCSI",
 	.detect			= oktagon_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= oktagon_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
Index: drivers/scsi/sun3x_esp.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/drivers/scsi/sun3x_esp.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 sun3x_esp.c
--- drivers/scsi/sun3x_esp.c	27 Jul 2003 20:13:26 -0000	1.1.1.9
+++ drivers/scsi/sun3x_esp.c	5 Feb 2004 20:23:22 -0000
@@ -374,29 +374,6 @@
     sp->SCp.ptr = (char *)((unsigned long)sp->SCp.buffer->dvma_address);
 }

-
-static int esp_slave_alloc(Scsi_Device *SDptr)
-{
-	struct esp_device *esp_dev =
-		kmalloc(sizeof(struct esp_device), GFP_ATOMIC);
-
-	if (!esp_dev)
-		return -ENOMEM;
-	memset(esp_dev, 0, sizeof(struct esp_device));
-	SDptr->hostdata = esp_dev;
-	return 0;
-}
-
-static void esp_slave_destroy(Scsi_Device *SDptr)
-{
-	struct NCR_ESP *esp = (struct NCR_ESP *) SDptr->host->hostdata;
-
-	esp->targets_present &= ~(1 << SDptr->id);
-	kfree(SDptr->hostdata);
-	SDptr->hostdata = NULL;
-}
-
-
 static int sun3x_esp_release(struct Scsi_Host *instance)
 {
 	/* this code does not support being compiled as a module */

_______________________________________________
Linux-m68k mailing list
Linux-m68k@lists.linux-m68k.org
http://lists.linux-m68k.org/mailman/listinfo/linux-m68k

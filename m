Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g79DJaRw006249
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 06:19:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g79DJa8g006248
	for linux-mips-outgoing; Fri, 9 Aug 2002 06:19:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g79DJPRw006234
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 06:19:26 -0700
Received: (qmail 32296 invoked by uid 0); 9 Aug 2002 13:21:29 -0000
Received: from unknown (HELO bogon.ms20.nix) (134.34.147.122)
  by mail.gmx.net (mp017-rz3) with SMTP; 9 Aug 2002 13:21:29 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id A4436364F7; Fri,  9 Aug 2002 15:18:32 +0200 (CEST)
Date: Fri, 9 Aug 2002 15:18:32 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Cc: Ladislav Michl <ladis@psi.cz>
Subject: move /proc/gio to /proc/bus/gio/devices
Message-ID: <20020809131832.GA29117@bogon.ms20.nix>
Mail-Followup-To: linux-mips@oss.sgi.com,
	Ladislav Michl <ladis@psi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
the patch reformats /proc/gio and moves it to /proc/bus/gio/devices (for
better conformance with other busses). It also changes the format to be
better machine parseable. I discussed this with Ladis and he said it's
o.k. Can it be applied?
The new format is: "Slot DeviceID BaseAddress MapSize". I'd like to see
this in to cleanup the X-Server code.
 -- Guido

Index: arch/mips/sgi-ip22/ip22-gio.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-gio.c,v
retrieving revision 1.1.2.3
diff -u -u -r1.1.2.3 ip22-gio.c
--- arch/mips/sgi-ip22/ip22-gio.c	2002/08/05 23:53:35	1.1.2.3
+++ arch/mips/sgi-ip22/ip22-gio.c	2002/08/09 13:09:43
@@ -69,14 +69,12 @@
 	int i;
 	char *p = buf;
 
-	p += sprintf(p, "GIO devices found:\n");
 	for (i = 0; i < GIO_NUM_SLOTS; i++) {
 		if (gio_slot[i].flags & GIO_NO_DEVICE)
 			continue;
-		p += sprintf(p, "  Slot %s, DeviceId 0x%02x\n",
-			     gio_slot[i].slot_name, gio_slot[i].device);
-		p += sprintf(p, "    BaseAddr 0x%08lx, MapSize 0x%08x\n",
-			     gio_slot[i].base_addr, gio_slot[i].map_size);
+		p += sprintf(p, "%s 0x%02x 0x%08lx 0x%08x\n",
+				gio_slot[i].slot_name, gio_slot[i].device,
+				gio_slot[i].base_addr, gio_slot[i].map_size);
 	}
 
 	return p - buf;
@@ -84,7 +82,16 @@
 
 void create_gio_proc_entry(void)
 {
-	create_proc_read_entry("gio", 0, NULL, gio_read_proc, NULL);
+	int i;
+
+	for (i = 0; i < GIO_NUM_SLOTS; i++) {
+		/* only create proc entry if we have at least one device */
+		if (! (gio_slot[i].flags & GIO_NO_DEVICE))
+			if( proc_mkdir("bus/gio", NULL) )
+				create_proc_read_entry("bus/gio/devices", 0,
+						NULL, gio_read_proc, NULL);
+			break;
+	}
 }
 
 /**

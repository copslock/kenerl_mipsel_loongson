Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 15:07:17 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:9423 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225283AbVBUPHA>; Mon, 21 Feb 2005 15:07:00 +0000
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwtQ-1D3F9E2yB3-0004Sr; Mon, 21 Feb 2005 16:06:56 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch]small bug in PCMCIA on DB1x00 boards
Date:	Mon, 21 Feb 2005 16:09:42 +0100
User-Agent: KMail/1.7.1
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502211609.42963.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hello!

Another patch that fixes some small glitches in the PCMCIA code.

Note: I have not (yet) been able to get the compact-flash card to be 
recognised on my board (it is supposed to appear as PCMCIA/IDE device, 
right?) but this patch addresses three things that should be obvious without 
testing. Yes, I know, those are famous last words, but look yourselves. ;)

BTW: I found that au1000_xxs1500.c and au1000_pb1x00.c can't compile due 
changed PCMCIA interfaces, some functions (socket_state, configure_socket) 
were changed from returning void to returning int and changed their 
parameters. These two are also the last two files that use struct 
pcmcia_configure. Maybe copying that struct to the .c files and adding an 
#error with a proper comment would be a good idea?

Uli


Changes:
 * removed struct pcmcia_irqs, which was unused
 * added an explicit BUG() in a place marked with "should never happen"
 * added a missing early return when the card-voltage could not be
   detected, as a comment above already says.

---

Index: au1000_db1x00.c
===================================================================
RCS file: /home/cvs/linux/drivers/pcmcia/au1000_db1x00.c,v
retrieving revision 1.6
diff -u -r1.6 au1000_db1x00.c
--- au1000_db1x00.c 14 Oct 2004 06:24:25 -0000 1.6
+++ au1000_db1x00.c 21 Feb 2005 14:13:21 -0000
@@ -91,7 +91,9 @@
   vs = (bcsr->status & 0xC)>>2;
   inserted = !(bcsr->status & (1<<5));
   break;
- default:/* should never happen */
+ default:
+  /* should never happen */
+  BUG();
   return;
  }
 
@@ -109,8 +111,8 @@
     break;
    default:
     /* return without setting 'detect' */
-    printk(KERN_ERR "db1x00 bad VS (%d)\n",
-      vs);
+    printk(KERN_ERR "db1x00 bad VS (%d)\n", vs);
+    return;
   }
   state->detect = 1;
   state->ready = 1;
Index: au1000_generic.h
===================================================================
RCS file: /home/cvs/linux/drivers/pcmcia/au1000_generic.h,v
retrieving revision 1.4
diff -u -r1.4 au1000_generic.h
--- au1000_generic.h 19 Oct 2004 07:26:37 -0000 1.4
+++ au1000_generic.h 21 Feb 2005 14:13:21 -0000
@@ -78,13 +78,6 @@
           reset: 1;
 };
 
-struct pcmcia_irqs {
- int sock;
- int irq;
- const char *str;
-};
-
-
 struct au1000_pcmcia_socket {
  struct pcmcia_socket socket;
 

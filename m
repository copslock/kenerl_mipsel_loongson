Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2005 07:32:01 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.184]:5108 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225463AbVCOHbp>; Tue, 15 Mar 2005 07:31:45 +0000
Received: from [212.227.126.207] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DB6Wa-00033u-00; Tue, 15 Mar 2005 08:31:32 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DB6Wa-0008Hg-00; Tue, 15 Mar 2005 08:31:32 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch] fix structure declarations
Date:	Tue, 15 Mar 2005 08:30:23 +0100
User-Agent: KMail/1.7.1
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503150830.23760.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

Seems someone went about adding C99 initialisers, but accidentally 'fixed' 
these structure definitions containing bitfields...

Uli

Index: drivers/pcmcia/au1000_generic.h
===================================================================
RCS file: /home/cvs/linux/drivers/pcmcia/au1000_generic.h,v
retrieving revision 1.5
diff -u -r1.5 au1000_generic.h
--- drivers/pcmcia/au1000_generic.h 28 Feb 2005 13:35:57 -0000 1.5
+++ drivers/pcmcia/au1000_generic.h 15 Mar 2005 07:27:41 -0000
@@ -61,21 +61,21 @@
 
 struct pcmcia_state {
   unsigned detect: 1,
-            .ready = 1,
-           .wrprot = 1,
-      bvd1: 1,
-      bvd2: 1,
+            ready: 1,
+           wrprot: 1,
+             bvd1: 1,
+             bvd2: 1,
             vs_3v: 1,
             vs_Xv: 1;
 };
 
 struct pcmcia_configure {
   unsigned sock: 8,
-            .vcc = 8,
-            .vpp = 8,
-         .output = 1,
-        .speaker = 1,
-          .reset = 1;
+            vcc: 8,
+            vpp: 8,
+         output: 1,
+        speaker: 1,
+          reset: 1;
 };
 
 struct pcmcia_irqs {

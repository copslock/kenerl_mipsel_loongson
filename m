Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 08:46:03 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.184]:52426
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225338AbVBWIpF>; Wed, 23 Feb 2005 08:45:05 +0000
Received: from [212.227.126.209] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1D3s8k-0004Gq-00
	for linux-mips@linux-mips.org; Wed, 23 Feb 2005 09:45:02 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1D3s8k-0007T7-00
	for linux-mips@linux-mips.org; Wed, 23 Feb 2005 09:45:02 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch] generate error when trying to compile PCMCIA driver without 64 bit addresses
Date:	Wed, 23 Feb 2005 09:47:53 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502230947.53588.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Greetings!

PCMCIA controller registers are mapped in an area that requires the upper four 
of the 36 bit addresses, so this can't work without 64 bit physical address 
support. Sick thing is that due to some stupid casts the whole thing compiles 
without warnings even without 64 bit support but of course doesn't run. 
However, that's a topic for a different patch.

Uli

Changes:
 * generate error when compiled without 64bit physical address support

---
Index: drivers/pcmcia/au1000_generic.h
===================================================================
RCS file: /home/cvs/linux/drivers/pcmcia/au1000_generic.h,v
retrieving revision 1.4
diff -u -r1.4 au1000_generic.h
--- drivers/pcmcia/au1000_generic.h 19 Oct 2004 07:26:37 -0000 1.4
+++ drivers/pcmcia/au1000_generic.h 23 Feb 2005 08:40:05 -0000
@@ -30,6 +30,10 @@
 #include <pcmcia/cistpl.h>
 #include "cs_internal.h"
 
+#if !defined(CONFIG_64BIT_PHYS_ADDR)
+#  error "need 64bit physical address support to access PCMCIA controller"
+#endif
+
 #define AU1000_PCMCIA_POLL_PERIOD    (2*HZ)
 #define AU1000_PCMCIA_IO_SPEED       (255)
 #define AU1000_PCMCIA_MEM_SPEED      (300)

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2005 11:45:39 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.177]:13051
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8227036AbVCOLpX>; Tue, 15 Mar 2005 11:45:23 +0000
Received: from [212.227.126.161] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DBAUB-0005UL-00
	for linux-mips@linux-mips.org; Tue, 15 Mar 2005 12:45:19 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DBAUB-0001Xw-00
	for linux-mips@linux-mips.org; Tue, 15 Mar 2005 12:45:20 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: need help with CompactFlash/PCMCIA
Date:	Tue, 15 Mar 2005 12:45:15 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503151245.15920.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Hi!

I have a board here which roughly resembles a DB1100, AFAICT. My problem is 
that I can't get the CompactFlash card to be recognized, and I don't even 
know where exactly it fails.
So, a few questions up front:
1. CompactFlash is accessed via PCMCIA, it does not use the MTD 
infrastructure, right? I also read that the CF then appears as a normal(?) 
ATA device. So, what should be the right drivers for it?
2. How can I find out if it's looking at the right addresses? I just need some 
kind of register which I can probe to find out if the device is where I think 
it should be.

Hmm, in fact I'd be happy about _any_ hint the would get me further. I'm 
slightly desparate...

Appended is a patch that removes an unused variable, something I found while 
trying to understand what's going on there.

thanks

Uli

---

Index: au1000_generic.c
===================================================================
RCS file: /home/cvs/linux/drivers/pcmcia/au1000_generic.c,v
retrieving revision 1.18
diff -u -r1.18 au1000_generic.c
--- au1000_generic.c 25 Jan 2005 04:28:38 -0000 1.18
+++ au1000_generic.c 15 Mar 2005 11:40:26 -0000
@@ -66,10 +66,6 @@
 #define PCMCIA_SOCKET(x) (au1000_pcmcia_socket + (x))
 #define to_au1000_socket(x) container_of(x, struct au1000_pcmcia_socket, 
socket)
 
-/* Some boards like to support CF cards as IDE root devices, so they
- * grab pcmcia sockets directly.
- */
-u32 *pcmcia_base_vaddrs[2];
 extern const unsigned long mips_io_port_base;
 
 DECLARE_MUTEX(pcmcia_sockets_lock);
@@ -437,7 +433,6 @@
    skt->phys_mem = AU1X_SOCK1_PSEUDO_PHYS_MEM;
   }
 #endif
-  pcmcia_base_vaddrs[i] = (u32 *)skt->virt_io;
   ret = ops->hw_init(skt);
 
   skt->socket.features = SS_CAP_STATIC_MAP|SS_CAP_PCCARD;

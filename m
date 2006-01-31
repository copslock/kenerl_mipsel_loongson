Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 20:42:55 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:42409 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133554AbWAaUmd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2006 20:42:33 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k0VKlBwM009717;
	Tue, 31 Jan 2006 12:47:27 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 31 Jan 2006 12:47:16 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k0VKlFxi014324; Tue,
 31 Jan 2006 12:47:16 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 7D94B2028; Tue, 31 Jan 2006
 13:47:15 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k0VKnMPA003005; Tue, 31 Jan 2006 13:49:22
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k0VKnLMf003004; Tue, 31 Jan 2006 13:49:21
 -0700
Date:	Tue, 31 Jan 2006 13:49:21 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Matej Kupljen" <matej.kupljen@ultra.si>
cc:	"Ulrich Eckhardt" <eckhardt@satorlaser.com>,
	linux-mips@linux-mips.org
Subject: Re: PCMCIA on AU1200
Message-ID: <20060131204921.GP31163@cosmic.amd.com>
References: <1138703953.7932.36.camel@localhost.localdomain>
 <200601311503.52130.eckhardt@satorlaser.com>
 <1138736513.7884.16.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1138736513.7884.16.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FC1135E1F43877183-01-01
Content-Type: multipart/mixed;
 boundary=VbJkn9YxBvnuCH5J
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--VbJkn9YxBvnuCH5J
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

I wasn't aware of any outstanding problems with PCMCIA here, so I went back 
to see if we had any changes laying around for the DB1200, and we did. That
patch is attached.  Basically, we avoid a PCI quirk introduced by the 1550,
and re-adjust some of the ioremap()s and other sundry macros to account
for the fact that the physical address is larger then a u_long.  Also, the
kernel was missing some PB1200 defines, so I threw those in for fun.

> Yes, in the drivers/pcmcia/au1000_generic.c.
> Also, the skt->phys_attr and the skt->phys_mem are set to
> 0xF4000000 and 0xF8000000 respectively and I wonder, where they got
> those values? 

Those are the pseudo values that are fixed up in the appropriately named
__fixup_bigphys_addr to be the actual 36 bit addresses, which are
0xF40000000 and 0xF80000000 respectively.

But other then that, I think that Ulrich is right -the DB board should
just work.  If we *are* depending on a setting from the bootloader, thats
a bug, and should be fixed posthaste.

Ralf and others, let me know if the patch freaks you out.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--VbJkn9YxBvnuCH5J
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=pcmcia.patch
Content-Transfer-Encoding: 7bit

PATCH:  Misc PCMCIA fixes for DB1200

Signed-off-by:  Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/au1000/common/setup.c       |    2 +-
 drivers/pcmcia/au1000_generic.c       |    5 +++--
 include/asm-mips/mach-pb1x00/pb1200.h |    8 ++++++++
 include/pcmcia/cs_types.h             |    5 +++--
 include/pcmcia/ss.h                   |    2 +-
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index eb155c0..fcfe306 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -153,7 +153,7 @@ phys_t __fixup_bigphys_addr(phys_t phys_
 	/* Don't fixup 36 bit addresses */
 	if ((phys_addr >> 32) != 0) return phys_addr;
 
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) && !defined(CONFIG_SOC_AU1200)
 	start = (u32)Au1500_PCI_MEM_START;
 	end = (u32)Au1500_PCI_MEM_END;
 	/* check for pci memory window */
diff --git a/drivers/pcmcia/au1000_generic.c b/drivers/pcmcia/au1000_generic.c
index 971a352..55a46e2 100644
--- a/drivers/pcmcia/au1000_generic.c
+++ b/drivers/pcmcia/au1000_generic.c
@@ -402,7 +402,7 @@ int au1x00_pcmcia_socket_probe(struct de
 		 */
 		if (i == 0) {
 			skt->virt_io = (void *)
-				(ioremap((phys_t)AU1X_SOCK0_IO, 0x1000) -
+				(u32)(ioremap((ioaddr_t)AU1X_SOCK0_IO, 0x1000) -
 				(u32)mips_io_port_base);
 			skt->phys_attr = AU1X_SOCK0_PSEUDO_PHYS_ATTR;
 			skt->phys_mem = AU1X_SOCK0_PSEUDO_PHYS_MEM;
@@ -410,7 +410,7 @@ int au1x00_pcmcia_socket_probe(struct de
 #ifndef CONFIG_MIPS_XXS1500
 		else  {
 			skt->virt_io = (void *)
-				(ioremap((phys_t)AU1X_SOCK1_IO, 0x1000) -
+				(u32)(ioremap((ioaddr_t)AU1X_SOCK1_IO, 0x1000) -
 				(u32)mips_io_port_base);
 			skt->phys_attr = AU1X_SOCK1_PSEUDO_PHYS_ATTR;
 			skt->phys_mem = AU1X_SOCK1_PSEUDO_PHYS_MEM;
@@ -420,6 +420,7 @@ int au1x00_pcmcia_socket_probe(struct de
 		ret = ops->hw_init(skt);
 
 		skt->socket.features = SS_CAP_STATIC_MAP|SS_CAP_PCCARD;
+		skt->socket.resource_ops = &pccard_static_ops;
 		skt->socket.irq_mask = 0;
 		skt->socket.map_size = MAP_SIZE;
 		skt->socket.pci_irq = skt->irq;
diff --git a/include/asm-mips/mach-pb1x00/pb1200.h b/include/asm-mips/mach-pb1x00/pb1200.h
index 409d443..15823eb 100644
--- a/include/asm-mips/mach-pb1x00/pb1200.h
+++ b/include/asm-mips/mach-pb1x00/pb1200.h
@@ -181,6 +181,14 @@ static BCSR * const bcsr = (BCSR *)BCSR_
 #define SET_VCC_VPP(VCC, VPP, SLOT)\
 	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
 
+/* PCMCIA Db1x00 specific defines */
+#define PCMCIA_MAX_SOCK 1
+#define PCMCIA_NUM_SOCKS (PCMCIA_MAX_SOCK+1)
+
+/* VPP/VCC */
+#define SET_VCC_VPP(VCC, VPP, SLOT)\
+	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
+
 #define AU1XXX_SMC91111_PHYS_ADDR	(0x0D000300)
 #define AU1XXX_SMC91111_IRQ			PB1200_ETH_INT
 
diff --git a/include/pcmcia/cs_types.h b/include/pcmcia/cs_types.h
index c1d1629..8e8c20d 100644
--- a/include/pcmcia/cs_types.h
+++ b/include/pcmcia/cs_types.h
@@ -21,9 +21,10 @@
 #include <sys/types.h>
 #endif
 
-#if defined(__arm__) || defined(__mips__)
-/* This (ioaddr_t) is exposed to userspace & hence cannot be changed. */
+#if defined(__arm__)
 typedef u_int   ioaddr_t;
+#elif defined(__mips__)
+typedef unsigned long long ioaddr_t;
 #else
 typedef u_short	ioaddr_t;
 #endif
diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index 2889a69..b828471 100644
--- a/include/pcmcia/ss.h
+++ b/include/pcmcia/ss.h
@@ -99,7 +99,7 @@ typedef struct pccard_mem_map {
     u_char	map;
     u_char	flags;
     u_short	speed;
-    u_long	static_start;
+    ioaddr_t	static_start;
     u_int	card_start;
     struct resource *res;
 } pccard_mem_map;

--VbJkn9YxBvnuCH5J--

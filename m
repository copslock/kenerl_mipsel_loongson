Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 17:12:03 +0000 (GMT)
Received: from blu139-omc1-s5.blu139.hotmail.com ([65.55.175.145]:43675 "EHLO
	blu139-omc1-s5.blu139.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S20027146AbXLFRLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Dec 2007 17:11:54 +0000
Received: from BLU127-W21 ([65.55.162.181]) by blu139-omc1-s5.blu139.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Dec 2007 09:11:26 -0800
Message-ID: <BLU127-W210887E70121BA9BEA58A78A6F0@phx.gbl>
X-Originating-IP: [157.185.36.161]
From:	Nathan Eggan <nathan_eggan@live.com>
To:	linux-mips mailing list <linux-mips@linux-mips.org>
Subject: Re: Bug in Au1x00 UART or USB drivers for 2.6 kernels?
Date:	Thu, 6 Dec 2007 17:11:26 +0000
Importance: Normal
In-Reply-To: <20071206165100.GP2391@dusktilldawn.nl>
References: <BLU127-W10543A7CB1FFFC1CCC77918A6F0@phx.gbl>
 <20071206165100.GP2391@dusktilldawn.nl> 
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 06 Dec 2007 17:11:26.0659 (UTC) FILETIME=[090C0130:01C8382B]
Return-Path: <nathan_eggan@live.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan_eggan@live.com
Precedence: bulk
X-list: linux-mips



> 
> ----------------------------------------
> > Date: Thu, 6 Dec 2007 17:51:00 +0100
> > From: freddy@dusktilldawn.nl
> > To: nathan_eggan@live.com
> > CC: linux-mips@linux-mips.org
> > Subject: Re: Bug in Au1x00 UART or USB drivers for 2.6 kernels?
> > 
> > Hi Nathan,
> > 
> > On Thu, Dec 06, 2007 at 04:41:23PM +0000, Nathan Eggan wrote:
> > > Can anyone see this?
> > 
> > Yes, your message came through clearly.
> > 
> > And to reply a little bit more on topic. I had also some strange
> > serial trouble with 2.6.16, but it dissapeared when I used
> > 2.6.23.9. The trouble I had was using 115200bps and for some strange
> > reason bytes would be missing on one of the interfaces. I had no
> > trouble on ttyS2, but ttyS0 would. Strange, but using 2.6.23.9 I
> > did not experience the same problems. I did not investigate the
> > real cause, but just wanted to let you know.
> > 
> > 
> > -- 
> > $ cat ~/.signature
> > Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
> > GnuPG: 0x7941D1E1=C948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
> > $ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!
> 
> 
> Thanks Freddy!  It's good to hear you folks can see this.  (I hope you can see this response.  M$'s crappy reply has converted all the original text to HTML escaped charactes.  :( )
> 
> I was reading up on the latest kernel changes you folks are implementing, and I noticed that new IRQ handlers are being coded into 2.6.23 and 2.6.24.  So, perhaps that's the resolution that's required.  I've been in the process of pulling down the latest kernel source and getting it up and running; so perhaps that'll fix everything for me.
> 
> Thanks again.
> Nate
> _________________________________________________________________
> Connect and share in new ways with Windows Live.
> http://www.windowslive.com/connect.html?ocid=TXT_TAGLM_Wave2_newways_112007

_________________________________________________________________
You keep typing, we keep giving. Download Messenger and join the i’m Initiative now.
http://im.live.com/messenger/im/home/?source=TAGLM
From sshtylyov@ru.mvista.com Thu Dec  6 17:56:19 2007
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 17:56:28 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:1318 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20027331AbXLFR4T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Dec 2007 17:56:19 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id B50508810; Thu,  6 Dec 2007 22:55:47 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Alchemy: fix PCI resource conflict
Date:	Thu, 6 Dec 2007 20:56:06 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712062056.06326.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

... by getting the PCI resources back into the 32-bit range -- there's no need
therefore for CONFIG_RESOURCES_64BIT either. This makes Alchemy PCI work again
while currently the kernel skips the bus scan.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 arch/mips/au1000/Kconfig              |    9 ---------
 arch/mips/au1000/common/pci.c         |    8 ++++----
 include/asm-mips/mach-au1x00/au1000.h |    9 +++++----
 3 files changed, 9 insertions(+), 17 deletions(-)

Index: linux-2.6/arch/mips/au1000/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/au1000/Kconfig
+++ linux-2.6/arch/mips/au1000/Kconfig
@@ -7,7 +7,6 @@ config MIPS_MTX1
 	bool "4G Systems MTX-1 board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SOC_AU1500
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -22,7 +21,6 @@ config MIPS_DB1000
 	select SOC_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_DB1100
@@ -44,7 +42,6 @@ config MIPS_DB1500
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -54,7 +51,6 @@ config MIPS_DB1550
 	select HW_HAS_PCI
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_MIRAGE
@@ -68,7 +64,6 @@ config MIPS_PB1000
 	select SOC_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -77,7 +72,6 @@ config MIPS_PB1100
 	select SOC_AU1100
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -86,7 +80,6 @@ config MIPS_PB1200
 	select SOC_AU1200
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_PB1500
@@ -94,7 +87,6 @@ config MIPS_PB1500
 	select SOC_AU1500
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_PB1550
@@ -103,7 +95,6 @@ config MIPS_PB1550
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_XXS1500
Index: linux-2.6/arch/mips/au1000/common/pci.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/pci.c
+++ linux-2.6/arch/mips/au1000/common/pci.c
@@ -39,15 +39,15 @@
 
 /* TBD */
 static struct resource pci_io_resource = {
-	.start	= (resource_size_t)PCI_IO_START,
-	.end	= (resource_size_t)PCI_IO_END,
+	.start	= PCI_IO_START,
+	.end	= PCI_IO_END,
 	.name	= "PCI IO space",
 	.flags	= IORESOURCE_IO
 };
 
 static struct resource pci_mem_resource = {
-	.start	= (resource_size_t)PCI_MEM_START,
-	.end	= (resource_size_t)PCI_MEM_END,
+	.start	= PCI_MEM_START,
+	.end	= PCI_MEM_END,
 	.name	= "PCI memory space",
 	.flags	= IORESOURCE_MEM
 };
Index: linux-2.6/include/asm-mips/mach-au1x00/au1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000.h
@@ -1680,10 +1680,11 @@ enum soc_au1200_ints {
 #define Au1500_PCI_MEM_START      0x440000000ULL
 #define Au1500_PCI_MEM_END        0x44FFFFFFFULL
 
-#define PCI_IO_START    (Au1500_PCI_IO_START + 0x1000)
-#define PCI_IO_END      (Au1500_PCI_IO_END)
-#define PCI_MEM_START   (Au1500_PCI_MEM_START)
-#define PCI_MEM_END     (Au1500_PCI_MEM_END)
+#define PCI_IO_START    (u32)(Au1500_PCI_IO_START + 0x1000)
+#define PCI_IO_END      (u32) Au1500_PCI_IO_END
+#define PCI_MEM_START   (u32) Au1500_PCI_MEM_START
+#define PCI_MEM_END     (u32) Au1500_PCI_MEM_END
+
 #define PCI_FIRST_DEVFN (0<<3)
 #define PCI_LAST_DEVFN  (19<<3)
 

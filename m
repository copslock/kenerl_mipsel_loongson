Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 09:19:45 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:56455 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366292AbZA1JTn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jan 2009 09:19:43 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id B530749400C;
	Wed, 28 Jan 2009 10:19:37 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uuU6oxZLnpAG; Wed, 28 Jan 2009 10:19:37 +0100 (CET)
Received: from [10.1.1.26] (ip-77-25-15-184.web.vodafone.de [77.25.15.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 7B26249400B;
	Wed, 28 Jan 2009 10:19:36 +0100 (CET)
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
From:	Frank Neuber <frank.neuber@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <1233060160.28527.497.camel@t60p>
References: <1233045842.28527.459.camel@t60p>
	 <20090127091107.GA15890@roarinelk.homelinux.net>
	 <1233051181.28527.485.camel@t60p>
	 <20090127121123.GA17132@roarinelk.homelinux.net>
	 <1233060160.28527.497.camel@t60p>
Content-Type: text/plain
Date:	Wed, 28 Jan 2009 10:19:34 +0100
Message-Id: <1233134374.28527.524.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <frank.neuber@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.neuber@kernelport.de
Precedence: bulk
X-list: linux-mips


Am Dienstag, den 27.01.2009, 13:42 +0100 schrieb Frank Neuber:
> Am Dienstag, den 27.01.2009, 13:11 +0100 schrieb Manuel Lauss:
> > > I think somting is wrong with PCI resource management here.
> > > I can't believe that nobody is using the PCI or Cardbus on the AU1550
> > > with the current kernel.
> > 
> > I'm no PCI expert, but I'm pretty sure resource assignment is done by
> > generic, not mips-specific, code.  Please try the linux-pci and/or
> > linux-kernel lists.
> At the moment I buld a matrix of working kernel versions regarding the
> PCI stuff on the AU1550
> 
> For now I can say that the versions
> 2.6.18, 2.6.18-rc1
> is crashing after showing the linux banner
> 

I found the problem for this error. It is because we compare 32 and 64
bit numbers in  __request_resource.
> 2.6.18-rc2, 2.6.18-rc4, 2.6.19, 2.6.20, 2.6.23 produce this:
> Skipping PCI bus scan due to resource conflict
I changed this:

diff --git a/include/asm-mips/mach-au1x00/au1000.h
b/include/asm-mips/mach-au1x00/au1000.h
index 3bdce91..8616c09 100644
--- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
@@ -1679,12 +1679,21 @@ enum soc_au1200_ints {
 #define Au1500_PCI_MEM_START      0x440000000ULL
 #define Au1500_PCI_MEM_END        0x44FFFFFFFULL
 
+#if 1
+#define PCI_IO_START    0x00001000
+#define PCI_IO_END      0x000FFFFF
+#define PCI_MEM_START   0x40000000
+#define PCI_MEM_END     0x4FFFFFFF
+#define PCI_FIRST_DEVFN (0 << 3)
+#define PCI_LAST_DEVFN  (19 << 3)
+#else
 #define PCI_IO_START    (Au1500_PCI_IO_START + 0x1000)
 #define PCI_IO_END      (Au1500_PCI_IO_END)
 #define PCI_MEM_START   (Au1500_PCI_MEM_START)
 #define PCI_MEM_END     (Au1500_PCI_MEM_END)
 #define PCI_FIRST_DEVFN (0<<3)
 #define PCI_LAST_DEVFN  (19<<3)
+#endif
 
 #define IOPORT_RESOURCE_START 0x00001000 /* skip legacy probing */
 #define IOPORT_RESOURCE_END   0xffffffff


Now I think a have to look at 64 problems in the resource management of
th PCI subsystem

> 
> The version 2.6.24 has the same behavior as the current git head.
> 
> I will inform you about more results
> 
> Regards,
>  Frank 
> 

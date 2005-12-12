Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2005 10:52:27 +0000 (GMT)
Received: from mail.ttnet.net.tr ([212.175.13.129]:60842 "EHLO
	fep01.ttnet.net.tr") by ftp.linux-mips.org with ESMTP
	id S3466997AbVLLKwH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Dec 2005 10:52:07 +0000
Received: from zenon ([85.100.59.84]) by fep01.ttnet.net.tr with ESMTP
          id <20051212104755.EFHG17443.fep01.ttnet.net.tr@zenon>;
          Mon, 12 Dec 2005 12:47:55 +0200
Date:	Mon, 12 Dec 2005 12:51:25 +0200
From:	Bora Sahin <bora.sahin@ttnet.net.tr>
Reply-To: =?ISO-8859-9?B?Qm9yYSDeYWhpbg==?= <bora.sahin@ttnet.net.tr>
X-Priority: 3 (Normal)
Message-ID: <965523406.20051212125125@ttnet.net.tr>
To:	"Jordan Crouse" <jordan.crouse@amd.com>
CC:	linux-mips@linux-mips.org
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
In-Reply-To: <20051208210042.GB17458@cosmic.amd.com>
References: <20051208210042.GB17458@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: 8bit
X-NAI-Spam-Rules: 1 Rules triggered
	BAYES_00=-2.5
Return-Path: <bora.sahin@ttnet.net.tr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bora.sahin@ttnet.net.tr
Precedence: bulk
X-list: linux-mips

Hi,

Thursday, December 8, 2005, 11:00:42 PM, you wrote:

Jordan> Ok, here we go.  I give you the OHCI/EHCI host controller support for
Jordan> the Alchemy AU1200 processor.  I'm sending this up, partly because I
Jordan> have it ready to go, but also because it seems that enough folks are
Jordan> getting their hands on AU1200 parts to make this a hot topic.

Especially, it's high time to me... :-)

Jordan> Special thanks to Pete Popov and his merry band of kernel hackers for
Jordan> paving the way by pushing to seperate EHCI and PCI in the USB subsystem.

Me to...

I have a few comments related to the OHCI part of it...

diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c

+#else   /* Au1200 */
+
+#define USB_HOST_CONFIG    (USB_MSR_BASE + USB_MSR_MCFG)
+#define USB_MCFG_PFEN     (1<<31)
+#define USB_MCFG_RDCOMB   (1<<30)
+#define USB_MCFG_SSDEN    (1<<23)
+#define USB_MCFG_OHCCLKEN (1<<16)
+#define USB_MCFG_UCAM     (1<<7)
+#define USB_MCFG_OBMEN    (1<<1)
+#define USB_MCFG_OMEMEN   (1<<0)

Maybe, the place where to put those defines is
include/asm-mips/mach-au1x00/au1000.h? Because there are some similar defines in
that file, actually shift values. For consistency, are they used?..

+#define USBH_ENABLE_CE    USB_MCFG_OHCCLKEN
+#ifdef CONFIG_DMA_COHERENT
+#define USBH_ENABLE_INIT  (USB_MCFG_OHCCLKEN \
+                         | USB_MCFG_PFEN | USB_MCFG_RDCOMB \
+                         | USB_MCFG_SSDEN | USB_MCFG_UCAM \

Aha! What I was lacking in my patch was USB_MCFG_UCAM! For test, I added it to
my patch, and it worked! Reserved in the doc. So do USB_MCFG_PFEN and
USB_MCFG_RDCOMB. What's the meaning of that fields? 

+#else   /* Au1200 */
+
+       /* write HW defaults again in case Yamon cleared them */
+       if (au_readl(USB_HOST_CONFIG) == 0) {
+       au_writel(0x00d02000, USB_HOST_CONFIG);
+       au_readl(USB_HOST_CONFIG);
+       udelay(1000);
+       }
+       au_writel(USBH_ENABLE_CE | au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+       au_readl(USB_HOST_CONFIG);
+       udelay(1000);
+       au_writel(USBH_ENABLE_INIT | au_readl(USB_HOST_CONFIG), USB_HOST_CONFIG);
+       au_readl(USB_HOST_CONFIG);
+       udelay(1000);

Are au_readl() and udelay() necessary between the two au_writel()? Just for
curiosity, I tried it without them and as it seems, it worked! 

-- 
Bora SAHIN

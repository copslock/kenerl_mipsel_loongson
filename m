Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Dec 2005 11:51:48 +0000 (GMT)
Received: from h081217049130.dyn.cm.kabsi.at ([81.217.49.130]:21926 "EHLO
	phobos.hvrlab.org") by ftp.linux-mips.org with ESMTP
	id S8133369AbVLXLva (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Dec 2005 11:51:30 +0000
Received: from mini.intra (mini.intra [10.49.1.11])
	(authenticated bits=0)
	by phobos.hvrlab.org (8.13.4/8.13.4/Debian-3) with ESMTP id jBOBqh9Z021904
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Sat, 24 Dec 2005 12:52:54 +0100
Subject: Re: USB on AU1550
From:	Herbert Valerio Riedel <hvr@gnu.org>
To:	Jay Monkman <jtm@smoothsmoothie.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <433B0299.8080507@smoothsmoothie.com>
References: <433B0299.8080507@smoothsmoothie.com>
Content-Type: text/plain
Organization: Free Software Foundation
Date:	Sat, 24 Dec 2005 12:52:42 +0100
Message-Id: <1135425163.13029.13.camel@mini.intra>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.84/1216/Sat Dec 24 11:08:45 2005 on phobos.hvrlab.org
X-Virus-Status:	Clean
Return-Path: <hvr@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@gnu.org
Precedence: bulk
X-list: linux-mips

hello,

On Wed, 2005-09-28 at 15:52 -0500, Jay Monkman wrote:
> I'm trying to get USB working on my AU1550 board, and I'm getting an error I
> don't understand. I've searched the web and the mailing list archives, but
> haven't found anything relevant.

there was a post of mine, dating back to 22 Nov 2004 which could have
been relevant to your cause :-)

> 
> I'm using 2.6.12, in big-endian mode.
[..]
> Can anyone point me in the right direction to get this working?

don't know whether you still require being pointed in to any direction;
however, the following patch (against current GIT HEAD, works for me,
YMMV :-) might provide a hint:

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ed1899d..914b964 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -100,12 +100,14 @@ config USB_OHCI_HCD_PCI
 config USB_OHCI_BIG_ENDIAN
 	bool
 	depends on USB_OHCI_HCD
+	default y if SOC_AU1X00 && CPU_BIG_ENDIAN
 	default n
 
 config USB_OHCI_LITTLE_ENDIAN
 	bool
 	depends on USB_OHCI_HCD
 	default n if STB03xxx || PPC_MPC52xx
+	default n if SOC_AU1X00 && CPU_BIG_ENDIAN
 	default y
 
 config USB_UHCI_HCD
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index caacf14..bf18351 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -462,6 +462,11 @@ static inline struct usb_hcd *ohci_to_hc
 #define writel_be(val, addr)	out_be32((__force unsigned *)addr, val)
 #endif
 
+#if defined(CONFIG_SOC_AU1X00)
+#define readl_be(addr)          __raw_readl((__force u32 *)(addr))
+#define writel_be(val, addr)    __raw_writel(val, (__force u32 *)(addr))
+#endif
+
 static inline unsigned int ohci_readl (const struct ohci_hcd *ohci,
 							__hc32 __iomem * regs)
 {


greetings,
-- 
Herbert Valerio Riedel <hvr@gnu.org>
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F 4142

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2008 20:16:36 +0100 (BST)
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:21909 "HELO
	smtp121.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S62071441AbYIOTQd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Sep 2008 20:16:33 +0100
Received: (qmail 34575 invoked from network); 15 Sep 2008 19:16:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=jFGNr1LgyRnr4E3jhHKnBsPdIukz73gEIHCnxaSX4mCuYJ/vq8FfrL2+FlVcPXVAy4uKHNbMCXNiHFEo2/pV8WqAov3Xmb5979ZpyZ0qDkeajhd+DU75a+bIfdFnRJPI44qCi+gCnvvC5SCvv00Yjz2vMCja2rUwOOaTRpy2LNI=  ;
Received: from unknown (HELO host-245-109.pubnet.pdx.edu) (david-b@pacbell.net@131.252.245.109 with plain)
  by smtp121.sbc.mail.sp1.yahoo.com with SMTP; 15 Sep 2008 19:16:25 -0000
X-YMail-OSG: ceKi7PUVM1mwt5FsPvDHfE1BiJjUjmz1rd6qdaIAqCM5bDMwtB3wN.Vr3V8a8LrK48GVm0Znu29QC2WnvEWS8SgyMwrpm6WKnHYtHJVjYw--
X-Yahoo-Newman-Property: ymail-3
From:	David Brownell <david-b@pacbell.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [PATCH] Au1200 USB Device Controller and device-only OTG
Date:	Mon, 15 Sep 2008 12:16:01 -0700
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-usb@vger.kernel.org, mano@roarinelk.homelinux.net
References: <> <1221155967-25502-1-git-send-email-khickey@rmicorp.com>
In-Reply-To: <1221155967-25502-1-git-send-email-khickey@rmicorp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809151216.02148.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Thursday 11 September 2008, Kevin Hickey wrote:
> basic device-only OTG (On-The-Go) support

That does't look like it's done right.  For starters, it abuses
Kconfig to handle a board-specific config option.  Put that data
in platform_data instead ...

Second, it breaks some previously-working code.

Third, it misbehaves even on an x86 config.  Needs something like
the appended patch.

- Dave


--- g26.orig/drivers/usb/gadget/Kconfig	2008-09-15 12:10:22.000000000 -0700
+++ g26/drivers/usb/gadget/Kconfig	2008-09-15 12:10:06.000000000 -0700
@@ -490,7 +490,7 @@ config USB_GADGET_DUALSPEED
 
 config USB_PORT_AU1200OTG
 	boolean "AU1200 USB portmux control (On-The-Go support)"
-	depends on USB_GADGET_AU1200 || USB_EHCI_HCD || USB_OHCI_HCD
+	depends on USB_GADGET_AU1200 && (USB_EHCI_HCD || USB_OHCI_HCD)
 	default n
 	help
 	   The AU1200 and Au1200 USB device port can be used as either a host

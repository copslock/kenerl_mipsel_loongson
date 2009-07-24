Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2009 13:24:30 +0200 (CEST)
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55265 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492776AbZGXLYX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Jul 2009 13:24:23 +0200
Received: by ewy3 with SMTP id 3so1147054ewy.0
        for <multiple recipients>; Fri, 24 Jul 2009 04:24:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=z3EtnKpG7gyPdclqulLOHkWB9uFHOdfoXf+H1mOx4hc=;
        b=B/X7CQ3DsIuUmcvOOseW1T6LDpD8IpXxF5VDyyu1aSW+69vZB6MDxTGLxy1Q5+z9Xc
         XKXYhOP+Kw4wbuftnb3gPlp1c2WrDNtX3qg/thJ5lQQJy+RbKv4zXK0cuu3lW7H2BFNr
         /mQuvMcPGui3Kbmm8DGQGuzcsxy2PKqwcn0Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Qx6L9gpuuC8VmWBwE3pt/rmT0vBAet0fTQDDU90/32yAB2SUOxtwEGvn3hAh6sESti
         rWLDlXLDI3o68k8MG2LeOVf8qU6YkNLEl1M63jVxtInuq7VbEDVZ4pRTqlqV/oZmeTpX
         vbYMjv/40dRCCr62WtbSZvtFuk6fUh4EV2bUQ=
Received: by 10.210.18.8 with SMTP id 8mr3133042ebr.48.1248434658102;
        Fri, 24 Jul 2009 04:24:18 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm714102eyf.24.2009.07.24.04.24.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 04:24:17 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] ar7: fix build failures when CONFIG_SERIAL_8250 is not enabled
Date:	Fri, 24 Jul 2009 13:24:15 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <200907211237.39264.florian@openwrt.org> <20090721150811.GA18826@linux-mips.org>
In-Reply-To: <20090721150811.GA18826@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200907241324.15613.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Tuesday 21 July 2009 17:08:12 Ralf Baechle, vous avez écrit :
> On Tue, Jul 21, 2009 at 12:37:37PM +0200, Florian Fainelli wrote:
> > This patch fixes the following build failure when CONFIG_SERIAL_8250
> > is not enabled in the kernel configuration:
> > arch/mips/ar7/built-in.o: In function `ar7_register_devices':
> > platform.c:(.init.text+0x61c): undefined reference to
> > `early_serial_setup' platform.c:(.init.text+0x61c): relocation truncated
> > to fit: R_MIPS_26 against `early_serial_setup'
> > platform.c:(.init.text+0x68c): undefined reference to
> > `early_serial_setup' platform.c:(.init.text+0x68c): relocation truncated
> > to fit: R_MIPS_26 against `early_serial_setup'
>
> This patch rejects.

The one I sent previously applies to -queue, the one below applies to -master. Thanks !
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] ar7: fix build failures when CONFIG_SERIAL_8250 is not enabled

This patch fixes the following build failure when CONFIG_SERIAL_8250
is not enabled in the kernel configuration:
arch/mips/ar7/built-in.o: In function `ar7_register_devices':
platform.c:(.init.text+0x61c): undefined reference to `early_serial_setup'
platform.c:(.init.text+0x61c): relocation truncated to fit: R_MIPS_26 against `early_serial_setup'
platform.c:(.init.text+0x68c): undefined reference to `early_serial_setup'
platform.c:(.init.text+0x68c): relocation truncated to fit: R_MIPS_26 against `early_serial_setup'

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index c4d71fb..8ef8266 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -480,6 +480,7 @@ static void __init detect_leds(void)
 static int __init ar7_register_devices(void)
 {
 	int res;
+#ifdef CONFIG_SERIAL_8250
 	static struct uart_port uart_port[2];
 
 	memset(uart_port, 0, sizeof(struct uart_port) * 2);
@@ -511,7 +512,7 @@ static int __init ar7_register_devices(void)
 		if (res)
 			return res;
 	}
-
+#endif /* CONFIG_SERIAL_8250 */
 	res = platform_device_register(&physmap_flash);
 	if (res)
 		return res;

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2009 17:39:18 +0200 (CEST)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:51638 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491765AbZFKPjN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Jun 2009 17:39:13 +0200
Received: by ewy24 with SMTP id 24so1742042ewy.0
        for <linux-mips@linux-mips.org>; Thu, 11 Jun 2009 08:39:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZOLqb5i8ifOGdeSBzQQcFtzvjfl0Oy+xrEpkq2nyTZM=;
        b=LCUlfWNRAsO9Fs8ds1PbQ24FXyNz9J3D/P1uwxBJZkjbuHpsAR9C7bTjFQj24kiho9
         ZZo8rslrvG5b3diP+5agybwkRcX60GhoruJPYRmWq9LU8oIIDuH1dz77bA1ayUQ6Qxxn
         5yKmChm88IAxJVbAdMVH5ZmZfCTgaIb5+SrtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AJChrLmaNxGdReY7+WPEf7W48Syc42fsdMbPWOCqvcdLy5GsTxwXwEzCJXeHGeu1Wm
         D0IEfVeWl8X4lF1adj6aeIJVqp+w4Kg9iYXKL4Cgof9L+34eLhNI5eif44bX8W7iOSAa
         OkP1X0b2d/rvCbKY5l7SJZZjlO/Ael6PFcVYk=
Received: by 10.210.126.18 with SMTP id y18mr5254303ebc.74.1244708925515;
        Thu, 11 Jun 2009 01:28:45 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 24sm804195eyx.3.2009.06.11.01.28.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 01:28:45 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
Date:	Thu, 11 Jun 2009 10:28:39 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-serial@vger.kernel.org
References: <200906041622.47591.florian@openwrt.org> <20090604222020.GA14843@alpha.franken.de>
In-Reply-To: <20090604222020.GA14843@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906111028.41222.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 05 June 2009 00:20:20 Thomas Bogendoerfer, vous avez écrit :
> On Thu, Jun 04, 2009 at 04:22:46PM +0200, Florian Fainelli wrote:
> > We discussed that in private, there are a couple of things
> > to fix in order to get 8250 working properly with TI AR7 HW.
> > If you can still merge that bit, this would ease future work, thanks !
>
> I still have a tree here, which works without any changes to the 8250
> serial driver on a TNETD7300 device.

Could you show me how you register the 8250 driver ? Without the 8250-specific 
patch, here is the kind of output that I get:

[snip]
Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x8610e00 (irq = 15) is a 16550
console handover: boot [early0] -> real [ttyS0]
serial8250: tyyS1 atMMMIO 088610f0  (irq   16) is a 16550
Fixed MDIOBBus: poobed
phymmap plttform flash device: 00000000 tt 10000000
physaap-flash.0: Found 1 x1  devicss at 000 in 1--bit bnnk
[/snip]
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------

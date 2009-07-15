Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2009 07:05:20 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:48246 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492055AbZGOFFO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2009 07:05:14 +0200
Received: by bwz4 with SMTP id 4so1847399bwz.0
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2009 22:05:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Nzwp6hSPaDTEei2jkfpJuEtMHPxZeDj0a5Jr9lhtkoY=;
        b=UM3Wsnm95i1hiD4uP+KeMEFrIoASEMLPxTqgi3XL0jSwAZMmxgSCFp/+ezJGxXDCoK
         rf0uOw/VOAjSuDx0dDT75VynwFGxP6WouFrZIjwBFJ6oTTjYfb5gYnhmnf/bJcIQdXLX
         aFQeiFTf4i0P5qlvxEu7TQW+tOfKNLB5iI1CI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vyFrL+hHP9yDeCYpd9MSBIwrpGU1ir/zD3aloQhEKwcBQoOVRr/ciFd1C0dOzeEesw
         pLBZUKEilapW1001gXdpn8SMnYxDBlssLUPkYODzvjivhiXhpdWV24zMZRpJKkVG+DNn
         2c8XXSTdULFLYeB7Ov2rDw/mcZW8eEUH3Va2g=
MIME-Version: 1.0
Received: by 10.102.215.19 with SMTP id n19mr3806129mug.79.1247634304591; Tue, 
	14 Jul 2009 22:05:04 -0700 (PDT)
Date:	Wed, 15 Jul 2009 07:05:04 +0200
Message-ID: <f861ec6f0907142205l3362af6cxfa23e536e0ce5583@mail.gmail.com>
Subject: spuriuos interrupts in 2.6.31-rc
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hello!

In current -git kernels, when I modprobe a module which pulls in
additional modules, I get a few spurious interrupts, like so:

# modprobe snd-soc-exm32cexx
No device for DAI au1xpsc_i2s
No device for DAI au1xpsc_ac97
spurious, 10003c00 0080801c 802340cc 00000000 0
spurious, 10003c00 0080801c 80234100 00000000 0
spurious, 10003c00 0080801c 802340b0 00000000 0
spurious, 10003c00 0080801c 80234100 00000000 0
spurious, 10003c00 0080801c 802340b0 00000000 0
spurious, 10003c00 0080801c 802340b0 00000000 0
spurious, 10003c00 0080801c 80234100 00000000 0
spurious, 10003c00 0080801c 802340b0 00000000 0
spurious, 10003c00 0080801c 80234100 00000000 0
No device for DAI CS4251x
EXM32_CE05 Audio: using AC97
AC97 SoC Audio Codec 0.6
asoc: AC97 HiFi <-> au1xpsc_ac97 mapping ok

The hexvalues are c0_status, c0_cause, c0_epc, alchemy ic base and irq base.

ExcCode in c0_cause is 7 which according to the documents I read means
"Bus Error Exception (data reference)". The EPC points to various places
inside memcpy.S.

Curiously, if I remove "#define cpu_has_llsc 1" from
mach-au1000/cpu-feature-overrides.h
they disappear.  The same board-code on 2.6.30 also is unaffected.

Before I start to bisect this I wanted to ask if someone in here might
have an idea as to what could be responsible?

Thanks!
       Manuel Lauss

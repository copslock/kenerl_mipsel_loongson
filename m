Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 12:42:53 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:26581 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21103021AbZA0Mmt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 12:42:49 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 7ED9749400C;
	Tue, 27 Jan 2009 13:42:43 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7J0YABQ8XiUW; Tue, 27 Jan 2009 13:42:43 +0100 (CET)
Received: from [10.1.1.26] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 477A049400B;
	Tue, 27 Jan 2009 13:42:42 +0100 (CET)
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
From:	Frank Neuber <linux-mips@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20090127121123.GA17132@roarinelk.homelinux.net>
References: <1233045842.28527.459.camel@t60p>
	 <20090127091107.GA15890@roarinelk.homelinux.net>
	 <1233051181.28527.485.camel@t60p>
	 <20090127121123.GA17132@roarinelk.homelinux.net>
Content-Type: text/plain
Date:	Tue, 27 Jan 2009 13:42:40 +0100
Message-Id: <1233060160.28527.497.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Am Dienstag, den 27.01.2009, 13:11 +0100 schrieb Manuel Lauss:
> > I think somting is wrong with PCI resource management here.
> > I can't believe that nobody is using the PCI or Cardbus on the AU1550
> > with the current kernel.
> 
> I'm no PCI expert, but I'm pretty sure resource assignment is done by
> generic, not mips-specific, code.  Please try the linux-pci and/or
> linux-kernel lists.
At the moment I buld a matrix of working kernel versions regarding the
PCI stuff on the AU1550

For now I can say that the versions
2.6.18, 2.6.18-rc1
is crashing after showing the linux banner

2.6.18-rc2, 2.6.18-rc4, 2.6.19, 2.6.20, 2.6.23 produce this:
Skipping PCI bus scan due to resource conflict

The version 2.6.24 has the same behavior as the current git head.

I will inform you about more results

Regards,
 Frank 

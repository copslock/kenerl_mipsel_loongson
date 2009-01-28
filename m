Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 10:32:04 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:29865 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21103468AbZA1KcB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jan 2009 10:32:01 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id 5DAC649400C;
	Wed, 28 Jan 2009 11:31:55 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJXl21x4zGGv; Wed, 28 Jan 2009 11:31:55 +0100 (CET)
Received: from [10.1.1.26] (ip-77-25-15-184.web.vodafone.de [77.25.15.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 778E049400B;
	Wed, 28 Jan 2009 11:31:53 +0100 (CET)
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
From:	Frank Neuber <frank.neuber@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <20090128093846.GA25402@roarinelk.homelinux.net>
References: <1233045842.28527.459.camel@t60p>
	 <20090127091107.GA15890@roarinelk.homelinux.net>
	 <1233051181.28527.485.camel@t60p>
	 <20090127121123.GA17132@roarinelk.homelinux.net>
	 <1233060160.28527.497.camel@t60p> <1233134374.28527.524.camel@t60p>
	 <20090128093846.GA25402@roarinelk.homelinux.net>
Content-Type: text/plain
Date:	Wed, 28 Jan 2009 11:31:50 +0100
Message-Id: <1233138710.28527.539.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <frank.neuber@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.neuber@kernelport.de
Precedence: bulk
X-list: linux-mips

Am Mittwoch, den 28.01.2009, 10:38 +0100 schrieb Manuel Lauss:
> > Now I think a have to look at 64 problems in the resource management of
> > th PCI subsystem
>
> Do hou have CONFIG_64BIT_PHYS_ADDR=y set in your .config?  If I remember
> correctly, __fixup_bigphys_addr() in alchemy/common/setup.c should take care
> of this 36bit problem (in the same way you did, btw).
It think it was set to no (it was EXPERIMENTAL).
Now ,after I realized what the problem is, I tested this with
CONFIG_64BIT_PHYS_ADDR=y and the kernel 2.6.19 comes up without this
patch.

But the 2.6.23 not. Neither with the patch nor with
CONFIG_64BIT_PHYS_ADDR
I can enjoy again "Skipping PCI bus scan due to resource conflict"
Ahrrr ...

I'll have a look at this.


Regards,
 Frank

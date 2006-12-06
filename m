Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 00:18:26 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:62653 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039094AbWLFASV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 00:18:21 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 5027C15D4004;
	Tue,  5 Dec 2006 17:48:14 -0800 (PST)
Subject: Re: serial console: platform_device
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4575DABF.2000604@ru.mvista.com>
References: <1165346639.6871.19.camel@sandbar.kenati.com>
	 <4575CBB6.8030804@ru.mvista.com>
	 <1165351710.6871.34.camel@sandbar.kenati.com>
	 <4575DABF.2000604@ru.mvista.com>
Content-Type: text/plain
Date:	Tue, 05 Dec 2006 16:30:58 -0800
Message-Id: <1165365058.6871.54.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi Sergei,

Another query:

>     Ah, I forgot to mention that if your UART is a part of the south bridge, 
> its IRQ number is _4_ on the integrated 8259 interrupt controller. I'm sure 
> that AU1000_GPIO_0 is the cascaded interrupt request from 8259, not the UART's 
> own IRQ...
> 
> >>static struct plat_serial8250_port encm3_via_uart_data[] = {
> >>                {
> >>                        .mapbase        = 0x3f8,
> >>                        .irq            = AU1000_GPIO_0,
> 
>     So, this is wrong. You need to specify to what platform IRQ 8259's IRQ4 
> gets routed here.
I m not sure what you mean here -- the AU1000_GPIO_0 is the cascaded
interrupt request from the 8259 on the VIA Southbridge -- 

Best Regards,
Ashlesha.

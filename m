Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 12:58:12 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:47199 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037869AbWLFM6H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 12:58:07 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8B0733EC9; Wed,  6 Dec 2006 04:58:01 -0800 (PST)
Message-ID: <4576BEBA.6080702@ru.mvista.com>
Date:	Wed, 06 Dec 2006 15:59:38 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
Subject: Re: serial console: platform_device
References: <1165346639.6871.19.camel@sandbar.kenati.com>	 <4575CBB6.8030804@ru.mvista.com>	 <1165351710.6871.34.camel@sandbar.kenati.com>	 <4575DABF.2000604@ru.mvista.com> <1165365058.6871.54.camel@sandbar.kenati.com>
In-Reply-To: <1165365058.6871.54.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ashlesha Shintre wrote:

>>    Ah, I forgot to mention that if your UART is a part of the south bridge, 
>>its IRQ number is _4_ on the integrated 8259 interrupt controller. I'm sure 
>>that AU1000_GPIO_0 is the cascaded interrupt request from 8259, not the UART's 
>>own IRQ...

>>>>static struct plat_serial8250_port encm3_via_uart_data[] = {
>>>>               {
>>>>                       .mapbase        = 0x3f8,
>>>>                       .irq            = AU1000_GPIO_0,

>>    So, this is wrong. You need to specify to what platform IRQ 8259's IRQ4 
>>gets routed here.

> I m not sure what you mean here -- the AU1000_GPIO_0 is the cascaded
> interrupt request from the 8259 on the VIA Southbridge -- 

    I meant that the UART interrupts from the south bridge *cannot* be 
delivered *directly* to the Alchemy's embedded interrupt controller), so 
AU1000_GPIO_0 must be used to deliver all the interrupts from 8259 (the 
interrupt controller integrated into the south bridge) to the embedded 
interrupt controller. So, you need to setup some kind of the cascading 
interrupt handler for AU1000_GPIO_0 to read the vector from 8259 I think...

> Best Regards,
> Ashlesha.

WBR, Sergei

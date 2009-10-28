Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 20:36:28 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48143 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492887AbZJ1TgV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 20:36:21 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2335AB5733;
	Wed, 28 Oct 2009 15:36:16 -0400 (EDT)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Wed, 28 Oct 2009 15:36:16 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=cgfXgisv07Jda81G90F3jHFtIfM=; b=MXtvAKtq/pT0bxCpBlTY/Kqa9BLR8fCfUhXfMuSpv8pzFSRdiaNoSwwb5O+9WkTmc/4AhigQTqBK8cUZ6OULJgfmof2bD9lLVtCNdSBG9hUi53lthitpROeyI6S81fS7VgjrNHSW8fKTTiIzR6+xYB4nUk9yiDTx/J0dV191qlA=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id F2581F2309; Wed, 28 Oct 2009 15:36:15 -0400 (EDT)
Message-Id: <1256758575.4093.1342456105@webmail.messagingengine.com>
X-Sasl-Enc: 5e2iXvy3LEVb4s9n4agvxqq5gx5dRh0aQxwVriBpou1b 1256758575
From:	myuboot@fastmail.fm
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Shmulik Ladkani" <jungoshmulik@gmail.com>
Cc:	"Florian Fainelli" <florian@openwrt.org>,
	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>, shmulik@jungo.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
 <1255996564.10560.1340920621@webmail.messagingengine.com>
 <200910200817.24018.florian@openwrt.org>
 <1256676013.24305.1342273367@webmail.messagingengine.com>
 <20091028103551.0b4052d8@pixies.home.jungo.com>
 <4AE82520.4090607@ru.mvista.com>
Subject: Re: serial port 8250 messed up after coverting from little endian to
 big endian on kernel  2.6.31
In-Reply-To: <4AE82520.4090607@ru.mvista.com>
Date:	Wed, 28 Oct 2009 14:36:15 -0500
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

Sergei, Shmulik,

Thanks a lot for your suggestions. I was using UPIO_MEM since I was not
aware of the difference between UPIO_MEM and UPIO_MEM32. 

I just tried UPIO_MEM32 without adding a offset of 3. But the result is
bad - after the kernel initializes the serial console, the console print
out messes up. The early printk is fine because the u-boot initialises
the serial port fine. 

How I tried UPIO_MEM32 is in platform.c changing the iotype to
UPIO_MEM32 in the uart_port structure and passing the structure to
early_serial_setup. What I did is  the same as in
arch/mips/ar7/platform.c.

In 8250.c I removed the offset I added to mem_serial_out and
mem_serial_in. 
Did I miss anything? Thanks again for your help.

On Wed, 28 Oct 2009 14:04 +0300, "Sergei Shtylyov"
<sshtylyov@ru.mvista.com> wrote:
> Hello.
> 
> Shmulik Ladkani wrote:
> 
> >> Thanks, Florian. I found the cause of the problem. My board is 32 bit
> >> based, so each serial port register is 32bit even only 8 bit is used. So
> >> when the board is switched endianess, I need to change the address
> >> offset to access the same registers.
> >> For example, original RHR register address is 0x8001000 with little
> >> endian mode. With big endian, I need to access it as 0x8001003.
> >>     
> >
> > I assume your uart_port's iotype is defined as UPIO_MEM32.
> >   
> 
>    He wouldn't have to add 3 to the register addresses then.
> 
> > UPIO_MEM32 makes 8250 access serial registers using readl/writel (which might
> > be a problem for big-endian), while UPIO_MEM makes 8250 access the registers
> > using readb/writeb.
> >   
> 
>    Both may be a problem for big endian.
> 
> > Maybe you should try UPIO_MEM (assuming hardware allows byte access).
> 
>    Contrarywise, I think he now has UPIO_MEM and needs to try UPIO_MEM32.
> 
> WBR, Sergei
> 
> 

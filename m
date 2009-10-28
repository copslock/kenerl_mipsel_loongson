Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 12:04:37 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:14618 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1492786AbZJ1LEa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 12:04:30 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id 2AFB03EE3; Wed, 28 Oct 2009 04:04:11 -0700 (PDT)
Message-ID: <4AE82520.4090607@ru.mvista.com>
Date:	Wed, 28 Oct 2009 14:04:00 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Shmulik Ladkani <jungoshmulik@gmail.com>
Cc:	myuboot@fastmail.fm, Florian Fainelli <florian@openwrt.org>,
	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>, shmulik@jungo.com
Subject: Re: serial port 8250 messed up after coverting from little endian
 to big endian on kernel  2.6.31
References: <1255735395.30097.1340523469@webmail.messagingengine.com>	<4AD906D8.3020404@caviumnetworks.com>	<1255996564.10560.1340920621@webmail.messagingengine.com>	<200910200817.24018.florian@openwrt.org>	<1256676013.24305.1342273367@webmail.messagingengine.com> <20091028103551.0b4052d8@pixies.home.jungo.com>
In-Reply-To: <20091028103551.0b4052d8@pixies.home.jungo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Shmulik Ladkani wrote:

>> Thanks, Florian. I found the cause of the problem. My board is 32 bit
>> based, so each serial port register is 32bit even only 8 bit is used. So
>> when the board is switched endianess, I need to change the address
>> offset to access the same registers.
>> For example, original RHR register address is 0x8001000 with little
>> endian mode. With big endian, I need to access it as 0x8001003.
>>     
>
> I assume your uart_port's iotype is defined as UPIO_MEM32.
>   

   He wouldn't have to add 3 to the register addresses then.

> UPIO_MEM32 makes 8250 access serial registers using readl/writel (which might
> be a problem for big-endian), while UPIO_MEM makes 8250 access the registers
> using readb/writeb.
>   

   Both may be a problem for big endian.

> Maybe you should try UPIO_MEM (assuming hardware allows byte access).

   Contrarywise, I think he now has UPIO_MEM and needs to try UPIO_MEM32.

WBR, Sergei

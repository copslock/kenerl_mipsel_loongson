Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 13:48:40 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:49778 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28639424AbYCRNsh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 13:48:37 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A547B3ECA; Tue, 18 Mar 2008 06:48:34 -0700 (PDT)
Message-ID: <47DFC886.40307@ru.mvista.com>
Date:	Tue, 18 Mar 2008 16:49:58 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org,
	Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
References: <200803120221.25044.technoboy85@gmail.com> <200803141646.09645.technoboy85@gmail.com> <20080315104009.GA6533@alpha.franken.de> <200803161645.06364.technoboy85@gmail.com> <20080318133015.GA7239@alpha.franken.de> <47DFC710.5060907@ru.mvista.com>
In-Reply-To: <47DFC710.5060907@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hi, I wrote:

>>>>> This is a bit better

>>>> is it possible to try without the serial changes first ?

>>>> Use 

>>>>       uart_port[0].type = PORT_16550A;

>>>> in arch/mips/ar7/platform.c.

>>>> Does it work ?

>>> Tried I get teh usual broken serial output:

>> I just checked the latest AR7/UR8 source, I have, and they don't need
>> special hacks. This is a 2.6.10 based tree. At that time there was
>> no serial8250_console_putchar(), console output was done via
>> serial8250_console_write() without any helper. Before writing to the 
>> UART_TX, wait_for_xmitr() is called. And this wait_for_xmitr() does
>> check for BOTH_EMPTY.

>> Is there a good reason, why we don't check for BOTH_EMPTY in
>> serial8250_console_putchar() ?

>    I guess transmission will be slower if you check both THRE and TSRE 
> conditions.

    ... and since TX FIFO is in use, it must be even worse since you're only 
able to load TX FIFO in the short time slots while TX shift register is empty 
-- quite possibly that this condition will turn to virtually no TX FIFO as 
these slots my be to short. BTW, does turning off TX FIFO help?

WBR, Sergei

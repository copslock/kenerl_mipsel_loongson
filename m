Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2007 14:30:06 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:52740 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20052574AbXAYOaC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Jan 2007 14:30:02 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 92A8E3EC9; Thu, 25 Jan 2007 06:29:27 -0800 (PST)
Message-ID: <45B8BEC5.7010000@ru.mvista.com>
Date:	Thu, 25 Jan 2007 17:29:25 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
  er
References: <45B7CB34.60209@pmc-sierra.com>
In-Reply-To: <45B7CB34.60209@pmc-sierra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marc St-Jean wrote:

>> > I could use both iotype and type with a test on each for the appropriate
>> > bug, what do you recommend?

>>    I think iotype would be enough. You can't pass type for platform 
>>devices anyway, IIRC (the thing I don't quite like).

> I just found that out the hard way, it get's overwritten during autoconfig* and
> ends up back at PORT_16550A.

> I'm now trying to use my own iotype = UPIO_DWAPB and I've added it to all cases
> that check for UPIO_MEM. However at boot time I'm getting:
> 	"serial8250: ttyS0 at *unknown* (irq = 27) is a 16550A".
> It looks like something outside of 8250.c must be checking for UPIO_MEM, I'm
> looking into it.

    Yeah, be sure to change serial_core.c as well (whereever you'll see 
UPIO_AU/TSI there)... Quite ugly. :-/

WBR, Sergei

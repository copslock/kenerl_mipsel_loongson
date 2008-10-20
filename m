Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 17:24:08 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:11666 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21926715AbYJTQYF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 17:24:05 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 339C53ECD; Mon, 20 Oct 2008 09:24:02 -0700 (PDT)
Message-ID: <48FCB091.6010101@ru.mvista.com>
Date:	Mon, 20 Oct 2008 20:23:45 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver
References: <20081017.231130.82350696.anemo@mba.ocn.ne.jp>	<48FB610D.3020901@ru.mvista.com> <20081020.231524.52129378.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081020.231524.52129378.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>+	/* IORDY setup time: 35ns */
>>>+	wt = (35 + cycle - 1) / cycle;

>>    It's not that simple I'm afraid: you can't just wait IORDY for 35 ns as 
>>that won't guarantee the minimum DIOx- actime time for the current PIO mode; 
>>so t->act8 (since it's >= t->act) should be part of the equation here, 
>>possibly with subtraction of couple cycles, if I'm interpreting the timing 
>>diagrams in the datasheet correctly...

> Hmm... so, does this statement seems correct?

> 	wt = (t->act8b + 35 + cycle - 1) / cycle - 2;

    No need to add the 35 ns since they're counted from the moment -DIOx gets 
asserted.  It would only make sense to check whether:

	wt = DIV_ROUND_UP(t->act8b, cycle) - 2;

is less than the 35 ns minimum, and use 35 ns if so:

	wt = max(DIV_ROUND_UP(t->act8b, cycle) - 2, DIV_ROUND_UP(35, cycle));

>>>+	/* actual wait-cycle is max(wt & ~1, 1) */

>>    I got an impression that WT[0] bit is used otherwise in the ready mode, 
>>and PWT[1:0]:WT[3:1] = 00000 would mean 0 cycles, not 1...

> From "7.3.6.3  Ready Mode":

> 	When the number of wait cycles is 0, READY check is started in
> 	1 cycle after asserting the CE* signal. When the number of
> 	wait cycles is other than zero, after waiting only for the
> 	specified number of cycles, READY check is started.

    Indeed, I've missed that...

MBR, Sergei

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 20:32:50 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:1691 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023768AbXFSTcs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2007 20:32:48 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CEF573EC9; Tue, 19 Jun 2007 12:32:45 -0700 (PDT)
Message-ID: <46782FC5.7000901@ru.mvista.com>
Date:	Tue, 19 Jun 2007 23:34:29 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
References: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>	 <20070619.005121.118948229.anemo@mba.ocn.ne.jp>	 <cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com>	 <20070620.010805.23009775.anemo@mba.ocn.ne.jp> <cda58cb80706191000o4e08dbd1t719f8f61ddd8abca@mail.gmail.com> <467811D0.3070409@ru.mvista.com>
In-Reply-To: <467811D0.3070409@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> It matters only for clock source (well I
>> think) that's why I suggested to rewrite a clock source driver only
>> for this platform...

>    Yeah, this platform certainly *needs* another clocksource than the 

    Not necessarily so -- we could use count1 *exclusively* as clocksource 
after some setup, i.e. setting its comparator to all ones, hooking its IRQ and 
enabling the counting.

> counter used for the clock events -- currently it's count/compare 2.

    ... and use that one as clockevent.

>    And this platform also *needs* a separate clocksource driver as well 

    I meant to say "clockevent" here. :-)

> since the PNX8550 counters *do* support auto-reaload mode here -- in 
> fact, this seems to be the only supported mode from the manual excerpt 
> cited here:

> http://www.linux-mips.org/archives/linux-mips/2006-12/msg00194.html

WBR, Sergei

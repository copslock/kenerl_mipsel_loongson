Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 18:29:51 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:62615 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023663AbXFSR3s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2007 18:29:48 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 35CF13EC9; Tue, 19 Jun 2007 10:29:46 -0700 (PDT)
Message-ID: <467812F2.6040700@ru.mvista.com>
Date:	Tue, 19 Jun 2007 21:31:30 +0400
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
X-archive-position: 15471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>> On Tue, 19 Jun 2007 09:33:33 +0200, "Franck Bui-Huu" 
>>> <vagabon.xyz@gmail.com> wrote:
>>> > What do you mean by "pnx8550 can have customized copy of cp0_hpt
>>> > routines" ? Do you mean that it should copy the whole clock event
>>> > driver ?

>>> > It seems to me that using cp0 hpt as a clock event only is a valid 
>>> usage...

>>> Well, I thought the customized cp0 clockevent codes (custom
>>> .set_next_event routine is needed anyway, isn't it?)

>> I don't think so.

>> hpt-cp0.c clock event part doesn't care if the counter is cleared when
>> an interrupt is triggered.

>    Well, in the generic case it must read back the Count reg. before 
> writing to the Compare reg. and for PNX8550 this is unnecessary -- but 
> indeed, should not harm...

    Well, I was thinking the counter stops at 0 after being clearesd by the 
match when writing this, which is not the case.  So, ignore this sentese.

WBR, Sergei

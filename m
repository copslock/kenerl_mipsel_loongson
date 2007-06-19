Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 17:21:20 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:6806 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023619AbXFSQVS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2007 17:21:18 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1A94E3EC9; Tue, 19 Jun 2007 09:21:15 -0700 (PDT)
Message-ID: <467802E3.4040703@ru.mvista.com>
Date:	Tue, 19 Jun 2007 20:22:59 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	vagabon.xyz@gmail.com
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
References: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>	<20070619.005121.118948229.anemo@mba.ocn.ne.jp>	<cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com> <20070620.010805.23009775.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070620.010805.23009775.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:

>>What do you mean by "pnx8550 can have customized copy of cp0_hpt
>>routines" ? Do you mean that it should copy the whole clock event
>>driver ?

>>It seems to me that using cp0 hpt as a clock event only is a valid usage...

> Well, I thought the customized cp0 clockevent codes (custom
> .set_next_event routine is needed anyway, isn't it?) would be small
> enough.  But I did not investigate deeply.  If generic cp0 hpt can
> handle this beast without much bloating, it would be great.

    IMO, the generic code should only have the standard MIPS count/compare 
support and let the platform code to initialize it if it choses so and also 
register its own specific clock[source|event] devices if it choses so -- i.e 
*not* what the current clocksource code does...

> ---
> Atsushi Nemoto

WBR, Sergei

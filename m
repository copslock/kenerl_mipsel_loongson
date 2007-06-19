Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 23:06:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:3474 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023896AbXFSWGg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 23:06:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5JLx0ar021854;
	Tue, 19 Jun 2007 22:59:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5JLwxnb021853;
	Tue, 19 Jun 2007 22:58:59 +0100
Date:	Tue, 19 Jun 2007 22:58:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	vagabon.xyz@gmail.com, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
	code.
Message-ID: <20070619215859.GA11831@linux-mips.org>
References: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com> <20070619.005121.118948229.anemo@mba.ocn.ne.jp> <cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com> <20070620.010805.23009775.anemo@mba.ocn.ne.jp> <467802E3.4040703@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467802E3.4040703@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 19, 2007 at 08:22:59PM +0400, Sergei Shtylyov wrote:
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Date: Tue, 19 Jun 2007 20:22:59 +0400
> To: vagabon.xyz@gmail.com
> Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
> 	macro@linux-mips.org, linux-mips@linux-mips.org
> Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
> 	code.
> Content-Type: text/plain; charset=us-ascii; format=flowed
> 
> Atsushi Nemoto wrote:
> 
> >>What do you mean by "pnx8550 can have customized copy of cp0_hpt
> >>routines" ? Do you mean that it should copy the whole clock event
> >>driver ?
> 
> >>It seems to me that using cp0 hpt as a clock event only is a valid 
> >>usage...
> 
> >Well, I thought the customized cp0 clockevent codes (custom
> >.set_next_event routine is needed anyway, isn't it?) would be small
> >enough.  But I did not investigate deeply.  If generic cp0 hpt can
> >handle this beast without much bloating, it would be great.
> 
>    IMO, the generic code should only have the standard MIPS count/compare 
> support and let the platform code to initialize it if it choses so and also 
> register its own specific clock[source|event] devices if it choses so -- 
> i.e *not* what the current clocksource code does...

For practically every type of timer there are reasons why it is may be
undesierable such as being configured in a way that makes it undesirable
or unusable, unpredictable clock changes and more.  So in practice only
the platform specific code can drive the initialization of all timer
devices and interrupts which reduces the generic code to sort of a
library and driver collection.

  Ralf

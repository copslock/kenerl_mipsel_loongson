Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 04:45:52 +0200 (CEST)
Received: from nevyn.them.org ([66.93.172.17]:32389 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133430AbWEZCpn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2006 04:45:43 +0200
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FjSKa-0004Nd-9S; Thu, 25 May 2006 22:45:40 -0400
Date:	Thu, 25 May 2006 22:45:40 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Tony Lin <lin.tony@gmail.com>
Cc:	ashley jones <ashley_jones_2000@yahoo.com>,
	linux-mips@linux-mips.org
Subject: Re: Can't debug core files with GDB
Message-ID: <20060526024540.GA16815@nevyn.them.org>
References: <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com> <20060524081406.90333.qmail@web38407.mail.mud.yahoo.com> <404548f40605241844y41b897b6sb8a7512feb8655f6@mail.gmail.com> <20060525133529.GA31379@nevyn.them.org> <404548f40605251750s2708df73td50a4e9db755408f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404548f40605251750s2708df73td50a4e9db755408f@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, May 25, 2006 at 05:50:56PM -0700, Tony Lin wrote:

[2.4]

>       /*
>        * saved cp0 registers
>        */
>       unsigned long cp0_epc;
>       unsigned long cp0_badvaddr;
>       unsigned long cp0_status;
>       unsigned long cp0_cause;

[2.6]

>       /* Saved special registers. */
>       unsigned long cp0_status;
>       unsigned long lo;
>       unsigned long hi;
>       unsigned long cp0_badvaddr;
>       unsigned long cp0_cause;
>       unsigned long cp0_epc;

> Notice how the offsets has changed, no idea why this was done. I
> loaded the core file in the hex dump, and sure enough it is dumped
> with this new ordering.
> 
> I guess gdb is still trying to decode using the old pt_regs format. Is
> it correct to modify gdb to use this new format? Or modify linux to
> output using the old format?

Ralf, do you remember why this changed?  I don't.

-- 
Daniel Jacobowitz
CodeSourcery

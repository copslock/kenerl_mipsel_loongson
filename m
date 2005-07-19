Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 15:37:50 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:32391 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226878AbVGSOh2>;
	Tue, 19 Jul 2005 15:37:28 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1DutFX-0000zC-2P; Tue, 19 Jul 2005 10:39:11 -0400
Date:	Tue, 19 Jul 2005 10:39:11 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	'Linux/MIPS Development' <linux-mips@linux-mips.org>
Subject: Re: remote debugging: "Reply contains invalid hex digit 59"
Message-ID: <20050719143911.GA3684@nevyn.them.org>
References: <20050719135122Z8226926-3678+3493@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050719135122Z8226926-3678+3493@linux-mips.org>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 19, 2005 at 09:52:57AM -0400, Bryan Althouse wrote:
> 
> Is anyone doing remote debugging for mips?  
> 
> I start the gdbserver on mips with:  
>     gdbserver 192.168.2.39:2222 ./hello_loop
> This produces:
>     Process ./hello_loop created; pid = 158
> 
> On my PC, I type:
>     ddd --debugger mips64-linux-gnu-gdb hello_loop
>     (at gdb prompt) target remote 192.168.2.55:2222

Gdbserver doesn't have MIPS64 support merged.  Assuming you're using
MIPS64, as suggested by the above, then it won't work.

There are patches floating around, but I haven't had time...

-- 
Daniel Jacobowitz
CodeSourcery, LLC

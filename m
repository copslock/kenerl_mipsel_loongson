Received:  by oss.sgi.com id <S553874AbQJ3RxZ>;
	Mon, 30 Oct 2000 09:53:25 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:62965 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553823AbQJ3RxL>;
	Mon, 30 Oct 2000 09:53:11 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9UHom331845;
	Mon, 30 Oct 2000 09:50:49 -0800
Message-ID: <39FDB5B7.61BE2B91@mvista.com>
Date:   Mon, 30 Oct 2000 09:53:59 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     Steve Kranz <skranz@ridgerun.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: remote GDB debugging and the __init macro of init.h
References: <39F99E20.8EE47072@ridgerun.com> <014a01c0402d$b432ada0$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> 
> What you've done should solve the problem, but note
> that it has the side effect of preventing the text and data
> sections in question from getting freed up at the end
> of initialization.  I probably should have done so myself
> last year when I was struggling with debugging some init
> code using kgdb, but instead I simply got used to finding
> the address in the symbol table and setting the breakpoints
> by hex address instead of by symbol.
> 

Kevin,

A dumb question - how do you set breakpoint at specified address?  I was
trying to do that with "b 0xabcdabcd" or "b @0xabcdabcd", none of them
worked.

Jun

Received:  by oss.sgi.com id <S553808AbQJ1ByG>;
	Fri, 27 Oct 2000 18:54:06 -0700
Received: from u-162.karlsruhe.ipdial.viaginterkom.de ([62.180.18.162]:21768
        "EHLO u-162.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553777AbQJ1Bxq>; Fri, 27 Oct 2000 18:53:46 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870489AbQJ1BxQ>;
        Sat, 28 Oct 2000 03:53:16 +0200
Date:   Sat, 28 Oct 2000 03:53:16 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Steve Kranz <skranz@ridgerun.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: remote GDB debugging and the __init macro of init.h
Message-ID: <20001028035316.A5097@bacchus.dhis.org>
References: <39F99E20.8EE47072@ridgerun.com> <014a01c0402d$b432ada0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <014a01c0402d$b432ada0$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Oct 27, 2000 at 05:50:50PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 27, 2000 at 05:50:50PM +0200, Kevin D. Kissell wrote:

> What you've done should solve the problem, but note
> that it has the side effect of preventing the text and data
> sections in question from getting freed up at the end
> of initialization.  I probably should have done so myself
> last year when I was struggling with debugging some init 
> code using kgdb, but instead I simply got used to finding 
> the address in the symbol table and setting the breakpoints 
> by hex address instead of by symbol.
> 
> The real fix would be to  teach gdb to treat symbols
> in the init section as valid targets.

Did somebody look into porting KDB?

  Ralf

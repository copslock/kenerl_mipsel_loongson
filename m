Received:  by oss.sgi.com id <S553915AbQJaEMX>;
	Mon, 30 Oct 2000 20:12:23 -0800
Received: from u-180.karlsruhe.ipdial.viaginterkom.de ([62.180.21.180]:2316
        "EHLO u-180.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553912AbQJaEMT>; Mon, 30 Oct 2000 20:12:19 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868674AbQJaEME>;
        Tue, 31 Oct 2000 05:12:04 +0100
Date:   Tue, 31 Oct 2000 05:12:04 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Steve Kranz <skranz@ridgerun.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: remote GDB debugging and the __init macro of init.h
Message-ID: <20001031051203.B27465@bacchus.dhis.org>
References: <39F99E20.8EE47072@ridgerun.com> <014a01c0402d$b432ada0$0deca8c0@Ulysses> <39FDB5B7.61BE2B91@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39FDB5B7.61BE2B91@mvista.com>; from jsun@mvista.com on Mon, Oct 30, 2000 at 09:53:59AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 09:53:59AM -0800, Jun Sun wrote:

> > What you've done should solve the problem, but note
> > that it has the side effect of preventing the text and data
> > sections in question from getting freed up at the end
> > of initialization.  I probably should have done so myself
> > last year when I was struggling with debugging some init
> > code using kgdb, but instead I simply got used to finding
> > the address in the symbol table and setting the breakpoints
> > by hex address instead of by symbol.
> 
> A dumb question - how do you set breakpoint at specified address?  I was
> trying to do that with "b 0xabcdabcd" or "b @0xabcdabcd", none of them
> worked.

b *0xabcdabcd

Try ``help break'' :-)

  Ralf

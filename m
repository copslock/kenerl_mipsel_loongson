Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2015 19:15:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56214 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012082AbbKTSPkWJ7eZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2015 19:15:40 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 9CB2CE116B8FA;
        Fri, 20 Nov 2015 18:15:31 +0000 (GMT)
Received: from [10.100.200.53] (10.100.200.53) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 20 Nov 2015
 18:15:33 +0000
Date:   Fri, 20 Nov 2015 18:15:32 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
CC:     Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Alex Smith <Alex.Smith@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] MIPS: Initial implementation of a VDSO
In-Reply-To: <6D39441BF12EF246A7ABCE6654B023532128FCAD@LEMAIL01.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1511201810080.6915@tp.orcam.me.uk>
References: <1443434629-14325-1-git-send-email-markos.chandras@imgtec.com>        <1443435011-17061-1-git-send-email-markos.chandras@imgtec.com> <CAOFt0_ANW6uHVU4+bTP8=oXJ8OjsEiuFPkz3GCcTZFLHs5xo4A@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B023532128FCAD@LEMAIL01.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.53]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 28 Sep 2015, Matthew Fortune wrote:

> > > +       /* lapc <symbol> is an alias to addiupc reg, <symbol> - .
> > > +        *
> > > +        * We can't use addiupc because there is no label-label
> > > +        * support for the addiupc reloc
> > > +        */
> > > +       __asm__("lapc   %0, _start                      \n"
> > > +               : "=r" (addr) : :);
> > 
> > Just curious - if lapc is just an alias to addiupc, why does that work
> > but not addiupc? IIRC I did try addiupc previously but removed it
> > because it wasn't working, didn't know about lapc!
> 
> This is just an unfortunate quirk of how the implementation is done in
> binutils. We don't recognise the special case that:
> 
> addiupc <reg>, <sym> - .
> 
> is the same as
> 
> lapc <reg>, <sym>
> 
> And therefore don't know that we can just use the MIPS_PC19_S2 reloc
> (name of that reloc may not be perfectly correct). It is a special
> case as the RHS of the expression in ADDIUPC above can be theoretically
> anything so we only support assembly time constants with addiupc.
> 
> Apart from the need to document the LAPC alias somewhere I'm not sure
> we need do anything to improve addiupc itself particularly.

 For the record -- this corresponds to how the LA macro and the 
PC-relative ADDIU instruction are handled when assembling MIPS16 code.

 And the place to document such peculiarities is obviously an assembly 
language manual.  A few have been written for the MIPS architecture 
already and with recent updates to the instruction set perhaps it is time 
for a revised edition or yet another book.

  Maciej

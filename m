Received:  by oss.sgi.com id <S42290AbQFSWF4>;
	Mon, 19 Jun 2000 15:05:56 -0700
Received: from [62.180.18.37] ([62.180.18.37]:15108 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S42239AbQFSWFl>;
	Mon, 19 Jun 2000 15:05:41 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1403524AbQFSWEz>;
        Tue, 20 Jun 2000 00:04:55 +0200
Date:   Tue, 20 Jun 2000 00:04:55 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Icache coherency problems for R3400, DS5000/240
Message-ID: <20000620000455.B27454@bacchus.dhis.org>
References: <Pine.GSO.3.96.1000619110632.10348D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1000619110632.10348D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jun 19, 2000 at 11:31:27AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jun 19, 2000 at 11:31:27AM +0200, Maciej W. Rozycki wrote:

>  Working on gdb I discovered a weird behaviour of my DS5000/240 -- under
> unspecified circumstances there were spurious breakpoint traps happening
> and some single-step breakpoints appeared persistent.  The following patch
> fixes these problems, making gdb fully reliable.
> 
>  Besides obvious bugfixes, it introduces two significant changes.  First,
> flush_icache_page() now performs what the name suggests, i.e. flushes the
> instruction cache.  Without this change ptrace(PTRACE_POKE*, ...) calls
> are unreliable.  Second, it changes the assumption of the icache line size
> to a single word -- apparently, at least R3400 of DS5000/240 has an icache
> with such a layout (DEC docs confirm it, indeed).  Without this change,
> there are problems with breakpoints placed at addresses equal 4 modulo 8. 
> 
>  I vote for an immediate inclusion of these fixes.

Looks good unless one of the R3000 gurus objects, so I'll add this right
after my ac21 commit finishes.

  Ralf

Received:  by oss.sgi.com id <S553856AbRCFDKe>;
	Mon, 5 Mar 2001 19:10:34 -0800
Received: from agile-50.OntheNet.com.au ([203.144.13.50]:32011 "EHLO
        surfers.oz.agile.tv") by oss.sgi.com with ESMTP id <S553852AbRCFDKa>;
	Mon, 5 Mar 2001 19:10:30 -0800
Received: from agile.tv (IDENT:ldavies@tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.0/8.11.0) with ESMTP id f263ARO23880;
	Tue, 6 Mar 2001 13:10:27 +1000
Message-ID: <3AA45523.CDF351CB@agile.tv>
Date:   Tue, 06 Mar 2001 13:10:27 +1000
From:   Liam Davies <ldavies@agile.tv>
Reply-To: ldavies@oz.agile.tv
Organization: Agile TV
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Troubles with TLB refills
References: <3AA30A91.B5842678@agile.tv> <20010305114926.A26862@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> This exception handler has been modified since the version tested in the
> Cobalt Qube and I'm not sure if the bug workaround actually got tested
> since then.
>

It seems to work now.

> handle_page_fault got called and printed something; therefore the
> exception handler cannot possibly have been trashed.  do_page_fault gets
> called by via the generic exception handler.  The TLB vectors there are only
> taken if there is a TLB entry matching the address in the TLB.  Therefore
> your theory about no tlb refill exception cannot be right.

And this is the way I understood the workings as well.

> The TLB
> dump only displays entries where at least on of the entry0 / entry1
> entries is valid, therefore you get an empty dump; maybe that made you
> believe you didn't get a TLB reload exception.

No, this is what I expected in the TLB since this was the first kuseg access.

Not long after posting this message I found the problem.  The exception handler

had been trashed, *before* it was copied to 0x80000000. I'm not sure what
trashed it yet, that is a job for later. What made this whole thing more
puzzling
is the actual stuff that was in 0x80000000 was absolute trash, it made no sense

in terms of instruction encodings. I would have thought the cpu would have
crapped out when it hit bad instructions. So it would seem the
exceptions were occurring but the code that it was executing wasn't even code.
Hence my assumption that we never got a TLB refill., even though the fault
handler was being called.

Liam

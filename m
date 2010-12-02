Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 15:54:28 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35037 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493237Ab0LBOyV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Dec 2010 15:54:21 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB2EsDII008409;
        Thu, 2 Dec 2010 14:54:13 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB2EsCYb008407;
        Thu, 2 Dec 2010 14:54:12 GMT
Date:   Thu, 2 Dec 2010 14:54:12 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaud Lacombe <lacombar@gmail.com>
Cc:     wu zhangjin <wuzhangjin@gmail.com>,
        John Reiser <jreiser@bitwagon.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org
Subject: Re: Build failure triggered by recordmcount
Message-ID: <20101202145412.GA7503@linux-mips.org>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
 <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
 <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
 <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 22, 2010 at 01:46:54PM -0500, Arnaud Lacombe wrote:

> On Mon, Nov 22, 2010 at 9:57 AM, wu zhangjin <wuzhangjin@gmail.com> wrote:
> > Hi,
> >
> > The cause should be the endian problem, I guess you were cross-compiling it?
> >
> yes.
> 
> > If we compile the kernel for (32bit + big endian) target on an x86
> > machine(little endian) or reversely, then, it will fail.
> >
> > Since the scripts/recordmcount is compiled with the local toolchain,
> > the data structs will be explained according to the local
> > configuration(endian...).
> >
> will it ? recordmcount.c does not switch endianness based on the host,
> but based on format of the object file, see the switch
> (ehdr->e_ident[EI_DATA]) { ... } in do_file(), the result does also
> depend a runtime endianness check.
> 
> > So, we may need to custom our own elf.h for recordmcount according to
> > the target type(endian here) of the kernel image:
> >
> > At first, pass the target information to recordmcount(only a demo
> > here, we may need to clear it carefully):

Looks all right to me.  Steven, can you merge it?

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

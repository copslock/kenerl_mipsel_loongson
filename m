Received:  by oss.sgi.com id <S42324AbQJEMPS>;
	Thu, 5 Oct 2000 05:15:18 -0700
Received: from u-143.karlsruhe.ipdial.viaginterkom.de ([62.180.18.143]:52228
        "EHLO u-143.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42201AbQJEMO5>; Thu, 5 Oct 2000 05:14:57 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868668AbQJEMNy>;
        Thu, 5 Oct 2000 14:13:54 +0200
Date:   Thu, 5 Oct 2000 14:13:54 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Dominic Sweetman <dom@algor.co.uk>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
Message-ID: <20001005141354.E30075@bacchus.dhis.org>
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39D0E51C.79A0BE50@mvista.com>; from jsun@mvista.com on Tue, Sep 26, 2000 at 11:04:12AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 11:04:12AM -0700, Jun Sun wrote:

> > > If we have to use "-mips2" option, is there a clean way which allows us
> > > to "uld/usw" instructions (instead of manually twicking the compilation
> > > for each file that uses them)?
> >
> 
> Ralf, before the perfect solution is found, the following patch makes
> the gcc complain go away.  It just use ".set mips3" pragma.

It's still perfectly broken.  Uld is a 64-bit instruction meaning you still
could get into problems with register corruption or even reserved instruction
exceptions on 32-bit cpus.  Not too mention that nobody did notice that
the constraints of the inline assembler were broken for all access sizes
plus a cast that would have cut off the upper 32 bit of a 64 bit access in
any case.  That's fixed now.

> I am pretty close to get USB running with the v2.4-test5.  The unaligned
> access is the minor problem.  The bigger problem I am fighting with now
> is bus_to_virt()/virt_to_bus() and USB interrupt.

The unaligned exception handler is fairly expensive.  I suggest you should
try to get proper alignment and where that is not possible go through
the entire code and use get_unaligned.  It's going to make a noticable
difference in performance.

  Ralf

Received:  by oss.sgi.com id <S42349AbQJESMu>;
	Thu, 5 Oct 2000 11:12:50 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:19952 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42330AbQJESMX>;
	Thu, 5 Oct 2000 11:12:23 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e95IApx03179;
	Thu, 5 Oct 2000 11:10:51 -0700
Message-ID: <39DD26CC.3805FFE8@mvista.com>
Date:   Thu, 05 Oct 2000 18:11:40 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "Kevin D. Kissell" <kevink@mips.com>,
        Dominic Sweetman <dom@algor.co.uk>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Tue, Sep 26, 2000 at 11:04:12AM -0700, Jun Sun wrote:
> 
> > > > If we have to use "-mips2" option, is there a clean way which allows us
> > > > to "uld/usw" instructions (instead of manually twicking the compilation
> > > > for each file that uses them)?
> > >
> >
> > Ralf, before the perfect solution is found, the following patch makes
> > the gcc complain go away.  It just use ".set mips3" pragma.
> 
> It's still perfectly broken.  Uld is a 64-bit instruction meaning you still
> could get into problems with register corruption or even reserved instruction
> exceptions on 32-bit cpus.  Not too mention that nobody did notice that
> the constraints of the inline assembler were broken for all access sizes
> plus a cast that would have cut off the upper 32 bit of a 64 bit access in
> any case.  That's fixed now.
> 

With my limited wisdom, I am totally confused by this paragraph.

I think you mentioned a couple of times before where 64-bit instructions
corrupt registers in 32-bit mode.  I think I have done that before with
R5000 R4500.  I did not notice any corruption.  What exactly is the
corruption you are referring to?

With the second half, are you saying the "cut-off-upper-32-bit" bug
actually hides the register corruption problem?  If so, maybe we need
the "cut-off-upper_32-bit" bug for the 32-bit MIPS tree.

Anyway, in short, what is your suggestion for fixing this bug?

Maciej suggested that we use packed struct of gcc (I assume gcc will
generate two loads and get the results with some bit masking and
shifting).  That does not sound too bad, although that does require one
to use the newer gcc.

> > I am pretty close to get USB running with the v2.4-test5.  The unaligned
> > access is the minor problem.  The bigger problem I am fighting with now
> > is bus_to_virt()/virt_to_bus() and USB interrupt.
> 
> The unaligned exception handler is fairly expensive.  I suggest you should
> try to get proper alignment and where that is not possible go through
> the entire code and use get_unaligned.  It's going to make a noticable
> difference in performance.
> 

Fortunately, the USB guys have already used get_unaligned() in all the
places - I hope.

Jun

Received:  by oss.sgi.com id <S42387AbQJEWyC>;
	Thu, 5 Oct 2000 15:54:02 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:9459 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42347AbQJEWxk>;
	Thu, 5 Oct 2000 15:53:40 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e95Mqjx14077;
	Thu, 5 Oct 2000 15:52:45 -0700
Message-ID: <39DD68DE.E9B26A3D@mvista.com>
Date:   Thu, 05 Oct 2000 22:53:34 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: load_unaligned() and "uld" instruction
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com> <011801c02f19$1283f6a0$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> 
> Jun Sun wrote:
> > "Kevin D. Kissell" wrote:
> > >
> > > > > > Ralf, before the perfect solution is found, the following patch
> makes
> > > > > > the gcc complain go away.  It just use ".set mips3" pragma.
> > >
> > > Which, as Ralf correctly observes, will generate code that will
> > > crash on 32-bit CPUs,
> >
> > Why will it crash 32-bit CPUs?  On my R5432 CPU, the lwl/lwr sequence
> > executes just fine.
> >
> > Or do you mean it will crash SOME 32-bit CPUs?  Do those 32-bit CPUs
> > support lwl or lwr?  If they don't, they should generate a reserved
> > instruction exception.  If they do, I don't see any problem.
> 
> Please re-read my previous message.  I wasn't talking about the
> MIPS I lwl/lwr sequence for loading an unaligned 32-bit word, I was
> talking about the MIPS III ldl/ldr sequence for loading an unaligned
> 64-bit doubleword.
> 
>             Kevin K.

Ahh, my bad.  

Although the usb does use get_unaligned(u64) (ldl/ldr), it actually does
not run into it - at least in my test so far.  That probably explains
why my fix runs on the R5432 CPU so far.

Ralf, I notice you have fixed it in the CVS tree.  Just did a test, and
it looks good here.

Thanks.

Jun

Received:  by oss.sgi.com id <S42347AbQJGARl>;
	Fri, 6 Oct 2000 17:17:41 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:24047 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42210AbQJGARg>;
	Fri, 6 Oct 2000 17:17:36 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e970FCx24137;
	Fri, 6 Oct 2000 17:15:12 -0700
Message-ID: <39DECDB2.5B8A9375@mvista.com>
Date:   Sat, 07 Oct 2000 00:16:02 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: load_unaligned() and "uld" instruction
References: <39CF9DFC.F30B302B@mvista.com> <200009252116.WAA01137@gladsmuir.algor.co.uk> <39CFC567.DD66BC56@mvista.com> <000d01c02782$32d31560$0deca8c0@Ulysses> <39D0E51C.79A0BE50@mvista.com> <20001005141354.E30075@bacchus.dhis.org> <39DD26CC.3805FFE8@mvista.com> <00d101c02f04$3a6d7340$0deca8c0@Ulysses> <39DD55E9.AFCACB0E@mvista.com> <20001006182821.B9061@bacchus.dhis.org> <39DE7B4D.8514FC59@mvista.com> <00e201c02fd6$9964c9c0$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> 
> Jun Sun wrote:
> > That is what the manual claims.  However I did find something strange.
> >
> > I run the following code on R5432:
> >
> > 0x8019dc34 <my_get_unaligned+4>:        ldl     $a2,7($a0)
> > 0x8019dc38 <my_get_unaligned+8>:        ldr     $a2,0($a0)
> > 0x8019dc3c <my_get_unaligned+12>:       srl     $a2,$a2,0x10
> >
> > As Kevin has guessed, it actually runs fine.  However, the register
> > content in $a2 is not right.  Basically it appears that $a2 is a 32-bit
> > register instead of 64-bit register.  I put a srl instruction to make
> > sure I was not fooled by gdb.
> 
> Please read the instruction manual for srl more closely.
> In order to preserve binary compatibility with 32-bit MIPS
> CPUs, srl, sll, and sra always work *as if* only a 32-bit register
> is implemented.  If you want to shift the full 64 bits, you need
> to use explicit 64-bit shifts: dsrl, dsll, dsra, etc.  Use a dsrl
> instead of an srl and you *may* see what you are expecting.
> 

Just re-did the test with dsrl.  It does show that the higher 32-bit are
loaded correctly by ldl/ldr.  The result still was not completely right,
due to the inline assembler bug noted by Ralf earlier.  That bug casts
off the higher 32-bit upon the function return.

Thanks, Kevin.


Jun

... learn something new each day ...

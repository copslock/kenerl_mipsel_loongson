Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4PLBfT13128
	for linux-mips-outgoing; Fri, 25 May 2001 14:11:41 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4PLBeF13125
	for <linux-mips@oss.sgi.com>; Fri, 25 May 2001 14:11:40 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA04224;
	Fri, 25 May 2001 14:11:33 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA17250;
	Fri, 25 May 2001 14:11:30 -0700 (PDT)
Message-ID: <011801c0e55f$e4d39820$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010525130531.17652A-100000@delta.ds2.pg.gda.pl>
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
Date: Fri, 25 May 2001 23:15:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>  The following program cannot be compiled with gcc 2.95.3, because the
> offset is out of range (I consider it a bug in gcc -- it should allocate
> and load a temporary register itself and pass it appropriately as %0,

I think gcc can be forgiven for not allocating a temporary,
given the ".set noat"...

> matching the "R" constraint; still it's better than generating bad code):
>
> int main(void)
> {
> int *p;
>
> asm volatile(".set push\n\t"
>   ".set noat\n\t"
> "lw $0,%0\n\t"
> ".set pop"
> :
> : "R" (p[0x10000]));
>
> return 0;
> }

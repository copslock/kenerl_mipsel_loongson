Received:  by oss.sgi.com id <S554050AbRAQOUm>;
	Wed, 17 Jan 2001 06:20:42 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:12260 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554045AbRAQOU0>;
	Wed, 17 Jan 2001 06:20:26 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA00831;
	Wed, 17 Jan 2001 15:15:24 +0100 (MET)
Date:   Wed, 17 Jan 2001 15:15:23 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ian Chilton <ian@ichilton.co.uk>,
        Ralf Baechle <ralf@uni-koblenz.de>
cc:     linux-mips@oss.sgi.com
Subject: Re: Kernel Report - 010117 (2.4.0)
In-Reply-To: <20010117125603.A29302@woody.ichilton.co.uk>
Message-ID: <Pine.GSO.3.96.1010117150114.29693B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 17 Jan 2001, Ian Chilton wrote:

> Determined physical RAM map:
>  memory: 00001000 @ 00000000 (reserved)
>  memory: 00001000 @ 00001000 (reserved)
>  memory: 001d6000 @ 08002000 (reserved)
>  memory: 00568000 @ 081d8000 (usable)
>  memory: 000c0000 @ 08740000 (ROM data)
>  memory: 05800000 @ 08800000 (usable)
[...]
> Freeing prom memory: 768kb freed
> Freeing prom memory: 768kb freed

 Good -- I was worrying if the code is able to free areas mared as "ROM
data". 

> root:~# cat /proc/iomem
> 00000000-00000fff : reserved
> 00001000-00001fff : reserved
> 08002000-081d7fff : reserved
>   08002000-08188297 : Kernel code
>   0819c300-081b23bf : Kernel data
> 081d8000-0873ffff : System RAM
> 08740000-087fffff : System RAM
> 08800000-0dffffff : System RAM

 It looks consistent with what was reported previously -- good. 

 Thanks for the report.  From your other report I see the system works
with debugging code enabled as well.  It's consistent with last Florian's,
too.  Therefore I'm considering the previous Florian's failure report an
accident. 

 I have no idea why swap doesn't work -- I'm actually running NFS-rooted
and unless I twiddle with the NBD thingy, I will not be able to test swap
anytime soon.

 The double output looks like a problem with printk.  Ralf, I recall you
made a few changes related to printk on SGI recently -- could you please
look into it?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

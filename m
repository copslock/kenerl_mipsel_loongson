Received:  by oss.sgi.com id <S42199AbQGUKXv>;
	Fri, 21 Jul 2000 03:23:51 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:26049 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42207AbQGUKXW>;
	Fri, 21 Jul 2000 03:23:22 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA06976;
	Fri, 21 Jul 2000 12:21:57 +0200 (MET DST)
Date:   Fri, 21 Jul 2000 12:21:57 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "J. Scott Kasten" <jsk@tetracon-eng.net>,
        Keith M Wesolowski <wesolows@foobazco.org>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000720142747.C26191@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1000721121201.4280C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 20 Jul 2000, Ralf Baechle wrote:

> [ralf@indy /tmp]$ echo 'main(){}' > c.c;gcc -o c c.c -lm -lieee
> collect2: ld terminated with signal 11 [Segmentation fault], core dumped

 The above example compiles fine for me natively and the resulting binary
works (i.e. it doesn't crash; what else would anyone expect from it? ;-)
).  Also I built a CVS snapshot of glibc 2.1.91 taken Jul 20th, 2000 at
2:25 UTC and it solves the libpthreads showstopper as I expected. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

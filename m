Received:  by oss.sgi.com id <S554090AbRBAPfz>;
	Thu, 1 Feb 2001 07:35:55 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:51898 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554067AbRBAPfk>;
	Thu, 1 Feb 2001 07:35:40 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA28726;
	Thu, 1 Feb 2001 16:30:48 +0100 (MET)
Date:   Thu, 1 Feb 2001 16:30:48 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc:     Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: glibc 2.2 on MIPS
In-Reply-To: <Pine.GSO.4.10.10102011611500.1855-100000@escobaria.sonytel.be>
Message-ID: <Pine.GSO.3.96.1010201162756.17657K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 1 Feb 2001, Geert Uytterhoeven wrote:

> Now it aborts later at:
> 
> | /bin/sh ./genscripts.sh . /usr/local/lib sparc-sun-solaris2.6 mipsel-unknown-linux-gnu mipsel-linux "elf32lsmip" "/usr/ccs/lib" elf32lsmip "mipsel-linux"
> | ./genscripts.sh: ./emulparams/mipsel-linux.sh: not found
> | make[3]: *** [eelf32lsmip.c] Error 1
> | make[3]: Leaving directory `/usr/people/geert.nba/mipsel-linux-binutils-2.10.1-3/binutils-2.10.1/ld'
> 
> ld/emulparams/ doesn't seem to contain any mipsel-related files.

 Now you didn't run automake in bfd. ;-)  You need to run it in ld as
well.  How about looking at the included spec file? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2TI1ib07234
	for linux-mips-outgoing; Thu, 29 Mar 2001 10:01:44 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2THuNM07111
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 09:59:38 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA16328;
	Thu, 29 Mar 2001 19:51:30 +0200 (MET DST)
Date: Thu, 29 Mar 2001 19:51:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: vhouten@kpn.com
cc: Karel van Houten <K.H.C.vanHouten@research.kpn.com>,
   Simon Gee <simong@oz.agile.tv>, linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain
In-Reply-To: <200103291728.TAA01350@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1010329194523.16049A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 29 Mar 2001, Houten K.H.C. van (Karel) wrote:

> This happens when I compile kernel 2.4.0-test9 with
> binutils 2.10.1, gcc 2.95.3, glibc 2.2.2 on my 5000/260 (R4k)
> (the same source/config compiles fine with 2.8.1/egcs-2.90.27/glibc-2.0.6):
[...]
> ./elf2ecoff /usr/src/linux/vmlinux vmlinux.ecoff -a
> wrote 20 byte file header.
> wrote 56 byte a.out header.
> wrote 240 bytes of section headers.
> wrote 4 byte pad.
> writing 30560 bytes...
> Intersegment gap (-2147256160 bytes) too large.
> make[1]: *** [vmlinux.ecoff] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.0t9-R4k/arch/mips/boot'
> make: *** [boot] Error 2

 I recall I needed to edit the ld script for linux 2.4.0-test12 that I am
currently using.  Just watch out which sections have improper addresses. 
Alternatively grab a newer version -- the script was fixed later (by Ralf,
IIRC).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

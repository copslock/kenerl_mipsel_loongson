Received:  by oss.sgi.com id <S554080AbRBAJae>;
	Thu, 1 Feb 2001 01:30:34 -0800
Received: from mail.sonytel.be ([193.74.243.200]:18136 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S554054AbRBAJaZ>;
	Thu, 1 Feb 2001 01:30:25 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA21284;
	Thu, 1 Feb 2001 10:27:45 +0100 (MET)
Date:   Thu, 1 Feb 2001 10:27:45 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc:     Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: glibc 2.2 on MIPS
In-Reply-To: <Pine.GSO.3.96.1010104222312.17873C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10102011022400.1855-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 4 Jan 2001, Maciej W. Rozycki wrote:
>  For binutils 2.10.1 the following fix makes binaries be built as ld.so
> expects.  Other fixes might be needed for 2.10.1 to work at all -- they
> are all available from: 
> ftp://ftp.ds2.pg.gda.pl/pub/macro/SRPMS/binutils-2.10.1-3.src.rpm (or use
> a mirror at: ftp://ftp.rfc822.org/pub/mirror/ftp.ds2.pg.gda.pl/...).

I tried to compile mipsel-binutils using the sources/patches in
mipsel-linux-binutils-2.10.1-3.src.rpm and got the following result:

| gcc -DHAVE_CONFIG_H -I. -I. -I. -D_GNU_SOURCE -I. -I. -I./../include
| -I./../intl -I../intl -g -O2 -W -Wall -c section.c -o section.o
| section.c:571: warning: initialization makes integer from pointer without a cast
| section.c:571: warning: initialization from incompatible pointer type
| section.c:571: warning: initialization from incompatible pointer type
| section.c:571: warning: excess elements in struct initializer
| section.c:571: warning: (near initialization for `bfd_com_section')
| section.c:572: warning: initialization makes integer from pointer without a cast
| section.c:572: warning: initialization from incompatible pointer type
| section.c:572: warning: initialization from incompatible pointer type
| section.c:572: warning: excess elements in struct initializer
| section.c:572: warning: (near initialization for `bfd_und_section')
| section.c:573: warning: initialization makes integer from pointer without a cast
| section.c:573: warning: initialization from incompatible pointer type
| section.c:573: warning: initialization from incompatible pointer type
| section.c:573: warning: excess elements in struct initializer
| section.c:573: warning: (near initialization for `bfd_abs_section')
| section.c:574: warning: initialization makes integer from pointer without a cast
| section.c:574: warning: initialization from incompatible pointer type
| section.c:574: warning: initialization from incompatible pointer type
| section.c:574: warning: excess elements in struct initializer
| section.c:574: warning: (near initialization for `bfd_ind_section')
| section.c: In function `bfd_make_section_anyway':
| section.c:712: structure has no member named `kept_section'
| make[3]: *** [section.lo] Error 1
| make[3]: Leaving directory `/usr/people/geert.nba/mipsel-linux-binutils-2.10.1-3/binutils-2.10.1/bfd'

Should we try mipsel-linux-binutils-2.10.91-1.src.rpm instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

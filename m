Received:  by oss.sgi.com id <S553826AbQJNMlu>;
	Sat, 14 Oct 2000 05:41:50 -0700
Received: from u-118.karlsruhe.ipdial.viaginterkom.de ([62.180.21.118]:52489
        "EHLO u-118.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553821AbQJNMl3>; Sat, 14 Oct 2000 05:41:29 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868617AbQJNMlM>;
        Sat, 14 Oct 2000 14:41:12 +0200
Date:   Sat, 14 Oct 2000 14:41:12 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014144112.C4396@bacchus.dhis.org>
References: <39E7EB73.9206D0DB@mvista.com> <20001014125532.A1536@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001014125532.A1536@paradigm.rfc822.org>; from flo@rfc822.org on Sat, Oct 14, 2000 at 12:55:32PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 12:55:32PM +0200, Florian Lohoff wrote:

> > 3.glibc
> > -------
> > 
> > a) the cvs tree on oss.sgi.com (v2.0.6).  Any patch needed?
> 
> *urgs* 2.0.6 - I am currently building everything against 2.0.6 but
> i rather now then later stop using it - But currently i am not using 2.2
> because with the newest patch set by Ralf (glibc + binutils) i get
> a bus error while using rpcgen with the freshly build 2.2 glibc in
> the build process ...
> 
> > Florian pointed out the following patch.  I am not 100% sure if it is
> > aginst the current sgi CVS tree.  Any confirmation?
> > 
> > ftp://ftp.rfc822.org/pub/local/debian-mips/patches/rel32-glibc.diff
> 
> This is the corresponding patch to the binutils things - Doesnt solve
> my problem though.

I got a newer libc 2.2 patch for you to try .  I'll make a new patch and
send it to you.

(All the GOT1_OK stupidity has to be removed from the patch you have.)

  Ralf

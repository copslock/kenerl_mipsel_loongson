Received:  by oss.sgi.com id <S553824AbQJNO0X>;
	Sat, 14 Oct 2000 07:26:23 -0700
Received: from u-97.karlsruhe.ipdial.viaginterkom.de ([62.180.10.97]:27914
        "EHLO u-97.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553748AbQJNO0H>; Sat, 14 Oct 2000 07:26:07 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870076AbQJNOZq>;
        Sat, 14 Oct 2000 16:25:46 +0200
Date:   Sat, 14 Oct 2000 16:25:46 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Christopher C. Chimelis" <chris@debian.org>
Cc:     Florian Lohoff <flo@rfc822.org>, Jun Sun <jsun@mvista.com>,
        linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014162546.A6206@bacchus.dhis.org>
References: <20001014125532.A1536@paradigm.rfc822.org> <Pine.LNX.4.21.0010140730280.17430-100000@spawn.hockeyfiend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010140730280.17430-100000@spawn.hockeyfiend.com>; from chris@debian.org on Sat, Oct 14, 2000 at 07:33:35AM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 07:33:35AM -0400, Christopher C. Chimelis wrote:

> > *urgs* 2.0.6 - I am currently building everything against 2.0.6 but
> > i rather now then later stop using it - But currently i am not using 2.2
> > because with the newest patch set by Ralf (glibc + binutils) i get
> > a bus error while using rpcgen with the freshly build 2.2 glibc in
> > the build process ...
> 
> Ugh.  Well, once you all figure out if binutils is to blame or if it's
> gcc, drop me a note and I'll make sure to spit out a binutils package that
> includes the good patch...

It's not obvious what's causing his problem.

Florian: Can you run elf/ld.so from your glibc 2.2 tree without any further
options or does it die?

  Ralf

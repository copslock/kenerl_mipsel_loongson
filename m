Received:  by oss.sgi.com id <S42250AbQIYUPr>;
	Mon, 25 Sep 2000 13:15:47 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.20.53]:9222 "EHLO
        u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S42201AbQIYUP0>; Mon, 25 Sep 2000 13:15:26 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869558AbQIYUOP>;
        Mon, 25 Sep 2000 22:14:15 +0200
Date:   Mon, 25 Sep 2000 22:14:14 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000925221414.A6190@bacchus.dhis.org>
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000925161500.A4773@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Sep 25, 2000 at 04:15:00PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Sep 25, 2000 at 04:15:00PM +0200, Florian Lohoff wrote:

> > > Build fails on mipsel ...
> > 
> > These messages look like file corruption.  Maybe one of the `features'
> > of the 2.4.0-test kernels and not libc at all?
> 
> I dont think so - I succeeded to compile ~2000 Packages of debian
> on this kernel and its noticeably the first execution with the "new" ld.so

I week of CPU time on an Origin building packages:  No problems ...  I'm
actually fairly close to get a RH 6.2 built - as far as that is possible
with glibc 2.0.

> LD_LIBRARY_PATH=..:../elf:../nss ../elf/ld.so.1 ./rpcgen -c rpcsvc/bootparam.x -o xbootparam.T
> /bin/sh: invalid character 45 in exportstr for full-config-sysdirs
> make[1]: *** [xbootparam.stmp] Segmentation fault

Ok, second theory.  What linker where you using to build all this programs?
The new ld.so needs to know what ld has built programs due to some pretty
stupid pre-2.9.something brokeness in R_MIPS_32 reloction handling.

  Ralf

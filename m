Received:  by oss.sgi.com id <S42310AbQIZAs3>;
	Mon, 25 Sep 2000 17:48:29 -0700
Received: from u-53.karlsruhe.ipdial.viaginterkom.de ([62.180.20.53]:57608
        "EHLO u-53.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42201AbQIZAsA>; Mon, 25 Sep 2000 17:48:00 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869539AbQIZAq4>;
        Tue, 26 Sep 2000 02:46:56 +0200
Date:   Tue, 26 Sep 2000 02:46:56 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000926024656.A8306@bacchus.dhis.org>
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org> <20000925221414.A6190@bacchus.dhis.org> <20000926010416.B3761@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000926010416.B3761@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Sep 26, 2000 at 01:04:16AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 01:04:16AM +0200, Florian Lohoff wrote:

> On Mon, Sep 25, 2000 at 10:14:14PM +0200, Ralf Baechle wrote:
> > On Mon, Sep 25, 2000 at 04:15:00PM +0200, Florian Lohoff wrote:
> > > LD_LIBRARY_PATH=..:../elf:../nss ../elf/ld.so.1 ./rpcgen -c rpcsvc/bootparam.x -o xbootparam.T
> > > /bin/sh: invalid character 45 in exportstr for full-config-sysdirs
> > > make[1]: *** [xbootparam.stmp] Segmentation fault
> > 
> > Ok, second theory.  What linker where you using to build all this programs?
> > The new ld.so needs to know what ld has built programs due to some pretty
> > stupid pre-2.9.something brokeness in R_MIPS_32 reloction handling.
> 
> egcs 1.0.3a binutils 2.8.1 (Very conservative)

That's actually the one combination I haven't tested.  Looking into it and
don't hold your breath :-(.

  Ralf

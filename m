Received:  by oss.sgi.com id <S42306AbQIYXdT>;
	Mon, 25 Sep 2000 16:33:19 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:59150 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42201AbQIYXdI>;
	Mon, 25 Sep 2000 16:33:08 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B685E812; Tue, 26 Sep 2000 01:38:50 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D5B5F9014; Tue, 26 Sep 2000 01:04:16 +0200 (CEST)
Date:   Tue, 26 Sep 2000 01:04:16 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000926010416.B3761@paradigm.rfc822.org>
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org> <20000925221414.A6190@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000925221414.A6190@bacchus.dhis.org>; from ralf@oss.sgi.com on Mon, Sep 25, 2000 at 10:14:14PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Sep 25, 2000 at 10:14:14PM +0200, Ralf Baechle wrote:
> On Mon, Sep 25, 2000 at 04:15:00PM +0200, Florian Lohoff wrote:
> > LD_LIBRARY_PATH=..:../elf:../nss ../elf/ld.so.1 ./rpcgen -c rpcsvc/bootparam.x -o xbootparam.T
> > /bin/sh: invalid character 45 in exportstr for full-config-sysdirs
> > make[1]: *** [xbootparam.stmp] Segmentation fault
> 
> Ok, second theory.  What linker where you using to build all this programs?
> The new ld.so needs to know what ld has built programs due to some pretty
> stupid pre-2.9.something brokeness in R_MIPS_32 reloction handling.

egcs 1.0.3a binutils 2.8.1 (Very conservative)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."

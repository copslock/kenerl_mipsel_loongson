Received:  by oss.sgi.com id <S42207AbQGTS6g>;
	Thu, 20 Jul 2000 11:58:36 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:2746 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42199AbQGTS6L>;
	Thu, 20 Jul 2000 11:58:11 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA20694;
	Thu, 20 Jul 2000 20:57:46 +0200 (MET DST)
Date:   Thu, 20 Jul 2000 20:57:45 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "J. Scott Kasten" <jsk@tetracon-eng.net>,
        Keith M Wesolowski <wesolows@foobazco.org>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000720142747.C26191@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1000720202344.16748F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 20 Jul 2000, Ralf Baechle wrote:

> Anyway, have you tried to rebuild an entire Linux distribution with your

 No I didn't and I don't expect anytime soon.  Basically due to the lack
of disk space and time to tweak broken RPMs.  I've effectively build 68 of
different binary RPMs so far (not counting different releases of the same
packages) and these include tools important to run a minimal system as
well as have a reasonable development environment.  These include SysVinit
2.78, bash 2.04, binutils 2.10, db 3.0.55, gcc 2.95.2, gdb 5.0, glibc
2.1.91, pam 0.72, rpm 3.0.4, and others.

> toolset, including kernel, static (Like rpm or ldconfig) and dynamic PIC
> code?  If that was successful I'd really like to recommend your toolset

 As far as I can see both statically (bash.static, rpm, ldconfig) and
dynamically linked code (almost everything else) works.  Dlopening seems
to work as NSS and PAM modules appear to work but it needs further
investigation.  Every recent failure I observed was a result of a bug in
glibc or the kernel. 

> as the new standard - especially binutils 2.8.1 are just too rotten.

 Agreed.

> Example:
> 
> [ralf@indy /tmp]$ echo 'main(){}' > c.c;gcc -o c c.c -lm -lieee
> collect2: ld terminated with signal 11 [Segmentation fault], core dumped

 This works for me with a cross-compiler from an i386 host.  I'll try it
natively at home tonight.  I don't expect a failure, though.  Gcc is
rock-solid for me for quite some time, and the last failure of binutils
I've seen was the problem of relocations in .data section in an executable
I've discussed with Ulf at the end of May.  Gcc 2.96 is just to unstable
to be used unless developing it and there is no point in using binutils
2.10.90 for most people.

> This nukes binutils 2.8.1 reliably ...  The problem is extracted from the
> INN build but also affects a few more packages.

 I will build packages progressively but bugfixes and improvements are
higher on my TODO list than a working distribution -- I can work with init
starting bash on the console. ;-)  I hope to have working libpthreads
tonight (fixes are in yesterday's changes and I have a patch to support
R3K) -- this is the last remaining obstacle that prevents me from being
able to build .mipsel.rpm packages natively (not all software cross-builds
well; glibc included).  I'll be able to test various software more
thoroughly then (though building glibc over NFS would certainly not be
running at a stunning speed, sigh...). 

 I will definitely work for getting some FTP space for RPMs.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

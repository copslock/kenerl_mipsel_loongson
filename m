Received:  by oss.sgi.com id <S553747AbRBHKUd>;
	Thu, 8 Feb 2001 02:20:33 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:50588 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553742AbRBHKUN>;
	Thu, 8 Feb 2001 02:20:13 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA29588;
	Thu, 8 Feb 2001 11:13:55 +0100 (MET)
Date:   Thu, 8 Feb 2001 11:13:55 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <3A81A3DC.E75E6045@mvista.com>
Message-ID: <Pine.GSO.3.96.1010208110748.29177A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 7 Feb 2001, Jun Sun wrote:

> I favor the libc approach as it is faster.

 No difference in speed, actually.  In both cases you switch to the kernel
mode when an FPU-related exception happens and then back to the user mode,
either after or before invoking the handler.  The libc approach has the
advantage of running unprivileged. 

> Unfortunately I don't think glibc for MIPS can be configured with
> --without-fp.  I modified a patch to get glibc 2.0.6 working for no-fp config,
> but it is not a clean one.  Is anybody working on that for the latest glibc
> 2.2?

 You never want to configure glibc with the --without-fp option.

> Ironically for MIPS you MUST have the FPU emulater when the CPU actually has a
> FPU. :-)

 The same for Alpha.  You don't need a full emulator anyway -- most of it
can be left out for FPU-equipped systems.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

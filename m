Received:  by oss.sgi.com id <S553708AbQKPMVo>;
	Thu, 16 Nov 2000 04:21:44 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:13792 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553690AbQKPMVR>;
	Thu, 16 Nov 2000 04:21:17 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA13311;
	Thu, 16 Nov 2000 13:13:41 +0100 (MET)
Date:   Thu, 16 Nov 2000 13:13:40 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Ian Chilton <ian@ichilton.co.uk>, linux-mips@oss.sgi.com,
        lfs-discuss@linuxfromscratch.org, Andreas Jaeger <aj@suse.de>
Subject: Re: User/Group Problem
In-Reply-To: <20001115085244.A5153@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001116125444.12770A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 15 Nov 2000, Ralf Baechle wrote:

> Ld.so isn't linked to the same base address as all other libraries for
> obscure reasons.  Right now dl-machine.h use the constant value of 0x5ffe0000
> as the base address which it assumes all libraries to be linked to - and that
> makes us calculate the wrong base address which we're passing to mmap.

 I don't count this as a bug.  The ELF spec allows shared objects to be
loaded with any load address.  In fact it's great we are non-standard here
-- this makes catching bugs easier.  I've already found and fixed a few
bugs in gdb thanks to this difference. 

> So we've got two bugs, not just one.  I knew about the ld.so part since
> Linux/MIPS has shared libs.  It's just that this is the first time this bug
> bites us.

 I insist there is a kernel bug only.  We might change the enforced base
address within ld.so one day to be more like other archs, but let's keep
it for now -- this really benefits.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

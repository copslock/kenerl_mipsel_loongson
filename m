Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GGk0x15287
	for linux-mips-outgoing; Mon, 16 Jul 2001 09:46:00 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GGjqV15278;
	Mon, 16 Jul 2001 09:45:52 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA00533; Mon, 16 Jul 2001 09:05:34 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA13581;
	Mon, 16 Jul 2001 14:03:31 +0200 (MET DST)
Date: Mon, 16 Jul 2001 14:03:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
In-Reply-To: <20010714125312.A6713@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010716133926.12988B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 14 Jul 2001, Ralf Baechle wrote:

> I'm just making an attempt to re-implement the ll/sc emulation as light
> as possible.  I hope to get the overhead down to the point were we don't
> need _test_and_set anymore - in any case below the overhead of a syscall.
> 
> Have you ever profiled the number of calls to MIPS_ATOMIC_SET or
> _test_and_set?  They'll be the other factor in a decission.

 I didn't profile it very extensively, yet when stracing `ls /usr/lib'
(fileutils 4.1 linked against glibc 2.2.3) on my system once I yielded
~4500 syscalls of which ~4000 were _test_and_set() (or MIPS_ATOMIC_SET,
depending on my kernel/glibc configuration) invocations.  Yes, libpthread
appears to assume atomic operations are cheap, which is justifiable as
they are indeed, for almost every other CPU type. 

 Also I feel having ll and sc opcodes in a pure MIPS I binary is somewhat
ugly (e.g. `objdump' won't disassemble them unless a MIPS II+ CPU is
specified), but I could probably live with it if performance was not
worse. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

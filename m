Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33Hf6c11348
	for linux-mips-outgoing; Tue, 3 Apr 2001 10:41:06 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33HdwM11307
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 10:40:00 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA12100;
	Tue, 3 Apr 2001 18:59:41 +0200 (MET DST)
Date: Tue, 3 Apr 2001 18:59:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@cotw.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
In-Reply-To: <3AC90E16.AEF59359@cotw.com>
Message-ID: <Pine.GSO.3.96.1010403185241.25523H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2 Apr 2001, Steven J. Hill wrote:

> Without the binutils patch, all binaries compiled for MIPS/Linux
> will be IRIX flavored which was the whole problem. I would now
> like to make 'elf[32|64]_trad[little|big]mips' be the official
> targets instead of 'elf[32|64]_[little|big]mips' which is what
> things currently are. This means changing of linker scripts in
> GLIBC as well as the Linux kernel (as far as I can tell). I would
> like to propose the any 'mips*-*-linux-gnu' and 'mips*el-*linux-gnu'
> targets be pure traditional targets WITHOUT any emulated IRIX targets
> which are the current 'elf[32|64]_[little|big]mips' targets. Please
> provide feedback, comments, etc. with justification. Thanks.

 I've reviewed the patch briefly and it appears fine in principle.  I'm
unsure about the target naming.  Since the MIPS ABI (which Linux tries to
conform to) is defined by SVR4 and IRIX defines incompatible changes, I
believe the the target SVR4 and Linux uses should be named
'elf[32|64]_bigmips' (and 'elf[32|64]_littlemips' for consistency, even
though SVR4 doesn't really define it) and the IRIX target should be named
something like 'elf[32|64]_irixbigmips'.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

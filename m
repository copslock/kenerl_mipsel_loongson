Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49EKt429096
	for linux-mips-outgoing; Wed, 9 May 2001 07:20:55 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49EKWF29090;
	Wed, 9 May 2001 07:20:33 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA09466;
	Wed, 9 May 2001 15:37:05 +0200 (MET DST)
Date: Wed, 9 May 2001 15:37:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Jaeger <aj@suse.de>
cc: "Steven J. Hill" <sjhill@cotw.com>, Florian Lohoff <flo@rfc822.org>,
   Tom Appermont <tea@sonycom.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
In-Reply-To: <ho7kzqd5kb.fsf@gee.suse.de>
Message-ID: <Pine.GSO.3.96.1010509152320.2489D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 9 May 2001, Andreas Jaeger wrote:

> >  Alternatively define rtld-oformat to elf(32|64)-trad(little|big)mips
> > where appropriate and require a minimal version of binutils in
> > sysdeps/unix/sysv/linux/mips/configure.in.  The requirement should be
> > forced anyway and I guess version 2.11.1 may be a good candidate once it's
> > out.
> 
> Let's test features and not version numbers if possible.  We have HJ
> Lu's binutils and the official binutils and we should be careful here
> testing for versions.

 You are right wrt elf(32|64)-trad(little|big)mips, indeed.  Still
released binutils before 2.11 have troubles with versioning and other bits
on MIPS and that's tough to test for.  So we should really force users to
make use of a recent enough version of binutils.  By choosing 2.11.1 as an
absolute minimum we could supposedly eliminate a test for
elf(32|64)-trad(little|big)mips, but an additional test won't hurt for
sure. 

 As to H.J.Lu's binutils I see no problem.  He consciously chose an
unambiguous versioning style, so we may have distinct rules for FSF and
H.J.Lu's binutils.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

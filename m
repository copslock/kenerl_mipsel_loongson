Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49DLSD25244
	for linux-mips-outgoing; Wed, 9 May 2001 06:21:28 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49DKQF25200;
	Wed, 9 May 2001 06:20:54 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA08596;
	Wed, 9 May 2001 15:07:59 +0200 (MET DST)
Date: Wed, 9 May 2001 15:07:59 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@cotw.com>
cc: Andreas Jaeger <aj@suse.de>, Florian Lohoff <flo@rfc822.org>,
   Tom Appermont <tea@sonycom.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
In-Reply-To: <3AF93D3F.5E57070@cotw.com>
Message-ID: <Pine.GSO.3.96.1010509144913.2489C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 9 May 2001, Steven J. Hill wrote:

> --- glibc-2.2.3/sysdeps/mips/rtld-ldscript.in   Sat Jul 12 18:23:14 1997
> +++ glibc-2.2.3-patched/sysdeps/mips/rtld-ldscript.in   Sun Apr 29 22:32:35 2001
> @@ -1,4 +1,3 @@
> -OUTPUT_FORMAT("@@rtld-oformat@@")
>  OUTPUT_ARCH(@@rtld-arch@@)
>  ENTRY(@@rtld-entry@@)
>  SECTIONS

 I guess you want to remove rtld-oformat definitions from
sysdeps/mips/mipsel/rtld-parms and sysdeps/mips/rtld-parms as well.  They
become dead code after your change.

 Alternatively define rtld-oformat to elf(32|64)-trad(little|big)mips
where appropriate and require a minimal version of binutils in
sysdeps/unix/sysv/linux/mips/configure.in.  The requirement should be
forced anyway and I guess version 2.11.1 may be a good candidate once it's
out.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

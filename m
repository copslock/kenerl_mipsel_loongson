Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4BGRbd10144
	for linux-mips-outgoing; Fri, 11 May 2001 09:27:37 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4BGR4F10128
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 09:27:05 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA10230;
	Fri, 11 May 2001 18:26:51 +0200 (MET DST)
Date: Fri, 11 May 2001 18:26:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Jaeger <aj@suse.de>
cc: sjhill@cotw.com, libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: glibc MIPS patch to check for binutils version...
In-Reply-To: <u8wv7ohw42.fsf@gromit.rhein-neckar.de>
Message-ID: <Pine.GSO.3.96.1010511182140.23383A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 11 May 2001, Andreas Jaeger wrote:

> 2001-05-11  Andreas Jaeger  <aj@suse.de>
> 
> 	* sysdeps/unix/sysv/linux/configure.in: Check binutils version on
> 	MIPS.

 Wouldn't it be cleaner if the check was placed in
sysdeps/unix/sysv/linux/mips/configure.in instead, like it's done for
Alpha?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CElLa09831
	for linux-mips-outgoing; Thu, 12 Apr 2001 07:47:21 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CEkrM09795
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 07:46:54 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA26844;
	Thu, 12 Apr 2001 16:46:32 +0200 (MET DST)
Date: Thu, 12 Apr 2001 16:46:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Michael Shmulevich <michaels@jungo.com>
cc: Linux/MIPS <linux-mips@oss.sgi.com>, FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: Dynamic linker and .interp section
In-Reply-To: <3AD5BBDF.8060101@jungo.com>
Message-ID: <Pine.GSO.3.96.1010412163645.24526C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 12 Apr 2001, Michael Shmulevich wrote:

> >  You can.  Ld never checks for its existence.
> 
> As with binutils-2.10 it is not true. Not only ld looks for it, it opens 
> the file, checks the architecture and even checks for SO_NAME (adds it 
> do NEEDS list). I have tried it several times.

 It is.  Otherwise I wouldn't be able to cross-compile and I am.  Check
whether you link against a dynamic object.  It might have the dynamic
linker as one of it's DT_NEEDED dependencies.  For example it's the case
for libc.so.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

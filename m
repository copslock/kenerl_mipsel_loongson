Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4OB1mc12202
	for linux-mips-outgoing; Thu, 24 May 2001 04:01:48 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4OB0MF12171
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 04:00:24 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA10348;
	Thu, 24 May 2001 12:56:29 +0200 (MET DST)
Date: Thu, 24 May 2001 12:56:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe deBlaquiere <jadb@redhat.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B0C89E0.2060204@redhat.com>
Message-ID: <Pine.GSO.3.96.1010524125422.6990C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 23 May 2001, Joe deBlaquiere wrote:

> Could not have said it better myself. If you have the emulation then you 
> can always use a noLLSC version of glibc if you are performance-driven. 

 I think there is some misunderstanding here -- I thought you are
recommending to drop the non-ll/sc code from glibc.

> Otherwise you can _also_ use the generic LLSC version. The overhead of 
> having a few hundreds of words of code is pretty small (compared with 
> 70+k of filenames via the BUG() macro) and ensures that either glibc 
> will work. It's the best of both worlds.

 Can't agree more.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

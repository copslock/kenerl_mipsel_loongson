Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f65IMC423906
	for linux-mips-outgoing; Thu, 5 Jul 2001 11:22:12 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f65IM7V23902
	for <linux-mips@oss.sgi.com>; Thu, 5 Jul 2001 11:22:08 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA21759;
	Thu, 5 Jul 2001 20:23:33 +0200 (MET DST)
Date: Thu, 5 Jul 2001 20:23:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Florian Lohoff <flo@rfc822.org>, Ralf Baechle <ralf@uni-koblenz.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: linux 2.4.5: sysmips(MIPS_ATOMIC_SET) is broken (yep, again...)
In-Reply-To: <3B44A91A.6AA110FC@mvista.com>
Message-ID: <Pine.GSO.3.96.1010705200310.20386C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 5 Jul 2001, Jun Sun wrote:

> That was the conclusion, but did not make to the CVS tree, probably due to
> Ralf's unwillingness to take a overhead for "flawed" CPUs.

 What overhead?  The code is conditional at the preprocessor level.

> In my last patch for Vr41xx, I have a patch for this.  Basically, I will send
> a SIGSYS if the return value is a small negative.  This will practically
> satify all the need while keep the change minimum.  The small modification to
> the semantic is not too bad at all if you consider the original syscall
> semantic is already badly broken.

 The default action for SIGSYS is to abort with a core dump, so it seems
fine here -- I don't object.  It allows us to use the normal return path,
instead of that crude jump hack, too.

 Not that I particularly care about sysmips(MIPS_ATOMIC_SET) anymore...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g77EuDRw004665
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 07:56:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g77EuDEa004664
	for linux-mips-outgoing; Wed, 7 Aug 2002 07:56:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g77Eu3Rw004645;
	Wed, 7 Aug 2002 07:56:04 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA21584;
	Wed, 7 Aug 2002 16:58:32 +0200 (MET DST)
Date: Wed, 7 Aug 2002 16:58:32 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: IPC syscall fixup (o32 conversion layer)
In-Reply-To: <3D5131C7.17F9E00@mips.com>
Message-ID: <Pine.GSO.3.96.1020807165108.18037F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 7 Aug 2002, Carsten Langgaard wrote:

> Here is a patch that fixes the ipc syscalls in the o32
> wrapper/conversion routines.
> Needed when running a 64-bit kernel on an o32 userland.

 Hmm, this looks dubious:

+#define AA(__x) ((unsigned long)((int)__x))

You probably want either:

((unsigned long)((unsigned int)__x))

or

((long)((int)__x)).

Since you are using pointers, likely the latter. 

 Sending patches within a mail's body would ease commenting them, BTW.  I
had to copy and paste the line above manually -- with gpm it's not a big
problem for a single line, but it gets tedious for larger chunks and gpm
is not everywhere. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

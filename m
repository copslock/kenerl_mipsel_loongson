Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f85LpZS32256
	for linux-mips-outgoing; Wed, 5 Sep 2001 14:51:35 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f85LpXd32253
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 14:51:33 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f85LpW129592
	for linux-mips@oss.sgi.com; Wed, 5 Sep 2001 17:51:32 -0400
Date: Wed, 5 Sep 2001 17:51:32 -0400
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: Re: segfault
Message-ID: <20010905175132.B26734@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20010904235410.A8310@neurosis.mit.edu> <20010905191550.B1054@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010905191550.B1054@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Sep 05, 2001 at 07:15:50PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Do you have a fix for the sysmips(MIPS_ATOMIC_SET) in there ? Or do
> you have the glibc compiled as -mips2 for usage of ll/sc ?

Yes, I'm pretty sure that fix is in there.  I'm confused by the whole
mips1/mips2/mips3 thing -- should I be compiling everything with the
same -mipsN, and if so, which one?  I have a VR41xx processor.  The
binaries I'm attempting to run are reported by file(1) as being MIPS 1,
while the kernel image is reported as being MIPS 3 (even though most
of the kernel Makefiles specify -mips2..?)

If I use -mips2 when compiling my userspace binaries, the output files
are the same size but different, but file(1) still reports them as
MIPS 1 and they still crash in the same way.

-jim

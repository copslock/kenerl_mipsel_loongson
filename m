Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DIxor11678
	for linux-mips-outgoing; Thu, 13 Sep 2001 11:59:50 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DIxme11675
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 11:59:48 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8DIxlB04047
	for linux-mips@oss.sgi.com; Thu, 13 Sep 2001 14:59:47 -0400
Date: Thu, 13 Sep 2001 14:59:47 -0400
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: Re: segfault
Message-ID: <20010913145947.A4031@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20010904235410.A8310@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010904235410.A8310@neurosis.mit.edu>; from jim@jtan.com on Tue, Sep 04, 2001 at 11:54:10PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I'm trying to get Linux working on my handheld PC (the Sharp Tripad,
> very similar to the Vadem Clio), but I'm having userland problems.  
> Some binaries compile and run fine, while others give a segfault right
> away.

Aha!  I think I've finally found the problem, thanks to a lightbulb
that blinked on after reading Kjeld's mail about optimization
problems.  I compile everything with -O3 (it's in my environment) and
that apparently resulted in broken binaries.  I rebuilt binutils, gcc,
glibc, and all of my test binaries with -O1.. and everything appears
to work perfectly.

(after wrestling with this for weeks on end, I feel pretty stupid that
it turned out to be something so simple, but I'm also quite elated
that it works)

Next step: conquer the world!  (or, at least, set up user-space stuff)

-jim

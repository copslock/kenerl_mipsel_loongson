Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f945GcO01378
	for linux-mips-outgoing; Wed, 3 Oct 2001 22:16:38 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f945GaD01375
	for <linux-mips@oss.sgi.com>; Wed, 3 Oct 2001 22:16:36 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f945GW319479;
	Thu, 4 Oct 2001 01:16:32 -0400
Date: Thu, 4 Oct 2001 01:16:32 -0400
From: Jim Paris <jim@jtan.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: test machines; illegal instructions
Message-ID: <20011004011632.A19472@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20010926221223.A17628@neurosis.mit.edu> <20010926202610.B7962@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010926202610.B7962@lucon.org>; from hjl@lucon.org on Wed, Sep 26, 2001 at 08:26:10PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > seen anything similar?  It's quite possibly a buggy cross compiler
> 
> I won't recommend gcc 3.0.1 for mips. My RedHat 7.1 port has everyting
> you need for cross/native compiling.

Even with the glibc and fileutils binaries from your port, 'rm' still
either segfaults or gives an illegal instruction, so it's pretty
certain that this is a kernel or CPU issue somehow.  Have you seen
anything like this?  'rm' does work if I compile fileutils with -O0,
but there still seems to be a larger problem at hand.

-jim

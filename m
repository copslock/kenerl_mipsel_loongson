Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f871ioU32325
	for linux-mips-outgoing; Thu, 6 Sep 2001 18:44:50 -0700
Received: from dea.linux-mips.net (u-187-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.187])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f871iid32321
	for <linux-mips@oss.sgi.com>; Thu, 6 Sep 2001 18:44:45 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f871hjo16275;
	Fri, 7 Sep 2001 03:43:45 +0200
Date: Fri, 7 Sep 2001 03:43:45 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: George Gensure <werkt@csh.rit.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: oops after rtc
Message-ID: <20010907034345.A16052@dea.linux-mips.net>
References: <20010907024645.A15857@dea.linux-mips.net> <Pine.SOL.4.31.0109062054550.12489-100000@fury.csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.31.0109062054550.12489-100000@fury.csh.rit.edu>; from werkt@csh.rit.edu on Thu, Sep 06, 2001 at 08:56:22PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 06, 2001 at 08:56:22PM -0400, George Gensure wrote:

> sorry, latest cvs off of oss + fast_sysmips + entry.S patches (entry.S is
> supposed to fix some build segfaults)  indy r5000, and I haven't decoded
> the oops message yet... (currently away from machine)

I'm quite certain that this isn't a RTC related oops.  I've got the
same machine and for me the kernel is locking up when remounting the root
r/w.  I'm looking into the issue but don't hold your breath, so much
to do ...

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L2xoh05426
	for linux-mips-outgoing; Wed, 20 Feb 2002 18:59:50 -0800
Received: from dea.linux-mips.net (a1as20-p220.stg.tli.de [195.252.194.220])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L2xj905423
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 18:59:46 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1L1xUD29890;
	Thu, 21 Feb 2002 02:59:30 +0100
Date: Thu, 21 Feb 2002 02:59:30 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: Robert Rusek <robru@teknuts.com>, linux-mips@oss.sgi.com
Subject: Re: Latest kernel?
Message-ID: <20020221025930.C29466@dea.linux-mips.net>
References: <000d01c1ba5a$083b1fc0$6701a8c0@computer> <20020220221507.GC29624@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020220221507.GC29624@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Feb 20, 2002 at 11:15:07PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 11:15:07PM +0100, Florian Lohoff wrote:

> > Where can I obtain the latest stable build of the kernel.  I need it to work
> > on my SGI IP22.  If possible I do not want to use CSV since I do not have a
> > high speed internet connection.  Any help would be greatly appreciated.
> 
> I dont think there are regular tarballs - Take the pain once - checkout
> the kernel and before modifying make a tarball. Then you can just
> 
> cvs -z3 update -Pd 
> 
> Your tarball all the time. BTW: You should checkout -r linux_2_4 as
> i dont think 2.5 has success reports on mips already.

I received success reports for some eval boards but at the same time
2.5 is a construction zone ...

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JAPvE11592
	for linux-mips-outgoing; Thu, 19 Jul 2001 03:25:57 -0700
Received: from dea.waldorf-gmbh.de (u-233-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.233])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JAPrV11584
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 03:25:54 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6JANPn04429;
	Thu, 19 Jul 2001 12:23:25 +0200
Date: Thu, 19 Jul 2001 12:23:24 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Barry Wu <wqb123@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: about mipsel linux thread problem
Message-ID: <20010719122324.B2422@bacchus.dhis.org>
References: <20010719030136.63012.qmail@web13905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010719030136.63012.qmail@web13905.mail.yahoo.com>; from wqb123@yahoo.com on Wed, Jul 18, 2001 at 08:01:36PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 18, 2001 at 08:01:36PM -0700, Barry Wu wrote:

> I just port mipsel linux 2.2.12 to our mips evaluation
> board, and I use glibc-2.0.6-5l and linuxthread 0.7.
> But when I run linuxthread application on it.
> The application reports "Bus error".
> I add some print information in linuxthreads source
> code, and find that when call
> linuxthreads/restart.h  suspend() function, the
> application will Bus error.
> I do not know which glibc and linuxthreads version
> can support mips linux well. And I do not know what
> the problem I meet is.

Please upgrade to glibc 2.2.x which will work much better.  Linuxthreads
is known to be broken with glibc 2.0 and nobody here intends to fix it as
glibc 2.0 is so old.

  Ralf

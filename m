Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KMc7R13096
	for linux-mips-outgoing; Fri, 20 Apr 2001 15:38:07 -0700
Received: from ayr-74.ayrnetworks.com (64-166-72-137.ayrnetworks.com [64.166.72.137])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KMc4M13086;
	Fri, 20 Apr 2001 15:38:04 -0700
Received: from ayrnetworks.com (IDENT:chua@localhost.localdomain [127.0.0.1])
	by ayr-74.ayrnetworks.com (8.11.0/8.11.0) with ESMTP id f3KMbp211392;
	Fri, 20 Apr 2001 15:37:51 -0700
Message-ID: <3AE0BA3E.A9D7658@ayrnetworks.com>
Date: Fri, 20 Apr 2001 15:37:50 -0700
From: Bryan Chua <chua@ayrnetworks.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "George Gensure,,," <werkt@csh.rit.edu>, linux-mips@oss.sgi.com
Subject: Re: glibc build
References: <3AE08A99.50201@csh.rit.edu> <3AE096DC.ECB49D19@ayrnetworks.com> <20010420182053.A7282@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

binutils 2.8.1, 2.9.1, 2.10, 2.10.1 (with and without patches) 2.11
gcc 2.95.2, 2.95.2.1, 2.95.3

The bug was that the specs file in 2.95.? seems to be missing a
-K__PIC__ in the spec for *cpp %{.S...}

It does seem to be in the current snapshot as of a few weeks ago and is
thus not necessary, but also not released.

-- bryan

Ralf Baechle wrote:

> On Fri, Apr 20, 2001 at 01:06:52PM -0700, Bryan Chua wrote:
>
> > CFLAGS=-D__PIC__ make all [check] install
> >
> > the target "check" will not work if you are cross compiling, so you
> > might as well install...  You end up coming across this in several
> > places.
>
> None of the compiler we ever recommended to use had this bug, so I
> wonder what compiler you're trying to use.
>
>   Ralf

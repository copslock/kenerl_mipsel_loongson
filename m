Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NK3OQ08750
	for linux-mips-outgoing; Mon, 23 Apr 2001 13:03:24 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3NK3MM08747
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 13:03:22 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3NK32i05855;
	Mon, 23 Apr 2001 17:03:02 -0300
Date: Mon, 23 Apr 2001 17:03:02 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Michael Shmulevich <michaels@jungo.com>
Cc: Linux/MIPS <linux-mips@oss.sgi.com>, FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: ld.so-1.9.x for mips
Message-ID: <20010423170302.E4623@bacchus.dhis.org>
References: <3AE44D0A.9080003@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE44D0A.9080003@jungo.com>; from michaels@jungo.com on Mon, Apr 23, 2001 at 06:40:58PM +0300
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 23, 2001 at 06:40:58PM +0300, Michael Shmulevich wrote:

> I have seen a compiled version of ld.so-1.9.11_mips on ftp.rfc882.com 
> site.I am searching for its sources.
> 
> Where can I find them, please?

While this package surprisingly compiles for MIPS it shouldn't be used
ever for anything on Linux/MIPS as we don't have libc4 / libc 5.  The
equivalent for libc6 aka glibc 2 is part of glibc.

Florian, can you remove this package from Debian/MIPS?

  Ralf

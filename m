Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KLLo910781
	for linux-mips-outgoing; Fri, 20 Apr 2001 14:21:50 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KLLkM10778
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 14:21:47 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3KLKri07299;
	Fri, 20 Apr 2001 18:20:53 -0300
Date: Fri, 20 Apr 2001 18:20:53 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Bryan Chua <chua@ayrnetworks.com>
Cc: "George Gensure,,," <werkt@csh.rit.edu>, linux-mips@oss.sgi.com
Subject: Re: glibc build
Message-ID: <20010420182053.A7282@bacchus.dhis.org>
References: <3AE08A99.50201@csh.rit.edu> <3AE096DC.ECB49D19@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE096DC.ECB49D19@ayrnetworks.com>; from chua@ayrnetworks.com on Fri, Apr 20, 2001 at 01:06:52PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 20, 2001 at 01:06:52PM -0700, Bryan Chua wrote:

> CFLAGS=-D__PIC__ make all [check] install
> 
> the target "check" will not work if you are cross compiling, so you
> might as well install...  You end up coming across this in several
> places.

None of the compiler we ever recommended to use had this bug, so I
wonder what compiler you're trying to use.

  Ralf

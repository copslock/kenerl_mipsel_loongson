Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49JSXT07028
	for linux-mips-outgoing; Wed, 9 May 2001 12:28:34 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49JSVF07024
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 12:28:32 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f49JQ8U02616;
	Wed, 9 May 2001 16:26:08 -0300
Date: Wed, 9 May 2001 16:26:08 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: lift the ioport_resource limit ...
Message-ID: <20010509162608.C2466@bacchus.dhis.org>
References: <3AF97FD0.7F382E49@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF97FD0.7F382E49@mvista.com>; from jsun@mvista.com on Wed, May 09, 2001 at 10:35:12AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 09, 2001 at 10:35:12AM -0700, Jun Sun wrote:

> Currently IO_SPACE_LIMIT is 0xffff, which is probably borrowed from the legacy
> i386 code.  Let us remove that limit, so that each machine does not have to
> laboriously reset it. 

ISA?

   Ralf

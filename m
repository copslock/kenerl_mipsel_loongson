Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f44ClrQ08310
	for linux-mips-outgoing; Fri, 4 May 2001 05:47:53 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f44ClpF08306
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 05:47:51 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f44CkYY01667;
	Fri, 4 May 2001 09:46:34 -0300
Date: Fri, 4 May 2001 09:46:34 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: nick@snowman.net, Matthew Dharm <mdharm@momenco.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Endianness...
Message-ID: <20010504094634.B1257@bacchus.dhis.org>
References: <Pine.LNX.4.21.0105021603030.22170-100000@ns> <3AF0724B.D74D9AF9@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF0724B.D74D9AF9@mvista.com>; from jsun@mvista.com on Wed, May 02, 2001 at 01:47:07PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 02, 2001 at 01:47:07PM -0700, Jun Sun wrote:

> BE is better known perhaps because all SGI workstations are BE.  Generally I
> found networking systems tend to use BE while consumer electronic devices tend
> to use LE (which means there are probably more MIPS CPUs running in LE.)
> 
> So far I have not found much difference in terms of endianess, although
> occassionaly you have to IO swap in drivers for BE machine.

The difference is mostly of religious nature even though I've been told
that various embedded apps can show noticable performance difference due
to byteswapping.  In general I prefer big endian because it tends to
trigger certain bugs in software more than little endian, such as accessing
a memory object with different sizes.

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fATFJGD17297
	for linux-mips-outgoing; Thu, 29 Nov 2001 07:19:16 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fATFJCo17294
	for <linux-mips@oss.sgi.com>; Thu, 29 Nov 2001 07:19:13 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fATEIva07904;
	Fri, 30 Nov 2001 01:18:57 +1100
Date: Fri, 30 Nov 2001 01:18:57 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Paul Mundt <pmundt@MVista.COM>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] const mips_io_port_base !?
Message-ID: <20011130011856.C7642@dea.linux-mips.net>
References: <20011128091655.A20264@lucon.org> <Pine.LNX.4.10.10111280921550.11130-100000@www.transvirtual.com> <20011129145513.D638@dea.linux-mips.net> <20011128201433.A30490@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011128201433.A30490@mvista.com>; from pmundt@MVista.COM on Wed, Nov 28, 2001 at 08:14:33PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 28, 2001 at 08:14:33PM -0800, Paul Mundt wrote:

> > > Ralph please apply this patch to arch/mips/kernel/setup.c. Some compilers
> > > don't like the conflict of definition in io.h and setup.c. Thanks.
> > 
> > Will do.  For curiosity's sake, which compilers do complain?
> > 
> GCC 3.0.2 was the one that complained for me.. 2.95.3 had no problems.

Thanks, fix is now in cvs.

  Ralf

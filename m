Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAT4tJ120742
	for linux-mips-outgoing; Wed, 28 Nov 2001 20:55:19 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAT4tHo20738
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 20:55:17 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAT3tDD01829;
	Thu, 29 Nov 2001 14:55:13 +1100
Date: Thu, 29 Nov 2001 14:55:13 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] const mips_io_port_base !?
Message-ID: <20011129145513.D638@dea.linux-mips.net>
References: <20011128091655.A20264@lucon.org> <Pine.LNX.4.10.10111280921550.11130-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10111280921550.11130-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, Nov 28, 2001 at 09:23:10AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 28, 2001 at 09:23:10AM -0800, James Simmons wrote:

> Ralph please apply this patch to arch/mips/kernel/setup.c. Some compilers
> don't like the conflict of definition in io.h and setup.c. Thanks.

Will do.  For curiosity's sake, which compilers do complain?

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03MvFN30818
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:57:15 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g03MvAg30815
	for <linux-mips@oss.sgi.com>; Thu, 3 Jan 2002 14:57:11 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g03LuvO04043;
	Thu, 3 Jan 2002 19:56:57 -0200
Date: Thu, 3 Jan 2002 19:56:57 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>,
   linux-mips@oss.sgi.com
Subject: Re: binutils bug workaround
Message-ID: <20020103195657.A12572@dea.linux-mips.net>
References: <Pine.LNX.4.21.0201032241030.8906-200000@melkor> <20020103135334.A3978@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020103135334.A3978@lucon.org>; from hjl@lucon.org on Thu, Jan 03, 2002 at 01:53:34PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 03, 2002 at 01:53:34PM -0800, H . J . Lu wrote:

> > 	This patch move the declaration of kswapd_wait as a workaround to
> > this compiler bug. This probably affects all mips64 kernels.
> 
> Shouldn't you fix the assmbler instead?

I absolutely agree.  The only thing I'd like to add is a some code that makes
the kernel panic if built with broken binutils.

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6KGVY29571
	for linux-mips-outgoing; Thu, 6 Dec 2001 12:16:31 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB6KGQo29565
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 12:16:27 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB6JGH811903;
	Thu, 6 Dec 2001 17:16:17 -0200
Date: Thu, 6 Dec 2001 17:16:17 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, config-patches@gnu.org
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
Message-ID: <20011206171617.B11840@dea.linux-mips.net>
References: <20011206093506.A6496@lucon.org> <20011206155724.A11083@dea.linux-mips.net> <20011206103605.A7366@lucon.org> <20011206164153.E8002@dea.linux-mips.net> <20011206105142.A7995@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206105142.A7995@lucon.org>; from hjl@lucon.org on Thu, Dec 06, 2001 at 10:51:42AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 06, 2001 at 10:51:42AM -0800, H . J . Lu wrote:

> > > How about this patch?
> > 
> > Looks good to me except that checking for __MIPSE[LB]__ should be
> > sufficient.  Anything that doesn't provide these two symbols wouldn't
> > have the chance of a snowball in hell to work.
> > 
> 
> I added those just in case someone wants to use a different compiler
> to bootstrap gcc on Linux/mips :-). I don't think it will hurt anyhing.

Sure, it won't.  And those guys who don't use a Linux/MIPS compiler seem
to be decieded to have _alot_ of extra fun anyway :-)

  Ralf

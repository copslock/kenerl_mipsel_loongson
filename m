Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6Jppv28906
	for linux-mips-outgoing; Thu, 6 Dec 2001 11:51:51 -0800
Received: from ocean.lucon.org ([12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB6Jpio28900;
	Thu, 6 Dec 2001 11:51:44 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A11E8125C1; Thu,  6 Dec 2001 10:51:42 -0800 (PST)
Date: Thu, 6 Dec 2001 10:51:42 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com, config-patches@gnu.org
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
Message-ID: <20011206105142.A7995@lucon.org>
References: <20011206093506.A6496@lucon.org> <20011206155724.A11083@dea.linux-mips.net> <20011206103605.A7366@lucon.org> <20011206164153.E8002@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206164153.E8002@dea.linux-mips.net>; from ralf@oss.sgi.com on Thu, Dec 06, 2001 at 04:41:53PM -0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 06, 2001 at 04:41:53PM -0200, Ralf Baechle wrote:
> On Thu, Dec 06, 2001 at 10:36:05AM -0800, H . J . Lu wrote:
> 
> > How about this patch?
> 
> Looks good to me except that checking for __MIPSE[LB]__ should be
> sufficient.  Anything that doesn't provide these two symbols wouldn't
> have the chance of a snowball in hell to work.
> 

I added those just in case someone wants to use a different compiler
to bootstrap gcc on Linux/mips :-). I don't think it will hurt anyhing.


H.J.

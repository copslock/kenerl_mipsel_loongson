Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB1KYF25882
	for linux-mips-outgoing; Mon, 10 Dec 2001 17:20:34 -0800
Received: from ocean.lucon.org ([12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB1KUo25879;
	Mon, 10 Dec 2001 17:20:30 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 381D5125C4; Mon, 10 Dec 2001 16:20:29 -0800 (PST)
Date: Mon, 10 Dec 2001 16:20:28 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ben Elliston <bje@redhat.com>
Cc: Daniel Jacobowitz <dan@debian.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
Message-ID: <20011210162028.A10675@lucon.org>
References: <20011210092104.A29953@nevyn.them.org> <Pine.LNX.4.33.0112110933570.17417-100000@hypatia.brisbane.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112110933570.17417-100000@hypatia.brisbane.redhat.com>; from bje@redhat.com on Tue, Dec 11, 2001 at 09:34:52AM +1000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 11, 2001 at 09:34:52AM +1000, Ben Elliston wrote:
> > > Of course, this needs some refinement.  ;-) Perhaps we need to run
> > > through $(CC_FOR_BUILD) -E or somesuch; cpp is no good, as it won't
> > > know all of the magic '*MIPS*' #defines.
> 
> > HJ's patch didn't compile anything; it ran code through
> > $(CC_FOR_BUILD) -E :)
> 
> I must admit, I missed that.  But I definitely noticed that it created 
> temporary files, which are more trouble than they're worth.  The number of 
> people running ./configure as root is frightening.

I don't want to assume $(CC_FOR_BUILD) can take - as input.


H.J.

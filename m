Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB0ZMX23406
	for linux-mips-outgoing; Mon, 10 Dec 2001 16:35:22 -0800
Received: from hypatia.brisbane.redhat.com (lulu.redhat.com.au [202.83.74.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB0ZIo23402;
	Mon, 10 Dec 2001 16:35:18 -0800
Received: from localhost (bje@localhost)
	by hypatia.brisbane.redhat.com (8.11.6/8.11.0) with ESMTP id fBANYqq17561;
	Tue, 11 Dec 2001 09:34:52 +1000
Date: Tue, 11 Dec 2001 09:34:52 +1000 (EST)
From: Ben Elliston <bje@redhat.com>
X-X-Sender:  <bje@hypatia.brisbane.redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: "H . J . Lu" <hjl@lucon.org>, Ralf Baechle <ralf@oss.sgi.com>,
   <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from
 /proc/cpuinfo?)
In-Reply-To: <20011210092104.A29953@nevyn.them.org>
Message-ID: <Pine.LNX.4.33.0112110933570.17417-100000@hypatia.brisbane.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > Of course, this needs some refinement.  ;-) Perhaps we need to run
> > through $(CC_FOR_BUILD) -E or somesuch; cpp is no good, as it won't
> > know all of the magic '*MIPS*' #defines.

> HJ's patch didn't compile anything; it ran code through
> $(CC_FOR_BUILD) -E :)

I must admit, I missed that.  But I definitely noticed that it created 
temporary files, which are more trouble than they're worth.  The number of 
people running ./configure as root is frightening.

Ben

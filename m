Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAFLGh29397
	for linux-mips-outgoing; Mon, 10 Dec 2001 07:21:16 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAFLBo29393;
	Mon, 10 Dec 2001 07:21:11 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16DRIm-0007uT-00; Mon, 10 Dec 2001 09:21:04 -0500
Date: Mon, 10 Dec 2001 09:21:04 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ben Elliston <bje@redhat.com>
Cc: "H . J . Lu" <hjl@lucon.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
Message-ID: <20011210092104.A29953@nevyn.them.org>
References: <20011206093506.A6496@lucon.org> <20011206155724.A11083@dea.linux-mips.net> <20011206103605.A7366@lucon.org> <15380.25324.287595.674046@scooby.brisbane.redhat.com> <15380.33671.382927.402138@scooby.brisbane.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15380.33671.382927.402138@scooby.brisbane.redhat.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 10, 2001 at 08:42:31PM +1100, Ben Elliston wrote:
> >>>>> "Ben" == Ben Elliston <bje@redhat.com> writes:
> 
>   Ben>   cpu=`cpp << EOF | grep ^mips
> 
> Of course, this needs some refinement.  ;-) Perhaps we need to run
> through $(CC_FOR_BUILD) -E or somesuch; cpp is no good, as it won't
> know all of the magic '*MIPS*' #defines.

HJ's patch didn't compile anything; it ran code through
$(CC_FOR_BUILD) -E :)

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

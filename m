Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAJT5l12679
	for linux-mips-outgoing; Mon, 10 Dec 2001 11:29:05 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBAJT0o12676
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 11:29:01 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBAISQM01297;
	Mon, 10 Dec 2001 16:28:26 -0200
Date: Mon, 10 Dec 2001 16:28:26 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ben Elliston <bje@redhat.com>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
Message-ID: <20011210162826.D24680@dea.linux-mips.net>
References: <20011206093506.A6496@lucon.org> <20011206155724.A11083@dea.linux-mips.net> <20011206103605.A7366@lucon.org> <15380.25324.287595.674046@scooby.brisbane.redhat.com> <15380.33671.382927.402138@scooby.brisbane.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15380.33671.382927.402138@scooby.brisbane.redhat.com>; from bje@redhat.com on Mon, Dec 10, 2001 at 08:42:31PM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 10, 2001 at 08:42:31PM +1100, Ben Elliston wrote:

>   Ben>   cpu=`cpp << EOF | grep ^mips
> 
> Of course, this needs some refinement.  ;-) Perhaps we need to run
> through $(CC_FOR_BUILD) -E or somesuch; cpp is no good, as it won't
> know all of the magic '*MIPS*' #defines.

Agreed but the basic idea is good.  Also this solution is suitable for
crosscompilation unlike the /proc/cpuinfo thing and doesn't rely on
properly installed libraries and headers might possibly of interest for
building standalone software.

  Ralf

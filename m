Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB1SNm26427
	for linux-mips-outgoing; Mon, 10 Dec 2001 17:28:23 -0800
Received: from ocean.lucon.org ([12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB1SKo26420;
	Mon, 10 Dec 2001 17:28:20 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id C9D71125C4; Mon, 10 Dec 2001 16:28:18 -0800 (PST)
Date: Mon, 10 Dec 2001 16:28:18 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ben Elliston <bje@redhat.com>
Cc: Daniel Jacobowitz <dan@debian.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
Message-ID: <20011210162818.A10808@lucon.org>
References: <20011210092104.A29953@nevyn.them.org> <Pine.LNX.4.33.0112110933570.17417-100000@hypatia.brisbane.redhat.com> <20011210162028.A10675@lucon.org> <15381.20970.104442.533926@scooby.brisbane.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15381.20970.104442.533926@scooby.brisbane.redhat.com>; from bje@redhat.com on Tue, Dec 11, 2001 at 11:23:06AM +1100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 11, 2001 at 11:23:06AM +1100, Ben Elliston wrote:
> >>>>> "H" == H J Lu <hjl@lucon.org> writes:
> 
>   H> I don't want to assume $(CC_FOR_BUILD) can take - as input.
> 
> But you can assume that you're running on a MIPS Linux system.
> 

Why can't Linux/mips have another compiler?


H.J.

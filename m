Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AHVPZ32265
	for linux-mips-outgoing; Tue, 10 Jul 2001 10:31:25 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AHVMV32261;
	Tue, 10 Jul 2001 10:31:22 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id CD903125BA; Tue, 10 Jul 2001 10:31:21 -0700 (PDT)
Date: Tue, 10 Jul 2001 10:31:21 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Jun Sun <jsun@mvista.com>, ralf@oss.sgi.com, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Re: Illegal instruction
Message-ID: <20010710103121.L19026@lucon.org>
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B4AE384.52049D47@mips.com>; from carstenl@mips.com on Tue, Jul 10, 2001 at 01:14:12PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 10, 2001 at 01:14:12PM +0200, Carsten Langgaard wrote:
> Thanks, that did the trick.
> Now I would like to try to install H.J. Lu's RedHat7.1 RPM packages.
> If I just do a:
>     rpm -Uvh --root /mnt/harddisk *.rpm

Those rpms have to be installed in the right order. I have a set up
to do that. I will see what I can do.


H.J.

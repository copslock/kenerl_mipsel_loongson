Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11Nqr021452
	for linux-mips-outgoing; Fri, 1 Feb 2002 15:52:53 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11Nqmd21449;
	Fri, 1 Feb 2002 15:52:48 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 8B15C125C3; Fri,  1 Feb 2002 14:52:44 -0800 (PST)
Date: Fri, 1 Feb 2002 14:52:44 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Carsten Langgaard <carstenl@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: fsck fails on latest 2.4 kernel
Message-ID: <20020201145244.B15521@lucon.org>
References: <20020116235232.A2760@dea.linux-mips.net> <NEBBLJGMNKKEEMNLHGAIEEDKCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIEEDKCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Fri, Feb 01, 2002 at 01:43:10PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 01:43:10PM -0800, Matthew Dharm wrote:
> Hrm... Looks like I'm getting bitten by this bug also.
> 
> I'm using H.J.'s toolchain RPMs for building the userspace
> applications, but the same tools as Carsten for building the kernel.
> I guess that combination doesn't work, either.
> 
> Unfortunately, the RPMs that H.J. has put on oss.sgi.com won't install
> on my system -- wrong version of RedHat.  And I don't see the source
> to his toolchain RPMs, so I can't rebuild it myself for the local
> libraries.

My toolchain source rpm is on oss.sgi.com:

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/SRPMS/toolchain-20011020-1.src.rpm


H.J.

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g122lkf26148
	for linux-mips-outgoing; Fri, 1 Feb 2002 18:47:46 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g122lgd26145;
	Fri, 1 Feb 2002 18:47:42 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 9AFCC125C3; Fri,  1 Feb 2002 17:47:38 -0800 (PST)
Date: Fri, 1 Feb 2002 17:47:38 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, Carsten Langgaard <carstenl@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: fsck fails on latest 2.4 kernel
Message-ID: <20020201174738.A18322@lucon.org>
References: <20020201145244.B15521@lucon.org> <NEBBLJGMNKKEEMNLHGAICEDNCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICEDNCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Fri, Feb 01, 2002 at 05:08:57PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 01, 2002 at 05:08:57PM -0800, Matthew Dharm wrote:
> As an aside, it looks like you can't rebuild this from source without
> gettext installed, but that isn't a pre-req given in the spec file.
> 
> It looks like there is code to detect gettext and substitute a local
> copy if it's not available, but that code doesn't seem to work right.
> 

There are many things left out, like gcc, binutils, glibc-devel, .....
I don't like to list all of them. It should be no different to
bootstrap gcc.


H.J.

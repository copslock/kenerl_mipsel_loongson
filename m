Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EF7F030094
	for linux-mips-outgoing; Fri, 14 Sep 2001 08:07:15 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EF7De30091
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 08:07:14 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id BDF65125C3; Fri, 14 Sep 2001 08:07:12 -0700 (PDT)
Date: Fri, 14 Sep 2001 08:07:12 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: binutils@sources.redhat.com, gdb@sourceware.cygnus.com,
   linux-mips@oss.sgi.com
Subject: Re: Continued MIPS kernel debugging symbols problem...
Message-ID: <20010914080712.A13976@lucon.org>
References: <3BA16CAA.6B4DF4A1@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA16CAA.6B4DF4A1@cotw.com>; from sjhill@cotw.com on Thu, Sep 13, 2001 at 09:34:18PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 13, 2001 at 09:34:18PM -0500, Steven J. Hill wrote:
> I did read them a few times and it appears that all the
> necessary changes are in the current gdb and insight CVS
> repositories. I checked out the latest sources a half
> hour ago and compiled both gdb and insight using the
> configuration line:
> 
>     configure --prefix=/opt/tools --target=mipsel-linux-elf
					     ^^^^^^^^^^^^^^^

I don't know if it will configure anything for Linux/mips. I use
mipsel-linux.


H.J.

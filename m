Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4BFt1e09225
	for linux-mips-outgoing; Fri, 11 May 2001 08:55:01 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4BFt0F09222
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 08:55:00 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 1F166125BA; Fri, 11 May 2001 08:54:58 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 00D67EC13; Fri, 11 May 2001 08:54:15 -0700 (PDT)
Date: Fri, 11 May 2001 08:54:15 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: glibc MIPS patch to check for binutils version...
Message-ID: <20010511085415.A1486@lucon.org>
References: <3AFBD5DE.A0457C6F@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFBD5DE.A0457C6F@cotw.com>; from sjhill@cotw.com on Fri, May 11, 2001 at 07:06:54AM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 11, 2001 at 07:06:54AM -0500, Steven J. Hill wrote:
> ***** Changelog entry *****
>         * sysdeps/mips/rtld-ldscript.in: removed unneeded binary
>         output format directive

I don't believe those rtld-ldscript.in and rtld-parms are needed for
the new MIPS toolchain at all. They may cause more trouble than
without. Could you please tell me what breaks when you remove them?
There is a chance that the old binaries compiled against glibc 2.0.x
may run with the new glibc 2.2 without those linker scripts for the
IRIX ABI.


H.J.

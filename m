Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LIDJX27439
	for linux-mips-outgoing; Sat, 21 Jul 2001 11:13:19 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LIDHV27436;
	Sat, 21 Jul 2001 11:13:17 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 788D2125BA; Sat, 21 Jul 2001 11:13:16 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 2E89AEC2D; Sat, 21 Jul 2001 11:13:16 -0700 (PDT)
Date: Sat, 21 Jul 2001 11:13:16 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Greg Satz <satz@ayrnetworks.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: SHN_MIPS_SCOMMON
Message-ID: <20010721111315.A9479@lucon.org>
References: <20010721104144.A17894@lucon.org> <B77F222C.888C%satz@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B77F222C.888C%satz@ayrnetworks.com>; from satz@ayrnetworks.com on Sat, Jul 21, 2001 at 12:12:29PM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 12:12:29PM -0600, Greg Satz wrote:
> The problem I ran into was making NFS as a kernel module. The resulting
> sunrpc.o module crashed when insmod was run over it. Ralf's fix that all
> compiles and links use -G 0 worked for me.

In that case, it is no linker bug. I believe -G 0 is required for
mips kernel modules.


H.J.

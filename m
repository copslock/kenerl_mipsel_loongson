Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5ILBSX27231
	for linux-mips-outgoing; Mon, 18 Jun 2001 14:11:28 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5ILBRV27228
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 14:11:27 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 98698125BA; Mon, 18 Jun 2001 14:11:26 -0700 (PDT)
Date: Mon, 18 Jun 2001 14:11:26 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Greg Satz <satz@ayrnetworks.com>
Cc: Brian Murphy <brian@murphy.dk>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Profiling support in glibc?
Message-ID: <20010618141126.B31621@lucon.org>
References: <3B2E5163.D130FA01@murphy.dk> <B753C92D.5ABA%satz@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B753C92D.5ABA%satz@ayrnetworks.com>; from satz@ayrnetworks.com on Mon, Jun 18, 2001 at 03:05:18PM -0600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 18, 2001 at 03:05:18PM -0600, Greg Satz wrote:
> I was able to get profiling working using glibc-2.2.2 and gcc-2.95.3. Both
> packages needed changes. The compiler had a stack misalignment correction
> for glibc. Glibc didn't save all the registers nor treat sp/fp correctly.
> Currently files compiled with -pg need to be linked -static. Specs need to
> be updated to do this automatically.
> 

The next release of my mips toolchain should be as good as the x86
version in RedHat 7.1. If you can send me patches against binutils,
glibc and gcc under

http://ftp.kernel.org/pub/linux/devel/binutils/mips/

I will take a look to see if I can include them in my next release.


H.J.

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA2Fa6C10637
	for linux-mips-outgoing; Fri, 2 Nov 2001 07:36:06 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA2Fa2010634
	for <linux-mips@oss.sgi.com>; Fri, 2 Nov 2001 07:36:02 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 24C99125C9; Fri,  2 Nov 2001 07:36:00 -0800 (PST)
Date: Fri, 2 Nov 2001 07:36:00 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: Dan Temple <dant@mips.com>, Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: BE Toolchain
Message-ID: <20011102073600.B7208@lucon.org>
References: <1004708261.31067.6.camel@localhost.localdomain> <3BE2A852.AFF0D905@mips.com> <1004710722.31067.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1004710722.31067.20.camel@localhost.localdomain>; from marc_karasek@ivivity.com on Fri, Nov 02, 2001 at 09:18:31AM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Nov 02, 2001 at 09:18:31AM -0500, Marc Karasek wrote:
> I should have been more specific,  I should have said cross-toolchain. 
> x86 -> MIPS.  I will check out the packages you mentioned below, and
> will investigate them as an option.  But as of right now, our build
> enviroment is still x86 Linux (RH 7.1).  We will be targeting a MIPS
> processor of our own, I cannot get into too many details.  We are using
> the Malta board right now for some testing/eval work.  But will be
> quickly moving to our own platform in the near future.  At that time the
> Malta will prob be put aside.  
> 

See #1 below.


H.J.
----
My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included. You may need glibc 2.2.3-11 or above to use those
rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.
3. install.tar.bz2 has some scripts to prepare NFS root and install
RedHat 7.1 on a hard drive.
4. baseline.tar.bz2 contains the cross build tree.
5. Since everything is cross compiled from x86, which is little endian,
many data files for mips, which is big endian, are either missing or
wrong. To get those data files for mips, you have to rebuild/install
the folowing rpms:

cracklib
glibc

natively on Linux/mips.

Thanks.


H.J.

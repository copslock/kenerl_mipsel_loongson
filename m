Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8860Du28268
	for linux-mips-outgoing; Fri, 7 Sep 2001 23:00:13 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8860Bd28265
	for <linux-mips@oss.sgi.com>; Fri, 7 Sep 2001 23:00:11 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E80D2125C0; Fri,  7 Sep 2001 23:00:09 -0700 (PDT)
Date: Fri, 7 Sep 2001 23:00:09 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: Update for RedHat 7.1
Message-ID: <20010907230009.A1705@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I updated a few packages, fixed a linker bug and rebuilt everything.


H.J.
----
My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included. You will need glibc 2.2.3-11 or above to use those
rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.
3. install.tar.bz2 has some scripts to prepare NFS root and install
RedHat 7.1 on a hard drive.
4. baseline.tar.bz2 contains the cross build tree.

Thanks.


H.J.

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5RIZ9124977
	for linux-mips-outgoing; Wed, 27 Jun 2001 11:35:09 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5RIZ8V24966
	for <linux-mips@oss.sgi.com>; Wed, 27 Jun 2001 11:35:08 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 516B0125BA; Wed, 27 Jun 2001 11:35:08 -0700 (PDT)
Date: Wed, 27 Jun 2001 11:35:08 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: RedHat 7.1 for mips/mipsel has been uploaded
Message-ID: <20010627113507.A11169@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The mips rpms are there and I also updated a few mipsel rpms. I
recompiled glibc without -mips2 so that it can run on MIPS I cpus.
But you may have problems with some kernels.

Let me know if you have successes or problems. I'd like to hear
stories on mips boxes since I only have mipsel.

Thanks.


H.J.
----
My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.

Thanks.


H.J.

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PNsr328487
	for linux-mips-outgoing; Mon, 25 Jun 2001 16:54:53 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PNsrV28483
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 16:54:53 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 6F295125BA; Mon, 25 Jun 2001 16:54:52 -0700 (PDT)
Date: Mon, 25 Jun 2001 16:54:52 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: RedHat 7.1 for MIPS is available
Message-ID: <20010625165452.A3723@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have uploaded the mipsel rpms. I will upload the mips rpms once the
build is finished.


H.J.
----
My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The glibc is compiled with -mips2.
2. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included.
3. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.

Thanks.


H.J.

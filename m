Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5LIsv316745
	for linux-mips-outgoing; Thu, 21 Jun 2001 11:54:57 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5LIsuV16742
	for <linux-mips@oss.sgi.com>; Thu, 21 Jun 2001 11:54:57 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 2DDB1125BA; Thu, 21 Jun 2001 11:54:55 -0700 (PDT)
Date: Thu, 21 Jun 2001 11:54:55 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: The new home of the new mips toolchain and RedHat 7.1
Message-ID: <20010621115455.A2678@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks to Ralf and SGI, I am putting the new mips toolchain and my mini
port of RedHat 7.1 for mips/mipsel at 

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

I will upload binutils, gcc andd glibc rpms first, followed by a subset
of RedHat 7.1. The whole process may take a few weeks since my network
connection is not very fast. Once the upload is done, you should be
able to put a small RedHat 7.1 on the mips/mipsel box and compile the
rest of RedHat 7.1 yourselves.

BTW, the new mips toolchain has gcc-2.96-88.1, binutils-2.11.90.0.19-1
and glibc-2.2.3-11.3. They are as good as the x86 version in RedHat
7.1. The only thing missing is gdb. I am looking forward to Daniel's
mips port.

Thanks.


H.J.

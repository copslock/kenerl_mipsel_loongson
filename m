Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UMLtp13857
	for linux-mips-outgoing; Mon, 30 Jul 2001 15:21:55 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UMLsV13854
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 15:21:54 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 02A63125C0; Mon, 30 Jul 2001 15:21:51 -0700 (PDT)
Date: Mon, 30 Jul 2001 15:21:51 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: Update for RedHat 7.1/mips
Message-ID: <20010730152151.A27066@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

FYI, I made many updates for RedHat 7.1/mips. I have added enough
stuff so that you put tegother a functional Linux server with it.


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

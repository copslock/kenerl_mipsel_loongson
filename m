Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5C43EU31157
	for linux-mips-outgoing; Mon, 11 Jun 2001 21:03:14 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5C43DV31152
	for <linux-mips@oss.sgi.com>; Mon, 11 Jun 2001 21:03:13 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 99ACA125BA; Mon, 11 Jun 2001 21:03:11 -0700 (PDT)
Date: Mon, 11 Jun 2001 21:03:11 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: A new mips toolchain is available
Message-ID: <20010611210311.A8768@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I put my new mips toolchain at

http://ftp.kernel.org/pub/linux/devel/binutils/mips/

There are source rpms for RedHat 7.1. They may only be built correctly
with rpm, especially binutils. I can provide mips and mipsel binaries
rpms for them. But it will take at least a few days.

BTW, my toolchain is for the SVR4 MIPS ABI. I don't know how compatible
it is with the IRIX ABI. Old IRIX ABI binaries seem to run fine. But I
don't know abour the IRIX ABI DSOs. Also my glibc is compiled with
-mmips2 since kernel cannot handle mips I glibc.



H.J.

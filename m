Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9PHdPV20727
	for linux-mips-outgoing; Thu, 25 Oct 2001 10:39:25 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9PHdKD20719;
	Thu, 25 Oct 2001 10:39:20 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9PHdHE0012136;
	Thu, 25 Oct 2001 10:39:17 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9PHdHNG012132;
	Thu, 25 Oct 2001 10:39:17 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 25 Oct 2001 10:39:17 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: Compile issues
In-Reply-To: <Pine.LNX.4.10.10110251019420.8950-100000@transvirtual.com>
Message-ID: <Pine.LNX.4.10.10110251038060.8950-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I get the following errors when compiling. It barfs at mips/kernel/setup.c.
I would send you a patch but I don't know what values you want to set
these to. 

setup.c: In function `cpu_probe':
setup.c:246: `PRID_REV_TX3927B' undeclared (first use in this function)
setup.c:246: (Each undeclared identifier is reported only once
setup.c:246: for each function it appears in.)
setup.c:256: `PRID_REV_TX39H3TEG' undeclared (first use in this function)
setup.c:275: `PRID_IMP_TX49' undeclared (first use in this function)

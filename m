Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PJaKB27379
	for linux-mips-outgoing; Mon, 25 Feb 2002 11:36:20 -0800
Received: from ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PJaI927376
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 11:36:18 -0800
Received: from [192.168.1.5] (IDENT:root@localhost.localdomain [127.0.0.1])
	by  ayrnetworks.com (8.11.6/8.11.2) with ESMTP id g1PIZ5e03585;
	Mon, 25 Feb 2002 10:35:05 -0800
Mime-Version: 1.0
X-Sender: kph@127.0.0.1
Message-Id: <a05100303b8a033ebf33b@[192.168.1.5]>
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICELKCFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAICELKCFAA.mdharm@momenco.com>
Date: Mon, 25 Feb 2002 10:36:09 -0800
To: "Matthew Dharm" <mdharm@momenco.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
From: Kevin Paul Herbert <kph@ayrnetworks.com>
Subject: Re: Is this a toolchain bug?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At 5:57 PM -0800 2/22/02, Matthew Dharm wrote:
>
>The toolchain I'm using is the one from oss.sgi.com by H.J. Liu
>(toolchain-20011020-1).  Because of the way the e1000 driver Makefile
>works, I'm actually compiling it using the native compiler on-target.
I just tossed out most of intel's makefile so that I could build it 
as part of our cross-build (hosted on RedHat i386), building it as a 
module. When I was using the 3.0 driver, I hacked it to be built with 
the kernel (not a module at all). It was just a few minutes of 
makefile hacking, and may save you some grief.

There is a driver V4.0.7? I *just* picked up 3.5 a little while 
ago... can you point me at where on intel's website you got your 
driver?

Thanks,
Kevin
-- 

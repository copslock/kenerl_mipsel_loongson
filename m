Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3440Ra30367
	for linux-mips-outgoing; Tue, 3 Apr 2001 21:00:27 -0700
Received: from vms4.rit.edu (vms4.isc.rit.edu [129.21.3.15])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3440RM30364
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 21:00:27 -0700
Received: from nerd-box.rit.edu ([129.21.134.39])
 by ritvax.isc.rit.edu (PMDF V5.2-32 #41784)
 with ESMTPA id <01K1ZCNMK0CAYPX5CZ@ritvax.isc.rit.edu> for
 linux-mips@oss.sgi.com; Wed, 4 Apr 2001 00:00:04 EDT
Date: Wed, 04 Apr 2001 00:03:30 -0700
From: jsc6233@ritvax.isc.rit.edu
Subject: Re: indy R5000 with irix 6.5
X-Sender: jsc6233@vmspop.isc.rit.edu
To: linux-mips@oss.sgi.com
Message-id: <5.0.0.25.0.20010404000235.00ac9c98@vmspop.isc.rit.edu>
MIME-version: 1.0
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,
I don't mean to be a complete moron but what are the EXACT steps i need to 
get a compiled kernel. I had downloaded the version 2.4 and attempted to 
make the kernel and i got syntax errors. Am I missing something??? I have 
gcc version 2.7 and cc version 7.3.
In general when looking at the various errors while compiling indy_mc.c 
they are things like not finding included files and not understanding 
declarations like
typedef __s8 int8_t;

Thanks
james

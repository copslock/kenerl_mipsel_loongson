Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g09CGip02299
	for linux-mips-outgoing; Wed, 9 Jan 2002 04:16:44 -0800
Received: from intotoinc.com (sdsl-66-80-10-146.dsl.sca.megapath.net [66.80.10.146])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g09CGgg02295
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 04:16:42 -0800
Received: from localhost (rajeshbv@localhost)
	by intotoinc.com (8.11.0/8.11.0) with ESMTP id g09BHLk21033
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 03:17:21 -0800
Date: Wed, 9 Jan 2002 03:17:21 -0800 (PST)
From: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
To: linux-mips@oss.sgi.com
Subject: Unresolved symbols while inserting a module
Message-ID: <Pine.LNX.4.21.0201090312450.20962-100000@intotoinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,

when i am trying to insert my kernel module or any sample test module on
MIPS 334A board with kernel 2.4.3, insmod is saying _gp_disp unresolved.
Can anybody point out what i am missing.

/sbin/insmod igateway.o
insmod: unresolved symbol _gp_disp

Thanks,
--Rajesh

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0IDDQs22856
	for linux-mips-outgoing; Fri, 18 Jan 2002 05:13:26 -0800
Received: from intotoinc.com (sdsl-66-80-10-146.dsl.sca.megapath.net [66.80.10.146])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0IDDNP22853
	for <linux-mips@oss.sgi.com>; Fri, 18 Jan 2002 05:13:23 -0800
Received: from localhost (rajeshbv@localhost)
	by intotoinc.com (8.11.0/8.11.0) with ESMTP id g0IDLLl10612;
	Fri, 18 Jan 2002 05:21:21 -0800
Date: Fri, 18 Jan 2002 05:21:21 -0800 (PST)
From: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
To: flo@rfc822.org
cc: linux-mips@oss.sgi.com, rajeshbv@intotoinc.com
Subject: Illegal instruction error on MIPS 79s334A with kernel version 2.4.3
Message-ID: <Pine.LNX.4.21.0201180513160.10537-100000@intotoinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,
I am facing a strange error in an user mode application. I am running this
application as daemon in background process.
The error i am getting is 

[iked:41] Illegal instruction 00000000 at 8036b364 ra=8036bb78
Got ri at 8036b624.
[iked:41] Illegal instruction 00000004 at 8036b624 ra=8036b5ec
Got ri at 8036b650.

It is continiously displaying this error upto several seconds and then
stopping. The daemon is also getting killed.
I have aplied fast-sysmips patch by florian to my kernel. Still could not
get rid
of it. Can anybody through some light on this.

Thanks,
--Rajesh

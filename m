Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f784e4p21766
	for linux-mips-outgoing; Tue, 7 Aug 2001 21:40:04 -0700
Received: from snfc21.pbi.net (mta6.snfc21.pbi.net [206.13.28.240])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f784e3V21763
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 21:40:03 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta6.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GHQ005EBFMNQ3@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Tue, 07 Aug 2001 21:40:00 -0700 (PDT)
Date: Tue, 07 Aug 2001 21:39:56 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: execve("sbin/init",argv_init,envp-init) in init() of main.c and
 sbin/init.
To: Steven Liu <stevenliu@psdc.com>
Cc: linux-mips@oss.sgi.com, dankamura@mvista.com
Reply-to: ppopov@pacbell.net
Message-id: <3B70C29C.8080803@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
References: <84CE342693F11946B9F54B18C1AB837B0A2294@ex2k.pcs.psdc.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven Liu wrote:

> Hi, ALL:
> 
> I posted a message in this board regarding
> execve("sbin/init",argv_init,envp-init) in init() of main.c this
> morning. Pete gave some very good suggessions.Thank you very much, Pete.
> I tried them but the problem has not been solved yet. My CPU is not
> standard R3000 mips CPU with some registers added in and modified. For
> example, ASID field in EntryHi register is of 8 bits instead of 6 bits.
> This may creat some problems.
> 
> I want to investigate the "sbin/init" program but I do not know where I
> can find the source code of this program. If you know any hint and let
> me know, I would be very pleased.
> 
> Thank you for your help.

If you tried sash and you couldn't run it, I strongly suggest not 
messing with /sbin/init. Work on your kernel until you can run a simple 
userland shell like sash.

Pete

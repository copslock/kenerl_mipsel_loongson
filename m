Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KHK4EC003385
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 10:20:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KHK4TA003384
	for linux-mips-outgoing; Tue, 20 Aug 2002 10:20:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from clearcore.com (clrsrv@[208.141.182.168])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KHJxEC003369
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 10:19:59 -0700
Received: (qmail 10728 invoked from network); 20 Aug 2002 17:22:51 -0000
Received: from clrsrv.clearcore.com (HELO clearcore.net) (192.168.1.1)
  by clrsrv.clearcore.com with SMTP; 20 Aug 2002 17:22:51 -0000
Message-ID: <3D627AEB.5010003@clearcore.net>
Date: Tue, 20 Aug 2002 11:22:51 -0600
From: Joe George <joeg@clearcore.net>
Organization: ClearCore
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Mips cross toolchain
References: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com> 	<3D626E61.3010505@clearcore.net> <1029862665.11391.5.camel@zeus.mvista.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Where those patches created from the sourceforge tree or you created
> them independently?  I would hate to see the two ports diverge.

I've been syncing the sf tree.

> I already sent Ralf a patch for the 36bit support.  He told me the patch
> looks fine but it doesn't seem like he's had time to merge it in.  The
> code is in sourceforge.net

My initial patches on this came from the sf tree.  Ralf called out the
endian problem.
> Again, I've done some work for big endian support and pushed it out in
> sourceforge.net because I have write access there.  Most drivers work
> just fine in BE mode.  The exception right now is the epson 1356/1386
> video controller.  There might be some others but I don't remember.
> Certainly all the SOC peripherals work fine.

The problems I'm working on are in your tlbex-mips32.S.

> If you're submitting patches in oss, please take the latest work in
> sourceforge.net first to sync up the two.  First, you might save
> yourself some work. Second, it will keep the two ports from diverging.

Couldn't of done it without your work, I really appreciate the work
you have done.

Joe

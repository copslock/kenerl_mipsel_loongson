Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2004 15:38:23 +0000 (GMT)
Received: from law10-f69.law10.hotmail.com ([IPv6:::ffff:64.4.15.69]:5136 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225336AbUCAPiV>;
	Mon, 1 Mar 2004 15:38:21 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 1 Mar 2004 07:38:09 -0800
Received: from 63.121.54.5 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 01 Mar 2004 15:38:08 GMT
X-Originating-IP: [63.121.54.5]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: kevink@mips.com, linux-mips@linux-mips.org
Cc: uhler@mips.com, dom@mips.com, echristo@redhat.com
Subject: Re: r3000 instruction set
Date: Mon, 01 Mar 2004 15:38:08 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW10-F69BVh7v5rhmI00034bc4@hotmail.com>
X-OriginalArrivalTime: 01 Mar 2004 15:38:09.0188 (UTC) FILETIME=[32B37640:01C3FFA3]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi folks

Thanks for all the information guys.  Sorry I didn't reply sooner.  I got 
buried at work with production problems but I've finally dug myself out from 
under.

It must have been a bad kaffe build.  I deleted everything, reconfigured, 
made sure I specified --with-engine=intrp and rebuilt.

Now, I'm getting signal 10.  I may need to set my stack and heap size 
smaller.  kaffe's default sizes are bigger than all the memory in my pda.

I'll let y'all know what turns up.

Mark



>From: "Kevin D. Kissell" <kevink@mips.com>
>To: "Mark and Janice Juszczec" <juszczec@hotmail.com>,        
><linux-mips@linux-mips.org>
>CC: <uhler@mips.com>, <dom@mips.com>, <echristo@redhat.com>
>Subject: Re: r3000 instruction set
>Date: Mon, 23 Feb 2004 18:21:19 +0100
>
> > Someone suggested posting the message I get.  Here it is:
> >
> > >./kaffe-bin FirstClass
> > [kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0,
> > P0_STATUS=0000500
> > pid 6: killed (signal 4)
> > >Reading command line: Try again
> > Kernel panic: Attmpted to kill int!
>
>Let me guess.  You are running little-endian.  The instruction word
>in memory would be 0x6a697406.  Do you think it's a coincidence
>that 0x6a6974 spells "jit" in ASCII?  ;o)
>
>The reported address range looks like that where kaffe builds its
>JITted instruciton buffers in MIPS/Linux.  And, like I say, JIT is
>somewhat broken for MIPS in Kaffe.  Which version of the kaffe sources
>are you building, and have you tried configuring with --with-engine=intrp
>as I suggested?
>
>             Regards,
>
>             Kevin K.

_________________________________________________________________
Click, drag and drop. My MSN is the simple way to design your homepage. 
http://click.atdmt.com/AVE/go/onm00200364ave/direct/01/

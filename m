Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 20:48:50 +0000 (GMT)
Received: from law10-f101.law10.hotmail.com ([IPv6:::ffff:64.4.15.101]:11783
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225542AbUBWUsr>; Mon, 23 Feb 2004 20:48:47 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 23 Feb 2004 12:48:39 -0800
Received: from 63.121.54.5 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 23 Feb 2004 20:48:39 GMT
X-Originating-IP: [63.121.54.5]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From:	"Mark and Janice Juszczec" <juszczec@hotmail.com>
To:	kevink@mips.com, linux-mips@linux-mips.org
Cc:	uhler@mips.com, dom@mips.com, echristo@redhat.com
Subject: Re: r3000 instruction set
Date:	Mon, 23 Feb 2004 20:48:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F10138dWMJ69i0000d0f4@hotmail.com>
X-OriginalArrivalTime: 23 Feb 2004 20:48:39.0906 (UTC) FILETIME=[6A952C20:01C3FA4E]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Kevin

Its been a few weeks since I built this version of kaffe.  The configure 
output says I did specify --with-engine=intrp.  I'll delete the compiled 
stuff, reconfigure (double checking that I give it --with-engine=intrp), 
recompile and retest.

I'll post my results.

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

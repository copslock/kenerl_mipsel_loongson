Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2003 03:54:18 +0100 (BST)
Received: from bay1-f85.bay1.hotmail.com ([IPv6:::ffff:65.54.245.85]:6928 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225213AbTECCyQ>;
	Sat, 3 May 2003 03:54:16 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 2 May 2003 19:54:07 -0700
Received: from 207.13.167.2 by by1fd.bay1.hotmail.msn.com with HTTP;
	Sat, 03 May 2003 02:54:07 GMT
X-Originating-IP: [207.13.167.2]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: ralf@linux-mips.org, kaos@sgi.com
Cc: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board -problems :(
Date: Fri, 02 May 2003 19:54:07 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F85pZpoMsDUISj00004247@hotmail.com>
X-OriginalArrivalTime: 03 May 2003 02:54:07.0775 (UTC) FILETIME=[43ECB2F0:01C3111F]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralph,

More info.

For the most part it looks like its building. But source files of some of 
the drivers are failing. Like for instance NVRAM ( nvram.c ), some file 
system files & some video driver files.

A friend of mine said this. “Do menuconfig & select the appropriate board 
option (for me it is MIPS Atlas 4Kc). And you don’t have to worry about all 
the other options (like the file systems, & device drivers) – At least to 
get it to build initially”. Is that statement right? What he meant was, when 
you select a board the remaining things get customized automatically 
according to the board option. So, if I selected Atlas 4Kc board then only 
the drivers, file systems & other modules relevant to Atlas 4Kc would get 
enabled for the build to follow. Is that right?

If that’s true, then I shouldn’t face these many number of errors when 
building FS & device driver modules.

To work around this, each time I see an error, I do “$ make ARCH=mips 
menuconfig”, go find the option corresponding to the module & disable it. So 
that those files never get built & then the build progresses a bit before it 
break again. I am yet to complete this activity (probably today after work & 
this weekend I will do this). Do you think it’s best way to go about this?

Thanks & Cheers,
-Mike.







>From: Ralf Baechle <ralf@linux-mips.org>
>To: Keith Owens <kaos@sgi.com>
>CC: Michael Anburaj <michaelanburaj@hotmail.com>,linux-mips@linux-mips.org
>Subject: Re: Linux for MIPS Atlas 4Kc board -problems :(
>Date: Sat, 3 May 2003 03:09:34 +0200
>
>On Fri, May 02, 2003 at 02:18:13PM +1000, Keith Owens wrote:
>
> > You have to specify ARCH=mips on _all_ make commands, not just make
> > *config.  Do 'make ARCH=mips' for the second one.
>
>In the MIPS kernel source I've hardwired ARCH=mips.  He'd either have
>to pass something like CROSS_COMPILE=mips-linux- or set the config
>option CONFIG_CROSSCOMPILE.
>
>   Ralf
>


_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

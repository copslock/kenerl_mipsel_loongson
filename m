Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2003 03:37:12 +0100 (BST)
Received: from bay1-f164.bay1.hotmail.com ([IPv6:::ffff:65.54.245.164]:55824
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225213AbTECChJ>; Sat, 3 May 2003 03:37:09 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 2 May 2003 19:36:55 -0700
Received: from 207.13.167.2 by by1fd.bay1.hotmail.msn.com with HTTP;
	Sat, 03 May 2003 02:36:55 GMT
X-Originating-IP: [207.13.167.2]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: ralf@linux-mips.org, kaos@sgi.com
Cc: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board -problems :(
Date: Fri, 02 May 2003 19:36:55 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F164XsFFsAitVG00004184@hotmail.com>
X-OriginalArrivalTime: 03 May 2003 02:36:55.0773 (UTC) FILETIME=[DCCDB0D0:01C3111C]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralph,

It will be great if you or any one from this forum enumerate all the build 
steps for building the Linux kernel (to work with Redboot or Flash image) 
for Atlas 4Kc board from scratch.

Development platform: Redhat Linux 9
Target Linux source: linux-mips’s CVS repository
Mips-linux tool-chain: rpm’s downloaded from link provided by linux-mips.com

I would be very much grateful for this help.

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
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 10:24:46 +0100 (BST)
Received: from bay1-f107.bay1.hotmail.com ([IPv6:::ffff:65.54.245.107]:42764
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225211AbTDKJYp>; Fri, 11 Apr 2003 10:24:45 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 11 Apr 2003 02:24:36 -0700
Received: from 4.43.152.130 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 11 Apr 2003 09:24:36 GMT
X-Originating-IP: [4.43.152.130]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Fri, 11 Apr 2003 02:24:36 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F107mJbJo9n2Lg00011ad3@hotmail.com>
X-OriginalArrivalTime: 11 Apr 2003 09:24:36.0974 (UTC) FILETIME=[2BBA40E0:01C3000C]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Thanks Ralf.

I want this question to be answered.

Can I build linux on my Win98 machine for MIPS 4Kc Atlas board using 
mipsisa32-elf-gcc & make?

Please respondwith atmost details.

Thanks,
-Mike.






>From: Ralf Baechle <ralf@linux-mips.org>
>To: Michael Anburaj <michaelanburaj@hotmail.com>
>CC: linux-mips@linux-mips.org
>Subject: Re: Linux for MIPS Atlas 4Kc board
>Date: Thu, 10 Apr 2003 03:25:29 +0200
>
>On Wed, Apr 09, 2003 at 02:32:03PM -0700, Michael Anburaj wrote:
>
> > I am new to Linux. But I have a strong ARM & MIPS background with kernel
> > porting & other stuff.
> >
> > I want to get a higher-level view of the essential components of Linux 
>for
> > MIPS & documentation about the kernel. Please point me to documents on 
>the
> > net.
>
>I suggest http://www.linux-mips.org to get started.
>
> > Question 2:
> > Does Linux-MIPS support the MIPS Atlas board with 4Kc processor using
> > mipsisa32-elf build tool chain (Contain the appropriate HAL or BSP)? Is 
>so,
> > please point me to documents that gives the exact build steps for the 
>same.
>
>No.  You must use a Linux configuration of the tools, that's mips-linux.
>
> > Also do let me know if Cygwin over Win98 dev. environment is good for
> > building & developing with Linux-MIPS or do I need to have Linux 
>installed
> > on my dev. machine?
>
>I've never use Cygwin myself.  The reports I've received are a mixed bag
>ranging from extremly bad to very good.
>
>   Ralf


_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus

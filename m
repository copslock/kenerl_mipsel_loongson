Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2003 17:09:42 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:35569 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225630AbTIZQJa>;
	Fri, 26 Sep 2003 17:09:30 +0100
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA27200;
	Fri, 26 Sep 2003 09:09:28 -0700
Subject: RE: How to increase download speed for UART
From: Pete Popov <ppopov@mvista.com>
To: Adeel Malik <AdeelM@avaznet.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <10C6C1971DA00C4BB87AC0206E3CA38264ED5F@1aurora.enabtech>
References: <10C6C1971DA00C4BB87AC0206E3CA38264ED5F@1aurora.enabtech>
Content-Type: text/plain
Organization: 
Message-Id: <1064592568.8219.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Sep 2003 09:09:28 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-09-26 at 08:41, Adeel Malik wrote:
> Yes this is an Motorola's S-Record File. Do you think that I am missing
> something?. I am using YAMON to configure the UART's settings on the board
> and HyperTerminal on the Host the transfer this file.

Yes, I think there's something definitely wrong. I wonder if the
download is even in progress... You're using windows and hyperterm? Try
it on linux but just doing "cat <srec file name>  > /dev/ttyS0",
assuming you're using the first serial port to connect to the target.
Yamon gives you feedback of the download progress by printing dots, when
downloading over ethernet. I imagine it does the same when downloading
over serial port, so if you are not seeing any progress feedback, then
perhaps that's another indication that your download is not working.

Pete

> ADEEL 
> 
> 
> -----Original Message-----
> From: Pete Popov [mailto:ppopov@mvista.com]
> Sent: Friday, September 26, 2003 8:45 PM
> To: Adeel Malik
> Cc: linux-mips@linux-mips.org
> Subject: Re: How to increase download speed for UART
> 
> 
> On Fri, 2003-09-26 at 08:32, Adeel Malik wrote:
> > Hi All,
> >          I am porting Linux to a MIPS based development platform. The
> > UART on the board provides a maximum baud rate of 115 kbps. But the
> > download time for the kernel Image of about 4.3 MB is about 4 hours
> > !!!!!. 
> 
> 4.3MB? Is this an SREC file? I've downloaded images over the serial port
> (srec files) and it takes no more than 10 minutes.
> 
> Pete
> 
> > Can someone help me address this problem ?. 
> >  
> > (I can't download the kernel image via tftp server using ethernet, as
> > the CPU doesn't have the MAC interface).
> >  
> > Regards,
> > ADEEL MALIK,
> >  
> > 
> 
> 

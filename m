Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2003 16:49:10 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:43484
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225624AbTIZPs6>; Fri, 26 Sep 2003 16:48:58 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <TPC4VWCK>; Fri, 26 Sep 2003 20:42:05 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA38264ED5F@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: RE: How to increase download speed for UART
Date: Fri, 26 Sep 2003 20:41:58 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

Yes this is an Motorola's S-Record File. Do you think that I am missing
something?. I am using YAMON to configure the UART's settings on the board
and HyperTerminal on the Host the transfer this file.

ADEEL 


-----Original Message-----
From: Pete Popov [mailto:ppopov@mvista.com]
Sent: Friday, September 26, 2003 8:45 PM
To: Adeel Malik
Cc: linux-mips@linux-mips.org
Subject: Re: How to increase download speed for UART


On Fri, 2003-09-26 at 08:32, Adeel Malik wrote:
> Hi All,
>          I am porting Linux to a MIPS based development platform. The
> UART on the board provides a maximum baud rate of 115 kbps. But the
> download time for the kernel Image of about 4.3 MB is about 4 hours
> !!!!!. 

4.3MB? Is this an SREC file? I've downloaded images over the serial port
(srec files) and it takes no more than 10 minutes.

Pete

> Can someone help me address this problem ?. 
>  
> (I can't download the kernel image via tftp server using ethernet, as
> the CPU doesn't have the MAC interface).
>  
> Regards,
> ADEEL MALIK,
>  
> 

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2003 16:45:34 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:35573 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225624AbTIZPpc>;
	Fri, 26 Sep 2003 16:45:32 +0100
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA26179;
	Fri, 26 Sep 2003 08:45:28 -0700
Subject: Re: How to increase download speed for UART
From: Pete Popov <ppopov@mvista.com>
To: Adeel Malik <AdeelM@avaznet.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <10C6C1971DA00C4BB87AC0206E3CA38264ED5E@1aurora.enabtech>
References: <10C6C1971DA00C4BB87AC0206E3CA38264ED5E@1aurora.enabtech>
Content-Type: text/plain
Organization: 
Message-Id: <1064591128.8219.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Sep 2003 08:45:28 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

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

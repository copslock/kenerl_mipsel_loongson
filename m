Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2003 19:16:03 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:13281 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225633AbTIZSP6>;
	Fri, 26 Sep 2003 19:15:58 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h8QIDUYY029420;
	Fri, 26 Sep 2003 11:13:30 -0700 (PDT)
Received: from xchange.mips.com (xchange [192.168.20.31])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA08662;
	Fri, 26 Sep 2003 11:16:52 -0700 (PDT)
Received: by xchange.mips.com with Internet Mail Service (5.5.2653.19)
	id <TVNB9C1L>; Fri, 26 Sep 2003 11:13:06 -0700
Message-ID: <0C5F4C7A1E3ED51194E200508B2CE32A02264DC1@xchange.mips.com>
From: "Mitchell, Earl" <earlm@mips.com>
To: "'Pete Popov'" <ppopov@mvista.com>,
	Adeel Malik <AdeelM@avaznet.com>
Cc: linux-mips@linux-mips.org
Subject: RE: How to increase download speed for UART
Date: Fri, 26 Sep 2003 11:13:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips

You can also get a probe with
ethernet support and do it that
way. 

-earlm

-----Original Message-----
From: Mitchell, Earl [mailto:earlm@mips.com]
Sent: Friday, September 26, 2003 11:04 AM
To: 'Pete Popov'; Adeel Malik
Cc: linux-mips@linux-mips.org
Subject: RE: How to increase download speed for UART



YAMON only prints '.' feedback for 
ethernet download, unless you modified it.
Download a copy of TeraTerm and use that
instead of Hyperterminal. Then you can use
the "Send File" command under File pulldown.
This gives you feedback showing how many
bytes have been transferred. 

I was able to load a 6.4MB linux srec
image in 27 minutes on my Malta 4Kc board
with baud rate set to 38.4K. Using TFTP 
over ethernet it takes 17 seconds. Another
alternative is to consider buying an EJTAG probe 
and loading thru that. The probes will probably load
something this size within 1-4 minutes. This
is assuming you have EJTAG interface available.
But I wouldn't buy a probe just to download
code. ;-) 

-earlm

-----Original Message-----
From: Pete Popov [mailto:ppopov@mvista.com]
Sent: Friday, September 26, 2003 9:09 AM
To: Adeel Malik
Cc: linux-mips@linux-mips.org
Subject: RE: How to increase download speed for UART


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

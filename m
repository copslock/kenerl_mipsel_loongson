Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2003 07:14:32 +0100 (BST)
Received: from futarque.com ([IPv6:::ffff:212.242.80.58]:39698 "HELO
	mail.futarque.com") by linux-mips.org with SMTP id <S8225373AbTI2GO3>;
	Mon, 29 Sep 2003 07:14:29 +0100
Received: (qmail 4505 invoked by uid 64014); 29 Sep 2003 06:14:20 -0000
Received: from smm@futarque.com by mail by uid 64011 with qmail-scanner-1.16 
 (uvscan: v4.1.60/v4278. spamassassin: 2.55.  Clear:. 
 Processed in 1.037044 secs); 29 Sep 2003 06:14:20 -0000
Received: from excalibur.futarque.com (192.168.2.15)
  by mail.futarque.com with SMTP; 29 Sep 2003 06:14:18 -0000
Subject: RE: How to increase download speed for UART
From: Steffen Malmgaard Mortensen <smm@futarque.com>
To: linux-mips@linux-mips.org
In-Reply-To: <0C5F4C7A1E3ED51194E200508B2CE32A02264DC1@xchange.mips.com>
References: <0C5F4C7A1E3ED51194E200508B2CE32A02264DC1@xchange.mips.com>
Content-Type: text/plain
Message-Id: <1064816058.3675.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Sep 2003 08:14:18 +0200
Content-Transfer-Encoding: 7bit
Return-Path: <smm@futarque.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: smm@futarque.com
Precedence: bulk
X-list: linux-mips

Hi
I have experienced the same problem with HyperTerminal on Win2000. There
are a number of freeware terminal emulators for Win2000 (eg.
http://home.planet.nl/~ruurdb/IVT.HTM), so you could try one of those if
you can't use linux.
Good luck
/Steffen

On Fri, 2003-09-26 at 20:13, Mitchell, Earl wrote:
> You can also get a probe with
> ethernet support and do it that
> way. 
> 
> -earlm
> 
> -----Original Message-----
> From: Mitchell, Earl [mailto:earlm@mips.com]
> Sent: Friday, September 26, 2003 11:04 AM
> To: 'Pete Popov'; Adeel Malik
> Cc: linux-mips@linux-mips.org
> Subject: RE: How to increase download speed for UART
> 
> 
> 
> YAMON only prints '.' feedback for 
> ethernet download, unless you modified it.
> Download a copy of TeraTerm and use that
> instead of Hyperterminal. Then you can use
> the "Send File" command under File pulldown.
> This gives you feedback showing how many
> bytes have been transferred. 
> 
> I was able to load a 6.4MB linux srec
> image in 27 minutes on my Malta 4Kc board
> with baud rate set to 38.4K. Using TFTP 
> over ethernet it takes 17 seconds. Another
> alternative is to consider buying an EJTAG probe 
> and loading thru that. The probes will probably load
> something this size within 1-4 minutes. This
> is assuming you have EJTAG interface available.
> But I wouldn't buy a probe just to download
> code. ;-) 
> 
> -earlm
> 
> -----Original Message-----
> From: Pete Popov [mailto:ppopov@mvista.com]
> Sent: Friday, September 26, 2003 9:09 AM
> To: Adeel Malik
> Cc: linux-mips@linux-mips.org
> Subject: RE: How to increase download speed for UART
> 
> 
> On Fri, 2003-09-26 at 08:41, Adeel Malik wrote:
> > Yes this is an Motorola's S-Record File. Do you think that I am missing
> > something?. I am using YAMON to configure the UART's settings on the board
> > and HyperTerminal on the Host the transfer this file.
> 
> Yes, I think there's something definitely wrong. I wonder if the
> download is even in progress... You're using windows and hyperterm? Try
> it on linux but just doing "cat <srec file name>  > /dev/ttyS0",
> assuming you're using the first serial port to connect to the target.
> Yamon gives you feedback of the download progress by printing dots, when
> downloading over ethernet. I imagine it does the same when downloading
> over serial port, so if you are not seeing any progress feedback, then
> perhaps that's another indication that your download is not working.
> 
> Pete
> 
> > ADEEL 
> > 
> > 
> > -----Original Message-----
> > From: Pete Popov [mailto:ppopov@mvista.com]
> > Sent: Friday, September 26, 2003 8:45 PM
> > To: Adeel Malik
> > Cc: linux-mips@linux-mips.org
> > Subject: Re: How to increase download speed for UART
> > 
> > 
> > On Fri, 2003-09-26 at 08:32, Adeel Malik wrote:
> > > Hi All,
> > >          I am porting Linux to a MIPS based development platform. The
> > > UART on the board provides a maximum baud rate of 115 kbps. But the
> > > download time for the kernel Image of about 4.3 MB is about 4 hours
> > > !!!!!. 
> > 
> > 4.3MB? Is this an SREC file? I've downloaded images over the serial port
> > (srec files) and it takes no more than 10 minutes.
> > 
> > Pete
> > 
> > > Can someone help me address this problem ?. 
> > >  
> > > (I can't download the kernel image via tftp server using ethernet, as
> > > the CPU doesn't have the MAC interface).
> > >  
> > > Regards,
> > > ADEEL MALIK,
> > >  
> > > 
> > 
> > 
> 
> 

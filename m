Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 06:45:08 +0100 (BST)
Received: from smtp800.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.168.179]:940
	"HELO smtp800.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225204AbTI3Fo5>; Tue, 30 Sep 2003 06:44:57 +0100
Received: from adsl-67-122-221-97.dsl.snfc21.pacbell.net (HELO 192.168.0.100) (narendrasankar@67.122.221.97 with plain)
  by smtp-sbc-v1.mail.vip.sc5.yahoo.com with SMTP; 30 Sep 2003 05:44:50 -0000
From: Narendra Sankar <narendrasankar@yahoo.com>
To: Adeel Malik <AdeelM@avaznet.com>
Subject: Re: How to increase download speed for UART
Date: Mon, 29 Sep 2003 22:44:38 -0700
User-Agent: KMail/1.5.9
Cc: linux-mips@linux-mips.org
References: <10C6C1971DA00C4BB87AC0206E3CA38264ED84@1aurora.enabtech>
In-Reply-To: <10C6C1971DA00C4BB87AC0206E3CA38264ED84@1aurora.enabtech>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309292244.38657.narendrasankar@yahoo.com>
Return-Path: <narendrasankar@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: narendrasankar@yahoo.com
Precedence: bulk
X-list: linux-mips

The limitation on download speeds would be determined by the UART on the PC 
you are using. PCs are typically limited to 115200 because of the clock 
generator they use for the UART. However you can buy add-on cards that can 
support up to the 1.5MBaud rate of the 16550. Your local computer store 
should carry one of these. They typically plugin to a PCI slot and you should 
be able to blast down the kernel image to your board.  That is the best way 
to get the 406kbps your board supports.
Also instead of an SREC image, you can tryout the LSI fast-load format. It is 
a base64 encoded image, that some firmware supports (pmon for example). A 
fast-load kernel image is around 1/2 the size of a SREC. I can get a kernel 
image of around 5MB to download in 3 minutes or so via 115200.

Hope that helps
Naren
On Monday 29 September 2003 12:41 am, Adeel Malik wrote:
> Hi,
>     The terminal emulator that you specified supports the max. baud rate of
> 115.2 kbps. And it is taking about 7 minutes to download the Kernel Image
> of 4.3 MB. Do you know some other Terminal Emulator that can support a
> higher baud rate ?.
>
> The UART of the target processor supports the max. baud rate of 406 kbps.
> So I can use the terminal emulator that supports for example, 406kbps, then
> my download time may be further reduced.
>
> Regards,
>
> ADEEL MALIK,
>
>
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Steffen Malmgaard
> Mortensen
> Sent: Monday, September 29, 2003 11:14 AM
> To: linux-mips@linux-mips.org
> Subject: RE: How to increase download speed for UART
>
>
> Hi
> I have experienced the same problem with HyperTerminal on Win2000. There
> are a number of freeware terminal emulators for Win2000 (eg.
> http://home.planet.nl/~ruurdb/IVT.HTM), so you could try one of those if
> you can't use linux.
> Good luck
> /Steffen
>
> On Fri, 2003-09-26 at 20:13, Mitchell, Earl wrote:
> > You can also get a probe with
> > ethernet support and do it that
> > way.
> >
> > -earlm
> >
> > -----Original Message-----
> > From: Mitchell, Earl [mailto:earlm@mips.com]
> > Sent: Friday, September 26, 2003 11:04 AM
> > To: 'Pete Popov'; Adeel Malik
> > Cc: linux-mips@linux-mips.org
> > Subject: RE: How to increase download speed for UART
> >
> >
> >
> > YAMON only prints '.' feedback for
> > ethernet download, unless you modified it.
> > Download a copy of TeraTerm and use that
> > instead of Hyperterminal. Then you can use
> > the "Send File" command under File pulldown.
> > This gives you feedback showing how many
> > bytes have been transferred.
> >
> > I was able to load a 6.4MB linux srec
> > image in 27 minutes on my Malta 4Kc board
> > with baud rate set to 38.4K. Using TFTP
> > over ethernet it takes 17 seconds. Another
> > alternative is to consider buying an EJTAG probe
> > and loading thru that. The probes will probably load
> > something this size within 1-4 minutes. This
> > is assuming you have EJTAG interface available.
> > But I wouldn't buy a probe just to download
> > code. ;-)
> >
> > -earlm
> >
> > -----Original Message-----
> > From: Pete Popov [mailto:ppopov@mvista.com]
> > Sent: Friday, September 26, 2003 9:09 AM
> > To: Adeel Malik
> > Cc: linux-mips@linux-mips.org
> > Subject: RE: How to increase download speed for UART
> >
> > On Fri, 2003-09-26 at 08:41, Adeel Malik wrote:
> > > Yes this is an Motorola's S-Record File. Do you think that I am missing
> > > something?. I am using YAMON to configure the UART's settings on the
>
> board
>
> > > and HyperTerminal on the Host the transfer this file.
> >
> > Yes, I think there's something definitely wrong. I wonder if the
> > download is even in progress... You're using windows and hyperterm? Try
> > it on linux but just doing "cat <srec file name>  > /dev/ttyS0",
> > assuming you're using the first serial port to connect to the target.
> > Yamon gives you feedback of the download progress by printing dots, when
> > downloading over ethernet. I imagine it does the same when downloading
> > over serial port, so if you are not seeing any progress feedback, then
> > perhaps that's another indication that your download is not working.
> >
> > Pete
> >
> > > ADEEL
> > >
> > >
> > > -----Original Message-----
> > > From: Pete Popov [mailto:ppopov@mvista.com]
> > > Sent: Friday, September 26, 2003 8:45 PM
> > > To: Adeel Malik
> > > Cc: linux-mips@linux-mips.org
> > > Subject: Re: How to increase download speed for UART
> > >
> > > On Fri, 2003-09-26 at 08:32, Adeel Malik wrote:
> > > > Hi All,
> > > >          I am porting Linux to a MIPS based development platform. The
> > > > UART on the board provides a maximum baud rate of 115 kbps. But the
> > > > download time for the kernel Image of about 4.3 MB is about 4 hours
> > > > !!!!!.
> > >
> > > 4.3MB? Is this an SREC file? I've downloaded images over the serial
> > > port (srec files) and it takes no more than 10 minutes.
> > >
> > > Pete
> > >
> > > > Can someone help me address this problem ?.
> > > >
> > > > (I can't download the kernel image via tftp server using ethernet, as
> > > > the CPU doesn't have the MAC interface).
> > > >
> > > > Regards,
> > > > ADEEL MALIK,

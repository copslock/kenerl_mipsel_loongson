Received:  by oss.sgi.com id <S553931AbQLABRx>;
	Thu, 30 Nov 2000 17:17:53 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60421 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S553928AbQLABRX>; Thu, 30 Nov 2000 17:17:23 -0800
Received: from sgisgp.singapore.sgi.com (sgisgp.singapore.sgi.com [134.14.84.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id RAA07643
	for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 17:25:24 -0800 (PST)
	mail_from (calvine@sgi.com)
Received: from sgp-apsa001e--n.singapore.sgi.com by sgisgp.singapore.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id JAA22496; Fri, 1 Dec 2000 09:26:44 +0800
Received: by sgp-apsa001e--n.singapore.sgi.com with Internet Mail Service (5.5.2650.21)
	id <XQ01WM2A>; Fri, 1 Dec 2000 09:20:23 +0800
Message-ID: <43FECA7CDC4CD411A4A3009027999112267CAD@sgp-apsa001e--n.singapore.sgi.com>
From:   Calvine Chew <calvine@sgi.com>
To:     "'Klaus Naumann'" <spock@mgnet.de>
Cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        "'J. Scott Kasten'" <jsk@tetracon-eng.net>
Subject: RE: I'm stuck...
Date:   Fri, 1 Dec 2000 09:20:15 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> -----Original Message-----
> From: Klaus Naumann [mailto:spock@mgnet.de]
> Sent: Friday, December 01, 2000 5:30 AM
> To: Calvine Chew
> Cc: 'linux-mips@oss.sgi.com'
> Subject: RE: I'm stuck...
> 
> 
> [snipped verbose message]
> 
> Calvine, what I'm asking myself is, if the box actually has connection
> to the net. Becuase if you don't get a single packet out on bootp time
> then something really is broken. So please try to check in any way if
> the box has netconn - does it have an AUI ? Some SGI systems seem
> to use that as first ethernet adapter and have problems with it ...
> 
Well, the good news is I've finally gotten my Indy to see my boot server.
When testing outgoing packets by configuring both server and client to the
SGI network, I discovered that my 2nd PCMCIA port, for some reason doesn't
configure any PCMCIA cards properly (same thing happened to my SCSI card,
but
I thought it was an isolated incident). Switching to the 1st port made 
everything work.

Unfortunately tftp isn't working. I have it configured using in.tftpd 
wrapped to tcpd, but when the Indy tries to get the bootfile, it says
"TFTP error: File not found (code 1)". The boopd does respond with the
seemingly correct messages but I am not sure if in.tftpd is working
or not. I have bootpd running on standalone (non-inetd) mode because
in.bootpd didn't work too. However I don't have tftpd. *groan*

Have to look into that later...

PS, Scott, I'm not using DHCP, but bootpd. Do I still need to configure
dhcp too? I assume that subnet entry excerpt is from dhcpd.conf?



--
Calvine Chew, Technical Consultant
Technology & Industry Consulting Group (Asia South), SGI.
***************************************************************
Inter spem curamque, timores inter et iras, omnem crede diem tibi
diluxisse supremum: grata superveniet quae sperabitur hora.
http://www.cyberjunkie.com/arcana
***************************************************************

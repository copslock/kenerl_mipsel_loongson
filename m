Received:  by oss.sgi.com id <S553935AbQLABdD>;
	Thu, 30 Nov 2000 17:33:03 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:54793 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S553932AbQLABcj>; Thu, 30 Nov 2000 17:32:39 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA04256
	for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 17:40:42 -0800 (PST)
	mail_from (calvine@sgi.com)
Received: from sgisgp.singapore.sgi.com (sgisgp.singapore.sgi.com [134.14.84.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via SMTP id RAA06696 for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 17:32:05 -0800 (PST)
Received: from sgp-apsa001e--n.singapore.sgi.com by sgisgp.singapore.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id JAA22741; Fri, 1 Dec 2000 09:40:24 +0800
Received: by sgp-apsa001e--n.singapore.sgi.com with Internet Mail Service (5.5.2650.21)
	id <XQ01WM2V>; Fri, 1 Dec 2000 09:34:03 +0800
Message-ID: <43FECA7CDC4CD411A4A3009027999112267CAE@sgp-apsa001e--n.singapore.sgi.com>
From:   Calvine Chew <calvine@sgi.com>
To:     "'Klaus Naumann'" <spock@mgnet.de>,
        "'J. Scott Kasten'" <jsk@tetracon-eng.net>
Cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: I'm stuck...
Date:   Fri, 1 Dec 2000 09:33:59 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Klaus and Scott.

Got tftp to work... damn! Linux in.tftpd didn't like the "-s" flag in
inetd.conf. Once that was gone, the HardHat install fired up!

Thanks all!!

--
Calvine Chew, Technical Consultant
Technology & Industry Consulting Group (Asia South), SGI.
***************************************************************
Inter spem curamque, timores inter et iras, omnem crede diem tibi
diluxisse supremum: grata superveniet quae sperabitur hora.
http://www.cyberjunkie.com/arcana
***************************************************************





> -----Original Message-----
> From: Klaus Naumann [mailto:spock@mgnet.de]
> Sent: Friday, December 01, 2000 5:30 AM
> To: Calvine Chew
> Cc: 'linux-mips@oss.sgi.com'
> Subject: RE: I'm stuck...
> 
> 
> On Thu, 30 Nov 2000, Calvine Chew wrote:
> 
> > Hi Klaus...
> > 
> > I would have installed RedHat 6.2 (like a trueblue SGI-man :-) but
> > the boot kernel hits the PC Card Services hang on installation.
> > SuSE 6.4 doesn't, hooked up my ethernet/modem and scsi 
> cards beautifully.
> 
> It's ok - I was just kiddin' because it's known that I'm not a big fan
> of the SuSE distribution for several reasons - but I'm far away from
> wanting to start a distro war here. So to make it clear I really was
> joking.
> 
> [snipped verbose message]
> 
> Calvine, what I'm asking myself is, if the box actually has connection
> to the net. Becuase if you don't get a single packet out on bootp time
> then something really is broken. So please try to check in any way if
> the box has netconn - does it have an AUI ? Some SGI systems seem
> to use that as first ethernet adapter and have problems with it ...
> 
> 			HTH, Klaus
> 
> -- 
> Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
> Nickname    : Spock             | Org.: Mad Guys Network
> Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
> PGP Key     : www.mgnet.de/keys/key_spock.txt
> 

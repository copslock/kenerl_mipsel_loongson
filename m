Received:  by oss.sgi.com id <S553945AbQLAGyh>;
	Thu, 30 Nov 2000 22:54:37 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:44831 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553941AbQLAGyG>;
	Thu, 30 Nov 2000 22:54:06 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id WAA18959
	for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 22:54:05 -0800 (PST)
	mail_from (calvine@sgi.com)
Received: from sgisgp.singapore.sgi.com (sgisgp.singapore.sgi.com [134.14.84.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via SMTP id WAA22245 for <linux-mips@oss.sgi.com>; Thu, 30 Nov 2000 22:52:16 -0800 (PST)
Received: from sgp-apsa001e--n.singapore.sgi.com by sgisgp.singapore.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	for <linux-mips@oss.sgi.com> id PAA26927; Fri, 1 Dec 2000 15:00:40 +0800
Received: by sgp-apsa001e--n.singapore.sgi.com with Internet Mail Service (5.5.2650.21)
	id <XQ01WMTD>; Fri, 1 Dec 2000 14:54:20 +0800
Message-ID: <43FECA7CDC4CD411A4A3009027999112267CB3@sgp-apsa001e--n.singapore.sgi.com>
From:   Calvine Chew <calvine@sgi.com>
To:     "'linux-mips'" <linux-mips@oss.sgi.com>
Subject: Xwindows/XFree86 in HardHat?
Date:   Fri, 1 Dec 2000 14:54:19 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi folks!

Does HardHat include some form of Xwindows? There are some xwindows
files in the distribution, but I can't fire up xwindows (some files seem to
be
missing). I did notice that HardHat included only one XF86 server
(XF68_FBDev)
but if I used that, startx reports a X11TransSocketUNIXConnect errno 146.
Do I need to install the latest XFree86 distribution (4.0.1), or is there
some
other things I can fiddle with in the config files?

TIA!!

--
Calvine Chew, Technical Consultant
Technology & Industry Consulting Group (Asia South), SGI.
***************************************************************
Inter spem curamque, timores inter et iras, omnem crede diem tibi
diluxisse supremum: grata superveniet quae sperabitur hora.
http://www.cyberjunkie.com/arcana
***************************************************************

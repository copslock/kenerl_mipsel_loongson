Received:  by oss.sgi.com id <S553704AbQLAHUH>;
	Thu, 30 Nov 2000 23:20:07 -0800
Received: from mx.mips.com ([206.31.31.226]:29329 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553756AbQLAHTt>;
	Thu, 30 Nov 2000 23:19:49 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA12900;
	Thu, 30 Nov 2000 23:19:17 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA26101;
	Thu, 30 Nov 2000 23:19:32 -0800 (PST)
Message-ID: <001901c05b67$8c88ab60$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Jesse Dyson" <jesse@winston-salem.com>,
        "Klaus Naumann" <spock@mgnet.de>, <linux-mips@oss.sgi.com>
References: <Pine.LNX.4.10.10011300938100.6504-100000@mail.netunlimited.net> <00f601c05ae8$19014500$0deca8c0@Ulysses> <20001201005942.A6172@bacchus.dhis.org>
Subject: Re: Indigo2 Kernel Boots!!!
Date:   Fri, 1 Dec 2000 08:22:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


> > When the init process fires up, it opens /dev/console as the
> > console output device.  A default SGI workstation installation
> > file system will have /dev/console bound to the major/minor device
> > node of the graphics display console.  If you want to run with a serial
> > console, you must therefore change this to bind /dev/console
> > to the serial port.  You can do this by doing an explicit mknod,
> > or by linking to the appropriate serial port device node,
> > which is usually /dev/ttyS0.
>
> Which both are wrong.  /dev/console should be a char device major 5, minor
1.
> There is no need to change this ever except for very old kernels.  With
2.2
> or 2.4 whenever people change /dev/console's major/minor it's usually
painting
> over some bug.

Having been through the exercise a dozen or more times with
the SGI 2.2 kernel distributions for the Indy, I would be fascinated
to know what bug I was painting over, and where the correct
procedure was documented.

            Kevin K.

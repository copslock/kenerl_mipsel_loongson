Received:  by oss.sgi.com id <S553879AbQK3QHh>;
	Thu, 30 Nov 2000 08:07:37 -0800
Received: from mx.mips.com ([206.31.31.226]:38019 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553876AbQK3QH0>;
	Thu, 30 Nov 2000 08:07:26 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA04037;
	Thu, 30 Nov 2000 08:06:58 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA29697;
	Thu, 30 Nov 2000 08:07:17 -0800 (PST)
Message-ID: <00f601c05ae8$19014500$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jesse Dyson" <jesse@winston-salem.com>,
        "Klaus Naumann" <spock@mgnet.de>
Cc:     <linux-mips@oss.sgi.com>
References: <Pine.LNX.4.10.10011300938100.6504-100000@mail.netunlimited.net>
Subject: Re: Indigo2 Kernel Boots!!!
Date:   Thu, 30 Nov 2000 17:10:32 +0100
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

> I'm not exactly sure what this means to "link" /dev/console.  Based on the
> FAQ (http://foobazco.org/~weslows/Install-HOWTO.html), I shouldn't have to
> do the inittab stuff since I am in ser port 1.  I noticed I do not have an
> /etc/inittab file in my root fs, but there is a inittabold.  Is there
> something with these files I have to fix or do I do an 'ln -s' or
> something on the /dev/console and point it to /dev/ttyS0?

When the init process fires up, it opens /dev/console as the
console output device.  A default SGI workstation installation
file system will have /dev/console bound to the major/minor device
node of the graphics display console.  If you want to run with a serial
console, you must therefore change this to bind /dev/console
to the serial port.  You can do this by doing an explicit mknod,
or by linking to the appropriate serial port device node,
which is usually /dev/ttyS0.

            Kevin K.

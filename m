Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OJ83U31744
	for linux-mips-outgoing; Tue, 24 Apr 2001 12:08:03 -0700
Received: from mail5.svr.pol.co.uk (mail5.svr.pol.co.uk [195.92.193.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3OJ82M31741
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 12:08:02 -0700
Received: from modem-421.hodad.dialup.pol.co.uk ([62.25.161.165] helo=derfel)
	by mail5.svr.pol.co.uk with smtp (Exim 3.13 #0)
	id 14s8AK-0002Pm-00
	for linux-mips@oss.sgi.com; Tue, 24 Apr 2001 20:08:00 +0100
From: "Andrew Linfoot" <alinfoot@escafeldcomputing.co.uk>
To: <linux-mips@oss.sgi.com>
Subject: RE: Passing kernel args
Date: Tue, 24 Apr 2001 20:09:13 +0100
Message-ID: <000701c0ccf2$1029ca20$0101a8c0@derfel>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <20010422001440.A1191@bilbo.physik.uni-konstanz.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Just thought i would let you know of my experience with autobooting.

I'm having the same problems as Dave in that i must specify a space in
the OSLoadOptions " root=/dev/sda1 ro". However every time i shutdown or
reboot it is truncated to OSLoadOptions= root=/dev/s meaning i have to reset
it after every reboot.

any ideas as to what may be causing this?
I am runnning on an Indy R5K

Also i am using an ELF kernel and not ECOFF as specified in Guido's howto.

Cheers
Andy

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4BNc2wJ029699
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 11 May 2002 16:38:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4BNc2kZ029698
	for linux-mips-outgoing; Sat, 11 May 2002 16:38:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from postfix1-2.free.fr (postfix1-2.free.fr [213.228.0.130])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4BNbmwJ029692
	for <linux-mips@oss.sgi.com>; Sat, 11 May 2002 16:37:48 -0700
Received: from yak (lyon-2-a7-62-147-23-243.dial.proxad.net [62.147.23.243])
	by postfix1-2.free.fr (Postfix) with SMTP
	id 229D0AB34D; Sun, 12 May 2002 01:04:27 +0200 (CEST)
Message-ID: <007001c1f940$ba95b0c0$011e1ec0@home>
From: "nsauzede" <nsauzede@online.fr>
To: "James Simmons" <jsimmons@transvirtual.com>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.LNX.4.10.10205091055260.9983-100000@www.transvirtual.com>
Subject: Re: Debian on Indy.
Date: Sun, 12 May 2002 01:08:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Okay. Got it to boot. Now it fails with a bunch of SCSI errors. After it
> complained it hanged. Any ideas or do you need th exact SCSI errors?


Just for info : I managed to have the Debian Woody to work fine on my Indy
(kernel is 2.4.13 if I remember well...)

But when I tried to boot some kernel 2.5.?? (can't remember last number -- I
fetched the source from CVS) I cross compiled on an i386 platform, I got the
same problem : bootup crashes at SCSI probing time...

Must be some kind of SCSI code regression or something..

I think I already posted my problem to the list but didn't get reply....

Nicolas Sauzede.

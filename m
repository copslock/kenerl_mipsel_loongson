Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TIfnnC025466
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 11:41:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TIfntC025465
	for linux-mips-outgoing; Wed, 29 May 2002 11:41:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TIfjnC025462
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 11:41:45 -0700
Received: from lahoo.mshome.net (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02191
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 11:42:57 -0700 (PDT)
	mail_from (brad@ltc.com)
Received: from prefect.mshome.net ([192.168.0.76] helo=prefect)
	by lahoo.mshome.net with smtp (Exim 3.12 #1 (Debian))
	id 17D7BN-0005CP-00; Wed, 29 May 2002 13:24:21 -0400
Message-ID: <00fd01c20735$de410760$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Brian Murphy" <brian@murphy.dk>
Cc: "linux-mips" <linux-mips@oss.sgi.com>
References: <3CF4CA8C.9040802@murphy.dk> <009701c2072b$2b1e2820$4c00a8c0@prefect> <3CF50A5A.9020807@murphy.dk>
Subject: Re: ioremap?
Date: Wed, 29 May 2002 13:25:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----- Original Message -----
From: "Brian Murphy" <brian@murphy.dk>
Cc: "linux-mips" <linux-mips@oss.sgi.com>
Sent: Wednesday, May 29, 2002 1:05 PM
Subject: Re: ioremap?


> Bradley D. LaRonde wrote:
>
> >Looks like those are for io (inb, outb, etc.) not mem (readb, writeb,
etc.).
> >io addresses shouldn't be ioremapped.
> >
> O.K.  I have now used set_io_port_base to set the base address to KSEG1.
> What should be ioremapped then?

Any address passed to readb, writeb, etc.  For example, a PCI mem resource
address.

Regards,
Brad

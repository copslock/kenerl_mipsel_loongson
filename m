Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KIiDEC005383
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 11:44:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KIiDdJ005382
	for linux-mips-outgoing; Tue, 20 Aug 2002 11:44:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from medtron.medtronic.com (medtron.medtronic.COM [144.15.157.122])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KIi7EC005366
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 11:44:07 -0700
Received: from RADIUM (localhost [127.0.0.1])
	by medtron.medtronic.com (8.10.1/8.10.1) with SMTP id g7KIl1x07008;
	Tue, 20 Aug 2002 13:47:01 -0500 (CDT)
From: "Lyle Bainbridge" <lyle@zevion.com>
To: "Joe George" <joeg@clearcore.net>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: Mips cross toolchain
Date: Tue, 20 Aug 2002 13:47:01 -0500
Message-ID: <NCBBKGDBOEEBDOELAFOFAEGKCPAA.lyle@zevion.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-reply-to: <3D626E61.3010505@clearcore.net>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



-----Original Message-----
From: Joe George [mailto:joeg@clearcore.net]
Sent: Tuesday, August 20, 2002 11:29 AM
To: Lyle Bainbridge
Cc: linux-mips@oss.sgi.com
Subject: Re: Mips cross toolchain


>>I don't know of anyone using big endian with Alchemy at this point.
>>There may be some and I'd like to hear from them.


Firstly, thanks to everyone for the advice.

Ideally I'd use big endian.  Is there any reason the toolchain
wouldn't support this.  I'm only using the Au1500 on-chip peripherals
with the addition of an external Highpoint HPT371 ATA controller.

Thanks
Lyle

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 14:32:03 +0000 (GMT)
Received: from hnet1.camc.org ([IPv6:::ffff:206.193.127.2]:14525 "EHLO
	mail2.camcare.com") by linux-mips.org with ESMTP
	id <S8225209AbTA0OcC>; Mon, 27 Jan 2003 14:32:02 +0000
Received: from KES.camcare.com (IS~KES [10.10.95.4]) by mail2.camcare.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2650.21)
	id DVDH2825; Mon, 27 Jan 2003 09:32:01 -0500
Received: by KES.camcare.com with Internet Mail Service (5.5.2650.21)
	id <D1M7RFC7>; Mon, 27 Jan 2003 09:31:54 -0500
Message-ID: <490E0430C3C72046ACF7F18B7CD76A2A568F70@KES.camcare.com>
From: "Smith, Todd" <Todd.Smith@camc.org>
To: linux-mips@linux-mips.org
Subject: You need help!
Date: Mon, 27 Jan 2003 09:31:48 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Todd.Smith@camc.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Todd.Smith@camc.org
Precedence: bulk
X-list: linux-mips

Hello Maciej,

You are sick and twisted but your testing plan will certainly find bugs. :)
My only question is how to tell the bugs from one package to the other. :)

Thanks for all of the hard work.

Todd Smith <todd.smith@camc.org>

-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@ds2.pg.gda.pl]
Sent: Monday, January 27, 2003 7:04 AM
To: Ralf Baechle
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux


On Mon, 27 Jan 2003, Ralf Baechle wrote:

> > Log message:
> > 	Fix a restoration of assembler's settings in csum_ipv6_magic().
> 
> Wow, how did you catch this one - running IPv6?

 I do run IPv6 -- I get to my 32-bit box with SSH over IPv6 just to make
sure I'll find more bugs (the previous one was the multicast filter). ;-) 
I even have ipv6.o as a module (which also triggered bugs in the past). 
Will have to try with the 64-bit box. ;-)))

 But this bug I've actually spotted studying compiler's diagnostic output
-- a "Macro instruction expanded into multiple instructions in a branch
delay slot" warning isn't normal for a .c file. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

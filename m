Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3CHmk8d016018
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 10:48:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3CHmkgi016017
	for linux-mips-outgoing; Fri, 12 Apr 2002 10:48:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ns1.ltc.com (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3CHm48d015964
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 10:48:39 -0700
Received: from prefect (prefect.mshome.net [192.168.0.76])
	by ns1.ltc.com (Postfix) with SMTP
	id 9A7B4590B2; Fri, 12 Apr 2002 13:44:08 -0400 (EDT)
Message-ID: <00e601c1e24a$4d7bc9a0$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020412185401.14896A-100000@delta.ds2.pg.gda.pl>
Subject: Re: Can modules be stripped?
Date: Fri, 12 Apr 2002 13:48:48 -0400
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
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Scott A McConnell" <samcconn@cotw.com>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Sent: Friday, April 12, 2002 12:57 PM
Subject: Re: Can modules be stripped?


> On Fri, 12 Apr 2002, Scott A McConnell wrote:
>
> > If I strip a module, insmod dies in obj_load() with Floating point
> > exception.
>
>  You can't strip modules as they are relocatables -- global symbols and
> relocations have to stay intact.

OK, you can't strip kernel modules (news to me, then again how often do I
use modules?), but it can't be because they "are relocatables".  I routinely
strip libraries without problem, and those are relocatables too.

So what's the real reason?

Regards,
Brad

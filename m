Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3CJAR8d021351
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 12:10:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3CJAR4D021350
	for linux-mips-outgoing; Fri, 12 Apr 2002 12:10:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ns1.ltc.com (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3CJA68d021332
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 12:10:19 -0700
Received: from prefect (prefect.mshome.net [192.168.0.76])
	by ns1.ltc.com (Postfix) with SMTP
	id ED126590B2; Fri, 12 Apr 2002 14:30:32 -0400 (EDT)
Message-ID: <012f01c1e250$c93fb0a0$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020412195812.14896B-100000@delta.ds2.pg.gda.pl>
Subject: Re: Can modules be stripped?
Date: Fri, 12 Apr 2002 14:35:13 -0400
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
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Sent: Friday, April 12, 2002 2:05 PM
Subject: Re: Can modules be stripped?


> On Fri, 12 Apr 2002, Bradley D. LaRonde wrote:
>
> > OK, you can't strip kernel modules (news to me, then again how often do
I
> > use modules?), but it can't be because they "are relocatables".  I
routinely
> > strip libraries without problem, and those are relocatables too.
>
>  What kind of libraries?  Shared libraries are shared objects and not
> relocatables.

Oh, oops. :-P  Now I see what you mean.  I confused shared object
w/relocatable.  My bad.

Did I know that kernel modules were "object files" i.e. relocatables.  Yes.
But I've always referred to them as object files (.o), not relocatables,
hence the confusion.

Which brings up an interesting question - why doesn't the kernel use .so
files for modules?

Regards,
Brad

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJ34q827827
	for linux-mips-outgoing; Tue, 18 Dec 2001 19:04:52 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJ34ho27821
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 19:04:45 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id B1627590A9; Tue, 18 Dec 2001 21:02:19 -0500 (EST)
Message-ID: <056a01c18831$919daf90$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, "Jun Sun" <jsun@mvista.com>
Cc: <jim@jtan.com>, <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1011219023325.16267B-100000@delta.ds2.pg.gda.pl>
Subject: Re: ISA
Date: Tue, 18 Dec 2001 21:05:01 -0500
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
To: "Jun Sun" <jsun@mvista.com>
Cc: <jim@jtan.com>; <linux-mips@oss.sgi.com>
Sent: Tuesday, December 18, 2001 8:50 PM
Subject: Re: ISA


> On Tue, 18 Dec 2001, Jun Sun wrote:
> > Now when people using ioremap/readb/writeb method to access ISA memory
space,
> > which lives in the lower range of the "bus memory space", it will
collide with
> > system ram under 1:1 mapping assumption.
>
>  Hmm, I believe there should be no such problem.  For systems equipped
> with the PCI bus we may just assume the low 16MB of PCI memory address
> space is reserved for ISA memory addresses (it's hardwired for many
> platforms, so there should be no problem with it), i.e. avoid programming
> BARs to point to that space and make ioremap() (or __ioremap(), actually)
> act accordingly, i.e. assume a 1:1 mapping for addresses above 16MB and
> perform an ISA mapping for ones below 16MB.

That sounds like the simplest and best solution.

Regards,
Brad

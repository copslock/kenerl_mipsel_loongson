Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2N1pVX03288
	for linux-mips-outgoing; Fri, 22 Mar 2002 17:51:31 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2N1pPq03278
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 17:51:26 -0800
Received: from prefect (prefect.local [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id 5FA56590B2; Fri, 22 Mar 2002 20:48:29 -0500 (EST)
Message-ID: <04c901c1d20d$bfb061e0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Pete Popov" <ppopov@mvista.com>, <linux-mips@oss.sgi.com>
References: <1016845916.24217.298.camel@zeus>
Subject: Re: [Linux-mips-kernel]io.h patch
Date: Fri, 22 Mar 2002 20:55:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


----- Original Message -----
From: "Pete Popov" <ppopov@mvista.com>
To: "sforge" <linux-mips-kernel@lists.sourceforge.net>
Sent: Friday, March 22, 2002 8:11 PM
Subject: [Linux-mips-kernel]io.h patch


> Some of the macros in io.h cause compile problems in some of the drivers
> because of the do while syntax.  I don't see any good reason why we
> can't make those macros inline functions.  Any objections to this patch?

I pester Ralf about this from time to time.  The standing objection is that
some older gccs don't do inline well.

Regards,
Brad

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBILRP815888
	for linux-mips-outgoing; Tue, 18 Dec 2001 13:27:25 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBILRIo15885
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 13:27:19 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id 104D4590A9; Tue, 18 Dec 2001 15:24:51 -0500 (EST)
Message-ID: <035001c18802$6af8d8d0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <jim@jtan.com>, <linux-mips@oss.sgi.com>
References: <20011218150423.A12143@neurosis.mit.edu>
Subject: Re: ISA
Date: Tue, 18 Dec 2001 15:27:29 -0500
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
From: "Jim Paris" <jim@jtan.com>
To: <linux-mips@oss.sgi.com>
Sent: Tuesday, December 18, 2001 3:04 PM
Subject: ISA


> Okay, so I'll change the i82365 driver to use isa_{read,write}[bwl]
> instead of ioremap & {read,write}[bwl], when CONFIG_ISA is defined.
> That shouldn't break other architectures.

Admittedly I haven't studied this, but ugh... can't we let isa_* die?

Regards,
Brad

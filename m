Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDICmU14978
	for linux-mips-outgoing; Thu, 13 Dec 2001 10:12:48 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDICho14975
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 10:12:44 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id B2E35590A9; Thu, 13 Dec 2001 12:10:59 -0500 (EST)
Message-ID: <070501c183f9$6b02de50$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Florian Lohoff" <flo@rfc822.org>
Cc: <linux-mips@oss.sgi.com>
References: <20011213163953.GB23023@paradigm.rfc822.org> <06c701c183f7$d23eb410$5601010a@prefect> <20011213170410.GB25296@paradigm.rfc822.org>
Subject: Re: [PATCH] /proc/cpuinfo endianess (autoconf dependencie)
Date: Thu, 13 Dec 2001 12:13:00 -0500
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
From: "Florian Lohoff" <flo@rfc822.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Thursday, December 13, 2001 12:04 PM
Subject: Re: [PATCH] /proc/cpuinfo endianess (autoconf dependencie)

> There is - But autoconf in the current version is broken and needs
> this to gather the endianess - As we currently have to live with it
> this is a 2.4 issue - 2.5 should fix this and remove endianess from
> /proc/cpuinfo.

I understand, thanks for the explanation.  So the patch should only go in
the 2.4 branch?

Regards,
Brad

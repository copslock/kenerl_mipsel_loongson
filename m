Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9J2BEi12473
	for linux-mips-outgoing; Thu, 18 Oct 2001 19:11:14 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9J2BBD12470
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 19:11:12 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP
	id 58C9E590A9; Thu, 18 Oct 2001 18:09:14 -0400 (EDT)
Message-ID: <007201c15843$57067a60$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "H . J . Lu" <hjl@lucon.org>, <linux-mips@oss.sgi.com>
References: <20011018185717.A8135@lucon.org>
Subject: Re: Strange behavior of serial console under 2.4.9
Date: Thu, 18 Oct 2001 22:11:18 -0400
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

I haven't noticed that.  I just ran top with 0 delay at 115200 and it seems
normally fast to me.

Regards,
Brad

----- Original Message -----
From: "H . J . Lu" <hjl@lucon.org>
To: <linux-mips@oss.sgi.com>
Sent: Thursday, October 18, 2001 9:57 PM
Subject: Strange behavior of serial console under 2.4.9


> The serial console under 2.4.9 is very strange. It is very slow. I have
> no such problem with 2.4.3/2.4.5. Telnet is fine.

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2H1aD317103
	for linux-mips-outgoing; Sat, 16 Mar 2002 17:36:13 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2H1a2917099
	for <linux-mips@oss.sgi.com>; Sat, 16 Mar 2002 17:36:03 -0800
Received: from prefect (prefect.local [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id 47025590B2; Sat, 16 Mar 2002 20:32:59 -0500 (EST)
Message-ID: <01dc01c1cd54$73281c40$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Girish Gulawani" <girishvg@yahoo.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
References: <00f601c1cd53$9c862060$8c3684d3@gol.com>
Subject: Re: Error loading shared libraries.
Date: Sat, 16 Mar 2002 20:38:32 -0500
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
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Sent: Saturday, March 16, 2002 8:32 PM
Subject: Error loading shared libraries.


>
> Hello, all.
> I know this is kind of weird problem at this point of time. I have a MIPS
> board booted up with Linux 2.4.3 kernel. But it fails on the "init". I get
> an error in the init process:
>
> init: error in loading shared libraries
> libutil.so.1: cannot map file data: Bad file descriptor ...
>
> The compiler used is EGCS 2.91.66, downloaded from the net.

What glibc?  Could this be the MIPS base address bug?  Maybe this patch by
H. J. Lu. (updated by me) will help:

http://www.ltc.com/~brad/mips/glibc-2.2.3-mips-base-addr-got.diff

Regards,
Brad

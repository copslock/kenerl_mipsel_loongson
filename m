Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16EDmI21881
	for linux-mips-outgoing; Wed, 6 Feb 2002 06:13:48 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16EDdA21876
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 06:13:41 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id 055CA590A9; Wed,  6 Feb 2002 09:05:36 -0500 (EST)
Message-ID: <002f01c1af18$a8685410$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: <sjhill@cotw.com>, "linux-mips" <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0202060948190.20126-100000@vervain.sonytel.be>
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
Date: Wed, 6 Feb 2002 09:14:53 -0500
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
From: "Geert Uytterhoeven" <geert@linux-m68k.org>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: <sjhill@cotw.com>; "linux-mips" <linux-mips@oss.sgi.com>
Sent: Wednesday, February 06, 2002 3:49 AM
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?


> On Tue, 5 Feb 2002, Bradley D. LaRonde wrote:
> > As already mentioned, a MIPS TLB entry typically can point with 36 bits
> > (that's 67TB of address space?) at physical memory.  If you have more
than
>
> At bit less: 64 GiB or approx. 69 GB :-)

Oops, yeah.  67TB seemed a little high.  :-P

Regards,
Brad

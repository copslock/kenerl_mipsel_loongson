Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA54Win08196
	for linux-mips-outgoing; Sun, 4 Nov 2001 20:32:44 -0800
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA54Wd008193
	for <linux-mips@oss.sgi.com>; Sun, 4 Nov 2001 20:32:40 -0800
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP
	id F30EF590A9; Sun,  4 Nov 2001 19:28:45 -0500 (EST)
Message-ID: <07b401c165b2$f981ec30$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Green" <greeen@iii.org.tw>, "Linux-mips" <linux-mips@oss.sgi.com>,
   "MipsMailList" <linux-mips@fnet.fr>
References: <008701c165ac$1a49a9a0$4c0c5c8c@trd.iii.org.tw>
Subject: Re: do_ri( )
Date: Sun, 4 Nov 2001 23:33:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've seen the same thing but on a different processor (VR5432).  gcc 3.0.1,
glibc 2.2.3.  I suspect stack/register corruption.

Regards,
Brad

----- Original Message -----
From: Green
To: Linux-mips ; MipsMailList
Sent: Sunday, November 04, 2001 10:43 PM
Subject: do_ri( )

Dear all,

    I often get into trouble executing multithread application.
    Sometimes it will appear the message " Illegal instruction = 0xXXXX " in
    do_ri() function in /arch/mips/kernel/traps.c.
    It happened randomly.

    Up to now, I still didn't know how to fix bug.
    If any one know how to fix it, please reply me.
    Appreciate in sincerely.

    P.S  My mips bos is R3912.

~~
Green  greeen@iii.org.tw

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5IBm3nC012704
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 04:48:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5IBm3f0012703
	for linux-mips-outgoing; Tue, 18 Jun 2002 04:48:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-27.ka.dial.de.ignite.net [62.180.196.27])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IBlsnC012699
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 04:47:55 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5IBmZo29507
	for linux-mips@oss.sgi.com; Tue, 18 Jun 2002 13:48:35 +0200
Received: from lahoo.mshome.net (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HGtDnC026125
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 09:55:16 -0700
Received: from prefect.mshome.net ([192.168.0.76] helo=prefect)
	by lahoo.mshome.net with smtp (Exim 3.12 #1 (Debian))
	id 17Jyui-0005nP-00; Mon, 17 Jun 2002 11:59:32 -0400
Message-ID: <00bd01c21618$4e714ef0$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Balakrishnan Ananthanarayanan" <balakris_ananth@email.com>,
   <linux-mips@oss.sgi.com>
References: <20020617094851.30730.qmail@email.com>
Subject: Re: Code error - why?
Date: Mon, 17 Jun 2002 12:01:56 -0400
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

Drop the $ on the registers?

Regards,
Brad

----- Original Message -----
From: "Balakrishnan Ananthanarayanan" <balakris_ananth@email.com>
To: <linux-mips@oss.sgi.com>; <linux-kernel@vger.kernel.org>;
<redhat-list@redhat.com>
Sent: Monday, June 17, 2002 5:48 AM
Subject: Code error - why?


> I wrote a SAMPLE CODE - Hello.S to work for a cross-assembler
mips-linux-as - but this is giving me an error message:
>    ".data
>          quest: .asciiz "Hello World!"
>     .text
>     _start:
>          la $a0, quest
>          li $v0, 4
>          syscall   "
>
> The error messages are:
>   " Hello.S line 5: illegal operands 'la'
>     Hello.S line 6: illegal operands 'li'"
>
> Can anyone help? What is wrong?

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 06:47:07 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:38811
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225194AbTA1GrH>; Tue, 28 Jan 2003 06:47:07 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0S6l0s20718;
	Tue, 28 Jan 2003 07:47:00 +0100
Date: Tue, 28 Jan 2003 07:47:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Smith, Todd" <Todd.Smith@camc.org>
Cc: linux-mips@linux-mips.org
Subject: Re: You need help!
Message-ID: <20030128074700.A20541@linux-mips.org>
References: <490E0430C3C72046ACF7F18B7CD76A2A568F70@KES.camcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <490E0430C3C72046ACF7F18B7CD76A2A568F70@KES.camcare.com>; from Todd.Smith@camc.org on Mon, Jan 27, 2003 at 09:31:48AM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 27, 2003 at 09:31:48AM -0500, Smith, Todd wrote:

> Hello Maciej,
> 
> You are sick and twisted but your testing plan will certainly find bugs. :)
> My only question is how to tell the bugs from one package to the other. :)
> 
> Thanks for all of the hard work.

Now guess why linux-mips.org is running IPv6 :-)

>  I do run IPv6 -- I get to my 32-bit box with SSH over IPv6 just to make
> sure I'll find more bugs (the previous one was the multicast filter). ;-) 
> I even have ipv6.o as a module (which also triggered bugs in the past). 
> Will have to try with the 64-bit box. ;-)))
> 
>  But this bug I've actually spotted studying compiler's diagnostic output
> -- a "Macro instruction expanded into multiple instructions in a branch
> delay slot" warning isn't normal for a .c file. 

The plain C version btw. expands into the same machine instructions.  Of
course it was written on a MIPS so it's no coincidence it'll perform well
on MIPS :)

[root@dea mips64-linux]# host -a ftp.linux-mips.org
Trying "ftp.linux-mips.org"
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 53547
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 2, ADDITIONAL: 1

;; QUESTION SECTION:
;ftp.linux-mips.org.		IN	ANY

;; ANSWER SECTION:
ftp.linux-mips.org.	53172	IN	A	62.254.210.162
ftp.linux-mips.org.	53156	IN	AAAA	3ffe:8260:2028:fffe::1
[...]

There is some ongoing effort to put as many Linux servers on IPv6 as
possible.  And yes, it's caught bugs before.

Everybody's favorite bug is of course is caused by autoconf.  Various
packages only detect the precense of IPv6 if it's actually configured
so there's no more escape from IPv6 already ...

  Ralf

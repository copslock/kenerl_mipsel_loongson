Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3DEi88d021215
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 13 Apr 2002 07:44:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3DEi8NU021214
	for linux-mips-outgoing; Sat, 13 Apr 2002 07:44:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ns1.ltc.com (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3DEhl8d021201
	for <linux-mips@oss.sgi.com>; Sat, 13 Apr 2002 07:43:54 -0700
Received: from prefect (prefect.mshome.net [192.168.0.76])
	by ns1.ltc.com (Postfix) with SMTP
	id EA6FC590B2; Sat, 13 Apr 2002 10:39:58 -0400 (EDT)
Message-ID: <006a01c1e2f9$c2e053a0$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <chtimwu@libra.seed.net.tw>
Cc: "linux-mips" <linux-mips@oss.sgi.com>
References: <3CB68CC8.1050207@libra.seed.net.tw> <005901c1e217$058f7f20$4c00a8c0@prefect> <3CB7E629.9060105@libra.seed.net.tw>
Subject: Re: LEXRA MIPS
Date: Sat, 13 Apr 2002 10:44:47 -0400
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

You say this only happens when a process raises a signal.

Maybe the signal trampoline is getting messed up.

Do you see the same behaviour with and without a signal handler installed
for the raised signal?

Regards,
Brad

----- Original Message -----
From: "Tim Wu" <chtimwu@libra.seed.net.tw>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: "linux-mips" <linux-mips@oss.sgi.com>
Sent: Saturday, April 13, 2002 4:02 AM
Subject: Re: LEXRA MIPS


> I insert a show_registers() into the begining of do_ri().
> It seems that CPU runs into data section.
>
> $0 : 00000000 1000fc00 00000014 00000000 00000001 00000000 00000000
00000000
> $8 : 0000fc00 7fff7a78 00000000 00000002 00000000 00000000 00000000
00000002
> $16: 00000004 7fff7e10 7fff7e18 00000000 100604b0 00000600 7fff7e28
00000010
> $24: 810d6080 00000000                   1005e870 7fff7a58 7fff7db0
7fff7a68
> Hi : 00000000
> Lo : 00000000
> epc  : 7fff7aa8    Not tainted
> Status: 0000fc0c
> Cause : 10000028
> Process ping (pid: 24, stackpage=81ff2000)
> Stack: 386d4381 31323100 00000000 00000000 24021000 00000000 00000000
0000fc0c
>         2ab39a1c 00000000 00000000 00000000 2ab9f550 00000000 00000200
00000000
>         00000000 00000000 00000003 00000000 7fff7d08 00000000 000000c0
00000000
>         00000000 00000000 0000fc00 00000000 81ff0210 00000000 00000000
00000000
>         00000003 00000000 00000000 00000000 00000000 00000000 00000000
00000000
>         00000002 ...
> Call Trace:
> Code: 00000000  00000003  00000000 <7fff7d08> 00000000  000000c0  00000000
> 00000000  00000000
>
>
>
> Bradley D. LaRonde wrote:
>
> > ----- Original Message -----
> > From: "Tim Wu" <chtimwu@libra.seed.net.tw>
> > To: "linux-mips" <linux-mips@oss.sgi.com>
> > Sent: Friday, April 12, 2002 3:29 AM
> > Subject: LEXRA MIPS
> >
> >
> >
> >>I traced the kernel source and found SIGILL is sent by the exception
> >>handler, do_ri().
> >>
> >
> > Can you tell what/where the reserved (illegal) instruction is that
causes
> > the trap?
> >
> > Regards,
> > Brad
> >
> >
> >
>
>
>

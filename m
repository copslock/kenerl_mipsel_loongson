Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3CBf28d008093
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 04:41:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3CBf2SK008092
	for linux-mips-outgoing; Fri, 12 Apr 2002 04:41:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ns1.ltc.com (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3CBeq8d008080
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 04:40:57 -0700
Received: from prefect (prefect.mshome.net [192.168.0.76])
	by ns1.ltc.com (Postfix) with SMTP
	id 4A622590B2; Fri, 12 Apr 2002 07:37:06 -0400 (EDT)
Message-ID: <005901c1e217$058f7f20$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <chtimwu@libra.seed.net.tw>, "linux-mips" <linux-mips@oss.sgi.com>
References: <3CB68CC8.1050207@libra.seed.net.tw>
Subject: Re: LEXRA MIPS
Date: Fri, 12 Apr 2002 07:41:44 -0400
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
From: "Tim Wu" <chtimwu@libra.seed.net.tw>
To: "linux-mips" <linux-mips@oss.sgi.com>
Sent: Friday, April 12, 2002 3:29 AM
Subject: LEXRA MIPS


> I traced the kernel source and found SIGILL is sent by the exception
> handler, do_ri().

Can you tell what/where the reserved (illegal) instruction is that causes
the trap?

Regards,
Brad

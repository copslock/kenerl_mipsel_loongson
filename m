Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f81Fqo314348
	for linux-mips-outgoing; Sat, 1 Sep 2001 08:52:50 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f81Fqkd14345
	for <linux-mips@oss.sgi.com>; Sat, 1 Sep 2001 08:52:46 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP
	id D033A590A9; Sat,  1 Sep 2001 11:51:33 -0400 (EDT)
Message-ID: <010401c132fe$610d0610$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Lars Munch" <lars@segv.dk>, <linux-mips@oss.sgi.com>
References: <20010901165842.B13357@tuxedo.skovlyporten.dk>
Subject: Re: set_except_vector question
Date: Sat, 1 Sep 2001 11:54:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Looks like it is synthesizing a jump (j) instruction to forward interrupt
exceptions to the interrupt handler for cpus that have a dedicated interrupt
vector (DIVEC).  arch/mips/kernel/setup.c sets the DIVEC option for certain
cpus.

Regards,
Brad

----- Original Message -----
From: "Lars Munch" <lars@segv.dk>
To: <linux-mips@oss.sgi.com>
Sent: Saturday, September 01, 2001 10:58 AM
Subject: set_except_vector question


> Hi
>
> I have been looking at the set_except_vector function in
> arch/mips[64]/kernel/traps.c and wondering why the handler
> address is changed/recalculated before it is stored:
>
> *(volatile u32 *)(KSEG0+0x200) = 0x08000000 | (0x03ffffff & (handler >>
2));
>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Could someone please enlighten me?
>
> Thanks
> Lars Munch
>

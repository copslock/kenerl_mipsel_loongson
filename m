Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ADWQd12302
	for linux-mips-outgoing; Fri, 10 Aug 2001 06:32:26 -0700
Received: from mout04.kundenserver.de (mout04.kundenserver.de [195.20.224.89])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ADWPV12299
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 06:32:25 -0700
Received: from [195.20.224.204] (helo=mrvdom00.schlund.de)
	by mout04.kundenserver.de with esmtp (Exim 2.12 #2)
	id 15VCOe-00043V-00; Fri, 10 Aug 2001 15:32:16 +0200
Received: from pd9007d28.dip.t-dialin.net ([217.0.125.40] helo=shodan)
	by mrvdom00.schlund.de with smtp (Exim 2.12 #2)
	id 15VCOd-0007s8-00; Fri, 10 Aug 2001 15:32:15 +0200
Message-ID: <002601c121a0$de4f2fa0$237900d9@shodan>
From: "Armin F. Gnosa" <mipslist@gnosa.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010810110057.2724F-100000@delta.ds2.pg.gda.pl>
Subject: Re: Problem with PMAD-AA / DECStation 5000/200
Date: Fri, 10 Aug 2001 15:32:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>  I'm not sure how exactly the ROMs are wired (they're usually 8-bit);
> hopefully in a "natural" way.  You can read most of ROMs under Linux via
> mmap()ping /dev/mem -- parts of ROMs may not be directly available to the
> host CPU if they contain option's CPU firmware.  The MB ROM is remapped
> (byte-merged) by the chipset so that it can be read in 32-bit quantities
> as parts of it get executed directly (the I/O ASIC permits switching the
> byte merging off).  Option ROMs are not remapped as they always get copied
> to the system RAM before execution.  Their organization can be read from
> their headers as specified by the TURBOchannel firmware specification.

That sounds like an interesting alternative to pulling the PROM out of
its socket. Then, a program running on a DECStation 5000/200 should be
reading from 0x1F81C0000..0x1F1FFFFF, right? One question about Byte
Merging: Does it mean that I don't have to read bytewise but instead
DWORD-wise?

Regards,
Armin

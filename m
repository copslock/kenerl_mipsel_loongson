Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QJhF905795
	for linux-mips-outgoing; Fri, 26 Oct 2001 12:43:15 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QJhC005789
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 12:43:12 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA13429;
	Fri, 26 Oct 2001 12:43:02 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA16769;
	Fri, 26 Oct 2001 12:43:03 -0700 (PDT)
Message-ID: <03d201c15e56$7c26cac0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "han han" <piggie111000@yahoo.com>, <linux-mips@oss.sgi.com>
References: <20011026185452.88972.qmail@web10804.mail.yahoo.com>
Subject: Re: MIPS 32bit and 64bit mode
Date: Fri, 26 Oct 2001 21:42:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> But, how does MIPS 5kc work with 32bit Linux kernel?

If the KX, UX, and PX bits of the CP0 Status register
are all zero, a MIPS5Kc is essentaillly functioning as
a 32-bit CPU.  The registers are still 64 bits, and
arithmetic operations will cause all 64 bits of the
destination to be written, but this is outside of the
"event horizon" of the program so long as 64-bit
data and addressing is not enabled.  The 64-bit
5Kc can, and does, boot the same Linux kernel as 
the 32-bit 4Kc.  MIPS64 is a strict superset of MIPS32.

> Do you means there is no difference between 32 bit
> mode and 64 bit mode for MIPS 5kc in kernel mode?

There is no such thing as "32-bit mode" and "64-bit
mode", not really.  There are 64-bit data-type instructions
(e.g. "LD", "DADD") and, logically independently, there
is 64-bit addressing for loads and stores - which includes 
LW and LB as well as LD.  64-bit data is always enabled 
in kernel mode on a MIPS64 part.  For 64-bit data in User 
mode, and for 64-bit addressing in *either* mode, there are 
explicit enables.

            Kevin K.

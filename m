Received:  by oss.sgi.com id <S553686AbRBIWI2>;
	Fri, 9 Feb 2001 14:08:28 -0800
Received: from mx.mips.com ([206.31.31.226]:11242 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553647AbRBIWI0>;
	Fri, 9 Feb 2001 14:08:26 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA28965;
	Fri, 9 Feb 2001 14:08:25 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA14443;
	Fri, 9 Feb 2001 14:08:21 -0800 (PST)
Message-ID: <01b001c092e5$58f6a8a0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        "Jun Sun" <jsun@mvista.com>
Cc:     <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010209212607.13007B-100000@delta.ds2.pg.gda.pl>
Subject: Re: config option vs. run-time detection (the debate continues ...)
Date:   Fri, 9 Feb 2001 23:12:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > Another question.  I know with mips32 and mips64 we can do run-time
detection
> > reliably.  What about other existing processors?
>
>  I've sent a quote from an IDT manual recently.  It recommended to use the
> FPU implementation ID to check if an FP hw is present.  I believe it
> should work for any sane implementation of a MIPS CPU.  See the mail for
> details.

The best method I know for post-R3000 CPUs is to
write and read back the CU1 bit of the Status register.
CPUs without an integrated FPU will not have a flip-flop
for the bit, and will read back a 0 even after writing a 1.
There was never any architectural requirement that
this be so, however, and this cannot be absolutely
guaranteed to work.  If anyone has a counter-example,
however, I'd be interested in hearing about it.

            Kevin K.

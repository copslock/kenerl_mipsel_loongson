Received:  by oss.sgi.com id <S553942AbRAIUaH>;
	Tue, 9 Jan 2001 12:30:07 -0800
Received: from mx.mips.com ([206.31.31.226]:64478 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553655AbRAIU3s>;
	Tue, 9 Jan 2001 12:29:48 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA02504;
	Tue, 9 Jan 2001 12:29:43 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA11181;
	Tue, 9 Jan 2001 12:29:40 -0800 (PST)
Message-ID: <01c201c07a7b$696b9c40$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        <linux-mips@oss.sgi.com>
References: <20010109095438.A10683@paradigm.rfc822.org> <XFMail.010109181100.Harald.Koerfgen@home.ivm.de> <20010109162835.B4232@bacchus.dhis.org> <019901c07a72$94d19f00$0deca8c0@Ulysses> <20010109175416.A5383@bacchus.dhis.org>
Subject: Re: MIPS32 patches breaking DecStation
Date:   Tue, 9 Jan 2001 21:33:12 +0100
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

> > Yes, it's cute, but it relies on accidents of implementation to work,
> > and could easily fail on other CPUs otherwise compatible with
> > the R4000.  In principle, such a branch might incur no delay at
> > all on an advanced 64-bit processor.  By all means, use it for
> > the specific cases of the CPUs on which it is known to work,
> > but it should not be used in "default" MIPS CP0 handlers.
> 
> This behaviour of the R4000 branch is documented in the R4000 manual's
> description of the pipeline.

Yes, yes, like I said, use it whenever you see an R4000 PrID
if you like.  Just don't use it as the handler installed for a PrID
not otherwise known to the kernel.

            Kevin K.

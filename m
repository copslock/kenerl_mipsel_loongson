Received:  by oss.sgi.com id <S553918AbRAIT0s>;
	Tue, 9 Jan 2001 11:26:48 -0800
Received: from mx.mips.com ([206.31.31.226]:8926 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553772AbRAIT0f>;
	Tue, 9 Jan 2001 11:26:35 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA01915;
	Tue, 9 Jan 2001 11:26:30 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA09526;
	Tue, 9 Jan 2001 11:26:26 -0800 (PST)
Message-ID: <019901c07a72$94d19f00$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>,
        "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Cc:     <linux-mips@oss.sgi.com>
References: <20010109095438.A10683@paradigm.rfc822.org> <XFMail.010109181100.Harald.Koerfgen@home.ivm.de> <20010109162835.B4232@bacchus.dhis.org>
Subject: Re: MIPS32 patches breaking DecStation
Date:   Tue, 9 Jan 2001 20:30:05 +0100
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

> > Same here on my /260 (R4400SC V4.0). Neither inserting four "sll
$0,$0,1" nor
> > four "nop" seem to work. The branch, on the other hand, does.

Then it's apparently more than just a garden-variety CP0 hazard.

> Note the ssnops only make sense on superscalar CPUs, so not on the R4000.

My point is that an SSNOP should cause a 1 cycle stall on *any* MIPS
implementation to date, superscalar or not.  It's not documented that
way for the R10000, but if I recall correctly, it works there too.  If one
wants to standardize on a single mechanism, that's the one to use.
That's all I'm saying.

> Also note that the branch is equivalent to three nops.  One for the
> branch instruction itself, the two more for instructions in the pipeline
> that get killed.  On the R4600 / R500 where the hazard is only a single
> instruction the branch is equivalent to only a single nop.  So while
> unobvious the branch is a rather neat idea.

Yes, it's cute, but it relies on accidents of implementation to work,
and could easily fail on other CPUs otherwise compatible with
the R4000.  In principle, such a branch might incur no delay at
all on an advanced 64-bit processor.  By all means, use it for
the specific cases of the CPUs on which it is known to work,
but it should not be used in "default" MIPS CP0 handlers.

            Regards,

            Kevin K.

Received:  by oss.sgi.com id <S553747AbRAIAbk>;
	Mon, 8 Jan 2001 16:31:40 -0800
Received: from mx.mips.com ([206.31.31.226]:13009 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553751AbRAIAbW>;
	Mon, 8 Jan 2001 16:31:22 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA23890;
	Mon, 8 Jan 2001 16:31:18 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA12210;
	Mon, 8 Jan 2001 16:31:14 -0800 (PST)
Message-ID: <000501c079d3$fefe1a60$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>, <linux-mips@oss.sgi.com>
References: <20010109004101.B27674@paradigm.rfc822.org>
Subject: Re: MIPS32 patches breaking DecStation
Date:   Tue, 9 Jan 2001 01:34:47 +0100
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

Florian,

Could you do me a huge favor and try a build that
uses 3 or 4 nops instead of the branch to the instruction
after the delay slot?   There was a reason that I eliminated
the branch construct from the MIPS internal Linux source
base - it's a hack that works perfectly on R4000's, but
it's pretty much a coincidence that it does so.  Yes,
the code fragment in question is R4K-specific, but
we really need to migrate towards the use of consistent
mechanisms that work across the full range of MIPS
CPUs.  Ideally, *all* CP0 hazards should some day be 
padded out with "ssnops" (sll $0,$0,1, if I recall), which 
force a 1 cycle delay per instruction even on superscalar 
MIPS CPUs.

            Kevin K.

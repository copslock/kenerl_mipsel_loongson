Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 16:38:22 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:25277
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225561AbUGMPiS>; Tue, 13 Jul 2004 16:38:18 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i6DFYFjd003365;
	Tue, 13 Jul 2004 08:34:15 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i6DFYDv0011781;
	Tue, 13 Jul 2004 08:34:13 -0700 (PDT)
Message-ID: <003301c468ee$80c5fa60$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <KevinK@mips.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: "S C" <theansweriz42@hotmail.com>, <linux-mips@linux-mips.org>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
Subject: Re: Strange, strange occurence
Date: Tue, 13 Jul 2004 17:31:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Scanned-By: MIMEDefang 2.39
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

> > A truly safe and general I-cache flush routine should itself run uncached,
> > but a cursory glance at the linux-mips.org sources makes me think
> > that we do not take that precaution by default - the flush_icache_range
> > pointer looks to be set to the address of r4k_flush_icache_range()
> > function, rather than its (uncacheable) alias in kseg1.  Is this something
> > that's fixed in a linker script, or are we just living dangerously?
> 
> That's a new restriction in MIPS32 v2.0 and you're right, we're not trying
> to deal with it yet except for the TX49xx.

I'm pretty sure that restriction is not new to MIPS32 v2.0.  In any
case, there are pre-MIPS32/MIPS64 chips in current mass production
and use, under Linux among other OSes, which specify in their user
manuals that one should not invalidate the Icache line from which one
is currently executing.  The clause about unpredictable behavior in
that case went into the MIPS32 spec because it was known that such
parts existed, and we wanted to make it as easy as possible for such 
designs to be made compliant

Invalidating the entire Icache with a routine executing out of the Icache
is a Bad Idea, and will almost certainly cause problems some of the time
on some MIPS processors.  Reasonable people could disagree on whether
we want to handle that in the generic code, or create a variant icache flush 
routine which gets plugged in only for those parts that really need it.

            Regards,

            Kevin K.

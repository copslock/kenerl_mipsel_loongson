Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 10:06:09 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:30409 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225224AbSLDJGI>;
	Wed, 4 Dec 2002 10:06:08 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB495vNf021969;
	Wed, 4 Dec 2002 01:05:58 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA06598;
	Wed, 4 Dec 2002 01:05:55 -0800 (PST)
Message-ID: <005701c29b74$f1f76870$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Carsten Langgaard" <carstenl@mips.com>,
	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <3DEDBDFC.D87C1B84@mips.com>
Subject: Re: Latest sources from CVS.
Date: Wed, 4 Dec 2002 10:09:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> I just checked the latest sources out of cvs.
> 
> It look like you are only able to compile the kernel, if you got a
> MIPS32/MIPS64 compliant compiler.
> The mips32 and mips64 assembler directives are set in
> include/asm-mips/mipsregs.h
> 
> I guess this will make some people out there, which doesn't use a MIPS32
> compliant compiler, a little bit unhappy.
> But then again, we would like to force everybody to use the SDE
> compiler.

For those on the list who don't understand Carsten's sense
of humour, I think that was missing a smiley!  ;-)
I mean, sure, we'd like to move more people toward SDE, 
but "force" is putting it a bit strongly!  And if those directives
are really being used unconditionally, I worry that the code
being generated is likewise emitting MIPS32 instructions
that won't work on the "ghost fleet" of abandoned workstations
now running Linux on R4K/R5K CPUs.

            Kevin K.

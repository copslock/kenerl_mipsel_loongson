Received:  by oss.sgi.com id <S553675AbQK0WDO>;
	Mon, 27 Nov 2000 14:03:14 -0800
Received: from mx.mips.com ([206.31.31.226]:48347 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553671AbQK0WC4>;
	Mon, 27 Nov 2000 14:02:56 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA03618;
	Mon, 27 Nov 2000 14:02:28 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA16300;
	Mon, 27 Nov 2000 14:02:47 -0800 (PST)
Message-ID: <011e01c058be$420db900$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     <tmaloney@ixl.com>, <linux-mips@oss.sgi.com>
References: <0A5319EEAF65D411825E00805FBBD8A1209DB0@exchange.clt.ixl.com>
Subject: Re: off topic timmy
Date:   Mon, 27 Nov 2000 23:06:10 +0100
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

Actually, there is a potential reason why it won't work.
I don't know about IRIX 6.4, but IRIX 6.3 had distinct
kernel, library, and binary builds for desktop (Indy,
Indigo2, Challenge S, O2) platforms versus the
larger server-class systems like those listed below.
The difference was that the "lite" desktop versions in fact
ran the CPU in 32-bit mode, while the big-system versions 
ran full 64-bit.  The logic was that the overhead of 
64-bit register context on the stack, etc, was too great
to be permitted on desktop platforms.  For people
like myself, who wanted to develop and test CPU
benchmark codes on the desktop before launching
them on the Origin, this was no kindness.

So there is an excellent chance that they "idiot
proofed" the release you have so that you can't load
it on your Indy.

            Kevin K.

----- Original Message -----
From: <tmaloney@ixl.com>
To: <linux-mips@oss.sgi.com>
Sent: Monday, November 27, 2000 9:35 PM
Subject: off topic timmy


> any reason this couldn't be used with a Indy R4600/133? please respond
> offlist, and thanks.
> 
> SGI IRIX 6.4 Installation CD Set (8 CD's)
> for Octane, Onyx, Onyx2 and Origin (200/2000) 
> Includes: 
> SGI 813-0616-002: IRIX 6.4 for Origin, Onyx2, and Octane 
> SGI 813-0617-003: IRIX 6.4 Applications, 8/97 
> SGI 813-0722-011: IRIX 6.4 Recommended/Required Patches 2/98 
> SGI 813-0735-001: Octane System Disk Patches, 2/98 
> SGI 813-0648-002: Octane Demos 1.1 for IRIX 6.4 
> SGI 813-0543-001: Freeware 2.0 
> SGI 813-0574-001: R5000 Convert Patch 
> SGI 814-0544-006: Hot Mix 17 
> 
> 
> 
> Tim Maloney
> Senior Developer
> iXL, Inc.
> 1930 Camden Road, Suite 2070
> Charlotte, NC 28203
> 704 943-7193 phone
> tmaloney@ixl.com
> www.ixl.com
> 

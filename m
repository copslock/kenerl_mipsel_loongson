Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2ME1kB31733
	for linux-mips-outgoing; Thu, 22 Mar 2001 06:01:46 -0800
Received: from chmls20.mediaone.net (chmls20.mediaone.net [24.147.1.156])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2ME1jM31730
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 06:01:45 -0800
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls20.mediaone.net (8.11.1/8.11.1) with SMTP id f2ME1hk24137;
	Thu, 22 Mar 2001 09:01:43 -0500 (EST)
From: "Jay Carlson" <nop@nop.com>
To: "Kevin D. Kissell" <kevink@mips.com>, <linux-mips@oss.sgi.com>
Subject: RE: Embedded MIPS/Linux Needs
Date: Thu, 22 Mar 2001 09:01:47 -0500
Message-ID: <KEEOIBGCMINLAHMMNDJNIEHDCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <00eb01c0b2c6$02c7ef60$0deca8c0@Ulysses>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Disclaimer: I'm just a hobbyist.

Kevin D. Kissell writes:

> Here at MIPS Technologies, we use Linux internally
> for design verification, experiments, benchmarking,
> etc., and as a consequence Carsten Langgaard and
> myself have both been active in this forum, and have
> tried to help the general Linux/MIPS community as
> best we can with the limited time that we can dedicate
> to the problem, in terms of suggested patches, bug
> fixes, cleanups, integration of needed components
> like the FPU emulator, etc.

Yes, and this is quite useful!

> I have a question for those of you who are doing
> Linux work for *new* platforms (as opposed to the
> SGI/DEC legacy box support people).  IF, and I
> emphasize the word *if*, MIPS Technologies were
> make a bigger investment in MIPS/Linux technology,
> be it kernel enhancements, cross/native tools,
> userland ports, libraries, or whatever, what would
> be your prioritized "wish list"?

Some of these things can reasonably be done by third parties.  For instance,
mvista's in the business of nailing down particular toolchain versions and
doing relevant ports.  These days I'm mostly userland, so I get to assume
that working kernels are and will continue to be emitted from the smart
people on this list too :-)

My pet issue is code density and compiler quality.  I think it's in MIPS's
best interest to provide a really good compiler for their products, and I
think gcc does a good job for traditional embedded MIPS systems.  But the
gcc/gas-generated code for the SVR4 ABI is pretty bad, especially for the
low-end devices.  snow (see previous message) shows how much room for
improvement there is.

Individual embedded Linux companies don't have much motivation to attack
this problem alone, as it looks like it could involve extensive gcc hacking.
If a particular customer looks like they have code density issues, it'd be
easier for embedded linux companies to just recommend, say, ARM.  MIPS
Technologies on the other hand carries the banner for all devices licensing
their architecture, and any toolchain work may result in greater demand for
their own cores and licensee products.

ARM and Cygnus recently contributed a gcc ARM backend rewrite.  That's what
got me thinking about this.

Jay

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2MCT8s29081
	for linux-mips-outgoing; Thu, 22 Mar 2001 04:29:08 -0800
Received: from exchange1.cam.pace.co.uk (host-131-80.pace.co.uk [136.170.131.80])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2MCT6M29078
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 04:29:06 -0800
Received: by exchange1 with Internet Mail Service (5.5.2448.0)
	id <GNGHZV6K>; Thu, 22 Mar 2001 12:27:59 -0000
Message-ID: <1402C4C025C4D311B50D00508B8B74E281B153@exchange1>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: linux-mips@oss.sgi.com
Subject: RE: Embedded MIPS/Linux Needs
Date: Thu, 22 Mar 2001 12:27:59 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm just starting out on this path, so my priorities might be off...

1. Packaging of a "stable" cross-development kit, including kernel,
toolchain and any other useful utilities. Saves me the time of assembling
the pieces myself and saves me asking questions about problems that were
fixed months ago. I know other companies provide this but I have yet to
evaluate them.

2. Provision of a framework (which may already be in place - I haven't got
that far yet) that provides me with a tick-list of hardware blocks that I
may need to provide code for to support my particular board, and to be
structured so that (as far as possible) I am adding files to the tree rather
than modifying them. The framework to be arranged so that I can do it
incrementally.

3. Support - not just for the development kit, but also as a source of
experience and suggestions for porting to new boards.

4. Work with chip manufacturers who are slow to provide Linux drivers.
Reference (rather than production quality) drivers would be better than
nothing. This is obviously not a MIPS specific issue.

Phil

-----Original Message-----
From: Kevin D. Kissell [mailto:kevink@mips.com]
Sent: 22 March 2001 11:48
To: linux-mips@oss.sgi.com
Subject: Embedded MIPS/Linux Needs


Here at MIPS Technologies, we use Linux internally
for design verification, experiments, benchmarking,
etc., and as a consequence Carsten Langgaard and
myself have both been active in this forum, and have
tried to help the general Linux/MIPS community as
best we can with the limited time that we can dedicate
to the problem, in terms of suggested patches, bug
fixes, cleanups, integration of needed components
like the FPU emulator, etc.

I have a question for those of you who are doing
Linux work for *new* platforms (as opposed to the
SGI/DEC legacy box support people).  IF, and I
emphasize the word *if*, MIPS Technologies were
make a bigger investment in MIPS/Linux technology,
be it kernel enhancements, cross/native tools,
userland ports, libraries, or whatever, what would
be your prioritized "wish list"?

Feel free to respond by point-to-point email, though
responses that are also copied to the mailing list
might provoke some interesting and enlightening
debate.

            Regards,

            Kevin K.

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2003 17:55:24 +0000 (GMT)
Received: from anchor-post-34.mail.demon.net ([IPv6:::ffff:194.217.242.92]:35596
	"EHLO anchor-post-34.mail.demon.net") by linux-mips.org with ESMTP
	id <S8225428AbTKVRyv>; Sat, 22 Nov 2003 17:54:51 +0000
Received: from skylon.demon.co.uk ([158.152.3.173])
	by anchor-post-34.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1ANby5-000KTU-0Y
	for linux-mips@linux-mips.org; Sat, 22 Nov 2003 17:54:49 +0000
Received: from skylon.demon.co.uk (skylon.demon.co.uk [158.152.3.173]) by skylon.demon.co.uk (8.8.7/UW7.0.1) with ESMTP id QAA10882; Sat, 22 Nov 2003 16:56:59 GMT
Message-ID: <3FBF955A.5C2CC00C@skylon.demon.co.uk>
Date: Sat, 22 Nov 2003 16:56:58 +0000
From: John Connett <jrc@skylon.demon.co.uk>
X-Mailer: Mozilla 4.04 [en] (X11; I; UnixWare 5 i386)
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: MIPS64 + HyperTransport + nForce3?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <jrc@skylon.demon.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jrc@skylon.demon.co.uk
Precedence: bulk
X-list: linux-mips

There are now a number of MIPS64 processor chips with HyperTransport
support.  NVIDIA produce a range of nForce3 system controller chips
which also use HyperTransport.  Does anyone produce a board that
combines the two and, to make my question relevant to this list, runs
Linux?

The low power requirements of the MIPS64 processors would make them an
ideal choice for small form factor boards such as those used in the
Shuttle XPC systems.  The recent Shuttle SN85G4 combines an AMD
Athlon64 and an nForce3 150.  This supports a good selection of
on-board peripherals together with 1 x AGP 8X/4X slot and 1 x PCI
slot.  Something similar using a single or dual MIPS64 processor chip
would make an attractive desktop system.  For the power crazy, a board
with the quad processor BCM-1400 should suffice ...
--
John Connett

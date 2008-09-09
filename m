Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2008 21:31:54 +0100 (BST)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:38668 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S32732224AbYIIU2n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Sep 2008 21:28:43 +0100
Received: from [217.109.65.213] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id PAA23414
	for <linux-mips@linux-mips.org>; Tue, 9 Sep 2008 15:57:43 -0500
Message-ID: <48C6DC4C.5040208@paralogos.com>
Date:	Tue, 09 Sep 2008 22:27:56 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Linux MIPS Org <linux-mips@linux-mips.org>
Subject: SMTC Patches [0 of 3]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

I've managed to steal enough time to rework the SMTC support
for the MIPS 34K (and, I suppose 1004K) processors so that it
works again near the head of the source tree.  This involved
a complete rework of the clocking model to be compatible with
new common timing event system, which finally enables "tickless"
operation in SMTC, something it needed pretty badly.  I also
solved the problem with using the "wait_irqoff" idle loop
under SMTC.

There are going to be three patches that will follow.  The
first two are relatively localized fixes to problems with
FPU affinity and with IPI replay that I came across in testing
the new code.  The last is a pretty big patch, but it all
pretty much hangs together and I couldn't see any sensible
way to partition it.

	Regards,

	Kevin K.

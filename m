Received:  by oss.sgi.com id <S554269AbRBEVRr>;
	Mon, 5 Feb 2001 13:17:47 -0800
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.69.0.28]:274 "HELO MIT.EDU")
	by oss.sgi.com with SMTP id <S554190AbRBEVRb>;
	Mon, 5 Feb 2001 13:17:31 -0800
Received: from GRAND-CENTRAL-STATION.MIT.EDU by MIT.EDU with SMTP
	id AA22760; Mon, 5 Feb 01 16:19:32 EST
Received: from melbourne-city-street.MIT.EDU (MELBOURNE-CITY-STREET.MIT.EDU [18.69.0.45])
	by grand-central-station.MIT.EDU (8.9.2/8.9.2) with ESMTP id QAA21591
	for <linux-mips@oss.sgi.com>; Mon, 5 Feb 2001 16:13:25 -0500 (EST)
Received: from w20-575-66.mit.edu (W20-575-66.MIT.EDU [18.187.1.21])
	by melbourne-city-street.MIT.EDU (8.9.3/8.9.2) with ESMTP id QAA05137
	for <linux-mips@oss.sgi.com>; Mon, 5 Feb 2001 16:13:25 -0500 (EST)
Received: from localhost (kbarr@localhost) by w20-575-66.mit.edu (8.9.3) with ESMTP
	id QAA195850; Mon, 5 Feb 2001 16:13:24 -0500 (EST)
Date:   Mon, 5 Feb 2001 16:13:23 -0500
From:   Kenneth C Barr <kbarr@MIT.EDU>
To:     <linux-mips@oss.sgi.com>
Subject: netbooting indy - update, elf2ecoff?
In-Reply-To: <20010205115026.C2487@bacchus.dhis.org>
Message-Id: <Pine.SGI.4.30L.0102051604550.234337-100000@w20-575-66.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Thank you very much for your help so far!  Here's an update and another
question:

Updates:
1.  Had to attach a console (we have XZ graphics not XL)
2.  An ecoff kernel image downloaded fine.  The ELF ones download halfway
and fail silently (even with the console attached)

Question: As the vmlinux-indy-2.2.1-990226.ecoff kernel begins the boot
sequence, it hangs at "unable to open initial console."  I had unpacked
the filesystem on linux as the FAQ suggests, and my device files look
right.  So, on the NFS server, I symlinked /dev/console to /dev/ttyS0.
Now the message is replaced with a cryptic: "S<<<<<"

Perhaps that kernel doesn't have console support?  Is there any other
explanation for the "S<<<<<" failure where I used to see "...initial
console?"

I'd like to try a different kernel but I can't find an elf2ecoff binary.
Does anyone have this converted or a known-good ecoff kernel?

Ken

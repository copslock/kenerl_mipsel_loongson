Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2003 23:18:59 +0000 (GMT)
Received: from dallas.texasconnect.net ([IPv6:::ffff:208.232.232.3]:18180 "EHLO
	dallas.texasconnect.net") by linux-mips.org with ESMTP
	id <S8225558AbTLAXS4>; Mon, 1 Dec 2003 23:18:56 +0000
Received: from dallas.texasconnect.net (dallas.texasconnect.net [208.232.232.3])
	by dallas.texasconnect.net (8.12.9/8.12.9) with ESMTP id hB1NIscq012340
	for <linux-mips@linux-mips.org>; Mon, 1 Dec 2003 17:18:54 -0600
Date: Mon, 1 Dec 2003 17:18:54 -0600 (CST)
From: Ed Okerson <eokerson@texasconnect.net>
To: linux-mips@linux-mips.org
Subject: Compact Flash on AU1500
Message-ID: <Pine.LNX.4.44.0312011710320.24981-100000@dallas.texasconnect.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <eokerson@texasconnect.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eokerson@texasconnect.net
Precedence: bulk
X-list: linux-mips

I recently finished work on u-boot to get it to read a compact flash
properly on the AU1500.  Now I need to get it working under Linux as well,
but have a few questions.  Is root fs on CF supported under 2.4.22?  I
have had conflicting reports on that, and need to know if that has to be
solved first.  I have been told that user space Card Services needs to be
loaded to detect the CF card, but that doesn't seem right with the ide-cs
in the kernel.  The problem with the AU1500 and u-boot was that the AU1X00
series processors always put the data from the CF in big-endian mode
regardless of what endian mode the CPU is running in, which is exactly the
wrong way around for reading partition tables and filesystems.  I have
been having trouble tracking down where in the kernel the actual reads are
done from the compact flash card, could someone point me to the right
place?

Ed Okerson

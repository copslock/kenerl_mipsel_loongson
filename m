Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2003 00:03:21 +0100 (BST)
Received: from p508B61D6.dip.t-dialin.net ([IPv6:::ffff:80.139.97.214]:55228
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225395AbTHYXDT>; Tue, 26 Aug 2003 00:03:19 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7PN2w8R009043
	for <linux-mips@linux-mips.org>; Tue, 26 Aug 2003 01:02:58 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7PN2v40009042
	for linux-mips@linux-mips.org; Tue, 26 Aug 2003 01:02:57 +0200
Date: Tue, 26 Aug 2003 01:02:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: fadvise64
Message-ID: <20030825230257.GA8936@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Seems like there was no real possibility of anybody using the new 2.5
syscall fadvise64 with it's screwed prototype so I'm simply going to
avoid adding any extra junk to the kernel and change fadvise64 to
make the real thing that is call sys_fadvise64_64.

If that is going to cause any potencial trouble for example with libc,
let me know ...

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2008 10:30:25 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:49389 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20022898AbYDUJaX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Apr 2008 10:30:23 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3L9TZsJ031213
	for <linux-mips@linux-mips.org>; Mon, 21 Apr 2008 02:29:35 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3L9UGC0017252;
	Mon, 21 Apr 2008 10:30:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3L9UFVC017243;
	Mon, 21 Apr 2008 10:30:15 +0100
Date:	Mon, 21 Apr 2008 10:30:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix handling of trap and breakpoint instructions
Message-ID: <20080421093015.GA26982@linux-mips.org>
References: <S20041689AbYDUAiN/20080421003813Z+6727@ftp.linux-mips.org> <20080421.100721.07644724.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080421.100721.07644724.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 21, 2008 at 10:07:21AM +0900, Atsushi Nemoto wrote:

> > Author: Ralf Baechle <ralf@linux-mips.org> Sun Apr 20 16:28:54 2008 +0100
> > Commit: 5881bb0de64887a60f7f49922cf73a3b4d40fc01
> > Gitweb: http://www.linux-mips.org/g/linux/5881bb0d
> > Branch: master
> 
> You must drop left shift of this line too.
> 
> 		if (bcode == (BRK_DIVZERO << 10))

Sigh, damn code duplication.  Will fix and cleanup.

  Ralf

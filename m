Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2008 17:12:54 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:58804 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20040672AbYDUQMv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Apr 2008 17:12:51 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3LGBrp8001253
	for <linux-mips@linux-mips.org>; Mon, 21 Apr 2008 09:12:00 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3LGCNMr004515;
	Mon, 21 Apr 2008 17:12:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3LGCLag004501;
	Mon, 21 Apr 2008 17:12:21 +0100
Date:	Mon, 21 Apr 2008 17:12:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix handling of trap and breakpoint instructions
Message-ID: <20080421161221.GA21641@linux-mips.org>
References: <S20041689AbYDUAiN/20080421003813Z+6727@ftp.linux-mips.org> <20080421.100721.07644724.nemoto@toshiba-tops.co.jp> <480CB728.7060402@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480CB728.7060402@avtrex.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 21, 2008 at 08:47:52AM -0700, David Daney wrote:

> Note that there has been some confusion about break codes in gas over the 
> years.  Ancient versions (I am not sure which) generated different break 
> codes than recent versions.
>
> Before changing it make sure that you don't break existing user space code.
>
> One problem (fixed around 2.4.25 or so) was the integer division by zero in 
> user space would result in SIGTRAP instead of SIGFPE.   If you change the 
> break code handling you should verify that you don't break this.

Not quite correct.  Very old and recent binutils are bug compatible.  It's
middle age gcc which unfortunately fixed the bug creating a bug ;-)

  Ralf

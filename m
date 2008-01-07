Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 12:22:19 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12703 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573851AbYAGMWR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 12:22:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m07CLvhs026451;
	Mon, 7 Jan 2008 12:21:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m07CLuK7026450;
	Mon, 7 Jan 2008 12:21:56 GMT
Date:	Mon, 7 Jan 2008 12:21:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	gregor.waltz@raritan.com, linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080107122156.GB24700@linux-mips.org>
References: <477E7DAE.2080005@raritan.com> <20080104192310.GE22809@networkno.de> <477EB2EA.7060009@raritan.com> <20080105.234256.25910407.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080105.234256.25910407.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 05, 2008 at 11:42:56PM +0900, Atsushi Nemoto wrote:

> > Our 2.4.12 kernel uses -mcpu=r3000 -mips1 to build the kernel. I tried 
> > switching the arch to r3000 from r3900 in 2.6.23.9, but that did not 
> > help. Perhaps -mips1 or an equivalent could help? I will try on Monday.
> 
> I think both mcpu=r3000 and r3900 should work.  But I believe at least
> one kernel patch is required for all MIPS I platforms including JMR3927.
> 
> http://www.linux-mips.org/archives/linux-mips/2007-02/msg00320.html

Well, is mmiowb() needed at all on JMR3927 - or R3000 in general?  Mmiowb()
is meant to deal with weak ordering which only matters to a few SMP
configurations.

  Ralf

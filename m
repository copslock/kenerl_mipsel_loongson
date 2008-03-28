Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 12:12:07 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:48282 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S528435AbYC1LMC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 12:12:02 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2SBAJgc022054
	for <linux-mips@linux-mips.org>; Fri, 28 Mar 2008 04:10:20 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2SBAsrr006067;
	Fri, 28 Mar 2008 11:10:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2SBAqce006066;
	Fri, 28 Mar 2008 11:10:52 GMT
Date:	Fri, 28 Mar 2008 11:10:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: kill useless time variables
Message-ID: <20080328111052.GA5684@linux-mips.org>
References: <200803272205.57531.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803272205.57531.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 27, 2008 at 10:05:57PM +0300, Sergei Shtylyov wrote:

> Since the commit 91a2fcc88634663e9e13dcdfad0e4a860e64aeee ([MIPS] Consolidate
> all variants of MIPS cp0 timer interrupt handlers) removed the Alchemy specific
> timer handler, 'r4k_offset' and 'r4k_cur' variables became practically useless,
> so get rid of them at last, renaming cal_r4off() function into calc_clock() and
> making it return CPU frequency. Also, make 'no_au1xxx_32khz' variable static...

Queued for2.6.26.  Thanks,

  Ralf

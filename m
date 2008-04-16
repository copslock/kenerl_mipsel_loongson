Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 19:01:07 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:59017 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20029399AbYDPSBF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2008 19:01:05 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3GI0J5i010956
	for <linux-mips@linux-mips.org>; Wed, 16 Apr 2008 11:00:19 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3GI0xv6007079;
	Wed, 16 Apr 2008 19:00:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3GI0xa0007078;
	Wed, 16 Apr 2008 19:00:59 +0100
Date:	Wed, 16 Apr 2008 19:00:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	linux-mips@linux-mips.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] MIPS: irixelf: fix test unsigned var < 0
Message-ID: <20080416180059.GC32263@linux-mips.org>
References: <480558CA.7090800@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480558CA.7090800@tiscali.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 03:39:22AM +0200, Roel Kluin wrote:

> v is unsigned, cast to signed to evaluate the do_brk() return value,

do_brk() is expected to return its first argument as the result in case
of success.  An error also wasn't getting propagated so some further
fixes were needed for irix_map_prda_page and its caller.  So I'll apply
a different fix.

Thanks!

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 14:10:28 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:50594 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S28573704AbYDNNK0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2008 14:10:26 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3ED9cX3019298
	for <linux-mips@linux-mips.org>; Mon, 14 Apr 2008 06:09:39 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3EDAIrZ012406;
	Mon, 14 Apr 2008 14:10:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3EDAIsZ012405;
	Mon, 14 Apr 2008 14:10:18 +0100
Date:	Mon, 14 Apr 2008 14:10:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix some section mismatches
Message-ID: <20080414131018.GB6361@linux-mips.org>
References: <20080414.215251.25478108.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080414.215251.25478108.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2008 at 09:52:51PM +0900, Atsushi Nemoto wrote:

> Also make coherentio static.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks; I folded your fixes into the other queue patches which introduced
the bugs.

  Ralf

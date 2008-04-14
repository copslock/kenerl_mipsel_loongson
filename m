Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 15:44:45 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:14755 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20023875AbYDNOon (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2008 15:44:43 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3EEhwRd028646
	for <linux-mips@linux-mips.org>; Mon, 14 Apr 2008 07:43:59 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3EEicn1031660;
	Mon, 14 Apr 2008 15:44:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3EEic1l031659;
	Mon, 14 Apr 2008 15:44:38 +0100
Date:	Mon, 14 Apr 2008 15:44:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Do not build spram.o unconditionally
Message-ID: <20080414144438.GA29804@linux-mips.org>
References: <20080414.224759.130241483.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080414.224759.130241483.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2008 at 10:47:59PM +0900, Atsushi Nemoto wrote:

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Also folded into the SPRAM patch.  But since not every R2 core has SPRAM
this should probably be done using a new CONFIG_ symbol.  And the
CONFIG_CPU_* were always meant for optimization not feature selection.
So I guess a little more polishing is still needed.  But it's getting
there.

Thanks!

  Ralf

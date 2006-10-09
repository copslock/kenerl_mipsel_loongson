Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 17:02:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:10176 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039692AbWJIQCO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 17:02:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k99G2Icj007876;
	Mon, 9 Oct 2006 17:02:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k99G2Gf1007875;
	Mon, 9 Oct 2006 17:02:16 +0100
Date:	Mon, 9 Oct 2006 17:02:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, mlachwani@mvista.com
Subject: Re: [PATCH] Make sure cpu_has_fpu is used only in atomic context
Message-ID: <20061009160215.GA7642@linux-mips.org>
References: <44F715F2.7050305@mvista.com> <20060901.122527.63741495.nemoto@toshiba-tops.co.jp> <20060901.170817.118968734.nemoto@toshiba-tops.co.jp> <20061009.001001.74753036.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009.001001.74753036.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 09, 2006 at 12:10:01AM +0900, Atsushi Nemoto wrote:

> Make sure cpu_has_fpu (which uses smp_processor_id()) is used
> only in atomic context.

It's awfully ugly to have an increasing number of preemption kludgery
around but it's not so trivial to avoid unfortunately ...

  Ralf

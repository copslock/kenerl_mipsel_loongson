Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 17:04:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24044 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573826AbXAWREk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 17:04:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0NH4ceX026386;
	Tue, 23 Jan 2007 17:04:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0NH4bRs026385;
	Tue, 23 Jan 2007 17:04:37 GMT
Date:	Tue, 23 Jan 2007 17:04:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][RFC] Move some kernel globals from asm file to C file.
Message-ID: <20070123170437.GA21507@linux-mips.org>
References: <20070124.003859.126141727.anemo@mba.ocn.ne.jp> <20070123161226.GA20530@linux-mips.org> <20070124.012105.63741796.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070124.012105.63741796.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 24, 2007 at 01:21:05AM +0900, Atsushi Nemoto wrote:

> Thanks, updated.  Also use "#ifdef MODULE_START" instead of complex
> condition.

Thanks, queued.

  Ralf

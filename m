Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 18:25:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2969 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038703AbXBVSZ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 18:25:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1MIPN9C000514;
	Thu, 22 Feb 2007 18:25:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1MIPLBg000513;
	Thu, 22 Feb 2007 18:25:21 GMT
Date:	Thu, 22 Feb 2007 18:25:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Kill redundant EXTRA_AFLAGS
Message-ID: <20070222182520.GA1487@linux-mips.org>
References: <20070223.003948.41198458.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070223.003948.41198458.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 23, 2007 at 12:39:48AM +0900, Atsushi Nemoto wrote:

> Many Makefiles in arch/mips have EXTRA_AFLAGS := $(CFLAGS) line.  This
> is redundant while AFLAGS contains $(cflags-y) and any options only
> listed in CFLAGS (not in cflags-y) should be unnecessary for asm
> sources.

Thanks, applied.

  Ralf

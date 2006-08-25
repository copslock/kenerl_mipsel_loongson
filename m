Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 12:46:09 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:9959 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038801AbWHYLqG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2006 12:46:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7PBkTeC006135;
	Fri, 25 Aug 2006 12:46:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7PBkSMB006134;
	Fri, 25 Aug 2006 12:46:28 +0100
Date:	Fri, 25 Aug 2006 12:46:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] do not use drop_mmu_context to flusing other task's icache
Message-ID: <20060825114628.GB31044@linux-mips.org>
References: <20060825.175531.99204769.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825.175531.99204769.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 25, 2006 at 05:55:31PM +0900, Atsushi Nemoto wrote:

> The c-r4k.c and c-sb1.c use drop_mmu_context() to flushing virtually
> tagged icache, but this would not work for flushing other task's
> icache.  The ptrace() (and copy_to_user_page()) is the case.  Use
> indexed flush for such cases.

Good spotting!

  Ralf

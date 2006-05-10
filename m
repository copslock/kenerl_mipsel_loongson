Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 16:57:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:11212 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133637AbWEJO5M (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 16:57:12 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4AEvBNc015247;
	Wed, 10 May 2006 15:57:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4AEvBuf015246;
	Wed, 10 May 2006 15:57:11 +0100
Date:	Wed, 10 May 2006 15:57:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] use generic DWARF_DEBUG
Message-ID: <20060510145711.GA11961@linux-mips.org>
References: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510.153604.82350680.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 10, 2006 at 03:36:04PM +0900, Atsushi Nemoto wrote:

> When debugging a kernel compiled by gcc 4.1 with gdb 6.4, gdb could
> not show filename, linenumber, etc.  It seems fixed if I used generic
> DWARF_DEBUG macro.  Although gcc 3.x seems work without this change,
> it would be better to use the generic macro unless there were
> something MIPS specific.

Okay, applied.

Thanks!

  Ralf

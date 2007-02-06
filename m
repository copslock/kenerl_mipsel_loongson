Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 11:51:03 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:55714 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037857AbXBFLvB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 11:51:01 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l16Bp0xE008054;
	Tue, 6 Feb 2007 11:51:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l16BoxH0008053;
	Tue, 6 Feb 2007 11:50:59 GMT
Date:	Tue, 6 Feb 2007 11:50:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Work around bogus gcc warnings.
Message-ID: <20070206115059.GA5660@linux-mips.org>
References: <S20037630AbWK3BWw/20061130012252Z+10493@ftp.linux-mips.org> <20070206.160221.07643905.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070206.160221.07643905.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 06, 2007 at 04:02:21PM +0900, Atsushi Nemoto wrote:

> This commit broke gdb, since any BREAK or TRAP instruction cause
> SIGSEGV.

Applied, thanks.

  Ralf

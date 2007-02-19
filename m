Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2007 15:22:47 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:63647 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037636AbXBSPWp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Feb 2007 15:22:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1JFMkY3012526;
	Mon, 19 Feb 2007 15:22:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1JFMiSj012525;
	Mon, 19 Feb 2007 15:22:44 GMT
Date:	Mon, 19 Feb 2007 15:22:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make some __setup functions static
Message-ID: <20070219152244.GB11401@linux-mips.org>
References: <20070218.010214.74565177.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070218.010214.74565177.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 18, 2007 at 01:02:14AM +0900, Atsushi Nemoto wrote:

> This fixes some sparse warnings. ("warning: symbol 'foo' was not
> declared. Should it be static?")

Thanks, applied.

  Ralf

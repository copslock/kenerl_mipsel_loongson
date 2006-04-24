Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 12:31:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51072 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133730AbWDXL3d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 12:29:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3OBgZBT006517;
	Mon, 24 Apr 2006 12:42:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3OAEsqJ003786;
	Mon, 24 Apr 2006 11:14:54 +0100
Date:	Mon, 24 Apr 2006 11:14:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Makefile crapectomy.
Message-ID: <20060424101454.GF3194@linux-mips.org>
References: <S8133763AbWCTMd3/20060320123329Z+1908@ftp.linux-mips.org> <20060415.000418.07644633.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415.000418.07644633.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 15, 2006 at 12:04:18AM +0900, Atsushi Nemoto wrote:

> This commit breaks sparse for 64bit kernel.  The -m64 option is
> required.  Also, some macro values (such as _MIPS_TUNE, etc.)  contain
> double-quote characters so it would be better quoting arguments by
> single-quote characters.

Thanks, applied.

  Ralf

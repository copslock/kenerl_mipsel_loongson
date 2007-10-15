Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 18:31:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:39388 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20036935AbXJORa7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2007 18:30:59 +0100
Received: from localhost (p8150-ipad303funabasi.chiba.ocn.ne.jp [123.217.154.150])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 975419BDF; Tue, 16 Oct 2007 02:29:38 +0900 (JST)
Date:	Tue, 16 Oct 2007 02:31:25 +0900 (JST)
Message-Id: <20071016.023125.59033711.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] Fix aliasing bug in copy_user_highpage, take 2.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20036863AbXJOPrf/20071015154735Z+80955@ftp.linux-mips.org>
References: <S20036863AbXJOPrf/20071015154735Z+80955@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 15 Oct 2007 16:47:30 +0100, linux-mips@linux-mips.org wrote:
> Turns out 6a36458d9348265327d074bdd40bfb1c5b6fb2cb  wasn't quite right.
> When called for a page that isn't marked dirty it would artificially
> create an alias instead of doing the obvious thing and access the page
> via KSEG0.
> 
> The same issue also exists in copy_to_user_page and copy_from_user_page
> which was causing the machine to die under rare circumstances for example
> when running ps if the BUG_ON() assertion added by the earlier fix was
> getting triggered.

This commit added a SetPageDcacheDirty() call for both
copy_to_user_page() and copy_from_user_page().  The call in
copy_from_user_page() is really needed?

---
Atsushi Nemoto

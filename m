Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 10:28:47 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:64226 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021984AbXEGJ2p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 May 2007 10:28:45 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 7 May 2007 18:28:43 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 105B24220B;
	Mon,  7 May 2007 18:28:38 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 04FFD204C3;
	Mon,  7 May 2007 18:28:38 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l479SbW0068428;
	Mon, 7 May 2007 18:28:37 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 07 May 2007 18:28:37 +0900 (JST)
Message-Id: <20070507.182837.126143175.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80705070150u75165c47n252a664fc92646f3@mail.gmail.com>
References: <11782930063123-git-send-email-fbuihuu@gmail.com>
	<20070506.010313.41199101.anemo@mba.ocn.ne.jp>
	<cda58cb80705070150u75165c47n252a664fc92646f3@mail.gmail.com>
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
X-archive-position: 14970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 7 May 2007 10:50:20 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > How about keeping board_time_init pointer as is and adding
> > plat_clk_setup only for simple platforms?
> 
> Not sure that would force us to duplicate all timekeeping stuff in
> time_init() hook because of several hacks. If this is really true,
> let's try to clean up some code.

Well, I have not looked closer those hackish board_time_init functions
yet.  Maybe we can do the cleanups, but frankly, now I think it is a
time for removal of them.

Both boards have been listed on

http://www.linux-mips.org/wiki/Category:Deprecated

since Jun 2006.

---
Atsushi Nemoto

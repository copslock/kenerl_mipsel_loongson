Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 15:50:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:26870 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031922AbYGYOum (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 15:50:42 +0100
Received: from localhost (p3225-ipad203funabasi.chiba.ocn.ne.jp [222.146.82.225])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BEAF9AB92; Fri, 25 Jul 2008 23:50:38 +0900 (JST)
Date:	Fri, 25 Jul 2008 23:52:33 +0900 (JST)
Message-Id: <20080725.235233.130241768.anemo@mba.ocn.ne.jp>
To:	jason.wessel@windriver.com
Cc:	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] kgdb, mips: add arch support for the kernel's kgdb
 core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <488941C5.9060908@windriver.com>
References: <1216400928-29097-3-git-send-email-jason.wessel@windriver.com>
	<20080725.012748.108121457.anemo@mba.ocn.ne.jp>
	<488941C5.9060908@windriver.com>
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
X-archive-position: 19959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 24 Jul 2008 22:00:21 -0500, Jason Wessel <jason.wessel@windriver.com> wrote:
> It seem ok to me to try it.  Here is version 3 of the patch, which I was going to send to Ralf.

Thanks, it works for me with serial_txx9 kgdboc module.
---
Atsushi Nemoto

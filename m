Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 02:24:23 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:35167 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20032876AbYG2BYN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 02:24:13 +0100
Received: from no.name.available by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Tue, 29 Jul 2008 10:24:12 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id DD5F242B6C;
	Tue, 29 Jul 2008 10:24:04 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id D07791F33F;
	Tue, 29 Jul 2008 10:24:04 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m6T1O4fl020085;
	Tue, 29 Jul 2008 10:24:04 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 29 Jul 2008 10:24:03 +0900 (JST)
Message-Id: <20080729.102403.150676958.nemoto@toshiba-tops.co.jp>
To:	jason.wessel@windriver.com
Cc:	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] kgdb, mips: add arch support for the kernel's kgdb
 core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <488E150F.9050508@windriver.com>
References: <20080725.235233.130241768.anemo@mba.ocn.ne.jp>
	<20080728.230512.132304415.anemo@mba.ocn.ne.jp>
	<488E150F.9050508@windriver.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 28 Jul 2008 13:50:55 -0500, Jason Wessel <jason.wessel@windriver.com> wrote:
> There is no technical reason that frame pointers are required for KGDB
> in the present mainline sources.  This does allow for further
> traceability but it is certainly not a requirement for the use of kgdb.
> If all you want to do is look at frame 0 and inspect memory or set a
> breakpoint and look at some structures kgdb will certainly serve your
> purpose.

Yes.  On MIPS, I can even show backtrace without FRAME_POINTER (if I
enabled DEBUG_INFO).

> I'll consider this a defect to the kgdb core and update the
> documentation to reflect that it is advised to use frame pointers, but
> not a requirement.

Thanks, your patch is fine for me.

---
Atsushi Nemoto

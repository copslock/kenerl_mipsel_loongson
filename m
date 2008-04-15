Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 01:51:43 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:35639 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S28574198AbYDOAvl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Apr 2008 01:51:41 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for [213.58.128.207] [213.58.128.207]) with ESMTP; Tue, 15 Apr 2008 09:51:39 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 814C04741E;
	Tue, 15 Apr 2008 09:51:35 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 6DB264741B;
	Tue, 15 Apr 2008 09:51:35 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m3F0pYAF056726;
	Tue, 15 Apr 2008 09:51:35 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 15 Apr 2008 09:51:34 +0900 (JST)
Message-Id: <20080415.095134.03976245.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Do not build spram.o unconditionally
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080414144438.GA29804@linux-mips.org>
References: <20080414.224759.130241483.anemo@mba.ocn.ne.jp>
	<20080414144438.GA29804@linux-mips.org>
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
X-archive-position: 18921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 14 Apr 2008 15:44:38 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> Also folded into the SPRAM patch.  But since not every R2 core has SPRAM
> this should probably be done using a new CONFIG_ symbol.  And the
> CONFIG_CPU_* were always meant for optimization not feature selection.
> So I guess a little more polishing is still needed.  But it's getting
> there.

Thanks, and please do not forget fix cpu-probe.c part too.

---
Atsushi Nemoto

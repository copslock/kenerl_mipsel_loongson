Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 16:15:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51367 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20022690AbZEOPO5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 May 2009 16:14:57 +0100
Received: from localhost (p3076-ipad213funabasi.chiba.ocn.ne.jp [124.85.68.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9BA95ACFF; Sat, 16 May 2009 00:14:53 +0900 (JST)
Date:	Sat, 16 May 2009 00:14:54 +0900 (JST)
Message-Id: <20090516.001454.193872890.anemo@mba.ocn.ne.jp>
To:	Geert.Uytterhoeven@sonycom.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
Subject: Re: [PATCH] TXx9: Add ACLC support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <alpine.LRH.2.00.0905151516300.32617@vixen.sonytel.be>
References: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
	<alpine.LRH.2.00.0905151516300.32617@vixen.sonytel.be>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 15 May 2009 15:45:36 +0200 (CEST), Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > Add platform support for ACLC of TXx9 SoCs.
> 
> I gave it a try on my RBTX4927, and after some fight^H^H^H^H^Hplaying with the
> alsa tools, I could play sound using `speaker-test --test wav --channels 2'!

Good news!  Thanks for your trial.

---
Atsushi Nemoto

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 16:32:30 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:49616 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037617AbWJKPcZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2006 16:32:25 +0100
Received: from localhost (p6080-ipad213funabasi.chiba.ocn.ne.jp [124.85.71.80])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BE699B882; Thu, 12 Oct 2006 00:32:19 +0900 (JST)
Date:	Thu, 12 Oct 2006 00:34:36 +0900 (JST)
Message-Id: <20061012.003436.130240259.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 4/5] Introduce __pa_symbol()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11605685254080-git-send-email-fbuihuu@gmail.com>
References: <1160568525897-git-send-email-fbuihuu@gmail.com>
	<11605685254080-git-send-email-fbuihuu@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 11 Oct 2006 14:08:44 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> This patch introduces __pa_symbol() macro which should be used to
> calculate the physical address of kernel symbols. It also relies
> on RELOC_HIDE() to avoid any compiler's oddities when doing
> arithmetics on symbols.

I agree with you that we need __pa_symbol(), but what is a purpose of
using RELOC_HIDE() here?  Frankly I do not understand what
RELOC_HIDE() does...

---
Atsushi Nemoto

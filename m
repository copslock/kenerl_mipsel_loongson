Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 10:49:04 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:37286 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037743AbWJLJtC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Oct 2006 10:49:02 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 12 Oct 2006 18:49:01 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4330923ECF;
	Thu, 12 Oct 2006 18:48:58 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 36C1B20846;
	Thu, 12 Oct 2006 18:48:58 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9C9mtW0035002;
	Thu, 12 Oct 2006 18:48:55 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 12 Oct 2006 18:48:55 +0900 (JST)
Message-Id: <20061012.184855.108739419.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] Introduce __pa_symbol()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <452D180D.9020700@innova-card.com>
References: <11605685254080-git-send-email-fbuihuu@gmail.com>
	<20061012.003436.130240259.anemo@mba.ocn.ne.jp>
	<452D180D.9020700@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 11 Oct 2006 18:13:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> RELOC_HIDE(x) is used because arithmetic on symbol addresses is
> undefined in C language. It avoid gcc to know that:
> 
> 	RELOC_HIDE(&_end) + OFFSET
> 
> is an operation on a symbol address and thus avoid an undefined
> operation.

Thanks, I see, but can not imagine the case the RELOC_HIDE() is
_really_ needed.  Do you have any example?

---
Atsushi Nemoto

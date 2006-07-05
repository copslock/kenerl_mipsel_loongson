Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 11:21:11 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:14303 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133407AbWGEKVC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Jul 2006 11:21:02 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 5 Jul 2006 19:20:59 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id ACCDA20453;
	Wed,  5 Jul 2006 19:20:55 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 85C562030D;
	Wed,  5 Jul 2006 19:20:55 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k65AKsW0096669;
	Wed, 5 Jul 2006 19:20:55 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 05 Jul 2006 19:20:54 +0900 (JST)
Message-Id: <20060705.192054.128618288.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44AB79D0.90002@innova-card.com>
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>
	<44AB79D0.90002@innova-card.com>
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
X-archive-position: 11911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 05 Jul 2006 10:35:28 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >  #elif defined(CONFIG_NEED_MULTIPLE_NODES)
> 
> why not using:
> 
> #elif defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
> 
> hence, we would have all memory model cases.

While NEED_MULTIPLE_NODES is defined if DISCONTIGMEM || NUMA, it seems
no difference.

> For now it seems to be implemented only in sgi-ip27 machine. Maybe we should
> make things clear by adding:
> 
> #ifdef CONFIG_SGI_IP27
> #define pfn_valid	[...]
> #else
> #error discontigmem model is only supported by sgi-ip27 platforms.
> #error Please try to implement a generic solution if you plan to
> #error use this memory model. Good luck ;)
> #endif /* CONFIG_SGI_IP27 */

Though the pfn_valid() is only used by ip27 for now, I suppose it
could be used other NUMA systems (not sure).

---
Atsushi Nemoto

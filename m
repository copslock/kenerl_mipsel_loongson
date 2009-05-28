Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 16:33:02 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51767 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023223AbZE1Pcz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 May 2009 16:32:55 +0100
Received: from localhost (p7181-ipad208funabasi.chiba.ocn.ne.jp [60.43.108.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 652039829; Fri, 29 May 2009 00:32:48 +0900 (JST)
Date:	Fri, 29 May 2009 00:32:49 +0900 (JST)
Message-Id: <20090529.003249.186064432.anemo@mba.ocn.ne.jp>
To:	apatard@mandriva.com
Cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, wuzj@lemote.com, yanh@lemote.com,
	philippe@cowpig.ca, r0bertz@gentoo.org, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, der.herr@hofr.at, liujl@lemote.com,
	erwan@thiscow.com
Subject: Re: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <m3my8yoovk.fsf@anduin.mandriva.com>
References: <cover.1243362545.git.wuzj@lemote.com>
	<1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
	<m3my8yoovk.fsf@anduin.mandriva.com>
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
X-archive-position: 23030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 27 May 2009 11:51:11 +0200, Arnaud Patard <apatard@mandriva.com> wrote:
> > +LEAF(swsusp_arch_resume)
...
> 
> you really need to flush cache/tlb here. If you don't do that you'll get
> some weird bugs.

I also wonder if we need to flush cache on swsusp_arch_suspend.  Maybe
kernel pages does not need to be flushed on here, but how about user
pages with dcache aliasing?  It seems swsusp_save() reads from source
page via kernel mapping without any care for coherency...

---
Atsushi Nemoto

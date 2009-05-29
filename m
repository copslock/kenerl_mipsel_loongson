Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 17:13:10 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51430 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20024710AbZE2QNE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 May 2009 17:13:04 +0100
Received: from localhost (p8014-ipad303funabasi.chiba.ocn.ne.jp [123.217.154.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 91599A93B; Sat, 30 May 2009 01:12:57 +0900 (JST)
Date:	Sat, 30 May 2009 01:12:59 +0900 (JST)
Message-Id: <20090530.011259.260978238.anemo@mba.ocn.ne.jp>
To:	wuzj@lemote.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, yanh@lemote.com,
	philippe@cowpig.ca, r0bertz@gentoo.org, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, der.herr@hofr.at, liujl@lemote.com,
	erwan@thiscow.com
Subject: Re: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1243530658.19464.5.camel@falcon>
References: <cover.1243362545.git.wuzj@lemote.com>
	<1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
	<1243530658.19464.5.camel@falcon>
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
X-archive-position: 23064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 29 May 2009 01:10:58 +0800, Wu Zhangjin <wuzj@lemote.com> wrote:
> > +LEAF(swsusp_arch_suspend)
> [...]
> > +	PTR_S a0, PT_R4(t0)
> > +	PTR_S a1, PT_R5(t0)
> > +	PTR_S a2, PT_R6(t0)
> 
> ooh, seems miss:
> 
> 	PTR_S a3, PT_R7(t0)
> 
> and is there a need to save/restore a4,a5,a6,a7 in 64bit kernel? 

No.  And I think no need to save/resotre a0 to a3 and v1 too.

---
Atsushi Nemoto

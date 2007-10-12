Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 10:07:57 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:42921 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20023656AbXJLJHt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 10:07:49 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 12 Oct 2007 18:07:47 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 8837242AEB;
	Fri, 12 Oct 2007 18:07:43 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 743F1429AC;
	Fri, 12 Oct 2007 18:07:43 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l9C97gAF032655;
	Fri, 12 Oct 2007 18:07:43 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 12 Oct 2007 18:07:42 +0900 (JST)
Message-Id: <20071012.180742.59650681.nemoto@toshiba-tops.co.jp>
To:	fbuihuu@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] tlbex.c: Cleanup __init usages.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <470F170E.1060303@gmail.com>
References: <470F16B9.7030406@gmail.com>
	<470F170E.1060303@gmail.com>
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
X-archive-position: 16983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 12 Oct 2007 08:41:18 +0200, Franck Bui-Huu <fbuihuu@gmail.com> wrote:
>  #define I_0(op)							\
> -	static inline void __init i##op(u32 **buf)		\
> +	static inline void i##op(u32 **buf)		\
>  	{							\
>  		build_insn(buf, insn##op);			\
>  	}

This causes section mismatches, since i_tlbwr and i_tlbwi can not be
inlined (see head of build_tlb_write_entry()).

Maybe __init __maybe_unused is preferred?

---
Atsushi Nemoto

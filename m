Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jul 2006 15:24:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:24006 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133802AbWG2OX6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 29 Jul 2006 15:23:58 +0100
Received: from localhost (p6108-ipad213funabasi.chiba.ocn.ne.jp [124.85.71.108])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9945CB032; Sat, 29 Jul 2006 23:23:52 +0900 (JST)
Date:	Sat, 29 Jul 2006 23:25:23 +0900 (JST)
Message-Id: <20060729.232523.74752889.anemo@mba.ocn.ne.jp>
To:	ddaney@avtrex.com
Cc:	nigel@mips.com, ths@networkno.de, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44CA5837.2060502@avtrex.com>
References: <44CA43EC.9010904@avtrex.com>
	<44CA4AA3.8080700@mips.com>
	<44CA5837.2060502@avtrex.com>
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
X-archive-position: 12119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 28 Jul 2006 11:32:23 -0700, David Daney <ddaney@avtrex.com> wrote:
> >> This was always the tricky part for me.  How do you know if the 
> >> function is a leaf?
> > 
> > I think that if you cannot find a store instruction which saves RA to 
> > the stack -- either because it's a real leaf and there is no such store, 
> > or because the PC hasn't yet reached the store instruction -- then in 
> > both cases it can be treated as a leaf.

Right.

> Presumably you are walking the code back from the PC until you find the 
> prolog.  How would you tell if you had gone past the beginning of a leaf 
> function?  If you find a j $31 you might assume that it was the end of 
> the previous function.

I think you are misunderstanding here.

What the get_frame_info() doing is just searching "sw $ra, ofs($sp)"
and "addiu sp,sp,-imm" instructions from beginning of the function.
We can obtain the start address and size of the function by
kallsyms_lookup().  This is why those stuff depend on CONFIG_KALLSYMS.

> I may be missing something here, if you know of a failure-proof manner 
> to detect leaf functions I would appreciate hearing what it is.

I have no good idea to do it without CONFIG_KALL_SYMS.
I suppose there is no silver bullet here...

---
Atsushi Nemoto
